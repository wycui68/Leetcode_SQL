# Write your MySQL query statement below
with t1 as 
(
    select s.student_id, 
    c.course_id
    from students s left join courses c 
    on s.major = c.major
)

select t1.student_id
from t1 left join enrollments t2 
on t1.student_id = t2.student_id 
and t1.course_id = t2.course_id
and grade = 'A'
group by t1.student_id 
having count(t1.course_id) = sum(grade = 'A')
order by 1;
