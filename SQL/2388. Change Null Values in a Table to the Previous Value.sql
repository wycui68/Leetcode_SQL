with recursive cet1 as 
(
    select id, drink, 
            row_number() over() as rnk 
    from CoffeeShop
), cet2 as 
(
    select id, drink, rnk
    from cet1
    where rnk = 1
    union all 
    select cet1.id, ifnull(cet1.drink, cet2.drink), cet1.rnk 
    from cet2 join cet1 
    on cet2.rnk = cet1.rnk - 1
)

select id, 
drink 
from cet2
