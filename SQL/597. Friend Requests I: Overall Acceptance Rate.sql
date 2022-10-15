with cet1 as (
select count(distinct requester_id, accepter_id) as accept
from RequestAccepted
), cet2 as (
select count(distinct sender_id, send_to_id) as request
from FriendRequest
)

select round(ifnull((select * from cet1) / (select * from cet2),0),2) as accept_rate


# Follow-up 1: return the accept rate for every month
SELECT IF(req.req = 0, 0.00, round(acp.acp / req.req, 2)) AS accept_rate, acp.month 
FROM (SELECT COUNT(DISTINCT requester_id, accepter_id) AS acp, Month(accept_date) AS month FROM request_accepted) acp, 
    (SELECT COUNT(DISTINCT sender_id, send_to_id) AS req, Month(request_date) AS month FROM friend_request) req 
WHERE acp.month = req.month 
GROUP BY acp.month
/* Result
{
    "headers": ["accept_rate", "month"], 
    "values": [[0.80, 6]]
}
*/

# Follow-up 2: return the cumulative accept rate for every day
# Without null check
SELECT ROUND(
    COUNT(DISTINCT requester_id, accepter_id) / COUNT(DISTINCT sender_id, send_to_id), 2
) AS rate, date_table.dates

FROM request_accepted acp, friend_request req, 
(SELECT request_date AS dates FROM friend_request
UNION
SELECT accept_date FROM request_accepted
ORDER BY dates) as date_table

WHERE acp.accept_date <= date_table.dates
AND req.request_date <= date_table.dates
GROUP BY date_table.dates
/* Result
{
    "headers": ["rate", "dates"], 
    "values": [[0.25, "2016-06-03"], [0.75, "2016-06-08"], [0.80, "2016-06-09"], [0.80, "2016-06-10"]]
}
*/
