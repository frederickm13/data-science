-- View: public.cities_transportation_percent

-- DROP VIEW public.cities_transportation_percent;

CREATE OR REPLACE VIEW public.cities_transportation_percent
 AS
 
SELECT c.account_number AS city_id,
2018 AS year,
taxis.taxis,
rail.rail,
buses.buses,
walking.walking,
cycling.cycling,
ferries.ferries,
other.other,
private_motor.private_motor
FROM cities c
    left outer join (SELECT cr.city_id,
        nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') AS taxis
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '11.0' 
            AND cr.survey_year = 2018 
            AND cq.column_name like 'Taxis%') taxis ON taxis.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') AS rail
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '11.0' AND cr.survey_year = 2018 AND cq.column_name like 'Rail%') rail ON rail.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') AS buses
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '11.0' AND cr.survey_year = 2018 AND cq.column_name like 'Buses%') buses ON buses.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') AS walking
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '11.0' AND cr.survey_year = 2018 AND cq.column_name like 'Walking%') walking ON walking.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') AS cycling
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '11.0' AND cr.survey_year = 2018 AND cq.column_name like 'Cycling%') cycling ON cycling.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') AS ferries
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '11.0' AND cr.survey_year = 2018 AND cq.column_name like 'Ferries%') ferries ON ferries.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') AS other
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '11.0' AND cr.survey_year = 2018 AND cq.column_name like 'Other%') other ON other.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') AS private_motor
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '11.0' AND cr.survey_year = 2018 AND cq.column_name like 'Private%') private_motor ON private_motor.city_id = c.account_number
UNION ALL
SELECT c.account_number AS city_id,
2019 AS year,
taxis.taxis,
rail.rail,
buses.buses,
walking.walking,
cycling.cycling,
ferries.ferries,
other.other,
private_motor.private_motor
FROM cities c
    left outer join (SELECT cr.city_id,
        nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') AS taxis
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2019 AND cq.column_name like 'Taxis%') taxis ON taxis.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') AS rail
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2019 AND cq.column_name like 'Rail%') rail ON rail.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') AS buses
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2019 AND cq.column_name like 'Buses%') buses ON buses.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') AS walking
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2019 AND cq.column_name like 'Walking%') walking ON walking.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') AS cycling
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2019 AND cq.column_name like 'Cycling%') cycling ON cycling.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') AS ferries
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2019 AND cq.column_name like 'Ferries%') ferries ON ferries.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') AS other
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2019 AND cq.column_name like 'Other%') other ON other.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') AS private_motor
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2019 AND cq.column_name like 'Private%') private_motor ON private_motor.city_id = c.account_number
UNION ALL
SELECT c.account_number AS city_id,
2020 AS year,
taxis.taxis,
rail.rail,
buses.buses,
walking.walking,
cycling.cycling,
ferries.ferries,
other.other,
private_motor.private_motor
FROM cities c
    left outer join (SELECT cr.city_id,
        nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') AS taxis
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2020 AND cq.column_name like 'Taxis%') taxis ON taxis.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') AS rail
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2020 AND cq.column_name like 'Rail%') rail ON rail.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') AS buses
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2020 AND cq.column_name like 'Buses%') buses ON buses.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') AS walking
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2020 AND cq.column_name like 'Walking%') walking ON walking.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') AS cycling
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2020 AND cq.column_name like 'Cycling%') cycling ON cycling.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') AS ferries
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2020 AND cq.column_name like 'Ferries%') ferries ON ferries.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') AS other
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2020 AND cq.column_name like 'Other%') other ON other.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        nullif(regexp_replace(cr.response, '[^-0-9.]+', '', 'g'), '') AS private_motor
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2020 AND cq.column_name like 'Private%') private_motor ON private_motor.city_id = c.account_number;
 
 ALTER TABLE public.cities_transportation_percent
    OWNER TO fmccollum;

