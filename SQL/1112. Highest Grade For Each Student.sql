# subquery
select student_id, min(course_id) as course_id, grade
from Enrollments
where (student_id, grade) in 
(
    select student_id, max(grade)
    from Enrollments
    group by student_id
)
group by student_id, grade
order by student_id


# window function 
with cet1 as 
(
    select student_id, 
           course_id, 
           grade, 
           row_number() over(partition by student_id order by grade desc, course_id) as row_num
    from Enrollments
)


select student_id, course_id, grade
from cet1
where row_num = 1
order by 1
