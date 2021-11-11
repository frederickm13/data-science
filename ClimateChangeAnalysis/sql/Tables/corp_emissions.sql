-- Table: public.corp_emissions

-- DROP TABLE public.corp_emissions;

CREATE TABLE IF NOT EXISTS public.corp_emissions
(
    id integer NOT NULL DEFAULT nextval('corp_emissions_id_seq'::regclass),
    corp_id integer,
    year smallint,
    emissions numeric,
    CONSTRAINT corp_emissions_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE public.corp_emissions
    OWNER to fmccollum;