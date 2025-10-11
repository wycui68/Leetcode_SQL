# Write your MySQL query statement below
with tb1 as 
(
    select
    employee_id, 
    review_id, 
    review_date, 
    rating, 
    dense_rank() over(partition by employee_id order by review_date desc) as rnk 
    from performance_reviews
)
, tb2 as 
(
    select *
    from tb1 
    where rnk <= 3
)
, tb3 as 
(
    select
    employee_id, 
    rating, 
    review_date, 
    lag(rating, 1) over(partition by employee_id order by review_date) as prev1, 
    lag(rating, 2) over(partition by employee_id order by review_date) as prev2
    from tb2
)
select 
e.employee_id, 
e.name, 
rating - prev2 as improvement_score
from tb3 join employees e 
on tb3.employee_id = e.employee_id 
where prev2 is not null 
and rating > prev1 
and prev1 > prev2
order by 3 desc, 2
