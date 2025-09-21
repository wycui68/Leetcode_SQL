# Write your MySQL query statement below
with tb as 
(
    select season_id, 
    team_id, 
    team_name, 
    sum(3*wins + draws) as points,
    sum(goals_for) as goals_for, 
    sum(goals_against) as goals_against
    from SeasonStats
    group by 1, 2, 3
)
select
season_id, 
team_id, 
team_name,
points, 
goals_for - goals_against as goal_difference, 
dense_rank() over(partition by season_id order by points desc, goals_for - goals_against desc, team_name) as position
from tb
order by 1, 6, 3
