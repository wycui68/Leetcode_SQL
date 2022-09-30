with cet1 as 
(
    select employee_id
    from Employees
    union all
    select employee_id
    from Salaries
)

select employee_id
from cet1
where employee_id not in 
(
    select t1.employee_id
    from Employees t1 join Salaries t2
    on t1.employee_id = t2.employee_id
)
order by employee_id
