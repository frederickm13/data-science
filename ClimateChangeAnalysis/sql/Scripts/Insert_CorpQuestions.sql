insert into corp_questions (
	survey_year,
	page_name,
	module_name,
	question_number,
	question_name,
	column_number,
	column_name,
	row_number,
	row_name
)
select distinct 
	cast(survey_year as smallint),
	page_name,
	module_name,
	question_number,
	question_unique_reference,
	column_number,
	column_name,
	row_number,
	row_name
from corp_questions_csv;