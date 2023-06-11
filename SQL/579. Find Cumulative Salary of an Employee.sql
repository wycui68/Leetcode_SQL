# 每个id不包括最近的一个月，比如id=1，不包括8月份的

select e1.id, e1.month, 
e1.salary + ifnull(e2.salary, 0) + ifnull(e3.salary, 0) as Salary
from Employee e1 left join Employee e2
on e1.id = e2.id and e1.month = e2.month + 1
left join Employee e3
on e2.id = e3.id and e2.month = e3.month + 1
where (e1.id, e1.month) not in 
    (
        select id, max(month)
        from Employee
        group by id
    )
order by e1.id, e1.month desc

# window function
# differnece between row and range
with cet as 
(
  select id, 
  month, 
  sum(salary) over(partition by id order by month range between 2 preceding and current row) as total_salary, 
  row_number() over(partition by id order by month desc) as rnk
  from Employee
)

select id, 
month, 
total_salary as Salary
from cet
where rnk != 1
order by id, month desc
