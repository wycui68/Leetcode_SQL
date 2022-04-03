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
