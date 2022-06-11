with cet1 as 
(
    select log_id, 
    row_number() over(order by log_id) as row_num
    from Logs
)

select min(log_id) as start_id, 
max(log_id) as end_id
from cet1
group by log_id - row_num
order by start_id
