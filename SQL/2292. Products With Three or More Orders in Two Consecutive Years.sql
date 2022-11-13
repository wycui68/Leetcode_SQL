#连续日期， 1321类似题
# each year has >= 3 orders and do this in two consecutive years
# lead/lag window function 

with cet as 
(
select product_id, 
count(distinct order_id) as cnt,
year(purchase_date) as order_year
from Orders
group by product_id, year(purchase_date)
having count(distinct order_id) >= 3
)

select distinct product_id
from 
(
select product_id, 
order_year, 
lag(order_year) over(partition by product_id) as prev
from cet
) t
where order_year - prev = 1
