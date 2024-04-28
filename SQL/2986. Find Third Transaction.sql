# Write your MySQL query statement below
with tb as 
(
    select *, 
    lag(spend, 1) over(partition by user_id order by transaction_date) as prev_spend, 
    lag(spend, 2) over(partition by user_id order by transaction_date) as prev_prev_spend, 
    rank() over(partition by user_id order by transaction_date) as rnk 
    from Transactions
)
select user_id, 
spend as third_transaction_spend, 
transaction_date as third_transaction_date
from tb
where spend > prev_spend and spend > prev_prev_spend
and rnk = 3
order by 1
