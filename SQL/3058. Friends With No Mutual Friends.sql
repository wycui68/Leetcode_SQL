# Write your MySQL query statement below
with all_friends as 
(
    select user_id1 as user_id, 
    user_id2 as friend_id
    from Friends
    union all
    select user_id2 as user_id, 
    user_id1 as friend_id
    from Friends
)
, shared_friend as 
(
    select a1.user_id as user_id1, a2.user_id as user_id2
    from all_friends a1 join all_friends a2
    on a1.friend_id = a2.friend_id
)
select *
from Friends
where (user_id1, user_id2) not in 
(
    select user_id1, 
    user_id2
    from shared_friend
)
order by 1, 2;
