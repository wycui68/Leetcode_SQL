with cet1 as 
(
    select Students.*, Subjects.subject_name
    from Students join Subjects 
), cet2 as
(
    select *, count(*) as attended_exams
    from Examinations 
    group by student_id, subject_name
)

select t1.*, ifnull(attended_exams, 0) as attended_exams
from cet1 t1 left join cet2 t2
on t1.student_id = t2.student_id 
and t1.subject_name = t2.subject_name
order by student_id, subject_name
