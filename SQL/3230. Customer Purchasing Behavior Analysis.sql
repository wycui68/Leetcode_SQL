# Write your MySQL query statement below
with tb as 
(
    select customer_id, 
    category, 
    sum(amount) as total_amount, 
    count(transaction_id) as transaction_count, 
    rank() over(partition by customer_id order by count(transaction_id) desc, max(transaction_date) desc) as rnk 
    from Transactions t left join Products p
    on t.product_id = p.product_id
    group by 1, 2
)

select customer_id, 
sum(total_amount) as total_amount, 
sum(transaction_count) as transaction_count, 
count(category) as unique_categories, 
round(sum(total_amount) / sum(transaction_count), 2) as avg_transaction_amount, 
category as top_category, 
sum(transaction_count)*10 + round(sum(total_amount)/100, 2) as loyalty_score
from tb 
group by 1
order by 7 desc, 1
