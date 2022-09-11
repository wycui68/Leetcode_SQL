with cet as 
    (
        select user_id
        , purchase_date
        , lead(purchase_date) over(partition by user_id order by purchase_date) as next_one
        from Purchases
    )
    
select distinct user_id

from cet
where datediff(next_one, purchase_date) <= 7
