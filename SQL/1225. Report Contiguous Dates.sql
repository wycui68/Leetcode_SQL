select 'failed' as period_state, min(fail_date) as start_date, max(fail_date) as end_date
from 
(
    select fail_date, row_number() over(order by fail_date) as row_num
    from Failed
    where fail_date between '2019-01-01' and '2019-12-31'
) t1
group by dayofyear(fail_date) - row_num

union all

select 'succeeded' as period_state, min(success_date) as start_date, max(success_date) as end_date
from 
(
    select success_date, row_number() over(order by success_date) as row_num
    from Succeeded
    where success_date between '2019-01-01' and '2019-12-31'
) t1
group by dayofyear(success_date) - row_num
order by start_date
