# Write your MySQL query statement below
with tb1 as 
(
    select customer_id, 
    transaction_date, 
    amount, 
    lead(transaction_date) over(partition by customer_id order by transaction_date) as next_txn, 
    lead(amount) over(partition by customer_id order by transaction_date) as next_amt
    from Transactions
)
, tb2 as 
(
    select *, 
    to_days(transaction_date) - rank() over(partition by customer_id order by transaction_date) as flag
    from tb1
    where next_amt > amount and datediff(next_txn, transaction_date) = 1
)
select customer_id, 
min(transaction_date) as consecutive_start, 
max(next_txn) as consecutive_end
from tb2
group by customer_id, flag
having count(*) >= 2
order by 1; 
