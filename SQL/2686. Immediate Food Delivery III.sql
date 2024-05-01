# Write your MySQL query statement below
with tb as 
(
    select *, 
    case when order_date = customer_pref_delivery_date then 1 else 0 end as order_ind
    from Delivery
)

select order_date, 
round(100 * ifnull(sum(order_ind) / count(distinct delivery_id), 0), 2) as immediate_percentage
from tb
group by 1
order by 1;
