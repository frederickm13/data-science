-- Table: public.cities_emissions

-- DROP TABLE public.cities_emissions;

CREATE TABLE IF NOT EXISTS public.cities_emissions
(
    id integer NOT NULL DEFAULT nextval('cities_emissions_id_seq'::regclass),
    city_id integer,
    year smallint,
    emissions numeric,
    CONSTRAINT cities_emissions_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE public.cities_emissions
    OWNER to fmccollum;