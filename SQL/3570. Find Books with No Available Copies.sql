# Write your MySQL query statement below
select t1.book_id, 
t1.title, 
t1.author, 
t1.genre, 
t1.publication_year, 
t2.current_borrowers
from library_books t1 join 
(
    select book_id, 
    count(*) as current_borrowers
    from borrowing_records
    where return_date is NULL 
    group by book_id
) t2 on t1.book_id = t2.book_id 
and total_copies = current_borrowers
order by 6 desc, 2
