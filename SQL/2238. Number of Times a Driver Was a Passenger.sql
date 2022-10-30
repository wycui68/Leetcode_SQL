select distinct t1.driver_id, 
ifnull(t2.cnt, 0) as cnt
from Rides t1 left join 
(
select passenger_id, 
count(distinct ride_id) as cnt
from Rides
group by passenger_id
)t2 on t1.driver_id = t2.passenger_id
