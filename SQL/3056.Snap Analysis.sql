# Write your MySQL query statement below
with tb1 as 
(
    select t1.user_id, 
    t1.activity_type, 
    t1.time_spent, 
    t2.age_bucket
    from Activities t1 left join Age t2 
    on t1.user_id = t2.user_id
)
, tb2 as 
(
    select age_bucket, 
    sum(case when activity_type = 'open' then time_spent else 0 end) as open_time, 
    sum(case when activity_type = 'send' then time_spent else 0 end) as send_time, 
    sum(time_spent) as tot_time
    from tb1
    group by age_bucket
)

select age_bucket, 
round(100 * send_time/tot_time, 2) as send_perc,
round(100 * open_time/tot_time, 2) as open_perc 

from tb2
