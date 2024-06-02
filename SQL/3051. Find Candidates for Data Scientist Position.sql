select distinct candidate_id
from Candidates
where skill in ('Python', 'Tableau', 'PostgreSQL')
group by 1
having count(*) >= 3
order by 1; 
