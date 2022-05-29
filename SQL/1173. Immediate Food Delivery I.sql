select round(100 * count(distinct delivery_id) / 
(select count(distinct delivery_id) from Delivery), 2) as immediate_percentage
from Delivery
where order_date = customer_pref_delivery_date
