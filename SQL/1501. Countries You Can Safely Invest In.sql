with cet1 as 
(
    select caller_id,duration 
    from Calls
    union all
    select callee_id as caller_id, duration 
    from Calls
), cet2 as
(
    select p.id, c1.name
    from Person p left join Country c1
    on left(phone_number, 3) = c1.country_code
)

select name as country
from cet1 left join cet2
on cet1.caller_id = cet2.id
group by name
having avg(duration) > (select avg(duration) from Calls)
