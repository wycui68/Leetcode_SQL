with cet1 as 
(
    select item_id, dayname(order_date) as 'day_time', quantity
    from Orders
), cet2 as 
(
    select item_id, day_time, 
    sum(quantity) as tot
    from cet1
    group by item_id, day_time
), cet3 as 
(
    select t1.item_category, cet2.*
    from Items t1 left join cet2
    on t1.item_id = cet2.item_id
)

select item_category as CATEGORY, 
ifnull(sum(case when day_time = 'Monday' then tot end), 0) as 'MONDAY',
ifnull(sum(case when day_time = 'Tuesday' then tot end), 0) as 'TUESDAY',
ifnull(sum(case when day_time = 'Wednesday' then tot end), 0) as 'WEDNESDAY',
ifnull(sum(case when day_time = 'Thursday' then tot end), 0) as 'THURSDAY',
ifnull(sum(case when day_time = 'Friday' then tot end), 0) as 'FRIDAY',
ifnull(sum(case when day_time = 'Saturday' then tot end), 0) as 'SATURDAY',
ifnull(sum(case when day_time = 'Sunday' then tot end), 0) as 'SUNDAY'

from cet3
group by item_category
order by 1
