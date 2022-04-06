select round(sum(num) / count(num), 1) as median
from 
    (
        select num, frequency, 
        sum(frequency) over() as total_number, 
        sum(frequency) over(order by num) as cumulative_freq
        from Numbers
    ) t
where total_number /2.0 between cumulative_freq - frequency and cumulative_freq
