with cet as 
(
select city_id, 
day, 
degree, 
row_number() over(partition by city_id order by degree desc, day) as rnk
from Weather
)

select city_id, 
day, 
degree
from cet
where rnk = 1
