# Write your MySQL query statement below
with tb0 as
(
    select
    student_id, 
    subject, 
    score, 
    dense_rank() over(partition by student_id, subject order by exam_date desc) as rnk1, 
    dense_rank() over(partition by student_id, subject order by exam_date ) as rnk2
    from Scores
    where (student_id, subject) in 
    (
        select student_id, subject
        from Scores
        group by student_id, subject
        having count(distinct exam_date) >= 2
    )
)
select a.student_id, 
a.subject, 
b.score as first_score, 
a.score as latest_score
from tb0 a join tb0 b
on a.student_id = b.student_id 
and a.subject = b.subject
and a.rnk1 = 1 and b.rnk2 = 1
where a.score > b.score
order by 1, 2
