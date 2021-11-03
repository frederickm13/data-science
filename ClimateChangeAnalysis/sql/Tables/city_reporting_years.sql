-- Table: public.city_reporting_years

-- DROP TABLE public.city_reporting_years;

CREATE TABLE IF NOT EXISTS public.city_reporting_years
(
    id integer NOT NULL DEFAULT nextval('city_reporting_years_id_seq'::regclass),
    city_id integer,
    reporting_year smallint,
    CONSTRAINT city_reporting_years_pkey PRIMARY KEY (id),
    CONSTRAINT city_year_unique UNIQUE (city_id, reporting_year),
    CONSTRAINT city_reporting_years_city_id_fkey FOREIGN KEY (city_id)
        REFERENCES public.cities (account_number) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.city_reporting_years
    OWNER to fmccollum;

REVOKE ALL ON TABLE public.city_reporting_years FROM pyscriptuser;

GRANT ALL ON TABLE public.city_reporting_years TO fmccollum;

GRANT UPDATE, INSERT, SELECT ON TABLE public.city_reporting_years TO pyscriptuser;