select account_id, 
day, 
sum(case when type = 'Deposit' then amount 
         when type = 'Withdraw' then (-1)*amount
         else 0 end) over(partition by account_id order by day) as balance
from Transactions
order by account_id, day

#########################################################################
# Write your MySQL query statement below
select t1.account_id, 
t1.day, 
sum(case when t2.type="Deposit" then t2.amount 
         when t2.type="Withdraw" then -t2.amount end) as balance
from Transactions t1 left join Transactions t2 
on t1.account_id = t2.account_id 
and t1.day >= t2.day
