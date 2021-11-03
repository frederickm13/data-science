select cr.city_id, c.city, c.country, cq.column_name, cq.question_name, cr.response
from city_responses as cr
inner join city_questions as cq on cr.question_id = cq.id
inner join cities as c on cr.city_id = c.account_number
where cq.question_number = '11.0'
	and cr.survey_year = 2018
	and response is not null
	and response not like '%not applicable%'
union all
select cr.city_id, c.city, c.country, cq.column_name, cq.question_name, cr.response
from city_responses as cr
inner join city_questions as cq on cr.question_id = cq.id
inner join cities as c on cr.city_id = c.account_number
where cq.question_number = '10.1'
	and cr.survey_year = 2019
	and response is not null
	and response not like '%not applicable%'
union all
select cr.city_id, c.city, c.country, cq.column_name, cq.question_name, cr.response
from city_responses as cr
inner join city_questions as cq on cr.question_id = cq.id
inner join cities as c on cr.city_id = c.account_number
where cq.question_number = '10.1'
	and cr.survey_year = 2020
	and response is not null
	and response not like '%not applicable%'