with cet as 
(
select host_team as id1, 
guest_team as id2, 
host_goals as goal_1, 
guest_goals as goal_2
from Matches
union all
select guest_team as id1, 
host_team as id2, 
guest_goals as goal_1, 
host_goals as goal_2
from Matches
)

select t1.team_id, 
t1.team_name, 
ifnull(tot, 0) as num_points
from Teams t1 left join 
(
select id1, 
sum(case when goal_1 > goal_2 then 3 
         when goal_1 = goal_2 then 1 
         else 0 end) as tot
from cet
group by id1
) t2 on t1.team_id = t2.id1
order by num_points desc, team_id

###########################################################
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
