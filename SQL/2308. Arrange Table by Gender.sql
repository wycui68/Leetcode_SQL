with cet as 
(
select user_id, 
gender, 
row_number() over(partition by gender order by user_id) as rnk1, 
(case when gender = 'female' then 1 when gender = 'other' then 2 else 3 end) as rnk2
from Genders
)

select user_id, 
gender
from cet
order by rnk1, rnk2
