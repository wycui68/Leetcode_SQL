with cet1 as 
(
    select task_id, submit_date, 
    dayofweek(submit_date) as wkday
    from Tasks
), cet2 as
(
    select task_id, 
    (case when wkday = 1  or wkday = 7 then 1 else 0 end) as weekend_cnt,
    (case when wkday != 1 and wkday!= 7 then 1 else 0 end) as working_cnt
    from cet1
    group by task_id
)

select sum(weekend_cnt) as weekend_cnt, 
sum(working_cnt) as working_cnt
from cet2
