select substring_index(email, '@', -1) as email_domain,
count(distinct id) as count
from Emails
where email like '%.com'
group by 1 
order by 1 ;
