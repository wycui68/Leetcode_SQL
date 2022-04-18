select id1 as id, cnt as num
from 
(
    select id1, count(distinct id2) as cnt
    from 
        (
            select distinct requester_id as id1, accepter_id as id2
            from RequestAccepted
            union all
            select accepter_id, requester_id
            from RequestAccepted
        ) t
    group by id1
    order by cnt desc
) tmp
limit 1
