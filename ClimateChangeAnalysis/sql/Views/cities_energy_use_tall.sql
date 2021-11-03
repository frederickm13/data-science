-- View: public.cities_energy_use_tall

-- DROP VIEW public.cities_energy_use_tall;

CREATE OR REPLACE VIEW public.cities_energy_use_tall
 AS
 SELECT cr.city_id,
    cq.column_name AS category,
    cr.response AS percentage
   FROM city_responses cr
     JOIN city_questions cq ON cr.question_id = cq.id
     JOIN cities c ON cr.city_id = c.account_number
  WHERE cq.question_number::text = '9.0'::text AND cr.survey_year = 2018 AND cr.response IS NOT NULL AND cq.column_name::text !~~ '%Total%'::text AND cq.column_name::text !~~ '%Year%'::text
UNION ALL
 SELECT cr.city_id,
    cq.column_name AS category,
    cr.response AS percentage
   FROM city_responses cr
     JOIN city_questions cq ON cr.question_id = cq.id
     JOIN cities c ON cr.city_id = c.account_number
  WHERE cq.question_number::text = '8.2'::text AND cr.survey_year = 2019 AND cr.response IS NOT NULL AND cq.column_name::text !~~ '%Total%'::text AND cq.column_name::text !~~ '%Year%'::text
UNION ALL
 SELECT cr.city_id,
    cq.column_name AS category,
    cr.response AS percentage
   FROM city_responses cr
     JOIN city_questions cq ON cr.question_id = cq.id
     JOIN cities c ON cr.city_id = c.account_number
  WHERE cq.question_number::text = '8.1'::text AND cr.survey_year = 2020 AND cr.response IS NOT NULL AND cq.column_name::text !~~ '%Total%'::text AND cq.column_name::text !~~ '%Year%'::text;

ALTER TABLE public.cities_energy_use_tall
    OWNER TO fmccollum;

