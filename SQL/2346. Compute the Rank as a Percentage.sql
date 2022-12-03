with cet as 
(
    select student_id, 
    department_id, 
    rank() over(partition by department_id order by mark desc) as rnk, 
    count(student_id) over(partition by department_id) as cnt
    from Students
)

select student_id, 
department_id, 
round(
    ifnull((rnk - 1) * 100 / (cnt - 1), 0), 2
) as percentage
from cet

# differnece between dense_rank and rank 
