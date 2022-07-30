with cet1 as 
(
    select t2.user_id, 
    ifnull(sum(case when user_id = paid_by then -amount
        when user_id = paid_to then amount end), 0) as amt
    from Transactions t1 right join Users t2
    on t1.paid_by = t2.user_id or t1.paid_to = t2.user_id
    group by user_id
)

select t1.user_id, t1.user_name, 
t1.credit + t2.amt as credit, 
(case when t1.credit + t2.amt >= 0 then 'No'
    else 'Yes' end) as credit_limit_breached
from Users t1 left join cet1 t2
on t1.user_id = t2.user_id
