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
    select cet2.month, 
    count(distinct driver_id) as active_drivers
    from cet2 left join Drivers d 
    on date_format(join_date, '%Y-%m') <= cet2.year_month
    group by cet2.month
), cet4 as 
(
    select cet2.month, 
    count(distinct a.ride_id) as accepted_rides
    from cet2 left join Rides r 
    on date_format(requested_at, '%Y-%m') = cet2.year_month
    left join AcceptedRides a 
    on r.ride_id = a.ride_id
    group by cet2.month
)


select cet3.month, 
cet3.active_drivers, 
cet4.accepted_rides
from cet3 left join cet4
on cet3.month = cet4.month

# recursive t1 -> month 1--> 12
# date_add add each month on the base onf 2019-12-01
# for the active drivers, count the join_date before the current month
# for the accepted riders, count the accepted date during the current month
