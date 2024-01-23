-- Table: public.members

-- DROP TABLE IF EXISTS public.members;

CREATE TABLE IF NOT EXISTS public.members
(
    user_id character varying(50) COLLATE pg_catalog."default" NOT NULL,
    pw character varying(68) COLLATE pg_catalog."default" NOT NULL,
    active boolean NOT NULL,
    CONSTRAINT members_pkey PRIMARY KEY (user_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.members
    OWNER to postgres;




CREATE TABLE IF NOT EXISTS public.roles
(
    user_id character varying(50) COLLATE pg_catalog."default" NOT NULL,
    role character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT fk_role_members FOREIGN KEY (user_id)
        REFERENCES public.members (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.authorities
    OWNER to postgres;
-- Index: ix_auth_username

-- DROP INDEX IF EXISTS public.ix_auth_username;

CREATE UNIQUE INDEX IF NOT EXISTS ix_auth_username
    ON public.authorities USING btree
    (username COLLATE pg_catalog."default" ASC NULLS LAST, authority COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
	
	
insert into members VALUES('john','{bcrypt}$2a$10$WKFJZVoRUnUCnQToub2TLeXqItW3KzzsRRoTgMjDA/fo7k5wrCrM6',TRUE);
insert into members VALUES('marry','{bcrypt}$2a$10$WKFJZVoRUnUCnQToub2TLeXqItW3KzzsRRoTgMjDA/fo7k5wrCrM6',TRUE);
insert into members VALUES('susan','{bcrypt}$2a$10$WKFJZVoRUnUCnQToub2TLeXqItW3KzzsRRoTgMjDA/fo7k5wrCrM6',TRUE);

insert into roles VALUES('john','ROLE_EMPLOYEE');
insert into roles VALUES('marry','ROLE_EMPLOYEE');
insert into roles VALUES('marry','ROLE_MANAGER');
insert into roles VALUES('susan','ROLE_EMPLOYEE');
insert into roles VALUES('susan','ROLE_MANAGER');
insert into roles VALUES('susan','ROLE_ADMIN');