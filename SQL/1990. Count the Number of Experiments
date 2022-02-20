with cet as 
(
    select *
    from 
        (
            select "Android" as "platform"
            union all
            select "IOS" as "platform"
            union all 
            select "Web" as "platform"
        ) t1 cross join 
        (
            select "Reading" as "experiment_name"
            union all
            select "Sports" as "experiment_name"
            union all 
            select "Programming" as "experiment_name"
        ) t2
)


select c.platform, c.experiment_name, 
ifnull(count(distinct experiment_id), 0) as "num_experiments"
from cet c left join Experiments e
on c.platform = e.platform and e.experiment_name = c.experiment_name
group by c.platform, c.experiment_name;
