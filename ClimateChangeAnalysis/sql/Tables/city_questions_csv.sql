-- Table: public.city_questions_csv

-- DROP TABLE public.city_questions_csv;

CREATE TABLE IF NOT EXISTS public.city_questions_csv
(
    questionnaire text COLLATE pg_catalog."default",
    year_reported_to_cdp smallint,
    account_number integer,
    organization text COLLATE pg_catalog."default",
    country text COLLATE pg_catalog."default",
    cdp_region text COLLATE pg_catalog."default",
    parent_section text COLLATE pg_catalog."default",
    section text COLLATE pg_catalog."default",
    question_number text COLLATE pg_catalog."default",
    question_name text COLLATE pg_catalog."default",
    column_number text COLLATE pg_catalog."default",
    column_name text COLLATE pg_catalog."default",
    row_number smallint,
    row_name text COLLATE pg_catalog."default",
    response_answer text COLLATE pg_catalog."default",
    comments text COLLATE pg_catalog."default",
    file_name text COLLATE pg_catalog."default",
    last_update text COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE public.city_questions_csv
    OWNER to fmccollum;

REVOKE ALL ON TABLE public.city_questions_csv FROM pyscriptuser;

GRANT ALL ON TABLE public.city_questions_csv TO fmccollum;

GRANT UPDATE, INSERT, SELECT ON TABLE public.city_questions_csv TO pyscriptuser;