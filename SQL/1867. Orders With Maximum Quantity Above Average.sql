with cet1 as 
(
    select order_id, avg(quantity) as avg_per_order
    from OrdersDetails
    group by order_id
), cet2 as 
(
    select order_id, max(quantity) as max_per_order
    from OrdersDetails
    group by order_id
)

select order_id
from cet2
where max_per_order > (select max(avg_per_order) from cet1)
