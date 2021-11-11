select cr.survey_year, cr.city_id, cr.response, q.row_number, q.response
from city_responses as cr
inner join city_questions as cq on cr.question_id = cq.id
inner join (
	select city_questions.id,
		city_questions.column_number, 
		city_questions.row_number, 
		city_responses.city_id, 
		city_responses.response
	from city_responses
	inner join city_questions on city_responses.question_id = city_questions.id
	where city_questions.column_name = 'Amount'
		and city_responses.survey_year = 2018
		and city_responses.response is not null
		and city_questions.question_number = '6.5'
) as q on cq.row_number = q.row_number
	and cr.city_id = q.city_id
where cq.question_number = '6.5'
	and cq.column_name = 'Source'
	and cr.survey_year = 2018
	and cr.response is not null
union all
select cr.survey_year, cr.city_id, cr.response, q.row_number, q.response
from city_responses as cr
inner join city_questions as cq on cr.question_id = cq.id
inner join (
	select city_questions.id,
		city_questions.column_number, 
		city_questions.row_number, 
		city_responses.city_id, 
		city_responses.response
	from city_responses
	inner join city_questions on city_responses.question_id = city_questions.id
	where city_questions.column_name = 'Amount'
		and city_responses.survey_year = 2019
		and city_responses.response is not null
		and city_questions.question_number = '7.5'
) as q on cq.row_number = q.row_number
	and cr.city_id = q.city_id
where cq.question_number = '7.5'
	and cq.column_name = 'Source'
	and cr.survey_year = 2019
	and cr.response is not null
