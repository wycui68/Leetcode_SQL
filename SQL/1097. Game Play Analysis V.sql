# cet1 -> count for each install_date, how many installs we have
# cet2 -> find the second_day and number of logins
# when join cet1 and cet2, notice there will be 1 day difference for the "event_date"
with cet1 as
(
    select distinct install_dt, count(player_id) as installs
    from 
    (
        select player_id, min(event_date) as install_dt
        from Activity
        group by player_id
    ) t1
    group by install_dt
), cet2 as
(
    select event_date, count(*) as second_day_login
    from Activity
    where (player_id, date_sub(event_date, interval 1 day)) in 
            (
                select player_id, min(event_date)
                from Activity
                group by player_id
            )
    group by event_date
)

select install_dt, installs, 
round(ifnull(second_day_login, 0) / installs, 2) as Day1_retention
from cet1 left join cet2
on cet1.install_dt = date_sub(cet2.event_date, interval 1 day);


################################################################
# window function 
# Write your MySQL query statement below
# lead(, offset) over(expr), offset -> n th row ahead of the current row
with table1 as 
(
  select player_id, 
  event_date, 
  rank() over(partition by player_id order by event_date) as rank_date, 
  lead(event_date, 1) over(partition by player_id order by event_date) as next_date
  from Activity
)

select event_date as install_dt, 
count(distinct player_id) as installs, 
round(sum(case when date_sub(next_date, interval 1 day) = event_date then 1 else 0 end) / count(distinct player_id), 2) as Day1_retention
from table1
where rank_date = 1
group by event_date

















