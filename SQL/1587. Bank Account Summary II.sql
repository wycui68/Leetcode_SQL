select t1.name, 
sum(amount) as balance
from Users t1 left join Transactions t2
on t1.account = t2.account
group by t1.name
having balance > 10000;
