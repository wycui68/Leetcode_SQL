select e1.name, 
e2.bonus
from Employee e1 left join Bonus e2 
on e1.empId = e2.empId
where e1.empId not in 
(
    select empId
    from Bonus
    where bonus >= 1000
)
