select question_id as survey_log
from 
    (
        select question_id, 
        sum(case when action = 'answer' then 1 else 0 end) / 
        sum(case when action = 'show' then 1 else 0 end) as rate
        from SurveyLog
        where action = 'show' or action = 'answer'
        group by question_id
        order by rate desc, question_id
    ) t
limit 1
