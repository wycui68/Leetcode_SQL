with cet1 as
    (
        select from_id as person1
        , to_id as person2
        , duration
        from Calls
        where from_id < to_id
        union all
        select to_id as person1
        , from_id as person2
        , duration 
        from Calls
        where from_id > to_id
    )

select person1
, person2
, count(*) as call_count
, sum(duration) as total_duration
from cet1
group by person1, person2
