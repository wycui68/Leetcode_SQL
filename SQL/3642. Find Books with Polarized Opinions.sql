# Write your MySQL query statement below

with tb as 
(
    select
    book_id, 
    max(session_rating) - min(session_rating) as rating_spread, 
    round(1.0*sum(case when session_rating >= 4 or session_rating <= 2 then 1 else 0 end )/count(*),2) as polarization_score
    from reading_sessions
    group by book_id
    having count(*) >= 5
    and max(session_rating) >= 4
    and min(session_rating) <= 2
)
select
b.book_id, 
b.title, 
b.author, 
b.genre, 
b.pages, 
tb.rating_spread, 
tb.polarization_score
from books b join tb 
on b.book_id = tb.book_id 
where polarization_score >= 0.6
order by polarization_score desc, title desc;
