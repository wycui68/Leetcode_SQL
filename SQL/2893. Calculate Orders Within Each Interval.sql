select ceil(minute / 6) as interval_no, 
sum(order_count) as total_orders
from Orders
group by interval_no
order by 1; 
