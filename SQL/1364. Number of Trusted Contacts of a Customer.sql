# Write your MySQL query statement below
with cet1 as 
(
    select customer_id, ifnull(cnt, 0) as contacts_cnt
    from Customers c1 left join 
        (
            select user_id, count(*) as cnt
            from Contacts
            group by user_id
        ) c2 on c1.customer_id = c2.user_id
), cet2 as 
(
    select user_id, count(*) as trusted_contacts_cnt 
    from Contacts
    where contact_name in 
        (
            select customer_name
            from Customers
        )
    group by user_id
)

select t1.invoice_id, 
       t2.customer_name, 
       t1.price,
       contacts_cnt,
       ifnull(trusted_contacts_cnt, 0) as trusted_contacts_cnt 
from Invoices t1 left join Customers t2
on t1.user_id = t2.customer_id
left join cet1 on t2.customer_id = cet1.customer_id
left join cet2 on cet1.customer_id = cet2.user_id
order by 1
