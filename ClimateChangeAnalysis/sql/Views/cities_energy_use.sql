-- View: public.cities_energy_use

-- DROP VIEW public.cities_energy_use;

CREATE OR REPLACE VIEW public.cities_energy_use
 AS
 SELECT c.account_number AS city_id,
    2018 AS year,
    coal.coal,
    gas.gas,
    hydro.hydro,
    geothermal.geothermal,
    nuclear.nuclear,
    wind.wind,
    biomass.biomass,
    oil.oil,
    solar.solar,
    other.other
   FROM cities c
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS coal
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '9.0'::text AND cr.survey_year = 2018 AND cr.response IS NOT NULL AND cq.column_name::text = 'Coal'::text) coal ON coal.city_id = c.account_number
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS gas
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '9.0'::text AND cr.survey_year = 2018 AND cr.response IS NOT NULL AND cq.column_name::text = 'Gas'::text) gas ON gas.city_id = c.account_number
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS hydro
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '9.0'::text AND cr.survey_year = 2018 AND cr.response IS NOT NULL AND cq.column_name::text = 'Hydro'::text) hydro ON hydro.city_id = c.account_number
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS geothermal
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '9.0'::text AND cr.survey_year = 2018 AND cr.response IS NOT NULL AND cq.column_name::text = 'Geothermal'::text) geothermal ON geothermal.city_id = c.account_number
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS nuclear
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '9.0'::text AND cr.survey_year = 2018 AND cr.response IS NOT NULL AND cq.column_name::text = 'Nuclear'::text) nuclear ON nuclear.city_id = c.account_number
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS wind
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '9.0'::text AND cr.survey_year = 2018 AND cr.response IS NOT NULL AND cq.column_name::text = 'Wind'::text) wind ON wind.city_id = c.account_number
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS biomass
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '9.0'::text AND cr.survey_year = 2018 AND cr.response IS NOT NULL AND cq.column_name::text = 'Biomass'::text) biomass ON biomass.city_id = c.account_number
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS oil
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '9.0'::text AND cr.survey_year = 2018 AND cr.response IS NOT NULL AND cq.column_name::text = 'Oil'::text) oil ON oil.city_id = c.account_number
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS solar
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '9.0'::text AND cr.survey_year = 2018 AND cr.response IS NOT NULL AND cq.column_name::text = 'Solar'::text) solar ON solar.city_id = c.account_number
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS other
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '9.0'::text AND cr.survey_year = 2018 AND cr.response IS NOT NULL AND cq.column_name::text = 'Other sources'::text) other ON other.city_id = c.account_number
UNION ALL
 SELECT c.account_number AS city_id,
    2019 AS year,
    coal.coal,
    gas.gas,
    hydro.hydro,
    geothermal.geothermal,
    nuclear.nuclear,
    wind.wind,
    biomass.biomass,
    oil.oil,
    solar.solar,
    other.other
   FROM cities c
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS coal
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '8.2'::text AND cr.survey_year = 2019 AND cr.response IS NOT NULL AND cq.column_name::text = 'Coal'::text) coal ON coal.city_id = c.account_number
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS gas
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '8.2'::text AND cr.survey_year = 2019 AND cr.response IS NOT NULL AND cq.column_name::text = 'Gas'::text) gas ON gas.city_id = c.account_number
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS hydro
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '8.2'::text AND cr.survey_year = 2019 AND cr.response IS NOT NULL AND cq.column_name::text = 'Hydro'::text) hydro ON hydro.city_id = c.account_number
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS geothermal
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '8.2'::text AND cr.survey_year = 2019 AND cr.response IS NOT NULL AND cq.column_name::text = 'Geothermal'::text) geothermal ON geothermal.city_id = c.account_number
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS nuclear
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '8.2'::text AND cr.survey_year = 2019 AND cr.response IS NOT NULL AND cq.column_name::text = 'Nuclear'::text) nuclear ON nuclear.city_id = c.account_number
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS wind
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '8.2'::text AND cr.survey_year = 2019 AND cr.response IS NOT NULL AND cq.column_name::text = 'Wind'::text) wind ON wind.city_id = c.account_number
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS biomass
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '8.2'::text AND cr.survey_year = 2019 AND cr.response IS NOT NULL AND cq.column_name::text = 'Biomass'::text) biomass ON biomass.city_id = c.account_number
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS oil
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '8.2'::text AND cr.survey_year = 2019 AND cr.response IS NOT NULL AND cq.column_name::text = 'Oil'::text) oil ON oil.city_id = c.account_number
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS solar
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '8.2'::text AND cr.survey_year = 2019 AND cr.response IS NOT NULL AND cq.column_name::text = 'Solar'::text) solar ON solar.city_id = c.account_number
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS other
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '8.2'::text AND cr.survey_year = 2019 AND cr.response IS NOT NULL AND cq.column_name::text = 'Other sources'::text) other ON other.city_id = c.account_number
UNION ALL
 SELECT c.account_number AS city_id,
    2020 AS year,
    coal.coal,
    gas.gas,
    hydro.hydro,
    geothermal.geothermal,
    nuclear.nuclear,
    wind.wind,
    biomass.biomass,
    oil.oil,
    solar.solar,
    other.other
   FROM cities c
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS coal
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '8.1'::text AND cr.survey_year = 2020 AND cr.response IS NOT NULL AND cq.column_name::text = 'Coal'::text) coal ON coal.city_id = c.account_number
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS gas
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '8.1'::text AND cr.survey_year = 2020 AND cr.response IS NOT NULL AND cq.column_name::text = 'Gas'::text) gas ON gas.city_id = c.account_number
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS hydro
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '8.1'::text AND cr.survey_year = 2020 AND cr.response IS NOT NULL AND cq.column_name::text = 'Hydro'::text) hydro ON hydro.city_id = c.account_number
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS geothermal
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '8.1'::text AND cr.survey_year = 2020 AND cr.response IS NOT NULL AND cq.column_name::text = 'Geothermal'::text) geothermal ON geothermal.city_id = c.account_number
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS nuclear
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '8.1'::text AND cr.survey_year = 2020 AND cr.response IS NOT NULL AND cq.column_name::text = 'Nuclear'::text) nuclear ON nuclear.city_id = c.account_number
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS wind
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '8.1'::text AND cr.survey_year = 2020 AND cr.response IS NOT NULL AND cq.column_name::text = 'Wind'::text) wind ON wind.city_id = c.account_number
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS biomass
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '8.1'::text AND cr.survey_year = 2020 AND cr.response IS NOT NULL AND cq.column_name::text = 'Biomass'::text) biomass ON biomass.city_id = c.account_number
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS oil
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '8.1'::text AND cr.survey_year = 2020 AND cr.response IS NOT NULL AND cq.column_name::text = 'Oil'::text) oil ON oil.city_id = c.account_number
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS solar
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '8.1'::text AND cr.survey_year = 2020 AND cr.response IS NOT NULL AND cq.column_name::text = 'Solar'::text) solar ON solar.city_id = c.account_number
     LEFT JOIN ( SELECT c_1.account_number AS city_id,
            cr.response AS other
           FROM city_responses cr
             LEFT JOIN city_questions cq ON cr.question_id = cq.id
             LEFT JOIN cities c_1 ON cr.city_id = c_1.account_number
          WHERE cq.question_number::text = '8.1'::text AND cr.survey_year = 2020 AND cr.response IS NOT NULL AND cq.column_name::text = 'Other sources'::text) other ON other.city_id = c.account_number;

ALTER TABLE public.cities_energy_use
    OWNER TO fmccollum;

