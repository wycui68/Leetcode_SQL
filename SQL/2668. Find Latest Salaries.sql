select emp_id, 
firstname, 
lastname, 
salary, 
department_id
from 
(
select emp_id, 
firstname, 
lastname, 
salary, 
department_id,
rank() over(partition by emp_id order by salary desc) as rnk
from Salary
) tmp
where rnk = 1
order by 1
