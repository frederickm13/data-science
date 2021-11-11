-- Table: public.cities_transportation_percent

-- DROP TABLE public.cities_transportation_percent;

CREATE TABLE IF NOT EXISTS public.cities_transportation_percent
(
    id integer NOT NULL DEFAULT nextval('cities_transportation_percent_id_seq'::regclass),
    city_id integer,
    year smallint,
    taxis numeric,
    rail numeric,
    buses numeric,
    walking numeric,
    cycling numeric,
    ferries numeric,
    other numeric,
    private_motor numeric,
    CONSTRAINT cities_transportation_percent_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE public.cities_transportation_percent
    OWNER to fmccollum;