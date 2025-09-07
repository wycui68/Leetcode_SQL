# Write your MySQL query statement below
with tb0 as 
(
select *, 
3*wins + draws points
from TeamStats
)
, tb1 as 
(
select *, 
count(*) over() rnk, 
rank() over(order by points desc) position
from tb0
)

select team_name, 
points, 
position, 
case when position < rnk/3 + 1 then 'Tier 1'
when position < 2 * (rnk/3) + 1 then 'Tier 2'
else 'Tier 3' end tier
from tb1
order by 2 desc, 1
