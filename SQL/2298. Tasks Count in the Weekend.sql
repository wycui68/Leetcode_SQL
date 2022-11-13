select 
sum(case when dayofweek(submit_date) = 1 or dayofweek(submit_date) = 7 then 1 else 0 end) as weekend_cnt, 
sum(case when dayofweek(submit_date) != 1 and dayofweek(submit_date) != 7 then 1 else 0 end) as working_cnt
from Tasks
