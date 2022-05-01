with cet1 as 
(
    select user_id, min(activity_date) as first_login
    from Traffic
    where activity = 'login'
    group by user_id
), cet2 as 
(
    select *
    from cet1
    where datediff('2019-06-30', first_login) <= 90
)

select first_login as login_date, 
        count(distinct user_id) as user_count
from cet2
group by first_login
