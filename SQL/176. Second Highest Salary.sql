select max(salary) as SecondHighestSalary 
from Employee
where salary not in 
    (
    select max(salary)
    from Employee
    )
    
# window function  
with cet as 
(
select salary, 
dense_rank() over(order by salary desc) as rnk
from Employee
)

select max(salary) as SecondHighestSalary
from cet
where rnk = 2
