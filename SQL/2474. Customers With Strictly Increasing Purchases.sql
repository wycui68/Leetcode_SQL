with t1 as 
(
    select *, 
extract(year from order_date) - lag(extract(year from order_date)) over(partition by customer_id order by order_date) as year_diff
    from Orders
)
, t2 as 
(
    select *, 
    extract(year from order_date) as yr
    from t1
    where customer_id not in 
    (
        select distinct customer_id
        from t1 
        where year_diff > 1
    )
)
, t3 as 
(
    select customer_id, yr, 
    sum(price) as price
    from t2
    group by customer_id, yr
)
, t4 as 
(
    select *, 
    price - lag(price) over(partition by customer_id order by yr) as price_diff
    from t3
)
select distinct customer_id
from t4
where customer_id not in 
(
select distinct customer_id
from t4
where price_diff <= 0
)
