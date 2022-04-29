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
