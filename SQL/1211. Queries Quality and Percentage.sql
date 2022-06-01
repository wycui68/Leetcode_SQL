with cet as 
(
    select query_name, 
           rating, 
           rating/position as quality
    from Queries
)

select query_name, 
       round(avg(quality), 2) as quality, 
       round(100 * sum(case when rating < 3 then 1 else 0 end) / count(*), 2) as poor_query_percentage
from cet
group by query_name
