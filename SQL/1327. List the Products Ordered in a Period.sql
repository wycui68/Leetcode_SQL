select t1.product_name, t2.unit
from Products t1 join 
(
    select product_id, sum(unit) as unit
    from Orders
    where order_date between '2020-02-01' and '2020-02-29'
    group by product_id
    having sum(unit) >= 100
) t2 on t1.product_id = t2.product_id
