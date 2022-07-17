select distinct title 
from TVProgram t1 left join Content t2
on t1.content_id = t2.content_id
where year(program_date) = 2020 and month(program_date) = 6
and Kids_content = 'Y' and content_type = 'Movies'
