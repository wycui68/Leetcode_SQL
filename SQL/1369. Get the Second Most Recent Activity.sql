with cet1 as 
(
    select username, activity, startDate, endDate, 
    row_number() over(partition by username order by startDate desc) as row_num
    from UserActivity
)

select username, activity, startDate, endDate
from cet1
where row_num = 2
union all
select *
from UserActivity
group by username
having count(distinct activity) = 1
