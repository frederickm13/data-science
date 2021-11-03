-- Table: public.corp_questions

-- DROP TABLE public.corp_questions;

CREATE TABLE IF NOT EXISTS public.corp_questions
(
    id integer NOT NULL DEFAULT nextval('corp_questions_id_seq'::regclass),
    survey_year smallint,
    page_name character varying(25) COLLATE pg_catalog."default",
    module_name character varying(50) COLLATE pg_catalog."default",
    question_number character varying(10) COLLATE pg_catalog."default",
    question_name character varying(500) COLLATE pg_catalog."default",
    column_number smallint,
    column_name character varying(300) COLLATE pg_catalog."default",
    row_number smallint,
    row_name character varying(300) COLLATE pg_catalog."default",
    CONSTRAINT corp_questions_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE public.corp_questions
    OWNER to fmccollum;

REVOKE ALL ON TABLE public.corp_questions FROM pyscriptuser;

GRANT ALL ON TABLE public.corp_questions TO fmccollum;

GRANT UPDATE, INSERT, SELECT ON TABLE public.corp_questions TO pyscriptuser;