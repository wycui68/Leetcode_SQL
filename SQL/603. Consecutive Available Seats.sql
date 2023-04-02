select distinct c1.seat_id as seat_id
from Cinema c1  join Cinema c2
on abs(c1.seat_id - c2.seat_id) = 1
and c1.free = 1 and c2.free = 1
group by c1.seat_id
order by c1.seat_id
