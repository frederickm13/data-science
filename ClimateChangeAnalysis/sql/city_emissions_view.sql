-- View: public.cities_emissions

-- DROP VIEW public.cities_emissions;

CREATE OR REPLACE VIEW public.cities_emissions
 AS
 SELECT cr.city_id,
    cr.survey_year AS year,
    cast(nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') as decimal) AS emissions
   FROM city_responses cr
     JOIN city_questions cq ON cr.question_id = cq.id
     JOIN cities c ON cr.city_id = c.account_number
  WHERE cq.question_number::text = '7.3a'::text AND cr.survey_year = 2018 
  AND cq.column_name::text ~~ '%Emissions%'::text
  AND cq.row_name::text = 'TOTAL BASIC emissions'::text 
UNION ALL
 SELECT cr.city_id,
    cr.survey_year AS year,
    cast(nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') as decimal) AS emissions
   FROM city_responses cr
     JOIN city_questions cq ON cr.question_id = cq.id
     JOIN cities c ON cr.city_id = c.account_number
  WHERE cq.question_number::text = '4.6b'::text AND cr.survey_year = 2019 
  AND cq.column_name::text ~~ '%Emissions%'::text
  AND cq.row_name::text = 'TOTAL BASIC emissions'::text 
UNION ALL
 SELECT cr.city_id,
    cr.survey_year AS year,
    cast(nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') as decimal) AS emissions
   FROM city_responses cr
     JOIN city_questions cq ON cr.question_id = cq.id
     JOIN cities c ON cr.city_id = c.account_number
  WHERE cq.question_number::text = '4.6b'::text AND cr.survey_year = 2020 
  AND cq.column_name::text ~~ '%Emissions%'::text 
  AND cq.row_name::text = 'TOTAL BASIC emissions'::text 

