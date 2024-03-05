with medal_winner as 
(
    select contest_id, 
    gold_medal as 'winner'
    from Contests
    union all 
    select contest_id, 
    silver_medal as 'winner'
    from Contests
    union all 
    select contest_id, 
    bronze_medal as 'winner'
    from Contests
), medal_rnk as 
(
    select contest_id, 
    winner, 
    row_number() over(partition by winner order by contest_id) as rnk 
    from medal_winner 
), winner_id as 
(
    select distinct winner
    from medal_rnk 
    group by winner, contest_id - rnk 
    having count(*) >= 3
    union 
    select distinct gold_medal as winner
    from Contests
    group by gold_medal
    having count(*) >=3
)

select name, mail
from winner_id w left join Users u 
on w.winner = u.user_id
