with cet1 as 
(
    select team_id, count(*) as matches_played
    from 
    (
        select home_team_id as team_id
        from Matches
        union all 
        select away_team_id as team_id
        from Matches
    ) t
    group by team_id
), cet2 as 
(
    select t1.team_id, 
    sum(case when t1.team_id = t2.home_team_id and t2.home_team_goals > t2.away_team_goals then 3
             when t1.team_id = t2.away_team_id and t2.away_team_goals > t2.home_team_goals then 3
             when t2.home_team_goals = t2.away_team_goals then 1 else 0 end) as points,

    sum(case when t1.team_id = t2.home_team_id then home_team_goals
             when t1.team_id = t2.away_team_id then away_team_goals end) as goal_for,

    sum(case when t1.team_id = t2.home_team_id then away_team_goals
             when t1.team_id = t2.away_team_id then home_team_goals end) as goal_against
    from Teams t1 left join Matches t2
    on t1.team_id = t2.home_team_id or t1.team_id = t2.away_team_id
    group by t1.team_id
)

select team_name, 
cet1.matches_played,
cet2.points, 
cet2.goal_for,
cet2.goal_against,
cet2.goal_for - cet2.goal_against as goal_diff
from Teams join cet1
on Teams.team_id = cet1.team_id
left join cet2
on cet1.team_id = cet2.team_id
order by points desc, goal_diff desc, team_name
