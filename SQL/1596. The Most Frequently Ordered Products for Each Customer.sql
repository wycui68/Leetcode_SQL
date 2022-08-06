with cet1 as
(
    select customer_id, 
    product_id, 
    count(*) as cnt
    from Orders
    group by 1, 2
), cet2 as
(
    select customer_id, 
    product_id, 
    dense_rank() over(partition by customer_id order by cnt desc) as rnk
    from cet1
)

select c.customer_id, 
c.product_id, 
p.product_name
from cet2 c left join Products p
on c.product_id = p.product_id
where rnk = 1
