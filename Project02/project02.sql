-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
--BEGIN;


CREATE TABLE IF NOT EXISTS public.my_contacts
(
    contact_id bigserial NOT NULL,
    last_name character varying(50) NOT NULL,
    first_name character varying(50) NOT NULL,
    phone bigint NOT NULL,
    email character varying(50) NOT NULL,
    gender character(1) NOT NULL CHECK (gender IN ('M','F')),
    birthday date NOT NULL,
    prof_id bigint NOT NULL,
    zip_code numeric,
    status_id bigint,
    PRIMARY KEY (contact_id)
);
DROP TABLE my_contacts;

--INSERTING INTO MY CONTACTS TABLE
INSERT INTO my_contacts(last_name,first_name,phone,email,gender,birthday,prof_id,zip_code,status_id)
VALUES ('Du Pont','Amanda',0674832734,'amanda0123@gmail.com','F','1988-04-16',1,1666,1),
('Thulo','Boity',0798654732,'boity0123@gmail.com','F','1985-08-02',2,5324,2),
('Nyovest','Cassper',0813425634,'nyovestcampaigns01@gmail.com','M','1982-08-19',3,4096,3),
('Sheeran','Ed',0783452681,'edsheeran@gmail.com','M','1989-07-13',4,1632,4),
('Eillish','Billy',0823564657,'billie23@gmail.com','F','1992-07-12',5,3421,5),
('Lopez','Jennifer',0657843899,'jlo@gmail.com','F','1978-11-28',6,8721,6);


SELECT * FROM my_contacts;


SELECT * FROM zip_code;
SELECT * FROM status;
SELECT * FROM profession;
SELECT * FROM seeking;

CREATE TABLE IF NOT EXISTS public.contact_interest
(
    contact_id bigint NOT NULL,
    interest_id bigint NOT NULL
);
SELECT * FROM contact_interest

CREATE TABLE IF NOT EXISTS public.contacts_seeking
(
    contact_id bigint NOT NULL,
    seeking_id bigint NOT NULL
);

CREATE TABLE IF NOT EXISTS public.interests
(
    interest_id bigserial NOT NULL,
    interests character(100) NOT NULL,
    PRIMARY KEY (interest_id)
);

CREATE TABLE IF NOT EXISTS public.seeking
(
    seeking_id bigserial NOT NULL,
    seeking character varying(50) NOT NULL,
    PRIMARY KEY (seeking_id)
);

CREATE TABLE IF NOT EXISTS public.profession
(
    prof_id bigserial NOT NULL,
    profession character varying(50) UNIQUE NOT NULL,
    PRIMARY KEY (prof_id)
);

CREATE TABLE IF NOT EXISTS public.zip_code
(
   zip_code bigint NOT NULL CHECK (zip_code < 9999 AND zip_code >999),
    city character varying(20) NOT NULL,
    province character varying(20) NOT NULL,
    PRIMARY KEY (zip_code)
);
DROP TABLE zip_code;


CREATE TABLE IF NOT EXISTS public.status
(
    status_id bigserial NOT NULL,
    status character varying(50) NOT NULL,
    PRIMARY KEY (status_id)
);


ALTER TABLE IF EXISTS public.my_contacts
    ADD FOREIGN KEY (prof_id)
    REFERENCES public.profession (prof_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.my_contacts
    ADD FOREIGN KEY (zip_code)
    REFERENCES public.zip_code (zip_code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.my_contacts
    ADD FOREIGN KEY (status_id)
    REFERENCES public.status (status_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.contact_interest
    ADD FOREIGN KEY (contact_id)
    REFERENCES public.my_contacts (contact_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.contact_interest
    ADD FOREIGN KEY (interest_id)
    REFERENCES public.interests (interest_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.contacts_seeking
    ADD FOREIGN KEY (contact_id)
    REFERENCES public.my_contacts (contact_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.contacts_seeking
    ADD FOREIGN KEY (seeking_id)
    REFERENCES public.seeking (seeking_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
    

--JOINING THE TABLES

--INNER JOIN 
SELECT * FROM my_contacts AS mc 

--INNER JOIN--

SELECT 
mc.last_name,
mc.first_name,
mc.phone,
mc.email,
mc.gender,
mc.birthday,
prof.profession,
z.city,
z.province,
s.status,
seeking.seeking,
interests.interests

FROM my_contacts AS mc

INNER JOIN profession AS prof
ON mc.prof_id = prof.prof_id

INNER JOIN zip_code AS z
ON mc.zip_code = z.zip_code

INNER JOIN status AS s
ON mc.status_id = s.status_id

--INTERESTS INNER JOIN--

--SELECT *
--FROM my_contacts AS mc

INNER JOIN contact_interest
ON mc.contact_id = contact_interest.contact_id

INNER JOIN interests
ON contact_interest.interest_id = interests.interest_id

--SEEKING INNER JOIN

--SELECT *
--FROM my_contacts AS mc

INNER JOIN contacts_seeking
ON mc.contact_id = contacts_seeking.contact_id

INNER JOIN seeking
ON contacts_seeking.seeking_id = seeking.seeking_id;

SELECT * FROM my_contacts;

INSERT INTO interests(interests)
VALUES ('Travel'),
('Nature'),
('Art'),
('Foreign languages'),
('Outdoor Activities'),
('Art such as painting or graphic design'),
('Making or listening to music'),
('Bodybuilding'),
('Outdoor Activities');


SELECT * FROM interests;

INSERT INTO seeking(seeking)
VALUES ('A crazy best-friend'),
('Boyfriend'),
('Girlfriend to match his interests'),
('Wife'),
('A Blesser'),
('Younger boyfriend');


SELECT * FROM seeking;


--INSERTING INTO THE PROFESSION TABLE
INSERT INTO profession (profession)
VALUES ('Architect'),
('Dentist'),
('Teacher'),
('Bartender'),
('Waitress'),
('Businesswoman');

SELECT * FROM profession;

--INSERTING INTO THE ZIP CODE
INSERT INTO zip_code(zip_code,city,province)
VALUES (1666,'Johannesburg','Gauteng'),
(5324,'Durban','KwaZulu-Natal'),
(4096,'East-london','Eastern-Cape'),
(1632,'Bloemfontein','Free-state'),
(3421,'Nelspruit','Mpumalanga'),
(8721,'Kimberly','Northern Cape');
SELECT * FROM zip_code;

--INSERTING INTO CONTACT_INTEREST TABLE
INSERT INTO contacts_seeking(contact_id,seeking_id)
VALUES (1,6),
(2,1),
(3,3),
(4,4),
(5,5),
(6,1);



INSERT INTO contact_interest(contact_id,interest_id)
VALUES (1,4),(1,1),
(2,5),(2,3),
(3,6),(3,7),
(4,8),(4,7),
(5,4),(5,3),
(6,1),(6,2);

INSERT INTO status(status)
VALUES ('Complicated'),
('Engaged'),
('Single'),
('Divorcee'),
('Gold digger'),
('Single');




SELECT * FROM my_contacts;
SELECT * FROM zip_code;
SELECT * FROM status; 
SELECT * FROM contact_interest;
SELECT * FROM contacts_seeking;
SELECT * FROM interests;
--END;