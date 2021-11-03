-- Table: public.corp_energy_consumption

-- DROP TABLE public.corp_energy_consumption;

CREATE TABLE IF NOT EXISTS public.corp_energy_consumption
(
    id integer NOT NULL DEFAULT nextval('corp_energy_consumption_id_seq'::regclass),
    corp_id integer,
    year smallint,
    category character varying(100) COLLATE pg_catalog."default",
    renewable numeric,
    non_renewable numeric,
    total numeric,
    CONSTRAINT corp_energy_consumption_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE public.corp_energy_consumption
    OWNER to fmccollum;