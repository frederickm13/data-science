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
	and csv.page_name = cq.page_name
	and csv.module_name = cq.module_name
	and csv.question_number = cq.question_number
	and csv.question_unique_reference = cq.question_name
	and csv.column_number = cq.column_number
	and csv.column_name = cq.column_name
	and csv.row_number = cq.row_number
	and csv.row_name = cq.row_name;