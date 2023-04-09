### window function ###
with cet as 
(
  select t1.employee_id, 
  amount, 
  date_format(pay_date, "%Y-%m") as pay_month, 
  t2.department_id
  from Salary t1 left join Employee t2 
  on t1.employee_id = t2.employee_id
), base as 
(
  select distinct pay_month, department_id, 
  avg(amount) over(partition by pay_month) as avg_company, 
  avg(amount) over(partition by pay_month, department_id) as avg_dept
  from cet
)

select pay_month, 
department_id, 
case when avg_company = avg_dept then 'same' 
     when avg_dept > avg_company then 'higher'
     else 'lower' end as comparison
from base
