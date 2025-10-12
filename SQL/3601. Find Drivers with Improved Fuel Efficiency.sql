with first_half as 
(
    select
    driver_id, 
    avg(distance_km/fuel_consumed) as first_half_avg
    from trips
    where month(trip_date) between 1 and 6
    group by 1
)
, second_half as 
(
    select
    driver_id, 
    avg(distance_km/fuel_consumed) as second_half_avg
    from trips
    where month(trip_date) between 7 and 12
    group by 1
)

select
t1.driver_id, 
t1.driver_name, 
round(t2.first_half_avg, 2) as first_half_avg, 
round(t3.second_half_avg, 2) as second_half_avg, 
round(second_half_avg - first_half_avg, 2) as efficiency_improvement
from drivers t1 join first_half t2 
on t1.driver_id = t2.driver_id 
join second_half t3 
on t2.driver_id = t3.driver_id
where second_half_avg > first_half_avg
order by 5 desc, 2

