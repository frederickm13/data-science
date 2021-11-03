-- Table: public.corp_questions_csv

-- DROP TABLE public.corp_questions_csv;

CREATE TABLE IF NOT EXISTS public.corp_questions_csv
(
    account_number integer,
    organization text COLLATE pg_catalog."default",
    survey_year smallint,
    response_received_date text COLLATE pg_catalog."default",
    accounting_period_to text COLLATE pg_catalog."default",
    ors_response_id integer,
    submission_date text COLLATE pg_catalog."default",
    page_name text COLLATE pg_catalog."default",
    module_name text COLLATE pg_catalog."default",
    question_number character varying(10) COLLATE pg_catalog."default",
    question_unique_reference text COLLATE pg_catalog."default",
    column_number smallint,
    column_name text COLLATE pg_catalog."default",
    table_columns_unique_reference text COLLATE pg_catalog."default",
    row_number smallint,
    row_name text COLLATE pg_catalog."default",
    data_point_name text COLLATE pg_catalog."default",
    data_point_id integer,
    response_value text COLLATE pg_catalog."default",
    comments text COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE public.corp_questions_csv
    OWNER to fmccollum;

REVOKE ALL ON TABLE public.corp_questions_csv FROM pyscriptuser;

GRANT ALL ON TABLE public.corp_questions_csv TO fmccollum;

GRANT UPDATE, INSERT, SELECT ON TABLE public.corp_questions_csv TO pyscriptuser;