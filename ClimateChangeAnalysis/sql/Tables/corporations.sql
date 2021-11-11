-- Table: public.corporations

-- DROP TABLE public.corporations;

CREATE TABLE IF NOT EXISTS public.corporations
(
    account_number integer NOT NULL,
    organization character varying(200) COLLATE pg_catalog."default",
    country character varying(100) COLLATE pg_catalog."default",
    region character varying(50) COLLATE pg_catalog."default",
    public character varying(25) COLLATE pg_catalog."default",
    authority_types character varying(50) COLLATE pg_catalog."default",
    activities character varying(300) COLLATE pg_catalog."default",
    sectors character varying(300) COLLATE pg_catalog."default",
    industries character varying(200) COLLATE pg_catalog."default",
    primary_activity character varying(100) COLLATE pg_catalog."default",
    primary_sector character varying(100) COLLATE pg_catalog."default",
    primary_industry character varying(100) COLLATE pg_catalog."default",
    primary_ticker character varying(25) COLLATE pg_catalog."default",
    tickers character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT corporations_pkey PRIMARY KEY (account_number)
)

TABLESPACE pg_default;

ALTER TABLE public.corporations
    OWNER to fmccollum;

REVOKE ALL ON TABLE public.corporations FROM pyscriptuser;

GRANT ALL ON TABLE public.corporations TO fmccollum;

GRANT UPDATE, INSERT, SELECT ON TABLE public.corporations TO pyscriptuser;