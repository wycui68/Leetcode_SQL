with cet1 as 
(
    select product_id, new_price, 
    row_number() over(partition by product_id order by change_date desc) as rnk
    from Products
    where change_date <= '2019-08-16'
), cet2 as 
(
    select distinct product_id
    from Products  
)

select cet2.*, ifnull(new_price, 10) as price
from cet2 left join 
(
    select product_id, new_price
    from cet1 
    where rnk = 1
) t
on cet2.product_id = t.product_id
