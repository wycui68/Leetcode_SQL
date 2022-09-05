with cet1 as 
(
    select reports_to, 
    count(distinct employee_id) as reports_count, 
    round(avg(age), 0) as average_age
    from Employees 
    group by reports_to
    having count(distinct employee_id) >= 1
)

select e.employee_id, e.name, cet1.reports_count, cet1.average_age
from cet1 join Employees e
on cet1.reports_to = e.employee_id
order by 1
