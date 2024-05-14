# Write your MySQL query statement below
with tb1 as 
(
    select dep_id, 
    count(distinct emp_id) as emp_cnt
    from Employees
    group by dep_id
)
, tb2 as 
(
    select dep_id, 
    dense_rank() over(order by emp_cnt desc) as rnk
    from tb1
)
, tb3 as 
(
    select dep_id, 
    emp_name
    from Employees
    where position = 'Manager'
)

select tb3.emp_name as manager_name,
tb2.dep_id as dep_id
from tb2 left join tb3
on tb2.dep_id = tb3.dep_id
where tb2.rnk = 1
order by 2;
