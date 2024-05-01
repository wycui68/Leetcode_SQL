# Write your MySQL query statement below
with tb1 as 
(
    select *, 
    1 / count(candidate) over(partition by voter) as vote
    from Votes
    where candidate is not null
)
, tb2 as 
(
    select candidate, 
    rank() over(order by sum(vote) desc) as vote_rnk
    from tb1
    group by candidate
)
select candidate
from tb2
where vote_rnk = 1
order by 1; 
