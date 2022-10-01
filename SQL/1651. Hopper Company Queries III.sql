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
    sum(ride_distance) as sum_dist, 
    sum(ride_duration) as sum_dur
    from cet2 left join Rides r 
    on date_format(requested_at, '%Y-%m') = cet2.year_month 
    left join AcceptedRides a 
    on r.ride_id = a.ride_id 
    group by cet2.month
)

select month, 
round(ifnull(sum(sum_dist) over(order by month rows between current row and 2 following)/3,0),2) as average_ride_distance,
round(ifnull(sum(sum_dur) over(order by month rows between current row and 2 following)/3,0),2) as average_ride_duration
from cet3
limit 10

# window=k 滑动窗口函数 over(order by xxx ROWS BETWEEN current row and k-1 following) 
# ROWS BETWEEN current row and k-1/UNBOUNDED following 当前行向后k行
# ROWS BETWEEN k-1/UNBOUNDED preceding and current row 当前行向前k行 UNBOUNDED是指flexible window
