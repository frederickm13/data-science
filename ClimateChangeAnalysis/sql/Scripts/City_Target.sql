select c.city, c.country, cq.survey_year, cr.response 
from city_responses as cr
inner join city_questions as cq on cr.question_id = cq.id
inner join cities as c on cr.city_id = c.account_number
where (cq.question_number = '1.4' and cq.survey_year = 2018)
	or (cq.question_number = '1.0' and cq.survey_year = 2019)
	or (cq.question_number = '1.0' and cq.survey_year = 2020)