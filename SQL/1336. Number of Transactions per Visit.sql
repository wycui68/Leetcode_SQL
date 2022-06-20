with recursive t1 as
(
select v.*, count(amount) as trans_cnt
from Visits v left join Transactions t
on v.user_id = t.user_id and v.visit_date = t.transaction_date
group by v.user_id, v.visit_date
), t2 as 
(
select 0 as trans_cnt
union all
select trans_cnt + 1
from t2
where trans_cnt < (select max(trans_cnt) from t1)
)

select t2.trans_cnt as transactions_count , count(t1.trans_cnt) as visits_count
from t2 left join t1
on t2.trans_cnt = t1.trans_cnt
group by t2.trans_cnt
