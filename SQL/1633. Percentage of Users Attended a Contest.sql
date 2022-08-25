with cet1 as 
    (
        select contest_id, count(distinct user_id) as cnt
        from Register
        group by contest_id
    )
    
select contest_id, 
round(cnt / (select count(distinct user_id) from Users) * 100, 2) as percentage
from cet1
order by 2 desc, 1
