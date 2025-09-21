# Write your MySQL query statement below
with tb as 
(
    select emp_id, 
    dept, 
    dense_rank() over(partition by dept order by salary desc) as rnk 
    from employees
)
select 
emp_id, 
dept
from tb 
where rnk = 2
order by 1
