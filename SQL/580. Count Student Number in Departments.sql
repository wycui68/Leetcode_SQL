select t1.dept_name, 
count(distinct student_id) as student_number
from Department t1 left join Student t2
on t1.dept_id = t2.dept_id
group by t1.dept_id
order by student_number desc, dept_name;
