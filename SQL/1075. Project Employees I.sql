select p.project_id, 
       round(avg(experience_years),2) as average_years
from Project p left join Employee t
on p.employee_id = t.employee_id
group by p.project_id
