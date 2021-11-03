-- Table: public.corporations_reporting_years

-- DROP TABLE public.corporations_reporting_years;

CREATE TABLE IF NOT EXISTS public.corporations_reporting_years
(
    id integer NOT NULL DEFAULT nextval('corporations_reporting_years_id_seq'::regclass),
    corp_id integer,
    reporting_year smallint,
    minimum_tier character varying(100) COLLATE pg_catalog."default",
    selected_tier character varying(100) COLLATE pg_catalog."default",
    questionnaire character varying(50) COLLATE pg_catalog."default",
    theme character varying(50) COLLATE pg_catalog."default",
    primary_questionnaire_sector character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT corporations_reporting_years_pkey PRIMARY KEY (id),
    CONSTRAINT corporations_reporting_years_corp_id_fkey FOREIGN KEY (corp_id)
        REFERENCES public.corporations (account_number) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.corporations_reporting_years
    OWNER to fmccollum;

REVOKE ALL ON TABLE public.corporations_reporting_years FROM pyscriptuser;

GRANT ALL ON TABLE public.corporations_reporting_years TO fmccollum;

GRANT UPDATE, INSERT, SELECT ON TABLE public.corporations_reporting_years TO pyscriptuser;