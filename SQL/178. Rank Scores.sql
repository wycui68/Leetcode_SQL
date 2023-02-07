select score, 
dense_rank() over(order by score desc) as "rank" 
from Scores

# dense_rank -> rank numers are consecutive numbers
