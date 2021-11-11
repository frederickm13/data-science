-- Table: public.cities_emissions_sector

-- DROP TABLE public.cities_emissions_sector;

CREATE TABLE IF NOT EXISTS public.cities_emissions_sector
(
    id integer NOT NULL DEFAULT nextval('cities_emissions_sector_id_seq'::regclass),
    city_id integer,
    year smallint,
    category character varying(50) COLLATE pg_catalog."default",
    emissions numeric,
    CONSTRAINT cities_emissions_sector_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE public.cities_emissions_sector
    OWNER to fmccollum;