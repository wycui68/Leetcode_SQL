select t1.*, ifnull(npv, 0) as npv
from Queries t1 left join NPV t2
on t1.id = t2.id and t1.year = t2.year
