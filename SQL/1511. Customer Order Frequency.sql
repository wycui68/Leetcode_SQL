select customer_id, name
from Customers
where customer_id in 
(
    select customer_id    
    from Orders t1 left join Product t2
    on t1.product_id = t2.product_id
    where date_format(order_date, '%Y-%m') = '2020-06'
    group by customer_id
    having sum(quantity * price) >= 100
) and customer_id in 
(
    select customer_id    
    from Orders t1 left join Product t2
    on t1.product_id = t2.product_id
    where date_format(order_date, '%Y-%m') = '2020-07'
    group by customer_id
    having sum(quantity * price) >= 100
)
