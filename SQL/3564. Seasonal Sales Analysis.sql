# Write your MySQL query statement below
with tb as 
(
    select
    case when month(sale_date) in (12, 1, 2) then 'Winter' 
    when month(sale_date) in (3, 4, 5) then 'Spring'
    when month(sale_date) in (6, 7, 8) then 'Summer'
    when month(sale_date) in (9, 10, 11) then 'Fall' end as season, 
    category,
    sum(quantity) as quantity, 
    sum(quantity * price) as total_revenue
    from sales s left join products p 
    on s.product_id = p.product_id 
    group by 1, 2
)
select 
season, 
category, 
quantity as total_quantity, 
total_revenue
from 
(
    select 
    season, 
    category, 
    quantity, 
    total_revenue, 
    dense_rank() over(partition by season order by quantity desc, total_revenue desc) as rnk
    from tb 
) tmp 
where rnk = 1
