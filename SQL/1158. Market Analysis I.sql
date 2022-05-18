with cet1 as 
    (
        select buyer_id, count(distinct order_id) as cnt
        from Orders
        where year(order_date) = '2019'
        group by buyer_id
    )
    
select t1.user_id as buyer_id, 
       join_date, 
       ifnull(cnt, 0) as orders_in_2019
from Users t1 left join cet1
on t1.user_id = cet1.buyer_id
