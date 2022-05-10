select day, sum(active_users) as active_users
from 
(
    select activity_date as day, 
           count(distinct user_id) as active_users
    from Activity
    where datediff('2019-07-27', activity_date) < 30 and activity_date <= '2019-07-27'
    group by activity_date, user_id
    having count(distinct activity_type) >= 1
) t
group by day
