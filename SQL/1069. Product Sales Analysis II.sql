select distinct s.product_id, 
       sum(quantity) as total_quantity
from Sales s left join Product p
on s.product_id = p.product_id
group by s.product_id
