# Write your MySQL query statement below
with tb1 as 
(
    select city, 
    hour(call_time) as hr, 
    count(*) as cnt
    from Calls
    group by city, hour(call_time)
)
, tb2 as 
(
    select city, 
    hr, 
    cnt, 
    dense_rank() over(partition by city order by cnt desc) as rnk 
    from tb1
)

select city, 
hr as peak_calling_hour, 
cnt as number_of_calls
from tb2
where rnk = 1
order by 2 desc, 1 desc;
