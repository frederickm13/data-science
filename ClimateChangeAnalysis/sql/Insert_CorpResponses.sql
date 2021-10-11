insert into corp_responses (
	question_id,
	corp_id,
	survey_year,
	response,
	comments
)
select cq.id,
	csv.account_number,
	csv.survey_year,
	csv.response_value,
	csv.comments
from corp_questions_csv as csv
left outer join corp_questions as cq on csv.survey_year = cq.survey_year
	and csv.question_number = cq.question_number
	and csv.column_number = cq.column_number
	and csv.row_number = cq.row_number