##### window function #####
with cet as 
(
select player_id, 
event_date, 
min(event_date) over(partition by player_id order by event_date) as first_login, 
lead(event_date, 1) over(partition by player_id order by event_date) as lead1 
from Activity
)

select round(
count(distinct player_id) / (select count(distinct player_id) from Activity)
, 2
) as fraction 

from cet
where datediff(lead1, first_login) = 1

##########################
with t1 as 
(
    select player_id, min(event_date) as first_log
    from Activity
    group by player_id
), t2 as 
(
    select count(distinct t1.player_id) as cnt
    from t1 join Activity a
    on t1.player_id = a.player_id
    and t1.first_log + 1 = a.event_date
)

select 
round(cnt / (select count(player_id) from t1), 2) as fraction
from t2
