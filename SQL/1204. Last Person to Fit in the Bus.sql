select person_name
from 
(
select person_id, 
person_name, 
weight, 
turn, 
sum(weight) over(order by turn ) as tot
from Queue
) tmp
where tot <= 1000
order by turn desc
limit 1
