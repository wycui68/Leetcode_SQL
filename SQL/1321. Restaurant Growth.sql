#连续日期， 2292类似题
with cet1 as 
(
    select visited_on, sum(amount) as cnt
    from Customer 
    group by visited_on
), cet2 as 
(
    select visited_on, sum(amount) as cnt
    from Customer 
    group by visited_on
)

select cet1.visited_on, 
sum(cet2.cnt) as amount, 
round(avg(cet2.cnt), 2) as average_amount
from cet1, cet2
where datediff(cet1.visited_on, cet2.visited_on) >= 0 and 
datediff(cet1.visited_on, cet2.visited_on) < 7
group by cet1.visited_on
having count(*) = 7
