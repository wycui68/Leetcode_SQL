select s.*, 
ifnull(sum(tot), 0) as total
from Salesperson s left join 
(
    select distinct t1.customer_id, 
    t1.salesperson_id, 
    sum(price) over(partition by t1.customer_id) as tot
    from Customer t1 left join Sales t2
    on t1.customer_id = t2.customer_id
) c on s.salesperson_id = c.salesperson_id
group by s.salesperson_id
