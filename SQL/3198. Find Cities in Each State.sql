select state, 
group_concat(city order by city separator ', ') as cities
from cities
group by state
order by 1; 
