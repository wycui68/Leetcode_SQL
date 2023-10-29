with recursive cet as (
select task_id, subtasks_count, 1 as subtask_id
from Tasks
union all
select task_id, subtasks_count, 1 + subtask_id
from cet
where subtask_id < (select max(subtasks_count)
                    from Tasks)
)

select t1.task_id, t1.subtask_id
from cet t1 left join Executed t2
on t1.task_id = t2.task_id 
and t1.subtask_id = t2.subtask_id
where t2.subtask_id is null
and t1.subtask_id <= t1.subtasks_count
order by t1.task_id, t1.subtask_id
