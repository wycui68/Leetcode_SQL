with cet1 as 
    (
        select event_type, avg(occurences) as 'avg_occ'
        from Events
        group by event_type
    ), cet2 as 
    (
        select business_id, event_type, avg(occurences) as 'avg_per_bus'
        from Events
        group by business_id, event_type
    )
 
 
select business_id
from 
(
    select cet2.business_id, 
    (case when cet2.avg_per_bus > cet1.avg_occ then 1 else 0 end) as cnt
    from cet2 left join cet1
    on cet2.event_type = cet1.event_type
) t
group by business_id
having sum(cnt) > 1;

