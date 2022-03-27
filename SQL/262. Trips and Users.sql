with cet as 
(
    select id, status, request_at
    from Trips
    where client_id not in 
        (
            select users_id
            from Users
            where banned = 'Yes'
        )
    and driver_id not in 
        (
            select users_id
            from Users
            where banned = 'Yes'
        )  
)

select request_at as "Day",
round(sum(case when status != 'completed' then 1 else 0 end)/
count(distinct id), 2) as 'Cancellation Rate'
from cet
where request_at between "2013-10-01" and "2013-10-03"
group by request_at;
