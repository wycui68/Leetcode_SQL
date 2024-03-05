# Write your MySQL query statement below
with trans_rnk as 
(
    select transaction_id, 
    dense_rank() over(partition by trans_day order by amount desc) as rnk 
    from 
    (
        select transaction_id, 
        cast(day as date) as trans_day, 
        amount
        from Transactions
    ) t1
)
select transaction_id
from trans_rnk 
where rnk = 1
order by 1
