# Write your MySQL query statement below
with tb as 
(
select user_id, 
steps_count, 
steps_date, 
lag(steps_date, 2) over(partition by user_id order by steps_date) as two_days_ago, 
round(avg(steps_count) over(partition by user_id order by steps_date rows between 2 preceding and current row), 2) as avg_steps
from Steps
)

select user_id, 
steps_date, 
avg_steps as rolling_average
from tb
where datediff(steps_date, two_days_ago) = 2
order by 1, 2;
