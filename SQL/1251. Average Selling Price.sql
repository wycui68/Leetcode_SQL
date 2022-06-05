with cet1 as
(
    select t1.product_id, t1.units, t2.price
    from UnitsSold t1 left join Prices t2
    on t1.product_id = t2.product_id 
    and t1.purchase_date between start_date and end_date
)

select distinct product_id, 
round(sum(units * price) / sum(units), 2) as average_price
from cet1
group by product_id
