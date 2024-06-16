# Write your MySQL query statement below
with tb1 as 
(
    select contact_id, 
    type, 
    duration, 
    row_number() over(partition by type order by duration desc) as rnk 
    from Calls
), 
tb as 
(
    select tb1.*, tb2.first_name
    from tb1 left join Contacts tb2 
    on tb1.contact_id = tb2.id 
    where rnk <= 3
)
select first_name, 
type, 
date_format(sec_to_time(duration), '%H:%i:%s') as duration_formatted
from tb
order by type, duration desc, first_name
