select 'bull' as word, 
sum(case when content regexp '( bull )' THEN 1 ELSE 0 END) as count
from Files
union 
select 'bear' as word, 
sum(case when content regexp '( bear )' THEN 1 ELSE 0 END) as count
from Files
