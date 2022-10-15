select problem_id
from Problems
where 100 * likes / (likes + dislikes) < 60
order by problem_id
