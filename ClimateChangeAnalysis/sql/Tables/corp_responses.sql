-- Table: public.corp_responses

-- DROP TABLE public.corp_responses;

CREATE TABLE IF NOT EXISTS public.corp_responses
(
    id integer NOT NULL DEFAULT nextval('corp_responses_id_seq'::regclass),
    corp_id integer,
    question_id integer,
    survey_year smallint,
    response character varying(5100) COLLATE pg_catalog."default",
    comments character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT corp_responses_pkey PRIMARY KEY (id),
    CONSTRAINT corp_responses_corp_id_fkey FOREIGN KEY (corp_id)
        REFERENCES public.corporations (account_number) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT corp_responses_question_id_fkey FOREIGN KEY (question_id)
        REFERENCES public.corp_questions (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.corp_responses
    OWNER to fmccollum;

REVOKE ALL ON TABLE public.corp_responses FROM pyscriptuser;

GRANT ALL ON TABLE public.corp_responses TO fmccollum;

GRANT UPDATE, INSERT, SELECT ON TABLE public.corp_responses TO pyscriptuser;