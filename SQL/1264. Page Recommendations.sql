with cet1 as
(
    select user1_id as user1, user2_id as user2
    from Friendship
    where user1_id = 1
    union all
    select user2_id as user1, user1_id as user2
    from Friendship
    where user2_id = 1
)

select distinct page_id as recommended_page
from Likes
where user_id in 
(
    select user2
    from cet1
) and page_id not in 
(
    select page_id
    from Likes
    where user_id = 1
)
