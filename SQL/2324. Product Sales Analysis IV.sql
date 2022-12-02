with cet as 
(
    select t1.user_id, 
    t1.product_id, 
    dense_rank() over(partition by user_id order by sum(quantity * price) desc) as rnk 
    from Sales t1 left join Product t2
    on t1.product_id = t2.product_id
    group by t1.user_id, t2.product_id
)

select user_id, 
product_id
from cet
where rnk = 1
