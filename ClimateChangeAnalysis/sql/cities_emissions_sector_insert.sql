insert into cities_emissions_sector
(city_id, year, category, emissions)
SELECT cr.city_id,
    cr.survey_year AS year,
	SPLIT_PART(SPLIT_PART(cq.row_name, ':', 1), '–', 1) as category,
    cast(nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') as decimal) AS emissions
   FROM city_responses cr
     JOIN city_questions cq ON cr.question_id = cq.id
     JOIN cities c ON cr.city_id = c.account_number
  WHERE cq.question_number::text = '7.3a'::text AND cr.survey_year = 2018 
  AND cq.column_name::text ~~ '%Emissions%'::text
  and cq.row_name not like '%TOTAL%'
UNION ALL
 SELECT cr.city_id,
    cr.survey_year AS year,
	SPLIT_PART(SPLIT_PART(cq.row_name, ':', 1), '–', 1) as category,
    cast(nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') as decimal) AS emissions
   FROM city_responses cr
     JOIN city_questions cq ON cr.question_id = cq.id
     JOIN cities c ON cr.city_id = c.account_number
  WHERE cq.question_number::text = '4.6b'::text AND cr.survey_year = 2019 
  AND cq.column_name::text ~~ '%Emissions%'::text
  and cq.row_name not like '%TOTAL%'
UNION ALL
 SELECT cr.city_id,
    cr.survey_year AS year,
	SPLIT_PART(SPLIT_PART(cq.row_name, ':', 1), '–', 1) as category,
    cast(nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') as decimal) AS emissions
   FROM city_responses cr
     JOIN city_questions cq ON cr.question_id = cq.id
     JOIN cities c ON cr.city_id = c.account_number
  WHERE cq.question_number::text = '4.6b'::text AND cr.survey_year = 2020 
  AND cq.column_name::text ~~ '%Emissions%'::text 
  and cq.row_name not like '%TOTAL%'

