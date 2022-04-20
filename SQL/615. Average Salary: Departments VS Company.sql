with company as 
    (
        select date_format(pay_date, '%Y-%m') as pay_month, 
               avg(amount) as company_avg
        from Salary
        group by pay_month
    ), dep as 
    (
    select date_format(pay_date, '%Y-%m') as pay_month,
           department_id, 
           avg(amount) as dep_avg
    from Salary s left join Employee e 
    on s.employee_id = e.employee_id
    group by pay_month, department_id
    )
    
select c.pay_month, d.department_id, 
(case when dep_avg < company_avg then 'lower'
     when dep_avg > company_avg then 'higher'
     else 'same' end) as comparison
from company c, dep d
where c.pay_month = d.pay_month
