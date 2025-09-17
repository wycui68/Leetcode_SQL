# Write your MySQL query statement below
select
t1.employee_id, 
count(*) as overlapping_shifts
from EmployeeShifts t1 join EmployeeShifts t2 
on t1.employee_id = t2.employee_id 
and  t1.start_time < t2.start_time 
and t1.end_time > t2.start_time
group by t1.employee_id 
order by 1
