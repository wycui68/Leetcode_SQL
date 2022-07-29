with cet1 as
(
    select order_id, order_date, product_id, 
    dense_rank() over(partition by product_id order by order_date desc) as rnk
    from Orders
)

select p.product_name, 
       cet1.product_id, 
       cet1.order_id, 
       cet1.order_date
from cet1 left join Products p
on cet1.product_id = p.product_id
where rnk = 1
order by  product_name, product_id, order_id
