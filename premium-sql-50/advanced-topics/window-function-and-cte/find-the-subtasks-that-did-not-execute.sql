with recursive all_sub_tasks as (
    select task_id, subtasks_count
    from tasks
    union all
    select task_id, subtasks_count - 1
    from all_sub_tasks
    where subtasks_count > 1
)

select task_id, subtasks_count as subtask_id
from all_sub_tasks
where (task_id, subtasks_count) not in (select * from executed)
