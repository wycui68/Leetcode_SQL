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

# window function 
# rows between -> based on the row number 
# range between -> based on the row values -> this problem req. 6 previous days
# min() -> output only one row w/ min of the table
# min() over() -> output each window w/min min of the table 

select visited_on, 
amount, 
round(amount/7, 2) as average_amount
from 
(
select distinct visited_on, 
sum(amount) over(order by visited_on range between interval 6 day preceding and current row) as amount, 
min(visited_on) over() as min_dt
from Customer
) tmp
where datediff(visited_on, min_dt) >= 6
order by visited_on
