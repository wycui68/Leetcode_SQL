# Write your MySQL query statement below
with cet as 
(
    select e.employee_id, 
    e.employee_name, e.department, 
    sum(duration_hours) as total_hours
    from employees e join meetings m 
    on e.employee_id = m.employee_id 
    group by e.employee_id, yearweek(meeting_date, 1)
)
select employee_id, 
employee_name, 
department, 
count(*) as meeting_heavy_weeks
from cet 
where total_hours > 20
group by employee_id
having meeting_heavy_weeks >= 2
order by meeting_heavy_weeks desc, employee_name
