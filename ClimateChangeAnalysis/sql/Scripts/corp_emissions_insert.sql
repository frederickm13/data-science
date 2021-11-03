insert into corp_emissions 
(corp_id, year, emissions)
select corp_id, year, sum(emissions)
from corp_emissions_tall
group by corp_id, year