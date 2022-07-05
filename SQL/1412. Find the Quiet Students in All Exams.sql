with cet1 as 
(
    select student_id, count(distinct exam_id) as cnt
    from Exam
    group by student_id
), cet2 as
(
    select exam_id, student_id, 
    dense_rank() over(partition by exam_id order by score desc) as row_num1
    from Exam
), cet3 as 
(
    select exam_id, student_id, 
    dense_rank() over(partition by exam_id order by score) as row_num2
    from Exam
)

select *
from Student 
where student_id in 
    (
        select student_id
        from cet1
    ) and student_id not in 
    (
        select student_id
        from cet2
        where row_num1 = 1
    ) and student_id not in 
        (
        select student_id
        from cet3
        where row_num2 = 1
    ) 
order by 1
