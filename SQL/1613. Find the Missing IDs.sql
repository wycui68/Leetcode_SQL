with recursive cet as 
    (
        select 1 as id
        union all
        select id + 1
        from cet
        where id < (select max(customer_id) from Customers)
    )


select id as ids
from cet
where id not in 
    (
        select customer_id
        from Customers
    )
order by 1
