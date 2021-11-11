select c.account_number as city_id, 
	2019 as year,
	coal.coal as coal,
	gas.gas as gas,
	hydro.hydro as hydro,
	geothermal.geothermal as geothermal,
	nuclear.nuclear as nuclear,
	wind.wind as wind,
	biomass.biomass as biomass,
	oil.oil as oil,
	solar.solar as solar,
	other.other as other
from cities as c
left outer join (
		select c.account_number as city_id, response as coal
		from city_responses as cr
		left outer join city_questions as cq on cr.question_id = cq.id
		left outer join cities as c on cr.city_id = c.account_number
		where cq.question_number = '8.2'
			and cr.survey_year = 2019
			and response is not null
			and column_name = 'Coal'
	) as coal on coal.city_id = c.account_number
left outer join (
		select c.account_number as city_id, response as gas
		from city_responses as cr
		left outer join city_questions as cq on cr.question_id = cq.id
		left outer join cities as c on cr.city_id = c.account_number
		where cq.question_number = '8.2'
			and cr.survey_year = 2019
			and response is not null
			and column_name = 'Gas'
	) as gas on gas.city_id = c.account_number
left outer join (
		select c.account_number as city_id, response as hydro
		from city_responses as cr
		left outer join city_questions as cq on cr.question_id = cq.id
		left outer join cities as c on cr.city_id = c.account_number
		where cq.question_number = '8.2'
			and cr.survey_year = 2019
			and response is not null
			and column_name = 'Hydro'
	) as hydro on hydro.city_id = c.account_number
left outer join (
		select c.account_number as city_id, response as geothermal
		from city_responses as cr
		left outer join city_questions as cq on cr.question_id = cq.id
		left outer join cities as c on cr.city_id = c.account_number
		where cq.question_number = '8.2'
			and cr.survey_year = 2019
			and response is not null
			and column_name = 'Geothermal'
	) as geothermal on geothermal.city_id = c.account_number
left outer join (
		select c.account_number as city_id, response as nuclear
		from city_responses as cr
		left outer join city_questions as cq on cr.question_id = cq.id
		left outer join cities as c on cr.city_id = c.account_number
		where cq.question_number = '8.2'
			and cr.survey_year = 2019
			and response is not null
			and column_name = 'Nuclear'
	) as nuclear on nuclear.city_id = c.account_number
left outer join (
		select c.account_number as city_id, response as wind
		from city_responses as cr
		left outer join city_questions as cq on cr.question_id = cq.id
		left outer join cities as c on cr.city_id = c.account_number
		where cq.question_number = '8.2'
			and cr.survey_year = 2019
			and response is not null
			and column_name = 'Wind'
	) as wind on wind.city_id = c.account_number
left outer join (
		select c.account_number as city_id, response as biomass
		from city_responses as cr
		left outer join city_questions as cq on cr.question_id = cq.id
		left outer join cities as c on cr.city_id = c.account_number
		where cq.question_number = '8.2'
			and cr.survey_year = 2019
			and response is not null
			and column_name = 'Biomass'
	) as biomass on biomass.city_id = c.account_number
left outer join (
		select c.account_number as city_id, response as oil
		from city_responses as cr
		left outer join city_questions as cq on cr.question_id = cq.id
		left outer join cities as c on cr.city_id = c.account_number
		where cq.question_number = '8.2'
			and cr.survey_year = 2019
			and response is not null
			and column_name = 'Oil'
	) as oil on oil.city_id = c.account_number
left outer join (
		select c.account_number as city_id, response as solar
		from city_responses as cr
		left outer join city_questions as cq on cr.question_id = cq.id
		left outer join cities as c on cr.city_id = c.account_number
		where cq.question_number = '8.2'
			and cr.survey_year = 2019
			and response is not null
			and column_name = 'Solar'
	) as solar on solar.city_id = c.account_number
left outer join (
		select c.account_number as city_id, response as other
		from city_responses as cr
		left outer join city_questions as cq on cr.question_id = cq.id
		left outer join cities as c on cr.city_id = c.account_number
		where cq.question_number = '8.2'
			and cr.survey_year = 2019
			and response is not null
			and column_name = 'Other sources'
	) as other on other.city_id = c.account_number