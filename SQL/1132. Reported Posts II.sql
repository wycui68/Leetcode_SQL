with table1 as 
(
    select t1.action_date, 
    100 * count(distinct t2.post_id) / count(distinct t1.post_id) as pct
    from 
    (
        select post_id, 
        action_date
        from Actions 
        where  extra = 'spam'
    ) t1 left join Removals t2 
    on t1.post_id = t2.post_id
    group by t1.action_date
)

select round(sum(pct) / count(distinct action_date), 2) as average_daily_percent
from table1

