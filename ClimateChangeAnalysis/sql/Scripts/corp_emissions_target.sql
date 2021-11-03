create or replace view corp_emissions_target
as 
select cr.corp_id, cr.survey_year, cr.response
from corp_responses as cr
inner join corp_questions as cq on cr.question_id = cq.id
	and cq.question_number = 'C4.1'