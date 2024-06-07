# Write your MySQL query statement below
with tb as 
(
select *, 
percent_rank() over(partition by state order by fraud_score desc) as rnk 
from Fraud
)

select policy_id, 
state, 
fraud_score
from tb
where rnk <= 0.05
order by state, fraud_score desc, policy_id;
