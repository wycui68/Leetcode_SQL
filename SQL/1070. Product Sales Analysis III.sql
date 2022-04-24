with first_year as 
(
    select *
    from Sales
    where (product_id, year) in 
        (
            select product_id, min(year)
            from Sales
            group by product_id
        )
)

select t1.product_id, 
       t1.year as first_year, 
       t1.quantity as quantity, 
       t1.price as price
from first_year as t1
