with tb_seller as 
(
select t1.seller_id, 
count(distinct t2.item_id) as num_items
from Users t1 left join Orders t2 
on t1.seller_id = t2.seller_id 
left join Items t3 
on t2.item_id = t3.item_id
where favorite_brand != item_brand
group by t1.seller_id
)
, tb_rnk as 
(
select seller_id, 
num_items, 
dense_rank() over(order by num_items desc) as rnk 
from tb_seller
)
select seller_id, 
num_items
from tb_rnk
where rnk = 1
order by 1; 
