select distinct buyer_id
from Sales
where buyer_id in 
    (
        select buyer_id
        from Sales s left join Product p
        on s.product_id = p.product_id
        where product_name = 'S8'
    ) and buyer_id not in 
    (
        select buyer_id
        from Sales s left join Product p
        on s.product_id = p.product_id
        where product_name = 'iPhone'
    )
