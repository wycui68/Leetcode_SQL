# for the desired customer, the number of the products they bought == # products
select distinct customer_id
from Customer
group by customer_id
having count(distinct product_key) = (select count(distinct product_key)
                                      from Product
                                      )
