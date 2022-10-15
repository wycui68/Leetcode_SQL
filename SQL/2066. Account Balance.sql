select account_id, 
day, 
sum(case when type = 'Deposit' then amount 
         when type = 'Withdraw' then (-1)*amount
         else 0 end) over(partition by account_id order by day) as balance
from Transactions
order by account_id, day
