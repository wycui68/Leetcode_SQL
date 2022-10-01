# Write your MySQL query statement below
with recursive cet1 as
(
    select 1 as month
    union all
    select month + 1
    from cet1
    where month < 12
), cet2 as 
(
    select month, 
    left(date_add('2019-12-01', interval month month), 7) as 'year_month'
    from cet1
), cet3 as
(
    select cet2.month, count(distinct driver_id) as active_drivers
    from cet2 left join Drivers d 
    on date_format(join_date, '%Y-%m') <= cet2.year_month
    group by cet2.month
), cet4 as 
(
    select cet2.month, 
    count(distinct a.driver_id) as driver_cnt
    from cet2 left join Rides r 
    on date_format(requested_at, '%Y-%m') = cet2.year_month 
    left join AcceptedRides a 
    on r.ride_id = a.ride_id 
    group by cet2.month, a.driver_id 
    having count(distinct a.ride_id) >= 1
)

select cet3.month, 
round(ifnull(100 * driver_cnt / active_drivers, 0), 2) as working_percentage
from cet3 left join 
(
    select month, sum(driver_cnt) as driver_cnt
    from cet4
    group by cet4.month
) t on cet3.month = t.month 
