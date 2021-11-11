INSERT INTO city_questions (
	questionnaire,
	survey_year,
	parent_section,
	section,
	question_number,
	question_name,
	column_number,
	column_name,
	row_number,
	row_name
)
SELECT DISTINCT
	questionnaire,
	year_reported_to_cdp,
	parent_section,
	section,
	question_number,
	question_name,
	CAST (column_number AS SMALLINT),
	column_name,
	row_number,
	row_name
FROM city_questions_csv;