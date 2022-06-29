with cet1 as 
(
    select product_id, '2020' as report_year, 
    (datediff(if(period_end <= '2020-12-31', period_end, date('2020-12-31')), 
             if(period_start >= '2020-01-01', period_start, date('2020-01-01'))) +1 ) * average_daily_sales as total_amount
    from Sales
    having total_amount > 0 
), cet2 as 
(
    select product_id, '2019' as report_year, 
    (datediff(if(period_end <= '2019-12-31', period_end, date('2019-12-31')), 
             if(period_start >= '2019-01-01', period_start, date('2019-01-01'))) +1 ) * average_daily_sales as total_amount
    from Sales
    having total_amount > 0 
), cet3 as 
(
    select product_id, '2018' as report_year, 
    (datediff(if(period_end <= '2018-12-31', period_end, date('2018-12-31')), 
             if(period_start >= '2018-01-01', period_start, date('2018-01-01'))) +1 ) * average_daily_sales as total_amount
    from Sales
    having total_amount > 0 
)

select tmp.product_id, p.product_name, 
report_year, total_amount
from 
(
    select *
    from cet1
    union all
    select *
    from cet2
    union all
    select *
    from cet3
) tmp left join Product p 
on tmp.product_id = p.product_id
order by product_id, report_year
