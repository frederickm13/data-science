-- Table: public.city_questions

-- DROP TABLE public.city_questions;

CREATE TABLE IF NOT EXISTS public.city_questions
(
    id integer NOT NULL DEFAULT nextval('city_questions_id_seq'::regclass),
    questionnaire character varying(25) COLLATE pg_catalog."default",
    survey_year smallint,
    parent_section character varying(100) COLLATE pg_catalog."default",
    section character varying(100) COLLATE pg_catalog."default",
    question_number character varying(25) COLLATE pg_catalog."default",
    question_name character varying(600) COLLATE pg_catalog."default",
    column_number smallint,
    column_name character varying(200) COLLATE pg_catalog."default",
    row_number smallint,
    row_name character varying(200) COLLATE pg_catalog."default",
    CONSTRAINT city_questions_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE public.city_questions
    OWNER to fmccollum;

REVOKE ALL ON TABLE public.city_questions FROM pyscriptuser;

GRANT ALL ON TABLE public.city_questions TO fmccollum;

GRANT UPDATE, INSERT, SELECT ON TABLE public.city_questions TO pyscriptuser;