-- Table: public.populations

-- DROP TABLE public.populations;

CREATE TABLE IF NOT EXISTS public.populations
(
    id integer NOT NULL DEFAULT nextval('populations_id_seq'::regclass),
    city_id integer,
    population_year smallint,
    population integer,
    CONSTRAINT populations_pkey PRIMARY KEY (id),
    CONSTRAINT city_pop_year_unique UNIQUE (city_id, population_year),
    CONSTRAINT populations_city_id_fkey FOREIGN KEY (city_id)
        REFERENCES public.cities (account_number) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.populations
    OWNER to fmccollum;

REVOKE ALL ON TABLE public.populations FROM pyscriptuser;

GRANT ALL ON TABLE public.populations TO fmccollum;

GRANT UPDATE, INSERT, SELECT ON TABLE public.populations TO pyscriptuser;