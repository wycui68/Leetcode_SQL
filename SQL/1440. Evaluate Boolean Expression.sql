select t1.*, 
case when operator = '>' and t2.value > t3.value then 'true'
     when operator = '=' and t2.value = t3.value then 'true'
     when operator = '<' and t2.value < t3.value then 'true'
     else 'false' end as value
from Expressions t1 left join Variables t2
on t1.left_operand = t2.name 
left join Variables t3
on t1.right_operand = t3.name
