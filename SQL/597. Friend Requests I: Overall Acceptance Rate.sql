with cet1 as (
select count(distinct requester_id, accepter_id) as accept
from RequestAccepted
), cet2 as (
select count(distinct sender_id, send_to_id) as request
from FriendRequest
)

select round(ifnull((select * from cet1) / (select * from cet2),0),2) as accept_rate
