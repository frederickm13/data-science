-- Table: public.corp_energy_consumption_tall

-- DROP TABLE public.corp_energy_consumption_tall;

CREATE TABLE IF NOT EXISTS public.corp_energy_consumption_tall
(
    id integer NOT NULL DEFAULT nextval('corp_energy_consumption_tall_id_seq'::regclass),
    corp_id integer,
    year smallint,
    category character varying(100) COLLATE pg_catalog."default",
    renewable boolean,
    consumption numeric,
    CONSTRAINT corp_energy_consumption_tall_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE public.corp_energy_consumption_tall
    OWNER to fmccollum;