# Write your MySQL query statement below
with tb as 
(
    select
    customer_id, 
    count(*) as order_cnt, 
    sum(case when hour(order_timestamp) >= 11 and hour(order_timestamp) < 14 then 1
            when hour(order_timestamp) >= 18 and hour(order_timestamp) < 21 then 1
            else 0 end) as peak_hr_cnt, 
    avg(order_rating) as avg_rating, 
    sum(case when order_rating is not null then 1 else 0 end) as rating_cnt
    from restaurant_orders
    group by customer_id
)

select
customer_id, 
order_cnt as total_orders, 
round(100 * peak_hr_cnt / order_cnt, 0) as peak_hour_percentage, 
round(avg_rating, 2) as average_rating
from tb 
where order_cnt >= 3
and peak_hr_cnt / order_cnt >= 0.6
and avg_rating >= 4.0
and rating_cnt / order_cnt >= 0.5
order by 4 desc, 1 desc
