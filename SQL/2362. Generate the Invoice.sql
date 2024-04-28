with tb1 as 
(
select p1.invoice_id, 
p1.product_id, 
p1.quantity, 
p2.price,
sum(quantity * price) over(partition by invoice_id) as invoice_amt, 
sum(quantity * price) over(partition by invoice_id, p1.product_id) as prod_amt
from Purchases p1 left join Products p2 
on p1.product_id = p2.product_id
)
, tb2 as 
(
select invoice_id, 
row_number() over(order by invoice_amt desc, invoice_id) as rnk 
from tb1
group by 1
)

select tb1.product_id, 
tb1.quantity, 
tb1.prod_amt as price
from tb2 left join tb1
on tb2.invoice_id = tb1.invoice_id
where rnk = 1
