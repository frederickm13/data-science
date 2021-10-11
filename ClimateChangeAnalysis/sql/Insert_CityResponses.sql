insert into city_responses (
	question_id,
	city_id,
	survey_year,
	response,
	comments
)
select cq.id,
	csv.account_number,
	csv.year_reported_to_cdp,
	csv.response_answer,
	csv.comments
from city_questions_csv as csv
left outer join city_questions as cq on csv.questionnaire = cq.questionnaire
	and csv.year_reported_to_cdp = cq.survey_year
	and csv.question_number = cq.question_number
	and cast (csv.column_number as smallint) = cq.column_number
	and csv.row_number = cq.row_number;