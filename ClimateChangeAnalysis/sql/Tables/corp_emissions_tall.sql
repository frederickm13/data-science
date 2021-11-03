-- Table: public.corp_emissions_tall

-- DROP TABLE public.corp_emissions_tall;

CREATE TABLE IF NOT EXISTS public.corp_emissions_tall
(
    id integer NOT NULL DEFAULT nextval('corp_emissions_tall_id_seq'::regclass),
    corp_id integer,
    year smallint,
    category character varying(100) COLLATE pg_catalog."default",
    scope smallint,
    emissions numeric,
    CONSTRAINT corp_emissions_tall_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE public.corp_emissions_tall
    OWNER to fmccollum;