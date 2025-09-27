# Write your MySQL query statement below
with tb as 
(
    select
    p1.product_id as product1_id, 
    p2.product_id as product2_id, 
    count(p2.user_id) as user_cnt
    from ProductPurchases p1 join ProductPurchases p2 
    on p1.product_id < p2.product_id
    and p1.user_id = p2.user_id
    group by 1, 2
    having count(*) >= 3
)
select tb.product1_id, 
tb.product2_id, 
p3.category as product1_category, 
p4.category as product2_category, 
user_cnt as customer_count
from tb  join ProductInfo p3 
on tb.product1_id = p3.product_id 
join ProductInfo p4
on tb.product2_id = p4.product_id
order by 5 desc, 1, 2
