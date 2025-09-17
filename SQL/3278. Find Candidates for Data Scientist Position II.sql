# Write your MySQL query statement below
with tb0 as 
(
    select candidate_id, 
    project_id, 
    100 + sum(
        case when proficiency > importance then 10 
            when proficiency < importance then -5 
            else 0 end
    ) as score, 
    count(*) as cnt_skill
    from Candidates c left join Projects p 
    on c.skill = p.skill 
    group by 1, 2
)
, tb1 as 
(
    select project_id, 
    candidate_id, 
    score, 
    row_number() over(partition by project_id order by score desc, candidate_id) as rnk 
    from tb0 
    where (project_id, cnt_skill) in 
    (
        select project_id, 
        count(*)
        from Projects
        group by 1
    )
)
select project_id, 
candidate_id, 
score
from tb1 
where rnk = 1
order by 1
