with cet1 as
(
    select user_id, sum(distance) as travelled_distance
    from Rides
    group by user_id
)

select name, ifnull(travelled_distance, 0) as travelled_distance
from Users t1 left join cet1 t2
on t1.id = t2.user_id
order by 2 desc, 1
