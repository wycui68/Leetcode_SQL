with cet1 as 
(
    select candidateId, name
    from Vote t1  join Candidate t2
    on t1.candidateId = t2.id
), cet2 as 
(
select distinct name, 
    count(*) over(partition by name) as cnt
from cet1
)

select name
from cet2
order by cnt desc
limit 1
