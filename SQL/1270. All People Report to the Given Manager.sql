select distinct e1.employee_id
from Employees e1 left join Employees e2 
on e1.manager_id = e2.employee_id
left join Employees e3
on e2.manager_id = e3.employee_id
where e3.manager_id = 1 and e1.employee_id != 1
