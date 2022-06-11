# Write your MySQL query statement below
with female as 
(
    select *
    from Scores
    where gender = 'F'
), male as 
(
    select *
    from Scores
    where gender = 'M'
)

select f1.gender, f1.day, sum(f2.score_points) as total
from female f1  join female f2
on f1.day >= f2.day
group by f1.day

union all

select m1.gender, m1.day, sum(m2.score_points) as total
from male m1  join male m2
on m1.day >= m2.day
group by m1.day

order by gender, day
