insert into corp_energy_consumption
(corp_id, year, category, renewable, non_renewable, total)
select distinct cect.corp_id,
	cect.year,
	cect.category,
	cect_r.consumption,
	cect_n.consumption,
	cect_r.consumption + cect_n.consumption
from corp_energy_consumption_tall as cect
inner join (
	select c.corp_id,
		c.year,
		c.category,
		c.consumption
	from corp_energy_consumption_tall as c
	where renewable = true
) as cect_r on cect_r.corp_id = cect.corp_id
	and cect_r.year = cect.year
	and cect_r.category = cect.category
inner join (
	select c.corp_id,
		c.year,
		c.category,
		c.consumption
	from corp_energy_consumption_tall as c
	where renewable = false
) as cect_n on cect_n.corp_id = cect.corp_id
	and cect_n.year = cect.year
		and cect_n.category = cect.category

delete from corp_energy_consumption
where category like '%Total%'