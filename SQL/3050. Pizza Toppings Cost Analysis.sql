select
concat(t1.topping_name, ",", t2.topping_name, ",", t3.topping_name) as pizza,
round(t1.cost + t2.cost + t3.cost, 2) as total_cost

from Toppings t1 join Toppings t2 join Toppings t3
on t1.topping_name < t2.topping_name and t2.topping_name < t3.topping_name
order by 2 desc, 1;
