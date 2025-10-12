# Write your MySQL query statement below
with tb_pos as 
(
    select
    patient_id, 
    min(test_date) as pos_dt
    from covid_tests
    where result = 'Positive'
    group by 1
)
, tb_neg as 
(
    select
    c1.patient_id, 
    min(c1.test_date) as neg_dt
    from covid_tests c1 join tb_pos c2 
    on c1.patient_id = c2.patient_id 
    where c1.test_date > c2.pos_dt
    and c1.result = 'Negative'
    group by 1
)
select
p1.*, 
datediff(neg_dt, pos_dt) as recovery_time
from patients p1 join tb_pos p2 
on p1.patient_id = p2.patient_id 
join tb_neg p3 
on p2.patient_id = p3.patient_id 
order by 4, 2
