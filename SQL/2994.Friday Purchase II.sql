with recursive tb1 as 
(
    select '2023-11-01' as purchase_date
    union all 
    select date_add(purchase_date, interval 1 day) as purchase_date
    from tb1
    where purchase_date < '2023-11-30'
)
, tb2 as 
(
    select tb1.purchase_date, 
    if(dayofweek(tb1.purchase_date)=6, 1, 0) as is_friday, 
    sum(ifnull(p.amount_spend, 0)) as total_amount
    from tb1 left join Purchases p 
    on tb1.purchase_date = p.purchase_date
    group by 1
)
select rank() over(order by purchase_date) as week_of_month, 
purchase_date, 
total_amount
from tb2
where is_friday = 1
order by 1;
