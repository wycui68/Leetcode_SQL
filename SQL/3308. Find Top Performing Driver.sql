# Write your MySQL query statement below
with tb as
(
    select
    fuel_type, 
    t2.driver_id, 
    round(avg(rating), 2) as rating, 
    sum(distance) as distance 
    from Trips t1 left join Vehicles t2 
    on t1.vehicle_id = t2.vehicle_id 
    left join Drivers t3 
    on t2.driver_id = t3.driver_id
    group by 1, 2
)

select 
fuel_type, 
tmp.driver_id, 
rating, 
distance
from 
(
    select *, 
    dense_rank() over(partition by fuel_type order by rating desc, distance desc) as rnk 
    from tb
) tmp 
where rnk = 1
order by 1; 
