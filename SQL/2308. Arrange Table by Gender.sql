with cet1 as
    (
        select user_id
        , gender
        , row_number() over(order by user_id) as rnk
        , 0 as ordering
        from Genders
        where gender = 'female'
    ), cet2 as 
        (
        select user_id
        , gender
        , row_number() over(order by user_id) as rnk
        , 1 as ordering
        from Genders
        where gender = 'other'
    ), cet3 as 
    (
        select user_id
        , gender
        , row_number() over(order by user_id) as rnk
        , 2 as ordering
        from Genders
        where gender = 'male'
    ), cet4 as
    (
        select *
        from cet1
        union all
        select *
        from cet2
        union all
        select *
        from cet3
    )
    
select user_id
, gender
from cet4
order by rnk, ordering
