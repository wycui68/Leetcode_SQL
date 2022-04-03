select player_id, device_id
from Activity
where (player_id, event_date) in 
    (
        select player_id, min(event_date) as first_log
        from Activity
        group by player_id
    )
