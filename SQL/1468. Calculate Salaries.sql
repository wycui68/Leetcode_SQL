with cet1 as 
(
    select company_id, max(salary) as max_sal
    from Salaries
    group by company_id
)

select t1.company_id, 
t1.employee_id, 
t1.employee_name, 
round((case when max_sal < 1000 then salary 
     when max_sal > 10000 then 0.51 * salary 
     else 0.76 * salary end), 0) as salary
from Salaries t1 left join cet1 t2
on t1.company_id = t2.company_id
