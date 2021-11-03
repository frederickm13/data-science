select cr.city_id, c.city, c.country, cq.column_name, cq.row_name, cr.response
from city_responses as cr
inner join city_questions as cq on cr.question_id = cq.id
inner join cities as c on cr.city_id = c.account_number
where cq.question_number = '9.1'
	and cr.survey_year = 2018
	and response is not null
	and column_name = 'MW capacity'
union all
select cr.city_id, c.city, c.country, cq.column_name, cq.row_name, cr.response
from city_responses as cr
inner join city_questions as cq on cr.question_id = cq.id
inner join cities as c on cr.city_id = c.account_number
where cq.question_number = '8.5'
	and cr.survey_year = 2019
	and response is not null
	and column_name = 'MW capacity'
union all
select cr.city_id, c.city, c.country, cq.column_name, cq.row_name, cr.response
from city_responses as cr
inner join city_questions as cq on cr.question_id = cq.id
inner join cities as c on cr.city_id = c.account_number
where cq.question_number = '8.4'
	and cr.survey_year = 2020
	and response is not null
	and column_name = 'MW capacity'