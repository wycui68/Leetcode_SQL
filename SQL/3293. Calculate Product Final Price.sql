select p.product_id, 
case when discount is not null then price * (1 - discount/100) 
when discount is null then  price end as final_price, 
p.category
from Products p left join Discounts d 
on p.category = d.category
order by 1; 
