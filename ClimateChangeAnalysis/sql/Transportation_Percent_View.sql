create view cities_transportation_percent
as
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
        cr.response AS taxis
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '11.0' 
            AND cr.survey_year = 2018 
            AND cq.column_name like 'Taxis%' 
            and cr.response not like '%not%') taxis ON taxis.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        cr.response AS rail
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '11.0' AND cr.survey_year = 2018 AND cq.column_name like 'Rail%' and cr.response not like '%not%') rail ON rail.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        cr.response AS buses
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '11.0' AND cr.survey_year = 2018 AND cq.column_name like 'Buses%' and cr.response not like '%not%') buses ON buses.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        cr.response AS walking
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '11.0' AND cr.survey_year = 2018 AND cq.column_name like 'Walking%' and cr.response not like '%not%') walking ON walking.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        cr.response AS cycling
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '11.0' AND cr.survey_year = 2018 AND cq.column_name like 'Cycling%' and cr.response not like '%not%') cycling ON cycling.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        cr.response AS ferries
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '11.0' AND cr.survey_year = 2018 AND cq.column_name like 'Ferries%' and cr.response not like '%not%') ferries ON ferries.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        cr.response AS other
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '11.0' AND cr.survey_year = 2018 AND cq.column_name like 'Other%' and cr.response not like '%not%') other ON other.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        cr.response AS private_motor
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '11.0' AND cr.survey_year = 2018 AND cq.column_name like 'Private%' and cr.response not like '%not%') private_motor ON private_motor.city_id = c.account_number
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
        cr.response AS taxis
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2019 AND cq.column_name like 'Taxis%' and cr.response not like '%not%') taxis ON taxis.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        cr.response AS rail
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2019 AND cq.column_name like 'Rail%' and cr.response not like '%not%') rail ON rail.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        cr.response AS buses
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2019 AND cq.column_name like 'Buses%' and cr.response not like '%not%') buses ON buses.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        cr.response AS walking
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2019 AND cq.column_name like 'Walking%' and cr.response not like '%not%') walking ON walking.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        cr.response AS cycling
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2019 AND cq.column_name like 'Cycling%' and cr.response not like '%not%') cycling ON cycling.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        cr.response AS ferries
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2019 AND cq.column_name like 'Ferries%' and cr.response not like '%not%') ferries ON ferries.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        cr.response AS other
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2019 AND cq.column_name like 'Other%' and cr.response not like '%not%') other ON other.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        cr.response AS private_motor
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2019 AND cq.column_name like 'Private%' and cr.response not like '%not%') private_motor ON private_motor.city_id = c.account_number
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
        cr.response AS taxis
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2020 AND cq.column_name like 'Taxis%' and cr.response not like '%not%') taxis ON taxis.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        cr.response AS rail
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2020 AND cq.column_name like 'Rail%' and cr.response not like '%not%') rail ON rail.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        cr.response AS buses
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2020 AND cq.column_name like 'Buses%' and cr.response not like '%not%') buses ON buses.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        cr.response AS walking
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2020 AND cq.column_name like 'Walking%' and cr.response not like '%not%') walking ON walking.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        cr.response AS cycling
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2020 AND cq.column_name like 'Cycling%' and cr.response not like '%not%') cycling ON cycling.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        cr.response AS ferries
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2020 AND cq.column_name like 'Ferries%' and cr.response not like '%not%') ferries ON ferries.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        cr.response AS other
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2020 AND cq.column_name like 'Other%' and cr.response not like '%not%') other ON other.city_id = c.account_number
    left outer join (SELECT cr.city_id,
        cr.response AS private_motor
        FROM city_responses cr
            JOIN city_questions cq ON cr.question_id = cq.id
            JOIN cities c_1 ON cr.city_id = c_1.account_number
        WHERE cq.question_number = '10.1' AND cr.survey_year = 2020 AND cq.column_name like 'Private%' and cr.response not like '%not%') private_motor ON private_motor.city_id = c.account_number;