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
