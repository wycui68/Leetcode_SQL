# 1. Join 
select d.name as Department, 
       t.name as Employee, 
       salary as Salary
from 
    (
        select name, salary, departmentId
        from Employee  
        where (departmentId, salary) in
        (select departmentId, max(salary)
         from Employee
         group by departmentId)
    ) t left join Department d
on t.departmentId = d.id


# 2. Dense rank
select d.name as Department, 
t.name as Employee, 
t.salary as Salary
from 
    (
        select departmentId, name,salary,
        dense_rank() over(partition by departmentId order by salary desc) as rnk
        from Employee
    ) t left join Department d
on t.departmentId = d.id
where rnk = 1
