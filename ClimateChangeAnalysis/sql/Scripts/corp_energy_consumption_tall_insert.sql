insert into corp_energy_consumption_tall
(corp_id, year, category, renewable, consumption)
select cr.corp_id,
	cr.survey_year,
	cq.row_name,
	true,
	cast(cr.response as decimal)
from corp_responses as cr
inner join corp_questions as cq on cr.question_id = cq.id
where cq.question_number = 'C8.2a'
	and cq.column_number = 2
union all 
select cr.corp_id,
	cr.survey_year,
	cq.row_name,
	false,
	cast(cr.response as decimal)
from corp_responses as cr
inner join corp_questions as cq on cr.question_id = cq.id
where cq.question_number = 'C8.2a'
	and cq.column_number = 3

delete from corp_energy_consumption_tall
where consumption is null

delete from corp_energy_consumption_tall
where category like '%Total%'