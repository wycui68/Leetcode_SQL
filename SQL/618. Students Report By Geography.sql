with t1 as 
    (
        select name as America, 
        row_number() over(order by name) as rnk
        from Student
        where continent = 'America'
    ), t2 as 
    (
        select name as Asia, 
        row_number() over(order by name) as rnk
        from Student
        where continent = 'Asia'
    ), t3 as 
    (
        select name as Europe, 
        row_number() over(order by name) as rnk
        from Student
        where continent = 'Europe'
    )
    
select America, Asia, Europe
from t1 left join t2
on t1.rnk = t2.rnk 
left join t3
on t1.rnk = t3.rnk
