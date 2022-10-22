##### window function #####
select player_id, 
event_date, 
sum(games_played) over(partition by player_id order by event_date rows between unbounded preceding and current row)
as games_played_so_far
from Activity


##########################
select a1.player_id, 
a1.event_date, 
sum(a2.games_played) as games_played_so_far
from Activity a1 join Activity a2
on a1.player_id = a2.player_id and a1.event_date >= a2.event_date
group by a1.player_id, a1.event_date
