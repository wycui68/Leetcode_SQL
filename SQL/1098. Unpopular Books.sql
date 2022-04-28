with cet1 as 
(
    select b.book_id, name, ifnull(quantity, 0) as quantity
    from Books b left join 
        (
            select book_id, sum(quantity) as quantity
            from Orders
            where dispatch_date > '2018-06-23' and dispatch_date <= '2019-06-23'
            group by book_id
        ) o on b.book_id = o.book_id 
)

select book_id, name
from cet1
where quantity < 10
and book_id not in 
(
    select book_id
    from Books
    where datediff('2019-06-23', available_from) < 30
)
