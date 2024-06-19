with tb_rnk as 
(
    select *, 
    row_number() over(partition by server_id, session_status order by status_time) as rn
    from Servers
)

select floor(sum(timestampdiff(second, t1.status_time, t2.status_time)/(3600*24)))
as total_uptime_days
from tb_rnk t1 join tb_rnk t2 
on t1.server_id = t2.server_id 
and t1.rn = t2.rn
where t1.session_status = 'start' and t2.session_status = 'stop'
