with cet as 
(
    select *
    from Transactions
    where state = 'approved'
    union all
    select id, country, 'chargeback' as state, amount, c.trans_date
    from Chargebacks c left join Transactions t
    on c.trans_id = t.id
)

select date_format(trans_date, '%Y-%m') as month, country, 
sum(case when state = 'approved' then 1 else 0 end) as approved_count,
sum(case when state = 'approved' then amount else 0 end) as approved_amount,
sum(case when state = 'chargeback' then 1 else 0 end) as chargeback_count,
sum(case when state = 'chargeback' then amount else 0 end) as chargeback_amount
from cet
group by month, country
