with cet1 as 
(
    select *
    from Sales
    where fruit = 'apples'
), cet2 as 
(
    select *
    from Sales
    where fruit = 'oranges'
)

select cet1.sale_date, cet1.sold_num - cet2.sold_num as diff
from cet1, cet2
where cet1.sale_date = cet2.sale_date
order by 1

#case when 
select sale_date, 
sum(case when fruit = "apples" then sold_num
     when fruit = "oranges" then -sold_num end) as diff
from Sales
group by sale_date
order by 1
