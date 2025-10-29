with tb1 as  
(
    select customer_id, 
    count(*) as total_txn, 
    min(transaction_date) as min_dt, 
    max(transaction_date) as max_dt, 
    sum(case when transaction_type = 'purchase' then 1 else 0 end) as purchases, 
    sum(case when transaction_type = 'refund' then 1 else 0 end) as refunds
    from customer_transactions
    group by customer_id
)
, tb2 as 
(
    select customer_id, 
    datediff(max_dt, min_dt) as date_diff, 
    purchases, 
    refunds, 
    total_txn
    from tb1 
    where refunds/purchases  <= 0.2 and total_txn >= 3
)
select customer_id
from tb2
where date_diff >= 30
order by 1
