# Write your MySQL query statement below
with tb1 as 
(
    select country, 
    winery, 
    sum(points) as tot_points
    from Wineries
    group by 1, 2
), tb2 as 
(
    select *, 
    dense_rank() over(partition by country order by tot_points desc, winery) as rnk 
    from tb1
)

select country, 
case when rnk = 1 then concat(winery, ' (', tot_points, ')') end as top_winery, 
coalesce(max(case when rnk = 2 then concat(winery, ' (', tot_points, ')') end), 'No second winery') as second_winery, 
coalesce(max(case when rnk = 3 then concat(winery, ' (', tot_points, ')') end), 'No third winery') as third_winery
from tb2
group by 1
order by 1;
