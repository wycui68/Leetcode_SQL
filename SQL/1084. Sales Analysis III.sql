with cet1 as
    (
        select product_id
        from Sales
        group by product_id
        having min(sale_date) >= '2019-01-01' and max(sale_date) <= '2019-03-31'
    )
    
select cet1.product_id, p.product_name
from cet1 left join Product p
on cet1.product_id = p.product_id;
