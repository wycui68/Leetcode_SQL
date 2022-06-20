with cet1 as 
(
    select name
    from MovieRating m left join Users u
    on m.user_id = u.user_id
    group by m.user_id
    order by count(*) desc, name
    limit 1
), cet2 as
(
    select title
    from MovieRating m1 left join Movies m2
    on m1.movie_id = m2.movie_id
    where created_at between '2020-02-01' and '2020-02-28'
    group by m1.movie_id
    order by avg(rating) desc, title
    limit 1
)

select name as results
from cet1
union all 
select title 
from cet2

