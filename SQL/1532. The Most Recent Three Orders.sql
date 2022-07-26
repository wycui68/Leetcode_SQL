with cet1 as 
(
    select customer_id, order_date, order_id, 
    row_number() over(partition by customer_id order by order_date desc) as rnk
    from Orders
)

select c.name as customer_name, cet1.customer_id, 
cet1.order_id, cet1.order_date
from cet1 left join Customers c
on cet1.customer_id = c.customer_id
where rnk <= 3
order by name, customer_id, order_date desc
