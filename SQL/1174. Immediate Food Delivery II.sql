with cet1 as 
(
    select *, 
    row_number() over(partition by customer_id order by order_date) as row_num
    from Delivery
), cet2 as 
(
    select count(distinct delivery_id) as cnt
    from cet1
    where row_num = 1 and order_date = customer_pref_delivery_date
)

select round(100 * cnt / 
(select count(distinct delivery_id) from cet1 where row_num = 1), 2) as immediate_percentage
from cet2
