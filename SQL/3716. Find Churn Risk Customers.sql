# Write your MySQL query statement below
with cet1 as 
(
    select *, 
    row_number() over(partition by user_id order by event_date desc) as rnk 
    from subscription_events
)
, cet2 as 
(
    select 
    user_id, 
    datediff(max(event_date), min(event_date)) as days_as_subscriber, 
    max(monthly_amount) as max_historical_amount
    from subscription_events
    group by user_id
    having sum(event_type = 'downgrade') >= 1
)
select
a.user_id, 
a.plan_name as current_plan, 
a.monthly_amount as current_monthly_amount ,
b.max_historical_amount,
b.days_as_subscriber
from cet1 a left join cet2 b 
on a.user_id = b.user_id
where a.rnk = 1 
and days_as_subscriber > 60
and (a.monthly_amount/b.max_historical_amount) < 0.5
and a.plan_name is not null 
order by days_as_subscriber desc,a.user_id
