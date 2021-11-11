-- View: public.cities_transportation_percent_tall

-- DROP VIEW public.cities_transportation_percent_tall;

CREATE OR REPLACE VIEW public.cities_transportation_percent_tall
 AS
 SELECT cr.city_id,
    cq.column_name AS category,
    cr.response AS percentage
   FROM city_responses cr
     JOIN city_questions cq ON cr.question_id = cq.id
     JOIN cities c ON cr.city_id = c.account_number
  WHERE cq.question_number::text = '11.0'::text AND cr.survey_year = 2018 AND cr.response IS NOT NULL AND cr.response::text !~~ '%not applicable%'::text
UNION ALL
 SELECT cr.city_id,
    cq.column_name AS category,
    cr.response AS percentage
   FROM city_responses cr
     JOIN city_questions cq ON cr.question_id = cq.id
     JOIN cities c ON cr.city_id = c.account_number
  WHERE cq.question_number::text = '10.1'::text AND cr.survey_year = 2019 AND cr.response IS NOT NULL AND cr.response::text !~~ '%not applicable%'::text
UNION ALL
 SELECT cr.city_id,
    cq.column_name AS category,
    cr.response AS percentage
   FROM city_responses cr
     JOIN city_questions cq ON cr.question_id = cq.id
     JOIN cities c ON cr.city_id = c.account_number
  WHERE cq.question_number::text = '10.1'::text AND cr.survey_year = 2020 AND cr.response IS NOT NULL AND cr.response::text !~~ '%not applicable%'::text;

ALTER TABLE public.cities_transportation_percent_tall
    OWNER TO fmccollum;

