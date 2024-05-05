with tb as 
(
    select flight_id, 
    count(distinct passenger_id) as passenger_cnt
    from Passengers
    group by flight_id
)
select t.flight_id, 
ifnull(case when capacity <= passenger_cnt then capacity 
else passenger_cnt end, 0) as booked_cnt, 
ifnull(case when capacity >= passenger_cnt then 0 
else passenger_cnt - capacity end, 0) as waitlist_cnt
from Flights t left join tb 
on t.flight_id = tb.flight_id
order by 1;
