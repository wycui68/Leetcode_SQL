# if id is odd but not the last one -> new == id+1
# if id is odd but the last ont -> new == id
# if id the even -> id -1
with cet1 as (
    select *
    from Seat, 
        (
            select count(distinct id) as cnt
            from Seat
        ) t
)

select case when id = cnt and id % 2 = 1 then id
            when id != cnt and id % 2 = 1 then id + 1
            else id - 1 end as id, 
       student
from cet1 
order by id; 
