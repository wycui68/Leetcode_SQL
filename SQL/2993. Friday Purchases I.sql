select (week(purchase_date) - week('2023-11-01') + 1) as 'week_of_month',
purchase_date, 
sum(amount_spend) as total_amount
from Purchases
where dayofweek(purchase_date) = 6
group by purchase_date
order by 1;
