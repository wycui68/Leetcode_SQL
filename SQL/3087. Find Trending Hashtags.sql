select concat("#", substring_index(substring_index(tweet, '#', -1), " ", 1)) as hashtag,
count(*) as hashtag_count
from Tweets
where tweet_date between '2024-02-01' and '2024-02-29'
group by hashtag
order by count(*) desc, hashtag desc
limit 3
