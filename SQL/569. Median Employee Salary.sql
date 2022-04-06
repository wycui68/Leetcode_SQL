# floor -> largest integer <= a number
select id, company, salary
from 
    (
        select id, company, salary, 
        row_number() over(partition by company order by salary) as row_num, 
        count(*) over(partition by company) as cnt
        from Employee
    ) t
where (cnt % 2 = 1 and row_num = floor(cnt/2) + 1)
or (cnt % 2 = 0 and (row_num = floor(cnt/2) + 1 or row_num = floor(cnt/2)))
