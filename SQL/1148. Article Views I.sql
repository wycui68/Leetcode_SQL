select distinct author_id as id
from Views
where author_id = viewer_id
group by article_id
having count(distinct article_id) >= 1
order by author_id 
