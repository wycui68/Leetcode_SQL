with tb as 
(
select bike_number, 
end_time,
row_number() over(partition by bike_number order by end_time desc) as rnk
from Bikes
)
select bike_number, 
end_time
from tb
where rnk = 1
