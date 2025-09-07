# Write your MySQL query statement below
with tb as 
(
select team_id, 
team_name, 
3 * wins + draws as points, 
rank() over(order by 3 * wins + draws desc) as position
from TeamStats
)

select team_id, 
team_name, 
points, 
position
from tb
order by points desc, team_name
