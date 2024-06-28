# Write your MySQL query statement below
with tb_lot as 
(
    select car_id, 
    lot_id, 
    sum(timestampdiff(second, entry_time, exit_time)/3600) as tot_time, 
    sum(fee_paid) as tot_fee
    from ParkingTransactions
    group by car_id, lot_id
)
select p.car_id, 
sum(fee_paid) as total_fee_paid, 
round(sum(fee_paid) / sum(timestampdiff(second, entry_time, exit_time)/3600), 2) as avg_hourly_fee, 
tb2.lot_id as most_time_lot
from parkingtransactions p left join 
(
    select *, 
    row_number() over(partition by car_id order by tot_time desc) as rnk 
    from tb_lot
) tb2 
on p.car_id = tb2.car_id 
and tb2.rnk = 1
group by car_id
order by 1; 
