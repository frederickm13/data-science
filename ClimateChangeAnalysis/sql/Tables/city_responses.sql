-- Table: public.city_responses

-- DROP TABLE public.city_responses;

CREATE TABLE IF NOT EXISTS public.city_responses
(
    id integer NOT NULL DEFAULT nextval('city_responses_id_seq'::regclass),
    city_id integer,
    question_id integer,
    survey_year smallint,
    response character varying(10000) COLLATE pg_catalog."default",
    comments character varying(3000) COLLATE pg_catalog."default",
    CONSTRAINT city_responses_pkey PRIMARY KEY (id),
    CONSTRAINT city_responses_city_id_fkey FOREIGN KEY (city_id)
        REFERENCES public.cities (account_number) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT city_responses_question_id_fkey FOREIGN KEY (question_id)
        REFERENCES public.city_questions (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.city_responses
    OWNER to fmccollum;

REVOKE ALL ON TABLE public.city_responses FROM pyscriptuser;

GRANT ALL ON TABLE public.city_responses TO fmccollum;

GRANT UPDATE, INSERT, SELECT ON TABLE public.city_responses TO pyscriptuser;