select t2.name as Department, 
       t1.name as Employee, 
       t1.salary as Salary
from 
(
    select name, 
           salary, 
           departmentId, 
           dense_rank() over(partition by departmentId order by salary desc) as rnk 
    from Employee
) t1 join Department t2
on t1.departmentId = t2.id
where rnk <= 3;
