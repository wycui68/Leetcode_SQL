with cet1 as 
(
    select distinct action_date, post_id
    from Actions
    where action = 'report' and extra = 'spam'
), cet2 as 
(
    select cet1.*
    from cet1 join Removals
    on cet1.post_id = Removals.post_id
), cet3 as
(
    select distinct cet1.action_date, 
    100 * count(cet2.post_id)/count(cet1.post_id) as pct
    from cet1 left join cet2
    on cet1.action_date = cet2.action_date and cet1.post_id = cet2.post_id
    group by cet1.action_date
)

select round(avg(pct), 2) as average_daily_percent
from cet3

