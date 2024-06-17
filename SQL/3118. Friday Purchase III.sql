# Write your MySQL query statement below
with tb1 as 
(
    select *
    from 
    (
        select 1 as week_of_month 
        union all 
        select 2 as week_of_month 
        union all 
        select 3 as week_of_month 
        union all 
        select 4 as week_of_month
    ) as weeks 
    cross join 
    (
        select 'Premium' as membership 
        union all 
        select 'VIP'
    ) as types
)
, tb2 as 
(
    select sum(amount_spend) as total_amount_base, 
    u.membership, 
    floor(dayofmonth(purchase_date - 1)/7) + 1 as week_of_month
    from Purchases p join Users u 
    on p.user_id = u.user_id
    where dayofweek(purchase_date) = 6
    group by week_of_month, membership
)
select tb1.*, 
ifnull(tb2.total_amount_base , 0) as total_amount
from tb1 left join tb2
on tb1.week_of_month = tb2.week_of_month 
and tb1.membership = tb2.membership
order by 1, 2
