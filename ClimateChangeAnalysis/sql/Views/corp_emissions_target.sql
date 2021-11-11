-- View: public.corp_emissions_target

-- DROP VIEW public.corp_emissions_target;

CREATE OR REPLACE VIEW public.corp_emissions_target
 AS
 SELECT cr.corp_id,
    cr.survey_year,
    cr.response
   FROM corp_responses cr
     JOIN corp_questions cq ON cr.question_id = cq.id AND cq.question_number::text = 'C4.1'::text;

ALTER TABLE public.corp_emissions_target
    OWNER TO fmccollum;

