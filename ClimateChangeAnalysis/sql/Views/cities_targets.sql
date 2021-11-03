-- View: public.cities_targets

-- DROP VIEW public.cities_targets;

CREATE OR REPLACE VIEW public.cities_targets
 AS
 SELECT c.account_number,
    cq.survey_year AS year,
    cr.response AS target
   FROM city_responses cr
     JOIN city_questions cq ON cr.question_id = cq.id
     JOIN cities c ON cr.city_id = c.account_number
  WHERE cq.question_number::text = '1.4'::text AND cq.survey_year = 2018 OR cq.question_number::text = '1.0'::text AND cq.survey_year = 2019 OR cq.question_number::text = '1.0'::text AND cq.survey_year = 2020;

ALTER TABLE public.cities_targets
    OWNER TO fmccollum;

