with cet1 as 
(
    select user_id, count(distinct session_id) as cnt
    from Activity
    where datediff('2019-07-27', activity_date) < 30 and activity_date <= '2019-07-27'
    group by user_id
)

select round(ifnull(sum(cnt) / count(distinct user_id), 0), 2) as average_sessions_per_user
from cet1 
