with cet1 as
    (
        select project_id, 
               max(experience_years)
        from Project p left join Employee e
        on p.employee_id = e.employee_id
        group by p.project_id
    )
    
select p.*
from Project p left join Employee e
on p.employee_id = e.employee_id
where (project_id, experience_years) in 
    (
        select *
        from cet1
    )
