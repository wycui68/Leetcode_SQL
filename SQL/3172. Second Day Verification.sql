# Write your MySQL query statement below
with tb as 
(
    select t1.user_id, 
    date_format(signup_date, '%Y-%m-%d') as signup_date, 
    date_format(action_date, '%Y-%m-%d') as action_date
    from emails t1 left join texts t2 
    on t1.email_id = t2.email_id 
    where t2.signup_action = 'Verified'
)
select user_id

from tb
where datediff(action_date, signup_date) = 1
order by 1;
