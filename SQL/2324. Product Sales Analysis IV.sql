with cet1 as
(
    select user_id, 
    t1.product_id, 
    sum(price * quantity) as amt
    from Sales t1 left join Product t2
    on t1.product_id = t2.product_id
    group by 1, 2
), cet2 as 
(
    select user_id, product_id, 
    dense_rank() over(partition by user_id order by amt desc) as rnk 
    from cet1
)

select user_id, product_id
from cet2
where rnk = 1
