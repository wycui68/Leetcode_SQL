select 
sum(t1.apple_count + ifnull(t2.apple_count, 0)) as apple_count, 
sum(t1.orange_count + ifnull(t2.orange_count, 0)) as orange_count
from Boxes t1 left join Chests t2
on t1.chest_id = t2.chest_id 
