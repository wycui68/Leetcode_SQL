#连续日期， 1321类似题
# each year has >= 3 orders and do this in two consecutive years
with cet1 as
(
    select product_id, year(purchase_date) as yr
    from Orders
    group by product_id, yr
    having count(order_id) >= 3
), cet2 as 
(
    select product_id, year(purchase_date) as yr
    from Orders
    group by product_id, yr
    having count(order_id) >= 3
)

select distinct cet1.product_id
from cet1, cet2
where cet1.product_id = cet2.product_id 
and (cet1.yr = cet2.yr or cet1.yr + 1 = cet2.yr)
group by cet1.product_id, cet1.yr
having count(cet2.yr) = 2 
