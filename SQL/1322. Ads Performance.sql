with cet1 as 
(
    select ad_id, 
    round(100 * sum(case when action = 'Clicked' then 1 else 0 end) / count(distinct user_id),2) as ctr
    from Ads
    where action != 'Ignored'
    group by ad_id
)

select distinct t1.ad_id, 
ifnull(ctr, 0) as ctr
from Ads t1 left join cet1
on t1.ad_id = cet1.ad_id
order by ctr desc, ad_id
