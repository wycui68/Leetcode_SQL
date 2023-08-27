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

# window function 
select gender, 
day, 
sum(score) over(partition by gender order by day rows between unbounded preceding and current row) as total
from 
(
select gender, 
day, 
sum(score_points) as score
from Scores
group by gender, day
) t

# since we are doing the summation of all the rows prior to the current, we can ignore the syntac of rows between... 
select gender, 
day, 
sum(points_per_day) over(partition by gender order by day) as total
from 
(
  select gender, 
  day, 
  sum(score_points) as points_per_day
  from Scores
  group by gender, day
) t
    
