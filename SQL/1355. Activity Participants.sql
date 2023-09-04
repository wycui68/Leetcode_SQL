select activity
from Friends
group by activity
having count(*) != (select count(*)
                    from Friends
                    group by activity
                    order by count(*) 
                    limit 1
                    )
and count(*) != (select count(*)
                    from Friends
                    group by activity
                    order by count(*) desc
                    limit 1
                    )
# window function 
with table1 as 
(
    select activity, 
    count(*) over(partition by activity) as cnt
    from Friends
), table2 as 
(
    select activity, 
    rank() over(order by cnt) as rnk_asc, 
    rank() over(order by cnt desc) as rnk_desc
    from table1
)

select distinct activity
from table2
where rnk_asc !=1 and rnk_desc != 1
