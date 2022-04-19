select followee as follower, count(*) as num
from Follow
where followee in 
    (
        select distinct followee
        from Follow
        group by followee
        having count(distinct follower) >= 1
    )
and followee in 
    (
        select distinct t2.followee
        from Follow t1 left join Follow t2
        on t1.follower = t2.followee
        group by t2.followee
        having count(distinct t2.follower) >= 1
    )
group by followee
order by follower
