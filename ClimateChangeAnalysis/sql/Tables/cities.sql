-- Table: public.cities

-- DROP TABLE public.cities;

CREATE TABLE IF NOT EXISTS public.cities
(
    account_number integer NOT NULL,
    organization character varying(200) COLLATE pg_catalog."default",
    city character varying(100) COLLATE pg_catalog."default",
    country character varying(100) COLLATE pg_catalog."default",
    cdp_region character varying(100) COLLATE pg_catalog."default",
    reporting_authority character varying(200) COLLATE pg_catalog."default",
    access character varying(25) COLLATE pg_catalog."default",
    location character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT cities_pkey PRIMARY KEY (account_number)
)

TABLESPACE pg_default;

ALTER TABLE public.cities
    OWNER to fmccollum;

REVOKE ALL ON TABLE public.cities FROM pyscriptuser;

GRANT ALL ON TABLE public.cities TO fmccollum;

GRANT UPDATE, INSERT, SELECT ON TABLE public.cities TO pyscriptuser;