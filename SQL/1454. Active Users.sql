with cet1 as
(
    select *, 
    dense_rank() over(partition by id order by login_date) as rnk
    from Logins
), cet2 as 
(
    select id
    from cet1 
    group by id, date_sub(login_date, interval rnk day)
    having count(distinct login_date) >= 5
)

select distinct a.*
from cet2 left join Accounts a
on cet2.id = a.id
order by 1
