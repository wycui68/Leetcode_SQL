with cet1 as 
    (
        select seller_id, 
        t1.item_id,
        item_brand,
        row_number() over(partition by seller_id order by order_date) as rnk
        from Orders t1 left join Items t2
        on t1.item_id = t2.item_id
    ), cet2 as 
    (
        select seller_id, item_brand
        from cet1
        where rnk = 2  
    )
    
select t1.user_id as seller_id, 
(case when t1.favorite_brand = cet2.item_brand then 'yes'
else 'no' end) as 2nd_item_fav_brand
from Users t1 left join cet2
on t1.user_id = cet2.seller_id
