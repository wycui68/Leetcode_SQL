with tb as 
(
    select user_id, 
    created_at, 
    lag(created_at, 1) over(partition by user_id order by created_at) as prev_dt
    from Users
)

select distinct user_id
from tb
where datediff(created_at, prev_dt) <= 7
