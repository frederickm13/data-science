select cr.city_id, c.city, c.country, SPLIT_PART(cq.row_name, ':', 1) as row_name, cq.column_name, cr.response
from city_responses as cr
inner join city_questions as cq on cr.question_id = cq.id
inner join cities as c on cr.city_id = c.account_number
where cq.question_number = '7.3a'
	and cr.survey_year = 2018
    and response is not null
    and column_name like '%Emissions%'
		and response not like '%not%'
union all
select cr.city_id, c.city, c.country, SPLIT_PART(cq.row_name, ':', 1) as row_name, cq.column_name, cr.response
from city_responses as cr
inner join city_questions as cq on cr.question_id = cq.id
inner join cities as c on cr.city_id = c.account_number
where cq.question_number = '4.6b'
	and cr.survey_year = 2019
    and response is not null
    and column_name like '%Emissions%'
		and response not like '%not%'
union all
select cr.city_id, c.city, c.country, SPLIT_PART(cq.row_name, ':', 1) as row_name, cq.column_name, cr.response
from city_responses as cr
inner join city_questions as cq on cr.question_id = cq.id
inner join cities as c on cr.city_id = c.account_number
where cq.question_number = '4.6b'
	and cr.survey_year = 2020
    and response is not null
    and column_name like '%Emissions%'
	and response not like '%not%'