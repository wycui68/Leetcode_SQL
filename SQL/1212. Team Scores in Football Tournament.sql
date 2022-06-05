with cet1 as 
(
    select team_id, team_name, 
    (case when host_goals > guest_goals then 3 
         when host_goals = guest_goals then 1 
         else 0 end) as points
    from Teams t join Matches m on t.team_id = m.host_team
), cet2 as
(
select team_id, team_name, 
     (case when guest_goals > host_goals then 3 
         when host_goals = guest_goals then 1 
         else 0 end) as points
from Teams t join Matches m on t.team_id = m.guest_team
), cet3 as 
(
    select *
    from cet1
    union all 
    select *
    from cet2
)

select t.*, 
ifnull(num_points, 0) as num_points
from Teams t left join
    (
        select team_id, team_name, sum(points) as num_points
        from cet3
        group by team_id
    ) tmp
on t.team_id = tmp.team_id
order by num_points desc, team_id 
