insert into corp_emissions_tall
(corp_id, year, category, scope, emissions)
select cr.corp_id, 
	cr.survey_year, 
	null,
	1,
	cast(cr.response as decimal)
from corp_responses as cr
inner join corp_questions as cq on cr.question_id = cq.id
where cq.question_number = 'C6.1'
		and cq.column_name like '%emissions%'
		and cr.survey_year = 2018
		and response is not null
union all
select cr.corp_id,
	cr.survey_year,
	'Location-Based',
	2,
	cast(cr.response as decimal)
from corp_responses as cr
inner join corp_questions as cq on cr.question_id = cq.id
where cq.question_number = 'C6.3'
		and cq.column_name like '%location%'
		and cr.survey_year = 2018
		and response is not null
union all
select cr.corp_id,
	cr.survey_year,
	'Market-Based',
	2,
	cast(cr.response as decimal)
from corp_responses as cr
inner join corp_questions as cq on cr.question_id = cq.id
where cq.question_number = 'C6.3'
		and cq.column_name like '%market%'
		and cr.survey_year = 2018
		and response is not null
union all
select cr.corp_id,
	cr.survey_year,
	cq.row_name,
	3,
	cast(cr.response as decimal)
from corp_responses as cr
inner join corp_questions as cq on cr.question_id = cq.id
where cq.question_number = 'C6.5'
		and cq.column_name like '%Metric%'
		and cr.survey_year = 2018
		and response is not null
union all
select cr.corp_id, 
	cr.survey_year, 
	null,
	1,
	cast(cr.response as decimal)
from corp_responses as cr
inner join corp_questions as cq on cr.question_id = cq.id
where cq.question_number = 'C6.1'
		and cq.column_name like '%emissions%'
		and cr.survey_year = 2019
		and response is not null
union all
select cr.corp_id,
	cr.survey_year,
	'Location-Based',
	2,
	cast(cr.response as decimal)
from corp_responses as cr
inner join corp_questions as cq on cr.question_id = cq.id
where cq.question_number = 'C6.3'
		and cq.column_name like '%location%'
		and cr.survey_year = 2019
		and response is not null
union all
select cr.corp_id,
	cr.survey_year,
	'Market-Based',
	2,
	cast(cr.response as decimal)
from corp_responses as cr
inner join corp_questions as cq on cr.question_id = cq.id
where cq.question_number = 'C6.3'
		and cq.column_name like '%market%'
		and cr.survey_year = 2019
		and response is not null
union all
select cr.corp_id,
	cr.survey_year,
	cq.row_name,
	3,
	cast(cr.response as decimal)
from corp_responses as cr
inner join corp_questions as cq on cr.question_id = cq.id
where cq.question_number = 'C6.5'
		and cq.column_name like '%Metric%'
		and cr.survey_year = 2019
		and response is not null
union all
select cr.corp_id, 
	cr.survey_year, 
	null,
	1,
	cast(cr.response as decimal)
from corp_responses as cr
inner join corp_questions as cq on cr.question_id = cq.id
where cq.question_number = 'C6.1'
		and cq.column_name like '%emissions%'
		and cr.survey_year = 2020
		and response is not null
		and cq.row_name = 'Reporting year'
union all
select cr.corp_id,
	cr.survey_year,
	'Location-Based',
	2,
	cast(cr.response as decimal)
from corp_responses as cr
inner join corp_questions as cq on cr.question_id = cq.id
where cq.question_number = 'C6.3'
		and cq.column_name like '%location%'
		and cr.survey_year = 2020
		and response is not null
		and cq.row_name = 'Reporting year'
union all
select cr.corp_id,
	cr.survey_year,
	'Market-Based',
	2,
	cast(cr.response as decimal)
from corp_responses as cr
inner join corp_questions as cq on cr.question_id = cq.id
where cq.question_number = 'C6.3'
		and cq.column_name like '%market%'
		and cr.survey_year = 2020
		and response is not null
		and cq.row_name = 'Reporting year'
union all
select cr.corp_id,
	cr.survey_year,
	cq.row_name,
	3,
	cast(cr.response as decimal)
from corp_responses as cr
inner join corp_questions as cq on cr.question_id = cq.id
where cq.question_number = 'C6.5'
		and cq.column_name like '%Metric%'
		and cr.survey_year = 2020
		and response is not null

delete from corp_emissions_tall
where emissions is null
	or emissions <= 0

delete from corp_emissions_tall
where category is null