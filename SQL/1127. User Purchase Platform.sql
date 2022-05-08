with cet1 as
    (
        select spend_date, 'desktop' as platform
        from Spending
        group by spend_date
        union all
        select spend_date, 'mobile' as platform
        from Spending
        group by spend_date
        union all
        select spend_date, 'both' as platform
        from Spending
        group by spend_date
    ), cet2 as
    (
        select spend_date, 
        if(count(distinct platform) = 1, platform, "both") as platform, 
        sum(amount) as total_amount, 
        count(distinct user_id) as total_users
        from Spending
        group by spend_date, user_id
    )
    
select cet1.*, 
ifnull(sum(cet2.total_amount), 0) as total_amount, 
ifnull(sum(cet2.total_users), 0) as total_users
from cet1 left join cet2
on cet1.spend_date = cet2.spend_date and cet1.platform = cet2.platform
group by cet1.spend_date, cet1.platform

