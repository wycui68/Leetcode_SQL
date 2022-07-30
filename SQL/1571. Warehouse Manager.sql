with cet1 as 
(
    select product_id, 
    Width * Length * Height as vol
    from Products
)

select name as warehouse_name, 
sum(units * vol) as volume
from Warehouse w left join cet1 
on w.product_id = cet1.product_id
group by 1
