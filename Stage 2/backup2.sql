--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4 (Debian 17.4-1.pgdg120+2)
-- Dumped by pg_dump version 17.4

-- Started on 2025-04-27 13:49:52 UTC

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 41036)
-- Name: destination; Type: TABLE; Schema: public; Owner: esti
--

CREATE TABLE public.destination (
    destination_name character varying(35) NOT NULL,
    destination_address character varying(50) NOT NULL,
    destination_type character varying(20) NOT NULL
);


ALTER TABLE public.destination OWNER TO esti;

--
-- TOC entry 221 (class 1259 OID 41066)
-- Name: driver; Type: TABLE; Schema: public; Owner: esti
--

CREATE TABLE public.driver (
    volunteer_id integer NOT NULL,
    license_number integer NOT NULL,
    night_avail character(1) NOT NULL
);


ALTER TABLE public.driver OWNER TO esti;

--
-- TOC entry 217 (class 1259 OID 40961)
-- Name: patient; Type: TABLE; Schema: public; Owner: esti
--

CREATE TABLE public.patient (
    patient_id integer NOT NULL,
    first_name character varying(20) NOT NULL,
    last_name character varying(20) NOT NULL,
    gender character(1) NOT NULL,
    date_of_birth date NOT NULL,
    address character varying(30) NOT NULL,
    phone_number integer NOT NULL,
    is_disabled character(1) NOT NULL,
    medical_equipment character varying(20) NOT NULL,
    CONSTRAINT valid_gender CHECK ((gender = ANY (ARRAY['F'::bpchar, 'M'::bpchar]))),
    CONSTRAINT valid_is_disabled CHECK ((is_disabled = ANY (ARRAY['Y'::bpchar, 'N'::bpchar])))
);


ALTER TABLE public.patient OWNER TO esti;

--
-- TOC entry 223 (class 1259 OID 41086)
-- Name: ride; Type: TABLE; Schema: public; Owner: esti
--

CREATE TABLE public.ride (
    ride_id integer NOT NULL,
    ride_date date NOT NULL,
    pickup_time time without time zone NOT NULL,
    patient_id integer NOT NULL,
    vehicle_id integer NOT NULL,
    driver_id integer NOT NULL,
    assistant_id integer,
    destination_name character varying(35) NOT NULL,
    destination_address character varying(50) NOT NULL
);


ALTER TABLE public.ride OWNER TO esti;

--
-- TOC entry 222 (class 1259 OID 41076)
-- Name: transport_assistant; Type: TABLE; Schema: public; Owner: esti
--

CREATE TABLE public.transport_assistant (
    volunteer_id integer NOT NULL,
    has_medical_training character(1) DEFAULT 'N'::bpchar NOT NULL
);


ALTER TABLE public.transport_assistant OWNER TO esti;

--
-- TOC entry 218 (class 1259 OID 40966)
-- Name: vehicle; Type: TABLE; Schema: public; Owner: esti
--

CREATE TABLE public.vehicle (
    vehicle_id integer NOT NULL,
    license_plate integer NOT NULL,
    type character varying(20) NOT NULL,
    capacity integer NOT NULL,
    CONSTRAINT valid_vehicle_type CHECK (((type)::text = ANY ((ARRAY['Accessible van'::character varying, 'car'::character varying, 'Ambulance'::character varying])::text[])))
);


ALTER TABLE public.vehicle OWNER TO esti;

--
-- TOC entry 219 (class 1259 OID 40976)
-- Name: volunteer; Type: TABLE; Schema: public; Owner: esti
--

CREATE TABLE public.volunteer (
    volunteer_id integer NOT NULL,
    first_name character varying(20) NOT NULL,
    last_name character varying(20) NOT NULL,
    date_of_birth date NOT NULL,
    phone_number integer NOT NULL,
    city character varying(20) NOT NULL
);


ALTER TABLE public.volunteer OWNER TO esti;

--
-- TOC entry 3406 (class 0 OID 41036)
-- Dependencies: 220
-- Data for Name: destination; Type: TABLE DATA; Schema: public; Owner: esti
--

COPY public.destination (destination_name, destination_address, destination_type) FROM stdin;
Maccabi Women's Clinic	HaPalmach St 107, Holon	Clinic
Meuhedet Pediatric Clinic	Menachem Begin St 23, Haifa	Clinic
Meuhedet Women's Clinic	HaPalmach St 110, Ashkelon	Clinic
Leumit Clinic	HaPalmach St 24, Ra'anana	Clinic
Meuhedet Women's Clinic	Rothschild Ave 65, Ashdod	Clinic
Clalit Women's Clinic	Rothschild Ave 6, Jerusalem	Clinic
Maccabi Health Center	Ben Gurion Blvd 43, Kfar Saba	Clinic
Maccabi City Clinic	Rothschild Ave 117, Ashkelon	Clinic
Meuhedet City Clinic	Herzl St 144, Bat Yam	Clinic
Clalit Health Center	Weizmann St 13, Haifa	Clinic
Clalit Women's Clinic	HaTikva St 133, Beersheba	Clinic
Maccabi City Clinic	HaTikva St 89, Ashdod	Clinic
Maccabi Clinic	HaShalom Rd 37, Kfar Saba	Clinic
Leumit Health Center	HaNegev St 29, Bat Yam	Clinic
Meuhedet Family Clinic	HaNegev St 121, Petah Tikva	Clinic
Clalit Women's Clinic	Herzl St 44, Haifa	Clinic
Assuta Hospital	HaYarkon St 11, Petah Tikva	Hospital
Leumit Pediatric Clinic	Ben Gurion Blvd 117, Rehovot	Clinic
Maccabi Family Clinic	Jabotinsky St 5, Rehovot	Clinic
Leumit Clinic	HaTikva St 113, Beersheba	Clinic
Clalit Women's Clinic	Sokolov St 96, Ashkelon	Clinic
Leumit Clinic	Weizmann St 37, Bnei Brak	Clinic
Leumit Pediatric Clinic	Begin Blvd 68, Modiin	Clinic
Leumit Clinic	Jabotinsky St 77, Modiin	Clinic
Clalit City Clinic	HaYarkon St 47, Ashkelon	Clinic
Meuhedet City Clinic	Menachem Begin St 90, Tel Aviv	Clinic
Meuhedet Pediatric Clinic	HaTikva St 104, Kfar Saba	Clinic
Leumit Health Center	Jabotinsky St 124, Holon	Clinic
Leumit Health Center	HaYarkon St 112, Modiin	Clinic
Maccabi Pediatric Clinic	Weizmann St 60, Rishon LeZion	Clinic
Meuhedet Clinic	HaYarkon St 98, Ramat Gan	Clinic
Leumit Women's Clinic	Ben Gurion Blvd 141, Ashkelon	Clinic
Leumit City Clinic	Begin Blvd 70, Beersheba	Clinic
Meuhedet Clinic	HaYarkon St 62, Ramat Gan	Clinic
Clalit Pediatric Clinic	Sokolov St 136, Rehovot	Clinic
Meuhedet Health Center	HaHistadrut St 65, Netanya	Clinic
Clalit Pediatric Clinic	HaPalmach St 44, Ashdod	Clinic
Leumit Clinic	Menachem Begin St 20, Herzliya	Clinic
Clalit Health Center	Ben Gurion Blvd 101, Rehovot	Clinic
Meuhedet Health Center	Herzl St 74, Modiin	Clinic
Clalit Health Center	HaShalom Rd 12, Bnei Brak	Clinic
Leumit Family Clinic	Sokolov St 20, Ashdod	Clinic
Clalit Clinic	HaHistadrut St 39, Ramat Gan	Clinic
Maccabi Family Clinic	HaHistadrut St 28, Rishon LeZion	Clinic
Clalit Family Clinic	Begin Blvd 29, Kfar Saba	Clinic
Leumit Family Clinic	HaHistadrut St 102, Ashkelon	Clinic
Maccabi Family Clinic	HaHistadrut St 41, Tel Aviv	Clinic
Leumit Women's Clinic	HaNegev St 115, Ramat Gan	Clinic
Meuhedet Women's Clinic	Ben Gurion Blvd 119, Holon	Clinic
Clalit Women's Clinic	HaPalmach St 139, Ashdod	Clinic
Leumit Clinic	Jabotinsky St 51, Ashkelon	Clinic
Meuhedet City Clinic	Herzl St 33, Ra'anana	Clinic
Leumit Women's Clinic	HaNegev St 149, Ramat Gan	Clinic
Leumit Health Center	Herzl St 52, Jerusalem	Clinic
Leumit Health Center	HaHistadrut St 16, Ashkelon	Clinic
Maccabi Clinic	HaYarkon St 94, Ashdod	Clinic
Maccabi Family Clinic	HaTikva St 98, Bat Yam	Clinic
Leumit Women's Clinic	Ben Gurion Blvd 76, Rehovot	Clinic
Leumit City Clinic	Rothschild Ave 115, Herzliya	Clinic
Leumit Pediatric Clinic	HaNegev St 140, Bnei Brak	Clinic
Leumit Women's Clinic	Ben Gurion Blvd 42, Bat Yam	Clinic
Meuhedet Pediatric Clinic	HaHistadrut St 65, Rehovot	Clinic
Maccabi Clinic	Weizmann St 12, Jerusalem	Clinic
Soroka Medical Center	HaYarkon St 6, Ashdod	Hospital
Maccabi Family Clinic	HaPalmach St 125, Ashkelon	Clinic
Meuhedet Family Clinic	Jabotinsky St 84, Haifa	Clinic
Leumit City Clinic	Weizmann St 35, Kfar Saba	Clinic
Clalit Family Clinic	Begin Blvd 107, Netanya	Clinic
Meuhedet Health Center	Sokolov St 132, Rishon LeZion	Clinic
Meuhedet City Clinic	HaYarkon St 15, Tel Aviv	Clinic
Meuhedet Women's Clinic	Sokolov St 23, Bat Yam	Clinic
Maccabi Health Center	HaYarkon St 74, Modiin	Clinic
Maccabi Pediatric Clinic	HaNegev St 56, Ramat Gan	Clinic
Meuhedet Health Center	Allenby St 129, Jerusalem	Clinic
Meuhedet Women's Clinic	Begin Blvd 122, Ra'anana	Clinic
Maccabi Clinic	HaTikva St 81, Kfar Saba	Clinic
Leumit City Clinic	HaPalmach St 11, Haifa	Clinic
Leumit Women's Clinic	HaYarkon St 113, Rishon LeZion	Clinic
Leumit Women's Clinic	Jabotinsky St 124, Ramat Gan	Clinic
Leumit Clinic	Jabotinsky St 21, Rehovot	Clinic
Clalit Health Center	Allenby St 46, Jerusalem	Clinic
Meuhedet Pediatric Clinic	Jabotinsky St 60, Bat Yam	Clinic
Clalit Health Center	Menachem Begin St 81, Tel Aviv	Clinic
Meuhedet Women's Clinic	Sokolov St 115, Tel Aviv	Clinic
Clalit Women's Clinic	HaPalmach St 11, Holon	Clinic
Meuhedet Women's Clinic	Menachem Begin St 122, Haifa	Clinic
Leumit Family Clinic	Ben Gurion Blvd 24, Tel Aviv	Clinic
Maccabi Pediatric Clinic	Sokolov St 62, Petah Tikva	Clinic
Clalit Pediatric Clinic	Allenby St 107, Ashkelon	Clinic
Maccabi Family Clinic	HaYarkon St 77, Kfar Saba	Clinic
Leumit City Clinic	HaNegev St 36, Haifa	Clinic
Meuhedet Pediatric Clinic	Begin Blvd 123, Ra'anana	Clinic
Meuhedet Family Clinic	HaShalom Rd 80, Bat Yam	Clinic
Clalit Pediatric Clinic	Menachem Begin St 69, Tel Aviv	Clinic
Clalit Family Clinic	HaHistadrut St 19, Holon	Clinic
Leumit City Clinic	HaYarkon St 136, Holon	Clinic
Clalit Pediatric Clinic	HaHistadrut St 50, Rehovot	Clinic
Maccabi Pediatric Clinic	HaNegev St 149, Rishon LeZion	Clinic
Leumit Women's Clinic	Ben Gurion Blvd 116, Rehovot	Clinic
Maccabi City Clinic	Ben Gurion Blvd 61, Bnei Brak	Clinic
Clalit Women's Clinic	Begin Blvd 76, Petah Tikva	Clinic
Meuhedet Clinic	Jabotinsky St 142, Kfar Saba	Clinic
Meuhedet Clinic	Begin Blvd 140, Bat Yam	Clinic
Clalit City Clinic	Jabotinsky St 41, Bnei Brak	Clinic
Maccabi Clinic	Begin Blvd 98, Ra'anana	Clinic
Clalit Family Clinic	Ben Gurion Blvd 143, Bnei Brak	Clinic
Clalit Clinic	Jabotinsky St 56, Ashdod	Clinic
Maccabi Clinic	Rothschild Ave 133, Rehovot	Clinic
Maccabi City Clinic	Menachem Begin St 59, Kfar Saba	Clinic
Maccabi Family Clinic	HaPalmach St 15, Haifa	Clinic
Clalit City Clinic	HaTikva St 80, Bat Yam	Clinic
Clalit Women's Clinic	HaTikva St 9, Haifa	Clinic
Clalit Family Clinic	HaYarkon St 28, Bat Yam	Clinic
Meuhedet Pediatric Clinic	Jabotinsky St 144, Herzliya	Clinic
Maccabi Pediatric Clinic	Weizmann St 112, Haifa	Clinic
Maccabi Clinic	Ben Gurion Blvd 128, Ashkelon	Clinic
Leumit Clinic	HaHistadrut St 111, Netanya	Clinic
Meuhedet Health Center	Weizmann St 40, Haifa	Clinic
Leumit Clinic	HaNegev St 102, Tel Aviv	Clinic
Leumit Pediatric Clinic	Sokolov St 30, Petah Tikva	Clinic
Maccabi Family Clinic	HaNegev St 59, Rehovot	Clinic
Leumit Health Center	Jabotinsky St 37, Ra'anana	Clinic
Meuhedet Women's Clinic	HaShalom Rd 135, Haifa	Clinic
Maccabi City Clinic	HaYarkon St 142, Jerusalem	Clinic
Maccabi Family Clinic	Weizmann St 118, Ashkelon	Clinic
Maccabi Clinic	HaPalmach St 36, Tel Aviv	Clinic
Leumit Women's Clinic	Allenby St 105, Ashdod	Clinic
Maccabi Health Center	Menachem Begin St 68, Rehovot	Clinic
Leumit Health Center	HaYarkon St 62, Bnei Brak	Clinic
Meuhedet Family Clinic	Menachem Begin St 58, Rehovot	Clinic
Clalit City Clinic	Sokolov St 78, Herzliya	Clinic
Maccabi Clinic	Menachem Begin St 131, Rishon LeZion	Clinic
Clalit Health Center	HaShalom Rd 8, Haifa	Clinic
Meuhedet Women's Clinic	Sokolov St 66, Netanya	Clinic
Maccabi Health Center	Weizmann St 25, Jerusalem	Clinic
Clalit Clinic	Ben Gurion Blvd 111, Beersheba	Clinic
Meuhedet Family Clinic	Begin Blvd 73, Bnei Brak	Clinic
Meuhedet Family Clinic	Allenby St 1, Rehovot	Clinic
Leumit Family Clinic	Ben Gurion Blvd 147, Ashkelon	Clinic
Maccabi Pediatric Clinic	HaNegev St 5, Ramat Gan	Clinic
Leumit Family Clinic	HaHistadrut St 128, Rishon LeZion	Clinic
Leumit Pediatric Clinic	Rothschild Ave 32, Petah Tikva	Clinic
Leumit Pediatric Clinic	HaYarkon St 95, Rishon LeZion	Clinic
Clalit Health Center	Jabotinsky St 51, Netanya	Clinic
Meuhedet Women's Clinic	HaYarkon St 87, Jerusalem	Clinic
Clalit Pediatric Clinic	Weizmann St 78, Netanya	Clinic
Clalit Pediatric Clinic	Rothschild Ave 56, Ramat Gan	Clinic
Meuhedet Women's Clinic	Sokolov St 58, Beersheba	Clinic
Meuhedet Clinic	Weizmann St 111, Rishon LeZion	Clinic
Leumit Family Clinic	Rothschild Ave 127, Petah Tikva	Clinic
Meuhedet Pediatric Clinic	HaPalmach St 113, Jerusalem	Clinic
Clalit City Clinic	Begin Blvd 105, Bat Yam	Clinic
Leumit Pediatric Clinic	HaShalom Rd 70, Kfar Saba	Clinic
Meuhedet Pediatric Clinic	HaHistadrut St 39, Netanya	Clinic
Meuhedet Family Clinic	HaHistadrut St 97, Kfar Saba	Clinic
Maccabi Family Clinic	Sokolov St 19, Jerusalem	Clinic
Meuhedet City Clinic	Rothschild Ave 66, Petah Tikva	Clinic
Maccabi Family Clinic	Herzl St 103, Jerusalem	Clinic
Leumit Health Center	HaPalmach St 78, Ashkelon	Clinic
Leumit Family Clinic	HaShalom Rd 39, Bat Yam	Clinic
Leumit Family Clinic	Allenby St 12, Ramat Gan	Clinic
Maccabi Family Clinic	Sokolov St 11, Rehovot	Clinic
Clalit Clinic	Menachem Begin St 121, Jerusalem	Clinic
Meuhedet Women's Clinic	Ben Gurion Blvd 46, Modiin	Clinic
Maccabi Pediatric Clinic	Ben Gurion Blvd 68, Herzliya	Clinic
Clalit Pediatric Clinic	Sokolov St 44, Ra'anana	Clinic
Maccabi City Clinic	Allenby St 142, Modiin	Clinic
Maccabi Health Center	Weizmann St 98, Ashkelon	Clinic
Leumit Pediatric Clinic	Menachem Begin St 92, Jerusalem	Clinic
Clalit City Clinic	Begin Blvd 17, Ashkelon	Clinic
Meuhedet City Clinic	HaPalmach St 122, Modiin	Clinic
Clalit City Clinic	Weizmann St 132, Kfar Saba	Clinic
Clalit City Clinic	Herzl St 84, Netanya	Clinic
Meuhedet Family Clinic	HaPalmach St 19, Rishon LeZion	Clinic
Leumit City Clinic	Ben Gurion Blvd 96, Bnei Brak	Clinic
Leumit Pediatric Clinic	Allenby St 96, Beersheba	Clinic
Clalit Pediatric Clinic	Ben Gurion Blvd 16, Ashkelon	Clinic
Clalit Family Clinic	Rothschild Ave 27, Bat Yam	Clinic
Leumit Pediatric Clinic	Herzl St 142, Kfar Saba	Clinic
Hadassah Ein Kerem Hospital	Herzl St 24, Haifa	Hospital
Leumit Family Clinic	Allenby St 38, Ramat Gan	Clinic
Clalit Pediatric Clinic	HaYarkon St 84, Bnei Brak	Clinic
Maccabi Clinic	Allenby St 129, Rehovot	Clinic
Maccabi Family Clinic	Herzl St 49, Holon	Clinic
Meuhedet City Clinic	Rothschild Ave 131, Ashdod	Clinic
Meuhedet Women's Clinic	HaYarkon St 98, Haifa	Clinic
Leumit Health Center	HaNegev St 1, Herzliya	Clinic
Maccabi Women's Clinic	Herzl St 112, Tel Aviv	Clinic
Leumit Health Center	Allenby St 82, Holon	Clinic
Leumit City Clinic	HaTikva St 108, Ramat Gan	Clinic
Meuhedet Women's Clinic	HaHistadrut St 126, Netanya	Clinic
Maccabi Women's Clinic	HaYarkon St 96, Kfar Saba	Clinic
Maccabi Family Clinic	Allenby St 35, Holon	Clinic
Maccabi Pediatric Clinic	Sokolov St 141, Herzliya	Clinic
Maccabi Clinic	HaNegev St 74, Ramat Gan	Clinic
Sheba Medical Center	HaShalom Rd 83, Tel Aviv	Hospital
Leumit Clinic	Herzl St 73, Modiin	Clinic
Meuhedet Health Center	Jabotinsky St 78, Herzliya	Clinic
Maccabi City Clinic	Weizmann St 75, Jerusalem	Clinic
Maccabi Health Center	HaHistadrut St 56, Jerusalem	Clinic
Rambam Health Campus	HaYarkon St 65, Jerusalem	Hospital
Leumit Health Center	Weizmann St 145, Petah Tikva	Clinic
Leumit Women's Clinic	HaShalom Rd 101, Ashdod	Clinic
Leumit City Clinic	Weizmann St 138, Modiin	Clinic
Maccabi Health Center	HaYarkon St 132, Ashdod	Clinic
Maccabi Health Center	HaTikva St 63, Jerusalem	Clinic
Meuhedet Clinic	Ben Gurion Blvd 9, Rishon LeZion	Clinic
Meuhedet City Clinic	HaHistadrut St 124, Rehovot	Clinic
Leumit Women's Clinic	Ben Gurion Blvd 106, Rehovot	Clinic
Ziv Medical Center	HaPalmach St 114, Holon	Hospital
Leumit Clinic	HaNegev St 42, Herzliya	Clinic
Meuhedet Health Center	Weizmann St 123, Ashdod	Clinic
Leumit Family Clinic	HaTikva St 41, Netanya	Clinic
Leumit City Clinic	HaPalmach St 140, Ra'anana	Clinic
Clalit Pediatric Clinic	HaPalmach St 37, Rehovot	Clinic
Maccabi Clinic	Weizmann St 78, Tel Aviv	Clinic
Leumit Pediatric Clinic	Jabotinsky St 76, Tel Aviv	Clinic
Leumit City Clinic	Sokolov St 97, Bnei Brak	Clinic
Clalit City Clinic	Ben Gurion Blvd 81, Herzliya	Clinic
Clalit Family Clinic	HaNegev St 15, Holon	Clinic
Meuhedet Women's Clinic	Rothschild Ave 1, Tel Aviv	Clinic
Maccabi Women's Clinic	Menachem Begin St 93, Haifa	Clinic
Maccabi Family Clinic	Sokolov St 90, Ashkelon	Clinic
Meuhedet Family Clinic	Rothschild Ave 36, Herzliya	Clinic
Leumit Pediatric Clinic	Begin Blvd 37, Petah Tikva	Clinic
Maccabi Pediatric Clinic	HaPalmach St 47, Netanya	Clinic
Maccabi Women's Clinic	Jabotinsky St 123, Petah Tikva	Clinic
Leumit Clinic	Herzl St 62, Kfar Saba	Clinic
Clalit Health Center	Jabotinsky St 14, Ashdod	Clinic
Meuhedet Health Center	Jabotinsky St 143, Holon	Clinic
Clalit Women's Clinic	HaHistadrut St 148, Ramat Gan	Clinic
Leumit Women's Clinic	HaTikva St 89, Bnei Brak	Clinic
Maccabi Clinic	Menachem Begin St 21, Bat Yam	Clinic
Meuhedet Clinic	Rothschild Ave 94, Rehovot	Clinic
Clalit Women's Clinic	Jabotinsky St 116, Modiin	Clinic
Leumit Family Clinic	Sokolov St 110, Netanya	Clinic
Maccabi Health Center	HaShalom Rd 91, Netanya	Clinic
Maccabi Health Center	HaTikva St 130, Rishon LeZion	Clinic
Clalit City Clinic	Begin Blvd 61, Rishon LeZion	Clinic
Maccabi Women's Clinic	HaShalom Rd 16, Ashdod	Clinic
Meuhedet Women's Clinic	Sokolov St 123, Netanya	Clinic
Leumit Family Clinic	HaNegev St 126, Modiin	Clinic
Clalit Family Clinic	Allenby St 100, Haifa	Clinic
Maccabi Pediatric Clinic	Herzl St 40, Rishon LeZion	Clinic
Clalit Clinic	Herzl St 148, Herzliya	Clinic
Leumit City Clinic	Jabotinsky St 3, Rishon LeZion	Clinic
Maccabi Family Clinic	Sokolov St 6, Haifa	Clinic
Maccabi Women's Clinic	Sokolov St 14, Petah Tikva	Clinic
Clalit Women's Clinic	Sokolov St 82, Petah Tikva	Clinic
Leumit Clinic	Ben Gurion Blvd 112, Ramat Gan	Clinic
Clalit Pediatric Clinic	Herzl St 20, Jerusalem	Clinic
Clalit Women's Clinic	HaYarkon St 60, Ashkelon	Clinic
Leumit Family Clinic	Ben Gurion Blvd 21, Bat Yam	Clinic
Maccabi Health Center	HaTikva St 93, Beersheba	Clinic
Leumit City Clinic	HaPalmach St 109, Modiin	Clinic
Meuhedet Health Center	HaNegev St 127, Tel Aviv	Clinic
Maccabi City Clinic	Jabotinsky St 56, Ra'anana	Clinic
Leumit Clinic	Weizmann St 138, Bnei Brak	Clinic
Leumit Pediatric Clinic	HaShalom Rd 52, Modiin	Clinic
Leumit Family Clinic	Ben Gurion Blvd 2, Modiin	Clinic
Meuhedet Family Clinic	Begin Blvd 74, Jerusalem	Clinic
Meuhedet City Clinic	Sokolov St 95, Ashkelon	Clinic
Leumit Women's Clinic	Sokolov St 98, Bnei Brak	Clinic
Meuhedet City Clinic	Ben Gurion Blvd 96, Ramat Gan	Clinic
Maccabi Health Center	HaTikva St 106, Jerusalem	Clinic
Meuhedet Family Clinic	HaYarkon St 37, Bat Yam	Clinic
Meuhedet Health Center	HaNegev St 139, Rehovot	Clinic
Meuhedet Clinic	Weizmann St 71, Ashkelon	Clinic
Meuhedet Family Clinic	HaNegev St 74, Petah Tikva	Clinic
Leumit City Clinic	Allenby St 107, Beersheba	Clinic
Meuhedet Clinic	HaShalom Rd 118, Jerusalem	Clinic
Maccabi Pediatric Clinic	HaShalom Rd 40, Kfar Saba	Clinic
Maccabi Pediatric Clinic	Herzl St 144, Rishon LeZion	Clinic
Clalit Health Center	HaTikva St 30, Rishon LeZion	Clinic
Maccabi Family Clinic	Weizmann St 128, Modiin	Clinic
Leumit City Clinic	HaPalmach St 140, Kfar Saba	Clinic
Leumit City Clinic	Ben Gurion Blvd 25, Ramat Gan	Clinic
Leumit City Clinic	HaHistadrut St 136, Kfar Saba	Clinic
Maccabi Family Clinic	HaPalmach St 14, Bat Yam	Clinic
Clalit Health Center	Herzl St 113, Bat Yam	Clinic
Meuhedet Pediatric Clinic	Allenby St 48, Haifa	Clinic
Maccabi Women's Clinic	Herzl St 74, Holon	Clinic
Meuhedet Pediatric Clinic	Begin Blvd 73, Bnei Brak	Clinic
Leumit City Clinic	HaTikva St 78, Petah Tikva	Clinic
Leumit Pediatric Clinic	Weizmann St 74, Rishon LeZion	Clinic
Maccabi Health Center	Allenby St 53, Kfar Saba	Clinic
Leumit Clinic	HaHistadrut St 140, Ra'anana	Clinic
Leumit Clinic	HaYarkon St 130, Petah Tikva	Clinic
Meuhedet City Clinic	HaTikva St 144, Ashkelon	Clinic
Clalit City Clinic	Weizmann St 77, Tel Aviv	Clinic
Leumit Clinic	HaNegev St 104, Ra'anana	Clinic
Clalit Family Clinic	HaHistadrut St 97, Bat Yam	Clinic
Clalit Women's Clinic	Begin Blvd 56, Rishon LeZion	Clinic
Meuhedet Family Clinic	Rothschild Ave 29, Jerusalem	Clinic
Clalit Women's Clinic	Begin Blvd 34, Bnei Brak	Clinic
Meuhedet Family Clinic	HaHistadrut St 144, Beersheba	Clinic
Shaare Zedek Medical Center	HaNegev St 69, Netanya	Hospital
Maccabi Clinic	Herzl St 23, Rehovot	Clinic
Leumit Pediatric Clinic	Jabotinsky St 22, Kfar Saba	Clinic
Maccabi Clinic	Rothschild Ave 112, Bnei Brak	Clinic
Clalit Women's Clinic	HaTikva St 40, Modiin	Clinic
Clalit Clinic	HaHistadrut St 142, Kfar Saba	Clinic
Meuhedet Clinic	Weizmann St 19, Rishon LeZion	Clinic
Maccabi Women's Clinic	HaHistadrut St 89, Ashdod	Clinic
Clalit Women's Clinic	HaTikva St 7, Ashdod	Clinic
Leumit Clinic	HaTikva St 85, Herzliya	Clinic
Leumit Women's Clinic	HaTikva St 7, Modiin	Clinic
Maccabi Family Clinic	HaHistadrut St 3, Beersheba	Clinic
Leumit Clinic	Sokolov St 20, Ashdod	Clinic
Clalit Women's Clinic	Rothschild Ave 149, Haifa	Clinic
Maccabi City Clinic	HaTikva St 148, Haifa	Clinic
Leumit Health Center	Sokolov St 32, Herzliya	Clinic
Leumit Health Center	HaShalom Rd 19, Haifa	Clinic
Leumit City Clinic	HaShalom Rd 123, Ra'anana	Clinic
Clalit Clinic	HaShalom Rd 48, Modiin	Clinic
Maccabi Family Clinic	Herzl St 145, Jerusalem	Clinic
Leumit Health Center	Allenby St 40, Bnei Brak	Clinic
Leumit Women's Clinic	HaTikva St 38, Ramat Gan	Clinic
Meuhedet Women's Clinic	Ben Gurion Blvd 112, Beersheba	Clinic
Maccabi Family Clinic	Rothschild Ave 32, Rishon LeZion	Clinic
Meuhedet Women's Clinic	HaShalom Rd 102, Ashkelon	Clinic
Leumit Women's Clinic	Begin Blvd 39, Rishon LeZion	Clinic
Leumit Women's Clinic	Herzl St 102, Herzliya	Clinic
Maccabi Pediatric Clinic	HaTikva St 63, Modiin	Clinic
Leumit Women's Clinic	HaHistadrut St 41, Haifa	Clinic
Leumit Pediatric Clinic	Begin Blvd 42, Bnei Brak	Clinic
Meuhedet Pediatric Clinic	Herzl St 134, Holon	Clinic
Maccabi Family Clinic	HaTikva St 49, Ramat Gan	Clinic
Clalit Family Clinic	HaYarkon St 102, Bat Yam	Clinic
Maccabi Women's Clinic	Herzl St 16, Modiin	Clinic
Meuhedet Family Clinic	HaHistadrut St 74, Haifa	Clinic
Maccabi City Clinic	HaPalmach St 28, Modiin	Clinic
Leumit Clinic	HaYarkon St 124, Modiin	Clinic
Clalit Clinic	HaHistadrut St 71, Ashkelon	Clinic
Kaplan Medical Center	Sokolov St 133, Herzliya	Hospital
Meuhedet City Clinic	Begin Blvd 64, Tel Aviv	Clinic
Clalit Pediatric Clinic	HaShalom Rd 49, Jerusalem	Clinic
Meuhedet Family Clinic	HaNegev St 44, Haifa	Clinic
Clalit Family Clinic	Menachem Begin St 26, Bat Yam	Clinic
Meuhedet Family Clinic	Menachem Begin St 148, Bat Yam	Clinic
Clalit Women's Clinic	Menachem Begin St 136, Ramat Gan	Clinic
Leumit Health Center	Rothschild Ave 88, Modiin	Clinic
Clalit Health Center	Rothschild Ave 146, Modiin	Clinic
Meuhedet Pediatric Clinic	Weizmann St 102, Haifa	Clinic
Clalit Health Center	Menachem Begin St 49, Beersheba	Clinic
Ichilov Hospital	Rothschild Ave 148, Beersheba	Hospital
Maccabi Pediatric Clinic	Herzl St 12, Jerusalem	Clinic
Maccabi Women's Clinic	Sokolov St 74, Bnei Brak	Clinic
Leumit Clinic	Allenby St 25, Netanya	Clinic
Maccabi Health Center	Rothschild Ave 118, Rehovot	Clinic
Maccabi City Clinic	HaPalmach St 85, Beersheba	Clinic
Leumit Health Center	Rothschild Ave 85, Ramat Gan	Clinic
Clalit Women's Clinic	HaPalmach St 142, Petah Tikva	Clinic
Meuhedet City Clinic	Jabotinsky St 71, Jerusalem	Clinic
Meuhedet Pediatric Clinic	HaShalom Rd 144, Petah Tikva	Clinic
Meuhedet City Clinic	Allenby St 124, Rishon LeZion	Clinic
Maccabi Pediatric Clinic	Begin Blvd 5, Rehovot	Clinic
Leumit City Clinic	Begin Blvd 66, Rehovot	Clinic
Meuhedet Clinic	Rothschild Ave 130, Rishon LeZion	Clinic
Clalit Family Clinic	HaNegev St 107, Bat Yam	Clinic
Meuhedet Health Center	Weizmann St 43, Rishon LeZion	Clinic
Clalit Family Clinic	Allenby St 103, Rishon LeZion	Clinic
Maccabi Pediatric Clinic	HaPalmach St 92, Holon	Clinic
Meuhedet Health Center	Jabotinsky St 37, Rishon LeZion	Clinic
Clalit City Clinic	HaTikva St 121, Jerusalem	Clinic
Maccabi Health Center	HaShalom Rd 53, Bnei Brak	Clinic
Maccabi Pediatric Clinic	Rothschild Ave 58, Holon	Clinic
Meuhedet Pediatric Clinic	HaHistadrut St 91, Haifa	Clinic
Maccabi Pediatric Clinic	HaPalmach St 49, Bat Yam	Clinic
Maccabi Pediatric Clinic	Ben Gurion Blvd 17, Modiin	Clinic
Maccabi Health Center	HaTikva St 86, Holon	Clinic
Meuhedet Clinic	Rothschild Ave 113, Rishon LeZion	Clinic
Maccabi Clinic	Herzl St 62, Netanya	Clinic
Leumit Women's Clinic	Begin Blvd 61, Jerusalem	Clinic
Leumit City Clinic	Begin Blvd 72, Ramat Gan	Clinic
Meuhedet Pediatric Clinic	HaHistadrut St 44, Bnei Brak	Clinic
Meuhedet Clinic	Ben Gurion Blvd 106, Bat Yam	Clinic
Leumit Pediatric Clinic	Begin Blvd 130, Ra'anana	Clinic
Leumit Family Clinic	HaYarkon St 147, Tel Aviv	Clinic
Meuhedet Pediatric Clinic	Allenby St 8, Modiin	Clinic
Barzilai Medical Center	HaNegev St 45, Ramat Gan	Hospital
Meuhedet City Clinic	Allenby St 117, Bat Yam	Clinic
Clalit Family Clinic	Allenby St 29, Holon	Clinic
Maccabi City Clinic	Herzl St 15, Rehovot	Clinic
Leumit Clinic	HaHistadrut St 139, Ra'anana	Clinic
Clalit Family Clinic	HaNegev St 61, Bat Yam	Clinic
Clalit City Clinic	HaYarkon St 105, Herzliya	Clinic
Maccabi Pediatric Clinic	HaYarkon St 111, Beersheba	Clinic
Clalit City Clinic	Weizmann St 60, Haifa	Clinic
Maccabi Pediatric Clinic	HaPalmach St 79, Jerusalem	Clinic
Maccabi Women's Clinic	HaYarkon St 77, Modiin	Clinic
Maccabi Pediatric Clinic	Weizmann St 16, Rishon LeZion	Clinic
Maccabi Women's Clinic	Ben Gurion Blvd 85, Ashkelon	Clinic
Leumit City Clinic	Jabotinsky St 124, Haifa	Clinic
Clalit Women's Clinic	HaTikva St 139, Rishon LeZion	Clinic
Clalit Pediatric Clinic	Ben Gurion Blvd 61, Holon	Clinic
Leumit Pediatric Clinic	Begin Blvd 30, Herzliya	Clinic
Clalit Family Clinic	HaShalom Rd 22, Ra'anana	Clinic
Meuhedet Clinic	Sokolov St 68, Bat Yam	Clinic
Meuhedet Health Center	HaNegev St 36, Herzliya	Clinic
\.


--
-- TOC entry 3407 (class 0 OID 41066)
-- Dependencies: 221
-- Data for Name: driver; Type: TABLE DATA; Schema: public; Owner: esti
--

COPY public.driver (volunteer_id, license_number, night_avail) FROM stdin;
451143202	3058550	N
651447743	5617204	Y
508895013	4474159	N
254904175	4979745	Y
587927685	3623517	Y
775579062	4124699	Y
989164091	5071368	Y
231324781	4928156	Y
405648081	2932172	N
427989892	7398714	N
951108053	1305999	Y
723266609	9306757	Y
924888731	5221300	Y
613307691	8031257	N
927468908	8960966	Y
106107388	9184961	N
375913224	7977381	Y
835425519	5451628	Y
116809193	9382694	N
492050992	6138649	N
355020965	2128824	Y
316396883	9773128	Y
770359651	6983202	N
765574491	7786986	Y
565425153	6910428	N
668035126	1838047	Y
157794649	6476112	N
489601917	2942751	Y
334099421	6422882	N
913568600	4471999	Y
581537784	4709302	N
942705156	6389333	N
121502474	6916708	N
801483903	1413049	Y
583133229	8324305	N
494708371	8435270	Y
480434918	8026249	N
162929677	1005848	N
577645975	2706630	N
333059661	3645906	Y
215791975	5775991	N
893399035	8394017	N
385321066	7369977	N
675033386	7586542	N
760677936	6631612	N
718084895	3511493	Y
510334717	4713685	N
575013098	3691920	Y
822386902	1462020	Y
314241360	8028202	Y
495900140	5041202	N
983060617	4588615	Y
789955108	4590031	Y
188163518	1326722	N
909580633	6455010	N
335528238	5453128	Y
869029092	7371048	N
421289999	8447492	N
569080510	9235900	Y
559056009	8582887	Y
832010443	7658586	N
517697659	6263127	N
809797531	5323804	N
510716800	8340907	N
194967455	7753900	N
471674082	1627418	Y
419832401	2969838	N
757088646	1180989	Y
361945520	1763596	N
236786603	7135977	Y
580038886	7125370	N
808677201	9629134	N
980860075	3998769	N
869278628	6744543	N
469439493	7439025	N
620016708	4004772	N
439413734	8424639	Y
670632947	6881570	N
870478094	2820483	Y
152785861	1422876	Y
548621554	6055269	N
127373899	1126011	N
165682443	7900942	N
565166657	6497529	N
103198638	5997669	Y
691705874	9381995	N
765921635	3799800	N
961074382	8704017	Y
129452534	4812784	Y
933176850	5528569	Y
493394881	4084810	Y
311784393	2242792	Y
648046509	4253079	Y
722223783	4858779	Y
195106131	6570010	Y
110532551	2942283	Y
130440929	2530562	Y
876946737	9763781	Y
914566516	5472456	Y
410254424	4796508	Y
766537646	5574100	Y
740682739	8882276	Y
262180529	9581365	Y
703776850	9086384	Y
952751158	1421428	Y
452354109	2047899	Y
350299663	4889784	Y
459613663	3694596	Y
790255711	2759033	Y
205096731	5612484	Y
349943042	1735905	Y
902246089	3585932	Y
939238672	2970764	Y
335569735	5680759	Y
799258702	4404217	Y
888469205	7128635	Y
686931483	6973207	Y
132264095	5185346	Y
390750761	8629451	Y
582888025	2501918	Y
589073536	4434081	Y
860923150	4941341	Y
128998748	7678130	Y
808943895	6608919	Y
146240027	5499038	Y
596823946	5252777	Y
870880025	2935240	Y
724516280	4676371	Y
936879403	8452498	Y
565737791	4499742	Y
967238983	2916476	Y
675610128	8907787	Y
385015287	5399724	Y
927916320	7439515	Y
378127589	1605911	Y
605063967	6141867	Y
318943388	3954678	Y
175078783	2632778	Y
278345196	4003229	Y
646651118	2445047	Y
602013357	6516177	Y
503075904	7682592	Y
337501464	9026706	Y
714051919	1178930	Y
767059275	7891592	Y
993263579	7533561	Y
678506268	4450686	Y
427852785	2426790	Y
890623488	3960592	Y
277290510	4560530	Y
240709151	8527148	Y
623490063	9619849	Y
595351873	9773105	Y
286582552	5927723	Y
484821493	6935083	Y
738536844	5104061	Y
565661395	3965065	Y
111533007	3710259	Y
352089792	9920331	Y
410962502	5508204	Y
747832838	6393800	Y
832006368	8106101	Y
368803859	9836239	Y
667143420	5155786	Y
762854976	4934852	Y
339014530	6803015	Y
710030144	6036260	Y
447168611	9757339	Y
523388008	8942905	Y
312816743	4563342	Y
604840053	6810498	Y
414316626	3622258	Y
145012488	7450614	Y
294557346	1570669	Y
204520642	8063292	Y
960240840	8324240	Y
367041409	8831527	Y
327338690	3569051	Y
651938317	7607899	Y
375218533	8815618	Y
244282748	1470597	Y
414131125	8966231	Y
571289027	4887604	Y
160913893	4528795	Y
303635805	4712795	Y
886939800	2262409	Y
300697114	9759963	Y
530516374	4441095	Y
896973596	2274033	Y
325430239	7979814	Y
561707109	4883700	Y
246927292	1009197	Y
705338121	5197528	Y
151385895	3509854	Y
121065055	5991889	Y
356308687	3756534	Y
106210399	6975286	Y
170476311	3468789	Y
282498842	5394413	Y
408394324	9565054	Y
\.


--
-- TOC entry 3403 (class 0 OID 40961)
-- Dependencies: 217
-- Data for Name: patient; Type: TABLE DATA; Schema: public; Owner: esti
--

COPY public.patient (patient_id, first_name, last_name, gender, date_of_birth, address, phone_number, is_disabled, medical_equipment) FROM stdin;
306674982	Rachel	Mizrahi	F	1972-01-28	30 Herzl St, Beersheba	593355531	N	None
591839254	Yosef	Shalom	M	1956-10-01	80 Ben Gurion St, Haifa	541722501	N	Oxygen Tank
383641443	Rachel	Cohen	F	1982-12-11	25 Dizengoff St, Beersheba	547653941	N	Oxygen Tank
893684024	Yosef	Gabay	M	1978-05-10	28 Dizengoff St, Beersheba	579570174	N	Oxygen Tank
198401039	Yosef	Levi	M	1978-05-16	17 Ben Gurion St, Jerusalem	508429257	N	None
543629152	Moshe	Gabay	M	1978-04-14	40 Dizengoff St, Haifa	554723928	N	None
329416185	Yaakov	Cohen	M	1988-11-01	98 Dizengoff St, Haifa	515674036	N	Oxygen Tank
575650818	Esther	Azoulay	F	1954-07-16	78 Dizengoff St, Tel Aviv	554523889	N	None
682247730	Yosef	Biton	M	1997-05-27	87 Herzl St, Beersheba	502437943	Y	Wheelchair
510369863	Leah	Levi	F	2006-10-03	28 Ben Gurion St, Haifa	597506683	Y	Wheelchair
189899416	Amit	Shalom	F	1972-02-20	88 Herzl St, Jerusalem	527113929	N	Oxygen Tank
946244382	Esther	Ohayon	F	1960-09-13	9 Herzl St, Eilat	508127902	N	Oxygen Tank
586562174	Noa	Azoulay	F	1988-09-06	62 Herzl St, Haifa	509573626	Y	Wheelchair
232412113	Rachel	Azoulay	F	2000-01-17	69 Ben Gurion St, Beersheba	545266322	N	None
895588198	Amit	Peretz	F	2000-01-23	89 Jabotinsky St, Haifa	507137548	N	Guide Dog
328312992	Amit	Gabay	F	1981-11-11	10 Ben Gurion St, Jerusalem	505405618	N	None
502455034	David	Harari	M	1964-10-18	26 Jabotinsky St, Jerusalem	522508682	N	Oxygen Tank
351451084	Miriam	Peretz	F	2006-04-08	14 Jabotinsky St, Jerusalem	583419800	N	None
440428166	Amit	Cohen	F	1973-05-04	31 Jabotinsky St, Eilat	577589303	Y	Wheelchair
326216990	Leah	Gabay	F	1976-01-25	91 Dizengoff St, Beersheba	537773251	N	None
149181012	David	Biton	M	1993-07-12	99 Jabotinsky St, Haifa	501168878	N	Guide Dog
754151802	David	Ohayon	M	1950-03-05	40 Ben Gurion St, Tel Aviv	588652404	N	None
546960294	Esther	Levi	F	2008-02-01	54 Jabotinsky St, Haifa	591714678	N	Oxygen Tank
738045160	Esther	Cohen	F	1969-09-24	21 Dizengoff St, Tel Aviv	593120020	N	None
155898237	Yaakov	Gabay	M	1997-11-25	42 Ben Gurion St, Eilat	587031328	N	None
144374344	Moshe	Mizrahi	M	1975-04-18	19 Jabotinsky St, Jerusalem	511093086	N	None
794952734	Esther	Harari	F	1976-03-28	21 Dizengoff St, Jerusalem	502236457	Y	Wheelchair
920666292	Amit	Harari	F	1960-11-11	10 Jabotinsky St, Eilat	537185784	Y	Wheelchair
595469585	Leah	Peretz	F	1971-03-16	32 Jabotinsky St, Eilat	517408094	N	None
877834494	Moshe	Shalom	M	1959-06-07	5 Ben Gurion St, Beersheba	581034925	N	Guide Dog
322279900	Noa	Cohen	F	1972-01-24	49 Dizengoff St, Tel Aviv	563567675	N	Guide Dog
121433639	Leah	Mizrahi	F	1986-01-20	30 Herzl St, Beersheba	579376831	Y	Wheelchair
236809338	Noa	Harari	F	1977-02-04	28 Herzl St, Tel Aviv	547766298	Y	Wheelchair
457553650	Moshe	Cohen	M	2002-08-25	36 Ben Gurion St, Eilat	503229597	N	None
170140414	Noa	Levi	F	1995-01-27	17 Ben Gurion St, Tel Aviv	557750415	N	Oxygen Tank
364653026	Yosef	Mizrahi	M	2001-01-12	41 Dizengoff St, Haifa	554437141	N	Oxygen Tank
267348942	David	Mizrahi	M	1983-08-22	26 Dizengoff St, Haifa	532889298	N	Oxygen Tank
163350630	Rachel	Gabay	F	1953-03-14	69 Dizengoff St, Eilat	538028034	N	Guide Dog
582969573	Noa	Ohayon	F	2010-06-18	64 Jabotinsky St, Tel Aviv	569807307	N	Guide Dog
976166486	David	Shalom	M	1969-03-27	19 Herzl St, Beersheba	554523782	N	None
999168068	Yosef	Ohayon	M	1995-09-05	13 Jabotinsky St, Tel Aviv	558572250	N	Oxygen Tank
914894458	Yosef	Cohen	M	1950-11-18	46 Herzl St, Eilat	575303193	Y	Wheelchair
249140620	Esther	Shalom	F	1968-01-28	46 Jabotinsky St, Haifa	522494083	Y	Wheelchair
341446195	Yaakov	Mizrahi	M	1980-01-26	40 Herzl St, Tel Aviv	537606664	N	Oxygen Tank
184019783	David	Azoulay	M	1999-05-04	8 Dizengoff St, Haifa	511444550	N	None
843075942	Noa	Shalom	F	1975-09-08	4 Dizengoff St, Jerusalem	531666160	Y	Wheelchair
851341222	David	Gabay	M	1967-07-09	21 Jabotinsky St, Tel Aviv	545244191	N	None
460087435	Leah	Cohen	F	2006-01-07	96 Ben Gurion St, Jerusalem	534928395	N	None
763371666	Amit	Ohayon	F	1972-05-14	42 Jabotinsky St, Tel Aviv	533966992	Y	Wheelchair
506237409	Rachel	Peretz	F	1955-12-20	65 Dizengoff St, Eilat	539112918	Y	Wheelchair
188709072	Miriam	Biton	F	1965-03-02	79 Dizengoff St, Tel Aviv	583018185	N	Oxygen Tank
292536682	Miriam	Gabay	F	1960-02-07	58 Ben Gurion St, Tel Aviv	566935474	Y	Wheelchair
910273798	Amit	Mizrahi	F	1958-09-19	78 Jabotinsky St, Beersheba	557547582	N	Guide Dog
247145715	David	Cohen	M	1951-05-09	44 Jabotinsky St, Jerusalem	501249922	N	Guide Dog
895576008	Miriam	Azoulay	F	1984-01-08	75 Ben Gurion St, Haifa	593625488	Y	Wheelchair
752098694	Yosef	Azoulay	M	1967-09-05	17 Jabotinsky St, Beersheba	502500380	N	Oxygen Tank
340100295	Leah	Shalom	F	1966-11-11	30 Ben Gurion St, Beersheba	541470870	N	Oxygen Tank
191561261	Leah	Ohayon	F	2007-06-12	27 Ben Gurion St, Tel Aviv	594884244	N	None
227095527	Amit	Biton	F	1973-01-01	80 Jabotinsky St, Beersheba	579000298	N	None
174306440	Miriam	Shalom	F	1994-01-27	87 Dizengoff St, Eilat	591718960	Y	Wheelchair
518986031	Yaakov	Peretz	M	2000-06-23	62 Ben Gurion St, Beersheba	523839572	N	Oxygen Tank
993112782	David	Peretz	M	1952-04-12	12 Dizengoff St, Jerusalem	523239226	N	None
473412170	Moshe	Peretz	M	1980-01-08	39 Dizengoff St, Haifa	514768739	N	Oxygen Tank
860088812	Miriam	Harari	F	1951-10-09	53 Dizengoff St, Haifa	579307872	N	Oxygen Tank
814384608	Noa	Biton	F	1977-05-14	66 Ben Gurion St, Eilat	517783188	N	Oxygen Tank
680566675	Leah	Biton	F	1980-09-13	88 Ben Gurion St, Beersheba	552444464	N	Oxygen Tank
916090435	Yosef	Harari	M	1978-09-13	29 Dizengoff St, Jerusalem	565812775	N	Oxygen Tank
871784867	Moshe	Ohayon	M	1981-08-22	60 Dizengoff St, Tel Aviv	546382106	N	Oxygen Tank
533476073	Esther	Gabay	F	1985-01-23	63 Jabotinsky St, Eilat	589837417	N	Oxygen Tank
728873342	Rachel	Ohayon	F	1959-03-10	41 Herzl St, Eilat	586130684	N	Guide Dog
918984720	Miriam	Ohayon	F	1993-10-15	43 Ben Gurion St, Haifa	561951185	N	Guide Dog
544949169	Esther	Peretz	F	1952-08-05	33 Dizengoff St, Beersheba	547223994	N	None
582442635	Noa	Peretz	F	1977-03-21	41 Jabotinsky St, Jerusalem	543083050	N	None
632577955	Miriam	Cohen	F	1996-08-08	18 Herzl St, Beersheba	513270874	Y	Wheelchair
733454157	Amit	Azoulay	F	1965-09-26	62 Herzl St, Haifa	504507098	N	None
206768692	Yaakov	Harari	M	1959-09-14	68 Herzl St, Jerusalem	555953227	N	None
771372820	Moshe	Levi	M	1958-06-09	44 Dizengoff St, Beersheba	548872143	N	None
679248949	Moshe	Azoulay	M	1989-01-06	62 Ben Gurion St, Beersheba	516609757	N	None
928091898	Yaakov	Azoulay	M	1985-02-23	99 Dizengoff St, Jerusalem	551155553	N	None
796091497	Yosef	Peretz	M	1987-03-02	53 Jabotinsky St, Eilat	562677349	N	Guide Dog
758038866	Yaakov	Ohayon	M	1974-12-11	64 Jabotinsky St, Tel Aviv	591547994	N	Oxygen Tank
855032071	Esther	Mizrahi	F	1974-05-14	54 Dizengoff St, Haifa	579173773	N	None
408340579	David	Levi	M	2005-05-22	99 Dizengoff St, Beersheba	522364579	N	None
946254016	Moshe	Biton	M	1961-11-07	2 Herzl St, Tel Aviv	532946258	Y	Wheelchair
744340871	Esther	Biton	F	1980-08-19	14 Jabotinsky St, Jerusalem	567150446	Y	Wheelchair
805185005	Rachel	Levi	F	1994-08-23	24 Dizengoff St, Beersheba	528637804	N	None
151948041	Amit	Levi	F	1979-04-14	3 Jabotinsky St, Jerusalem	599269626	N	None
568658593	Yaakov	Shalom	M	2006-04-15	82 Ben Gurion St, Beersheba	561366640	Y	Wheelchair
704835566	Yaakov	Biton	M	1968-06-19	67 Herzl St, Eilat	528308208	N	Oxygen Tank
757315687	Rachel	Biton	F	1963-04-13	23 Dizengoff St, Eilat	567555195	N	None
290221251	Rachel	Shalom	F	1958-06-09	76 Herzl St, Beersheba	586519082	N	None
813482571	Miriam	Mizrahi	F	1999-08-15	46 Jabotinsky St, Eilat	508398891	N	Guide Dog
458111142	Noa	Mizrahi	F	2002-05-19	2 Ben Gurion St, Jerusalem	512260302	N	None
256086565	Moshe	Harari	M	1954-09-10	8 Jabotinsky St, Haifa	539565088	N	None
915928506	Noa	Gabay	F	1972-04-25	56 Ben Gurion St, Haifa	563419141	Y	Wheelchair
603632562	Rachel	Harari	F	2002-05-18	40 Herzl St, Jerusalem	596804877	N	None
367688443	Leah	Azoulay	F	1988-02-04	94 Jabotinsky St, Tel Aviv	579816683	N	None
894956091	Leah	Harari	F	1997-06-10	67 Ben Gurion St, Tel Aviv	516040080	N	None
981257093	Miriam	Levi	F	1965-01-21	20 Dizengoff St, Jerusalem	573819097	N	None
156769696	Rachel	Mizrahi	F	1990-11-02	72 Jabotinsky St, Jerusalem	525630595	Y	Wheelchair
974269487	Yosef	Shalom	M	2002-11-17	51 Dizengoff St, Eilat	584517953	N	None
209732140	Rachel	Cohen	F	1985-04-04	86 Herzl St, Haifa	565073136	N	None
287218285	Yosef	Gabay	M	1985-10-15	91 Dizengoff St, Haifa	551595636	N	None
530709488	Yosef	Levi	M	2001-06-15	11 Jabotinsky St, Eilat	508163112	N	Guide Dog
725872450	Moshe	Gabay	M	2000-10-08	45 Herzl St, Jerusalem	503377418	Y	Wheelchair
400850159	Yaakov	Cohen	M	2004-04-09	19 Dizengoff St, Haifa	523466342	N	Oxygen Tank
120855999	Esther	Azoulay	F	1962-01-01	84 Jabotinsky St, Jerusalem	514622624	N	Oxygen Tank
741059892	Yosef	Biton	M	1999-10-17	67 Herzl St, Eilat	578034834	N	Guide Dog
221606473	Leah	Levi	F	2003-09-13	33 Ben Gurion St, Beersheba	598074084	N	None
110151501	Amit	Shalom	F	1987-01-22	83 Jabotinsky St, Tel Aviv	572581823	Y	Wheelchair
297461390	Esther	Ohayon	F	1978-06-19	30 Herzl St, Jerusalem	554589701	N	None
906327198	Noa	Azoulay	F	2005-09-09	13 Herzl St, Haifa	511678570	Y	Wheelchair
653318684	Rachel	Azoulay	F	1967-08-20	85 Dizengoff St, Eilat	522007890	Y	Wheelchair
452938441	Amit	Peretz	F	1998-07-12	9 Jabotinsky St, Beersheba	518055483	Y	Wheelchair
285594371	Amit	Gabay	F	1962-07-27	92 Jabotinsky St, Eilat	533855365	Y	Wheelchair
431782073	David	Harari	M	1997-02-25	26 Dizengoff St, Jerusalem	588853402	N	None
467713954	Miriam	Peretz	F	1980-08-23	42 Ben Gurion St, Jerusalem	506058012	N	Guide Dog
894548767	Amit	Cohen	F	1993-09-15	66 Jabotinsky St, Tel Aviv	548937332	N	None
382178937	Leah	Gabay	F	1965-10-06	44 Herzl St, Beersheba	535179833	N	None
322317846	David	Biton	M	1959-10-04	92 Ben Gurion St, Jerusalem	507244859	N	None
275062263	David	Ohayon	M	1971-09-21	15 Herzl St, Haifa	538941506	N	Oxygen Tank
665010330	Esther	Levi	F	2010-07-24	84 Jabotinsky St, Haifa	566086346	N	None
811725293	Esther	Cohen	F	1989-05-22	95 Herzl St, Haifa	554761947	Y	Wheelchair
753729185	Yaakov	Gabay	M	2000-02-16	94 Herzl St, Beersheba	565237593	N	Oxygen Tank
782770105	Moshe	Mizrahi	M	1985-08-26	30 Ben Gurion St, Haifa	513073000	N	Guide Dog
358393463	Esther	Harari	F	1980-06-24	60 Jabotinsky St, Eilat	556096985	N	Guide Dog
949677625	Amit	Harari	F	1951-11-11	98 Jabotinsky St, Tel Aviv	547160525	N	Guide Dog
131666625	Leah	Peretz	F	1988-04-14	43 Ben Gurion St, Eilat	591121923	N	Guide Dog
542297151	Moshe	Shalom	M	1970-04-05	47 Dizengoff St, Jerusalem	533519023	N	Guide Dog
150349157	Noa	Cohen	F	1993-07-11	43 Dizengoff St, Eilat	512267036	N	Oxygen Tank
916939137	Leah	Mizrahi	F	1989-01-20	7 Jabotinsky St, Eilat	591921733	N	Oxygen Tank
352506228	Noa	Harari	F	1960-12-10	17 Jabotinsky St, Eilat	546806313	N	None
512030298	Moshe	Cohen	M	1954-07-19	25 Dizengoff St, Beersheba	517685465	N	None
947243926	Noa	Levi	F	2000-06-08	44 Jabotinsky St, Jerusalem	565572286	Y	Wheelchair
154227972	Yosef	Mizrahi	M	1996-06-17	55 Dizengoff St, Beersheba	535989906	N	Oxygen Tank
223971678	David	Mizrahi	M	1996-09-20	39 Herzl St, Jerusalem	524649458	N	None
590818651	Rachel	Gabay	F	2008-12-18	92 Herzl St, Beersheba	576018796	N	Oxygen Tank
536709776	Noa	Ohayon	F	1998-08-16	44 Dizengoff St, Beersheba	534676620	Y	Wheelchair
178288655	David	Shalom	M	1955-05-26	26 Dizengoff St, Haifa	551838051	Y	Wheelchair
299229343	Yosef	Ohayon	M	1975-11-07	91 Herzl St, Eilat	517671115	N	Guide Dog
590652532	Yosef	Cohen	M	1977-10-09	89 Herzl St, Jerusalem	516484667	Y	Wheelchair
343278287	Esther	Shalom	F	1953-08-17	37 Herzl St, Tel Aviv	532200068	Y	Wheelchair
926419142	Yaakov	Mizrahi	M	2010-11-10	28 Ben Gurion St, Tel Aviv	592247670	N	None
139889274	David	Azoulay	M	1986-10-24	71 Jabotinsky St, Beersheba	511506001	Y	Wheelchair
641087529	Noa	Shalom	F	2006-07-12	26 Herzl St, Tel Aviv	597338598	N	Guide Dog
320907039	David	Gabay	M	1988-06-10	52 Herzl St, Haifa	573762216	N	Oxygen Tank
737208814	Leah	Cohen	F	1993-11-12	36 Herzl St, Beersheba	561552769	N	None
463548843	Amit	Ohayon	F	1999-03-26	89 Dizengoff St, Eilat	597298868	N	None
283767201	Rachel	Peretz	F	1965-04-14	39 Herzl St, Jerusalem	561043819	N	Oxygen Tank
122403164	Miriam	Biton	F	1975-10-07	79 Jabotinsky St, Haifa	559488577	N	Oxygen Tank
829589264	Miriam	Gabay	F	1967-09-27	50 Jabotinsky St, Eilat	569969307	Y	Wheelchair
959505198	Amit	Mizrahi	F	1971-01-04	85 Dizengoff St, Beersheba	573280636	N	None
741606378	David	Cohen	M	1951-03-20	10 Ben Gurion St, Eilat	593272487	Y	Wheelchair
163977003	Miriam	Azoulay	F	1981-02-03	84 Ben Gurion St, Tel Aviv	502704862	Y	Wheelchair
242098030	Yosef	Azoulay	M	1952-04-25	87 Jabotinsky St, Tel Aviv	532336976	N	None
890970312	Leah	Shalom	F	1979-06-01	71 Herzl St, Tel Aviv	525526013	N	None
101565191	Leah	Ohayon	F	2007-07-01	24 Dizengoff St, Eilat	596595588	N	Oxygen Tank
277537826	Amit	Biton	F	2004-04-12	88 Herzl St, Eilat	517695325	Y	Wheelchair
208136962	Miriam	Shalom	F	1983-05-09	2 Jabotinsky St, Tel Aviv	567425761	N	Oxygen Tank
537493895	Yaakov	Peretz	M	1973-08-14	33 Dizengoff St, Eilat	529960207	N	Oxygen Tank
431925566	David	Peretz	M	1988-06-03	96 Ben Gurion St, Jerusalem	531820379	N	None
319864750	Moshe	Peretz	M	2005-08-19	76 Herzl St, Haifa	595854712	N	Guide Dog
223302984	Miriam	Harari	F	1975-03-12	91 Jabotinsky St, Haifa	575089425	N	None
558919861	Noa	Biton	F	2007-10-18	25 Jabotinsky St, Jerusalem	506634042	N	Guide Dog
107106212	Yaakov	Levi	M	1988-04-10	54 Herzl St, Haifa	507698779	N	None
123928798	Leah	Biton	F	1962-09-10	39 Dizengoff St, Jerusalem	581052254	Y	Wheelchair
862445507	Yosef	Harari	M	1985-08-08	7 Herzl St, Eilat	583104278	N	Oxygen Tank
174043533	Moshe	Ohayon	M	2005-09-24	9 Ben Gurion St, Eilat	534693952	Y	Wheelchair
617124389	Esther	Gabay	F	1957-02-17	29 Jabotinsky St, Eilat	534521406	N	Guide Dog
300036531	Rachel	Ohayon	F	1960-05-11	41 Jabotinsky St, Beersheba	552810191	N	Oxygen Tank
498056409	Miriam	Ohayon	F	2002-08-03	28 Jabotinsky St, Tel Aviv	594444158	N	None
849864109	Esther	Peretz	F	2008-08-12	19 Dizengoff St, Haifa	578264352	N	None
505288440	Noa	Peretz	F	1977-01-18	42 Herzl St, Eilat	567746965	N	None
587398835	Miriam	Cohen	F	1998-10-18	95 Jabotinsky St, Haifa	551863367	N	None
263372945	Amit	Azoulay	F	2002-06-26	64 Herzl St, Jerusalem	517965380	N	None
350031763	Yaakov	Harari	M	1983-11-09	41 Dizengoff St, Beersheba	561760334	N	None
812170410	Moshe	Azoulay	M	2010-09-14	27 Ben Gurion St, Tel Aviv	539706772	N	Guide Dog
614959631	Yaakov	Azoulay	M	1993-08-28	12 Jabotinsky St, Beersheba	535172940	N	None
538839225	Yosef	Peretz	M	1963-04-07	53 Ben Gurion St, Eilat	575370195	Y	Wheelchair
472314962	Yaakov	Ohayon	M	1952-12-28	40 Ben Gurion St, Jerusalem	521721481	N	Guide Dog
355235662	Esther	Mizrahi	F	1973-11-18	87 Dizengoff St, Haifa	552408208	N	Guide Dog
721698371	David	Levi	M	2010-07-26	43 Jabotinsky St, Haifa	546845063	N	None
207067497	Moshe	Biton	M	1995-09-18	12 Jabotinsky St, Beersheba	598554341	N	Guide Dog
284489969	Esther	Biton	F	1967-07-02	28 Dizengoff St, Beersheba	597683049	N	None
587650033	Rachel	Levi	F	1991-03-21	35 Ben Gurion St, Beersheba	583441410	N	Guide Dog
189791206	Amit	Levi	F	1957-04-22	68 Ben Gurion St, Beersheba	543324829	N	Guide Dog
638913607	Yaakov	Shalom	M	1952-10-03	84 Jabotinsky St, Haifa	559657932	N	None
632274169	Yaakov	Biton	M	1974-04-01	99 Herzl St, Beersheba	549082856	Y	Wheelchair
300628794	Rachel	Biton	F	1990-12-01	77 Jabotinsky St, Tel Aviv	592068291	Y	Wheelchair
739103170	Rachel	Shalom	F	1972-09-26	73 Ben Gurion St, Jerusalem	524468655	N	None
689825727	Miriam	Mizrahi	F	1976-03-28	48 Dizengoff St, Beersheba	531033542	Y	Wheelchair
724199106	Noa	Mizrahi	F	1990-07-10	70 Herzl St, Tel Aviv	532956335	N	Guide Dog
662729589	Moshe	Harari	M	1953-01-08	62 Jabotinsky St, Beersheba	501358458	Y	Wheelchair
429596723	Noa	Gabay	F	1983-07-21	65 Herzl St, Beersheba	512863947	N	None
248993596	Rachel	Harari	F	1989-08-17	21 Jabotinsky St, Haifa	516451681	N	None
627627838	Leah	Azoulay	F	1995-02-01	75 Ben Gurion St, Tel Aviv	562111654	N	None
147130620	Leah	Harari	F	1965-06-26	55 Dizengoff St, Tel Aviv	535235642	N	None
626008407	Miriam	Levi	F	1955-02-17	40 Dizengoff St, Beersheba	577027304	N	None
276643268	Rachel	Mizrahi	F	1960-11-19	54 Jabotinsky St, Jerusalem	535656740	Y	Wheelchair
816422554	Yosef	Shalom	M	2004-04-28	63 Ben Gurion St, Eilat	584750819	N	None
485521617	Rachel	Cohen	F	1973-03-25	36 Dizengoff St, Tel Aviv	532240370	Y	Wheelchair
294996591	Yosef	Gabay	M	1983-09-06	10 Jabotinsky St, Beersheba	505026804	N	None
196728836	Yosef	Levi	M	1975-07-20	55 Ben Gurion St, Tel Aviv	542064254	N	None
607933636	Moshe	Gabay	M	2002-04-15	74 Jabotinsky St, Haifa	554505458	N	Guide Dog
734987957	Yaakov	Cohen	M	1969-07-16	88 Ben Gurion St, Eilat	522974962	N	None
135745856	Esther	Azoulay	F	1960-01-10	50 Ben Gurion St, Haifa	531399214	N	None
420061429	Yosef	Biton	M	1989-04-23	37 Dizengoff St, Tel Aviv	561125472	Y	Wheelchair
343329332	Leah	Levi	F	1971-11-02	82 Dizengoff St, Tel Aviv	565404028	N	None
284004279	Amit	Shalom	F	1997-11-24	57 Jabotinsky St, Jerusalem	566518761	N	Oxygen Tank
129762178	Esther	Ohayon	F	1983-01-27	25 Dizengoff St, Beersheba	527802310	N	None
465944468	Noa	Azoulay	F	1984-09-19	68 Jabotinsky St, Jerusalem	528137949	Y	Wheelchair
243794689	Rachel	Azoulay	F	1970-11-05	82 Ben Gurion St, Haifa	582667682	Y	Wheelchair
880103575	Amit	Peretz	F	1972-05-20	97 Ben Gurion St, Jerusalem	577579330	N	None
415777602	Amit	Gabay	F	1968-08-08	1 Dizengoff St, Tel Aviv	567458197	N	None
464558868	David	Harari	M	1982-04-18	78 Herzl St, Haifa	506619423	N	Guide Dog
366900528	Miriam	Peretz	F	1976-07-12	99 Ben Gurion St, Haifa	559173448	N	None
518912049	Amit	Cohen	F	1967-10-20	77 Ben Gurion St, Haifa	513551777	N	None
730453991	Leah	Gabay	F	1988-08-17	94 Jabotinsky St, Beersheba	573626477	N	None
189128964	David	Biton	M	1973-02-08	42 Herzl St, Jerusalem	545529760	N	Guide Dog
916917936	David	Ohayon	M	1983-11-27	28 Jabotinsky St, Jerusalem	504698611	N	Oxygen Tank
514134929	Esther	Levi	F	1988-01-02	31 Jabotinsky St, Beersheba	541282297	N	Guide Dog
868919607	Esther	Cohen	F	2002-12-03	16 Ben Gurion St, Eilat	566478411	N	None
161764941	Yaakov	Gabay	M	1960-06-17	82 Herzl St, Tel Aviv	528498368	N	Guide Dog
173426798	Moshe	Mizrahi	M	1999-06-13	79 Dizengoff St, Beersheba	524352514	N	Oxygen Tank
733226714	Esther	Harari	F	1956-07-08	70 Ben Gurion St, Eilat	575170605	N	None
258775091	Amit	Harari	F	1993-11-07	62 Ben Gurion St, Jerusalem	515853857	N	None
272193302	Leah	Peretz	F	2003-09-17	47 Ben Gurion St, Eilat	554153476	Y	Wheelchair
377899807	Moshe	Shalom	M	1995-01-11	28 Ben Gurion St, Tel Aviv	544033560	N	None
494804448	Noa	Cohen	F	1978-05-21	5 Herzl St, Eilat	574942614	Y	Wheelchair
463857918	Leah	Mizrahi	F	1986-05-14	6 Ben Gurion St, Haifa	536624884	N	None
822970399	Noa	Harari	F	1951-05-21	77 Ben Gurion St, Haifa	528591606	N	Guide Dog
348914405	Moshe	Cohen	M	1980-09-25	61 Herzl St, Beersheba	565040649	N	None
606515031	Noa	Levi	F	2001-01-25	35 Dizengoff St, Tel Aviv	545406462	Y	Wheelchair
360443298	Yosef	Mizrahi	M	1965-09-10	70 Herzl St, Haifa	537652733	N	None
958722701	David	Mizrahi	M	1963-06-09	7 Herzl St, Eilat	552205602	N	Oxygen Tank
333409051	Rachel	Gabay	F	2000-01-03	15 Dizengoff St, Haifa	593500101	Y	Wheelchair
298404492	Noa	Ohayon	F	1984-11-25	96 Dizengoff St, Jerusalem	531786751	Y	Wheelchair
362385152	David	Shalom	M	1970-05-19	47 Jabotinsky St, Jerusalem	573659465	N	Guide Dog
805876988	Yosef	Ohayon	M	1965-05-15	37 Ben Gurion St, Eilat	583492777	N	None
563027137	Yosef	Cohen	M	2001-06-05	34 Herzl St, Beersheba	593426176	Y	Wheelchair
135084311	Esther	Shalom	F	1965-09-23	15 Herzl St, Beersheba	546114200	Y	Wheelchair
899936576	Yaakov	Mizrahi	M	1957-06-01	44 Dizengoff St, Eilat	559168544	N	None
915339436	David	Azoulay	M	1988-02-16	46 Ben Gurion St, Eilat	511769032	N	Oxygen Tank
358867112	Noa	Shalom	F	1980-10-04	1 Dizengoff St, Eilat	572178888	Y	Wheelchair
596928327	David	Gabay	M	1970-03-06	78 Herzl St, Tel Aviv	576403270	N	Oxygen Tank
871004539	Leah	Cohen	F	1996-02-21	45 Ben Gurion St, Tel Aviv	598098979	Y	Wheelchair
469589167	Amit	Ohayon	F	2009-10-12	80 Ben Gurion St, Tel Aviv	575149809	N	Oxygen Tank
760208651	Rachel	Peretz	F	1983-12-07	19 Ben Gurion St, Tel Aviv	538288411	N	Guide Dog
251420151	Miriam	Biton	F	1985-05-15	97 Dizengoff St, Beersheba	541796029	N	None
177702985	Miriam	Gabay	F	1965-11-03	63 Ben Gurion St, Haifa	543681203	Y	Wheelchair
303722231	Amit	Mizrahi	F	1998-03-02	33 Dizengoff St, Tel Aviv	567589391	Y	Wheelchair
299085717	David	Cohen	M	1993-05-18	21 Herzl St, Beersheba	515863317	Y	Wheelchair
434477925	Miriam	Azoulay	F	2005-02-07	5 Herzl St, Beersheba	537405106	N	Oxygen Tank
836771587	Yosef	Azoulay	M	2010-08-22	22 Ben Gurion St, Haifa	524272379	N	None
727330871	Leah	Shalom	F	1989-12-15	1 Jabotinsky St, Haifa	548065390	N	Guide Dog
789677587	Leah	Ohayon	F	1971-10-22	42 Ben Gurion St, Beersheba	512816406	Y	Wheelchair
282408614	Amit	Biton	F	1984-09-01	9 Dizengoff St, Jerusalem	592282889	N	None
855172589	Miriam	Shalom	F	1954-12-14	58 Ben Gurion St, Jerusalem	599143734	Y	Wheelchair
185144803	Yaakov	Peretz	M	1961-04-25	86 Ben Gurion St, Eilat	502847544	N	Oxygen Tank
966268273	David	Peretz	M	1976-08-16	5 Jabotinsky St, Beersheba	533977869	N	None
777188208	Moshe	Peretz	M	1968-07-07	90 Herzl St, Haifa	563703542	Y	Wheelchair
433513336	Miriam	Harari	F	1983-11-21	84 Dizengoff St, Jerusalem	504702939	N	None
560347583	Noa	Biton	F	1984-10-21	71 Jabotinsky St, Eilat	583373259	N	None
331181020	Yaakov	Levi	M	1989-06-21	5 Ben Gurion St, Jerusalem	567700454	Y	Wheelchair
254630730	Leah	Biton	F	1975-08-04	5 Jabotinsky St, Eilat	558545739	Y	Wheelchair
490061917	Yosef	Harari	M	1967-07-23	25 Herzl St, Beersheba	595949795	Y	Wheelchair
797776394	Moshe	Ohayon	M	1964-12-06	48 Herzl St, Haifa	525476388	Y	Wheelchair
180510182	Esther	Gabay	F	1951-12-13	70 Jabotinsky St, Tel Aviv	533613632	N	None
726107543	Rachel	Ohayon	F	2000-08-05	94 Ben Gurion St, Beersheba	534950229	Y	Wheelchair
116338238	Miriam	Ohayon	F	1973-09-19	100 Dizengoff St, Jerusalem	552008279	N	Guide Dog
844888238	Esther	Peretz	F	1950-09-04	43 Herzl St, Jerusalem	519225900	Y	Wheelchair
504527711	Noa	Peretz	F	2008-09-21	42 Herzl St, Eilat	563493643	N	Guide Dog
612913584	Miriam	Cohen	F	2005-03-10	8 Ben Gurion St, Haifa	531561113	N	None
754600805	Amit	Azoulay	F	2005-10-09	61 Jabotinsky St, Jerusalem	598728082	N	Oxygen Tank
409960350	Yaakov	Harari	M	1980-09-26	36 Ben Gurion St, Beersheba	586279034	N	Oxygen Tank
503988129	Moshe	Levi	M	1956-05-05	74 Dizengoff St, Haifa	586780621	N	None
475277239	Moshe	Azoulay	M	2004-08-12	46 Herzl St, Jerusalem	519978975	N	None
439631560	Yaakov	Azoulay	M	1958-08-27	81 Jabotinsky St, Beersheba	526230589	N	Oxygen Tank
450494685	Yosef	Peretz	M	1967-10-20	43 Jabotinsky St, Tel Aviv	525029757	N	Oxygen Tank
486579729	Yaakov	Ohayon	M	2002-04-10	23 Jabotinsky St, Jerusalem	555898434	Y	Wheelchair
378410529	Esther	Mizrahi	F	1994-04-09	7 Dizengoff St, Eilat	553664078	Y	Wheelchair
353165680	David	Levi	M	1973-07-14	70 Herzl St, Eilat	526009961	Y	Wheelchair
509642139	Moshe	Biton	M	1959-06-07	46 Dizengoff St, Jerusalem	532834800	N	None
809200522	Esther	Biton	F	1986-07-03	1 Jabotinsky St, Jerusalem	544218087	N	Oxygen Tank
836728213	Rachel	Levi	F	1981-07-09	18 Herzl St, Jerusalem	557402180	N	None
188765341	Amit	Levi	F	1957-05-28	2 Jabotinsky St, Jerusalem	559607224	Y	Wheelchair
194165094	Yaakov	Shalom	M	1987-04-26	73 Ben Gurion St, Tel Aviv	576106519	N	Oxygen Tank
974746813	Yaakov	Biton	M	1985-07-18	32 Herzl St, Jerusalem	568331801	N	Guide Dog
188769931	Rachel	Biton	F	1959-01-16	8 Dizengoff St, Haifa	598524463	Y	Wheelchair
260362065	Rachel	Shalom	F	1992-12-26	86 Jabotinsky St, Tel Aviv	528335640	N	Guide Dog
749132937	Miriam	Mizrahi	F	2008-05-02	20 Jabotinsky St, Jerusalem	578037192	Y	Wheelchair
670190917	Noa	Mizrahi	F	1986-12-18	3 Jabotinsky St, Jerusalem	557363872	N	Oxygen Tank
887631402	Moshe	Harari	M	1968-09-15	56 Jabotinsky St, Tel Aviv	569294100	N	None
426410380	Noa	Gabay	F	2007-09-05	76 Dizengoff St, Beersheba	506342130	N	None
310637280	Rachel	Harari	F	1994-11-03	13 Dizengoff St, Eilat	594287990	N	Oxygen Tank
542415875	Leah	Azoulay	F	2007-07-06	35 Ben Gurion St, Haifa	506652633	N	Oxygen Tank
253196823	Leah	Harari	F	1988-04-04	73 Dizengoff St, Beersheba	543460559	N	Guide Dog
477313143	Miriam	Levi	F	1952-06-13	42 Jabotinsky St, Tel Aviv	535964901	N	None
406254292	Rachel	Mizrahi	F	1953-08-07	73 Herzl St, Haifa	544217001	N	None
852559916	Yosef	Shalom	M	1996-11-06	33 Ben Gurion St, Jerusalem	594510580	Y	Wheelchair
230624445	Rachel	Cohen	F	1969-05-09	1 Dizengoff St, Beersheba	566180854	Y	Wheelchair
371217957	Yosef	Gabay	M	1991-06-24	61 Ben Gurion St, Beersheba	566600620	N	Guide Dog
519814178	Yosef	Levi	M	2005-06-19	34 Dizengoff St, Beersheba	516748521	N	None
483346047	Moshe	Gabay	M	2010-12-15	43 Jabotinsky St, Haifa	517072515	Y	Wheelchair
526256593	Yaakov	Cohen	M	1951-02-03	4 Herzl St, Tel Aviv	519788825	N	None
470869626	Esther	Azoulay	F	1958-11-05	47 Ben Gurion St, Haifa	524238182	Y	Wheelchair
844513515	Yosef	Biton	M	2006-07-28	53 Jabotinsky St, Haifa	561507484	N	Guide Dog
984346343	Leah	Levi	F	1991-10-24	74 Jabotinsky St, Jerusalem	505607791	N	Oxygen Tank
762364645	Amit	Shalom	F	1974-04-06	61 Jabotinsky St, Jerusalem	566432164	Y	Wheelchair
305150698	Esther	Ohayon	F	1981-03-12	71 Ben Gurion St, Beersheba	594598406	Y	Wheelchair
221634502	Noa	Azoulay	F	1995-01-18	31 Jabotinsky St, Tel Aviv	543918642	N	None
582419251	Rachel	Azoulay	F	1979-08-25	76 Dizengoff St, Tel Aviv	518360623	N	Guide Dog
593065946	Amit	Peretz	F	2000-11-24	83 Ben Gurion St, Haifa	575805266	N	Oxygen Tank
583707574	Amit	Gabay	F	1960-03-28	47 Herzl St, Tel Aviv	527058769	N	Guide Dog
172617282	David	Harari	M	1983-05-04	28 Jabotinsky St, Jerusalem	545764282	N	None
590778593	Miriam	Peretz	F	1993-05-20	54 Herzl St, Tel Aviv	594521266	N	Oxygen Tank
151910759	Amit	Cohen	F	1973-02-28	52 Jabotinsky St, Beersheba	545501798	N	None
657393222	Leah	Gabay	F	1961-04-17	35 Dizengoff St, Tel Aviv	517284891	Y	Wheelchair
287043819	David	Biton	M	1989-09-23	90 Dizengoff St, Jerusalem	542737095	N	Guide Dog
755228375	David	Ohayon	M	2003-12-18	92 Dizengoff St, Eilat	508416140	N	Oxygen Tank
699825997	Esther	Levi	F	1984-06-19	81 Herzl St, Beersheba	579190838	N	Guide Dog
574857929	Esther	Cohen	F	1958-10-06	15 Jabotinsky St, Eilat	508617721	N	Oxygen Tank
890176770	Yaakov	Gabay	M	2003-09-28	18 Dizengoff St, Haifa	543207050	N	Oxygen Tank
978090247	Moshe	Mizrahi	M	1992-05-27	14 Ben Gurion St, Haifa	555673661	Y	Wheelchair
229853224	Esther	Harari	F	2005-04-02	77 Ben Gurion St, Tel Aviv	554755044	N	None
168877637	Amit	Harari	F	1996-11-20	34 Herzl St, Tel Aviv	539669818	N	Oxygen Tank
833485809	Leah	Peretz	F	1991-05-15	13 Dizengoff St, Haifa	551850441	Y	Wheelchair
403792403	Moshe	Shalom	M	1990-10-08	84 Ben Gurion St, Haifa	531336287	Y	Wheelchair
508184542	Noa	Cohen	F	1962-07-13	70 Ben Gurion St, Eilat	513521471	Y	Wheelchair
652037078	Leah	Mizrahi	F	1994-11-19	63 Ben Gurion St, Jerusalem	572518351	Y	Wheelchair
292169783	Noa	Harari	F	2006-11-21	35 Dizengoff St, Eilat	582413533	N	Oxygen Tank
281369713	Moshe	Cohen	M	1956-06-07	9 Jabotinsky St, Jerusalem	518385398	N	None
775101924	Noa	Levi	F	1987-02-01	45 Dizengoff St, Haifa	508266591	N	Oxygen Tank
970296727	Yosef	Mizrahi	M	1990-05-07	34 Herzl St, Jerusalem	546657557	N	Oxygen Tank
533354204	David	Mizrahi	M	1963-07-21	11 Ben Gurion St, Jerusalem	564752386	N	Oxygen Tank
185818355	Rachel	Gabay	F	1956-09-05	92 Ben Gurion St, Haifa	566324564	N	None
845115493	Noa	Ohayon	F	1989-01-16	41 Ben Gurion St, Eilat	522849095	N	None
892550568	David	Shalom	M	1953-11-28	8 Dizengoff St, Beersheba	552327515	N	Oxygen Tank
814690335	Yosef	Ohayon	M	1966-07-16	15 Dizengoff St, Beersheba	532154949	N	Oxygen Tank
645957157	Yosef	Cohen	M	1962-01-24	85 Dizengoff St, Tel Aviv	533573347	N	None
209176386	Esther	Shalom	F	1971-07-28	26 Jabotinsky St, Beersheba	532491345	Y	Wheelchair
409466719	Yaakov	Mizrahi	M	1978-05-15	33 Ben Gurion St, Jerusalem	598586149	N	Guide Dog
155981712	David	Azoulay	M	2001-07-27	78 Dizengoff St, Haifa	517897685	N	None
715266007	Noa	Shalom	F	1962-06-10	56 Dizengoff St, Jerusalem	552712849	Y	Wheelchair
124782507	David	Gabay	M	2004-03-05	79 Dizengoff St, Jerusalem	506264973	N	Oxygen Tank
694810573	Leah	Cohen	F	1991-03-03	32 Herzl St, Beersheba	561871210	N	None
591879309	Amit	Ohayon	F	1990-10-18	73 Herzl St, Beersheba	528299251	N	Oxygen Tank
182172500	Rachel	Peretz	F	1986-04-09	91 Jabotinsky St, Tel Aviv	595895734	N	Guide Dog
536869685	Miriam	Biton	F	1996-09-08	54 Dizengoff St, Eilat	539771536	N	Oxygen Tank
274894140	Miriam	Gabay	F	1975-01-01	53 Ben Gurion St, Jerusalem	594936598	N	None
982886900	Amit	Mizrahi	F	1955-09-18	53 Jabotinsky St, Tel Aviv	537867114	N	Oxygen Tank
748336036	David	Cohen	M	1981-04-17	81 Ben Gurion St, Haifa	503347965	N	None
629845815	Miriam	Azoulay	F	2001-01-22	77 Herzl St, Tel Aviv	594463545	Y	Wheelchair
762559306	Yosef	Azoulay	M	1966-12-21	58 Ben Gurion St, Tel Aviv	596487041	N	None
418541884	Leah	Shalom	F	1986-11-27	23 Dizengoff St, Jerusalem	563988150	N	Guide Dog
375159255	Leah	Ohayon	F	1962-09-22	29 Dizengoff St, Beersheba	527909152	N	Oxygen Tank
156313275	Amit	Biton	F	1996-02-17	59 Dizengoff St, Eilat	581727168	N	Oxygen Tank
250708248	Miriam	Shalom	F	1973-10-18	92 Ben Gurion St, Jerusalem	541818154	Y	Wheelchair
944917553	Yaakov	Peretz	M	1970-10-25	69 Jabotinsky St, Haifa	533323258	N	None
639156305	David	Peretz	M	1978-11-27	62 Herzl St, Beersheba	597168823	Y	Wheelchair
965413870	Moshe	Peretz	M	1986-02-08	11 Ben Gurion St, Tel Aviv	585227805	N	Oxygen Tank
514692698	Noa	Biton	F	1983-04-23	26 Ben Gurion St, Beersheba	559646432	N	Oxygen Tank
963025761	Yaakov	Levi	M	1963-12-01	74 Ben Gurion St, Eilat	544037791	N	None
603369296	Leah	Biton	F	1991-01-20	41 Ben Gurion St, Beersheba	596159055	Y	Wheelchair
417243925	Yosef	Harari	M	1953-02-28	18 Jabotinsky St, Eilat	501974371	N	None
195297250	Moshe	Ohayon	M	2010-12-20	84 Ben Gurion St, Haifa	529740609	Y	Wheelchair
165914899	Esther	Gabay	F	1977-04-24	9 Ben Gurion St, Beersheba	572182234	N	Oxygen Tank
368041638	Rachel	Ohayon	F	1958-10-06	29 Ben Gurion St, Eilat	586290352	N	Guide Dog
388934046	Miriam	Ohayon	F	1970-09-05	57 Ben Gurion St, Tel Aviv	585587270	N	None
476830627	Esther	Peretz	F	1997-05-09	65 Ben Gurion St, Jerusalem	567297910	N	None
862048623	Noa	Peretz	F	1953-09-16	16 Dizengoff St, Eilat	563388361	N	None
797569992	Miriam	Cohen	F	1977-04-02	27 Ben Gurion St, Eilat	554067220	N	Guide Dog
367818889	Amit	Azoulay	F	1951-05-14	12 Herzl St, Beersheba	598983210	N	Guide Dog
638101487	Yaakov	Harari	M	2007-04-23	68 Ben Gurion St, Eilat	566840818	N	Oxygen Tank
563031706	Moshe	Levi	M	2001-11-08	57 Dizengoff St, Jerusalem	562391758	N	None
536640092	Moshe	Azoulay	M	2003-11-01	24 Jabotinsky St, Jerusalem	517595663	N	Guide Dog
678621121	Yaakov	Azoulay	M	1965-05-01	52 Dizengoff St, Beersheba	529153241	N	Oxygen Tank
977648192	Yosef	Peretz	M	1985-05-16	22 Dizengoff St, Eilat	563627501	N	None
612117711	Yaakov	Ohayon	M	1950-07-28	68 Ben Gurion St, Eilat	591649665	N	None
396524353	Esther	Mizrahi	F	1970-10-24	39 Ben Gurion St, Haifa	578362546	N	Oxygen Tank
945922559	David	Levi	M	2010-10-19	13 Jabotinsky St, Beersheba	537492464	N	None
267088184	Moshe	Biton	M	1965-06-27	70 Herzl St, Jerusalem	506603545	N	Oxygen Tank
197148858	Esther	Biton	F	1987-09-22	5 Ben Gurion St, Beersheba	577886627	N	Oxygen Tank
301023302	Amit	Levi	F	1964-01-14	82 Herzl St, Tel Aviv	575498173	N	None
903260938	Yaakov	Shalom	M	1967-10-04	53 Ben Gurion St, Tel Aviv	525785407	Y	Wheelchair
637152102	Yaakov	Biton	M	1975-12-18	90 Dizengoff St, Haifa	585401399	N	None
345789475	Rachel	Biton	F	1985-10-18	77 Herzl St, Tel Aviv	528176535	Y	Wheelchair
799742877	Rachel	Shalom	F	1974-07-15	75 Dizengoff St, Eilat	536757186	N	Guide Dog
111387179	Miriam	Mizrahi	F	1959-04-11	65 Ben Gurion St, Eilat	567358607	Y	Wheelchair
962605402	Noa	Mizrahi	F	2008-11-24	17 Dizengoff St, Beersheba	548110873	N	Oxygen Tank
773426386	Moshe	Harari	M	1996-01-01	50 Jabotinsky St, Haifa	511929860	Y	Wheelchair
702769651	Noa	Gabay	F	2008-09-25	31 Herzl St, Beersheba	582589205	N	None
172001273	Rachel	Harari	F	1989-12-22	79 Herzl St, Haifa	506469459	Y	Wheelchair
314642987	Leah	Azoulay	F	1961-05-09	17 Herzl St, Beersheba	529762352	N	Guide Dog
213596569	Leah	Harari	F	2001-09-20	44 Dizengoff St, Haifa	577123964	N	Guide Dog
894985571	Miriam	Levi	F	1962-05-11	9 Ben Gurion St, Jerusalem	568357306	N	None
\.


--
-- TOC entry 3409 (class 0 OID 41086)
-- Dependencies: 223
-- Data for Name: ride; Type: TABLE DATA; Schema: public; Owner: esti
--

COPY public.ride (ride_id, ride_date, pickup_time, patient_id, vehicle_id, driver_id, assistant_id, destination_name, destination_address) FROM stdin;
375	2025-11-28	14:15:00	946244382	342	286582552	153432684	Meuhedet Women's Clinic	HaShalom Rd 135, Haifa
1324	2025-11-28	07:00:00	124782507	143	356308687	642573144	Meuhedet Family Clinic	Jabotinsky St 84, Haifa
1693	2025-11-28	15:15:00	223302984	224	939238672	886553988	Meuhedet Family Clinic	Jabotinsky St 84, Haifa
1	2025-09-04	16:00:00	236809338	136	175078783	228630954	Meuhedet Health Center	HaNegev St 139, Rehovot
2	2025-11-14	18:30:00	366900528	324	421289999	\N	Leumit Women's Clinic	Herzl St 102, Herzliya
3	2025-03-23	10:00:00	629845815	347	427989892	717220517	Meuhedet Family Clinic	Rothschild Ave 36, Herzliya
4	2025-06-01	08:30:00	844513515	10	151385895	403951290	Meuhedet Women's Clinic	Sokolov St 115, Tel Aviv
5	2025-10-26	06:45:00	232412113	197	175078783	\N	Maccabi Clinic	Weizmann St 78, Tel Aviv
6	2025-02-06	06:30:00	762364645	41	278345196	165928627	Clalit Health Center	Ben Gurion Blvd 101, Rehovot
7	2025-08-27	08:45:00	172617282	36	980860075	106374385	Leumit Clinic	Jabotinsky St 21, Rehovot
8	2025-04-21	17:00:00	174043533	185	893399035	333012046	Clalit Family Clinic	HaHistadrut St 19, Holon
9	2025-03-21	13:45:00	371217957	122	993263579	700986555	Maccabi Family Clinic	HaHistadrut St 28, Rishon LeZion
10	2025-06-15	14:45:00	536869685	195	318943388	139987077	Meuhedet Clinic	Weizmann St 19, Rishon LeZion
11	2025-03-12	13:45:00	591839254	279	686931483	632667768	Maccabi Women's Clinic	Herzl St 112, Tel Aviv
12	2025-02-12	17:45:00	351451084	331	162929677	358401641	Leumit Clinic	Menachem Begin St 20, Herzliya
13	2025-02-27	07:45:00	811725293	172	765921635	904402564	Meuhedet Health Center	HaNegev St 127, Tel Aviv
14	2025-02-20	20:00:00	892550568	175	801483903	\N	Clalit Family Clinic	HaYarkon St 102, Bat Yam
15	2025-12-08	09:00:00	794952734	233	130440929	485241165	Maccabi Family Clinic	HaTikva St 98, Bat Yam
16	2025-10-16	10:15:00	248993596	396	523388008	744541166	Clalit City Clinic	HaTikva St 80, Bat Yam
17	2025-07-14	16:30:00	178288655	190	314241360	139987077	Maccabi Health Center	Weizmann St 98, Ashkelon
18	2025-04-04	10:30:00	974269487	191	368803859	958396544	Maccabi Health Center	HaYarkon St 132, Ashdod
19	2025-06-14	09:45:00	276643268	56	890623488	112742705	Shaare Zedek Medical Center	HaNegev St 69, Netanya
20	2025-11-15	11:45:00	984346343	200	339014530	114916894	Leumit City Clinic	Begin Blvd 70, Beersheba
21	2025-04-01	16:00:00	652037078	175	939238672	\N	Leumit Health Center	Herzl St 52, Jerusalem
22	2025-05-22	07:15:00	966268273	190	421289999	642311259	Leumit Pediatric Clinic	HaShalom Rd 70, Kfar Saba
23	2025-09-13	13:45:00	185144803	346	613307691	233341981	Meuhedet Pediatric Clinic	Allenby St 8, Modiin
24	2025-02-14	12:45:00	586562174	374	705338121	112742705	Clalit Women's Clinic	Begin Blvd 34, Bnei Brak
25	2025-02-12	13:45:00	542297151	15	277290510	\N	Meuhedet Health Center	Weizmann St 123, Ashdod
26	2025-07-27	13:45:00	300628794	88	480434918	886567223	Barzilai Medical Center	HaNegev St 45, Ramat Gan
27	2025-12-12	08:30:00	358867112	58	356308687	\N	Meuhedet Family Clinic	HaHistadrut St 74, Haifa
28	2025-10-19	08:45:00	371217957	53	503075904	310449903	Maccabi Pediatric Clinic	Rothschild Ave 58, Holon
29	2025-03-04	06:00:00	174043533	113	790255711	569598179	Meuhedet Pediatric Clinic	HaHistadrut St 39, Netanya
30	2025-10-04	20:00:00	463857918	335	675610128	330948886	Leumit Clinic	Weizmann St 37, Bnei Brak
31	2025-01-24	08:15:00	526256593	65	254904175	700986555	Meuhedet City Clinic	Allenby St 124, Rishon LeZion
32	2025-06-08	12:00:00	208136962	325	495900140	432026089	Meuhedet Clinic	Sokolov St 68, Bat Yam
33	2025-08-10	10:45:00	400850159	263	375913224	\N	Meuhedet City Clinic	Ben Gurion Blvd 96, Ramat Gan
34	2025-08-04	13:15:00	836728213	200	410254424	637417326	Leumit Clinic	Jabotinsky St 77, Modiin
35	2025-12-14	14:45:00	563027137	153	277290510	277362370	Leumit Health Center	Rothschild Ave 88, Modiin
36	2025-05-22	06:30:00	984346343	31	670632947	578303296	Clalit City Clinic	Begin Blvd 17, Ashkelon
37	2025-03-19	12:15:00	221606473	304	724516280	\N	Maccabi Clinic	Ben Gurion Blvd 128, Ashkelon
38	2025-09-21	15:00:00	301023302	186	559056009	641246037	Maccabi City Clinic	Weizmann St 75, Jerusalem
39	2025-05-18	12:15:00	632577955	164	170476311	323208385	Leumit Clinic	Menachem Begin St 20, Herzliya
40	2025-11-17	16:00:00	191561261	232	822386902	717220517	Clalit Pediatric Clinic	Herzl St 20, Jerusalem
41	2025-04-01	07:45:00	587398835	100	421289999	946589413	Clalit City Clinic	Weizmann St 60, Haifa
42	2025-09-17	11:00:00	440428166	238	236786603	680422772	Maccabi Pediatric Clinic	Ben Gurion Blvd 68, Herzliya
43	2025-01-08	09:00:00	151910759	144	385321066	233715310	Leumit Clinic	Herzl St 62, Kfar Saba
44	2025-09-07	16:30:00	974746813	195	740682739	\N	Leumit Clinic	Herzl St 73, Modiin
45	2025-12-06	06:45:00	702769651	191	128998748	\N	Clalit Health Center	Rothschild Ave 146, Modiin
46	2025-12-23	07:15:00	364653026	75	111533007	967167857	Maccabi Pediatric Clinic	Sokolov St 141, Herzliya
47	2025-09-15	11:45:00	198401039	3	548621554	186854746	Clalit Health Center	Jabotinsky St 51, Netanya
48	2025-09-28	09:30:00	542415875	146	355020965	876785540	Maccabi Pediatric Clinic	HaShalom Rd 40, Kfar Saba
49	2025-05-26	13:15:00	505288440	285	352089792	169095841	Clalit Women's Clinic	Begin Blvd 76, Petah Tikva
50	2025-07-07	17:30:00	322279900	41	452354109	\N	Maccabi Family Clinic	Sokolov St 19, Jerusalem
51	2025-05-22	08:30:00	294996591	114	770359651	372000492	Meuhedet City Clinic	Allenby St 124, Rishon LeZion
52	2025-09-23	10:15:00	457553650	333	808943895	367550207	Clalit Family Clinic	Ben Gurion Blvd 143, Bnei Brak
53	2025-11-06	13:45:00	163977003	328	789955108	595566634	Leumit Clinic	Weizmann St 138, Bnei Brak
54	2025-04-13	09:45:00	250708248	352	204520642	927259391	Clalit Family Clinic	Rothschild Ave 27, Bat Yam
55	2025-10-28	14:00:00	415777602	98	909580633	\N	Clalit City Clinic	Jabotinsky St 41, Bnei Brak
56	2025-04-01	19:45:00	918984720	315	116809193	358890331	Leumit Women's Clinic	HaHistadrut St 41, Haifa
57	2025-07-26	10:15:00	721698371	172	325430239	\N	Clalit Women's Clinic	HaTikva St 40, Modiin
58	2025-05-10	08:15:00	490061917	142	494708371	560761358	Meuhedet Women's Clinic	HaYarkon St 98, Haifa
59	2025-12-18	07:45:00	281369713	195	809797531	300885051	Meuhedet Pediatric Clinic	Allenby St 48, Haifa
60	2025-04-11	16:15:00	918984720	328	714051919	\N	Clalit Health Center	HaTikva St 30, Rishon LeZion
61	2025-01-18	08:30:00	603369296	136	757088646	154992568	Meuhedet Health Center	Sokolov St 132, Rishon LeZion
62	2025-10-25	16:00:00	486579729	152	195106131	437174782	Leumit Health Center	Jabotinsky St 124, Holon
63	2025-09-04	11:45:00	617124389	372	375218533	733386484	Clalit Family Clinic	Begin Blvd 107, Netanya
64	2025-06-04	18:45:00	546960294	92	414131125	590833948	Meuhedet City Clinic	Sokolov St 95, Ashkelon
65	2025-05-13	10:15:00	999168068	132	678506268	644870997	Maccabi Clinic	HaTikva St 81, Kfar Saba
66	2025-04-24	19:15:00	836771587	55	419832401	946589413	Rambam Health Campus	HaYarkon St 65, Jerusalem
67	2025-08-09	06:15:00	400850159	232	799258702	\N	Meuhedet Women's Clinic	Ben Gurion Blvd 119, Holon
68	2025-12-07	11:30:00	855172589	141	316396883	926559749	Meuhedet Pediatric Clinic	Menachem Begin St 23, Haifa
69	2025-08-15	18:45:00	757315687	139	651938317	\N	Clalit Health Center	Jabotinsky St 14, Ashdod
70	2025-10-22	12:30:00	248993596	200	495900140	799658255	Clalit Women's Clinic	HaTikva St 139, Rishon LeZion
71	2025-11-24	20:30:00	248993596	323	480434918	\N	Leumit Women's Clinic	HaShalom Rd 101, Ashdod
72	2025-12-02	20:15:00	281369713	122	799258702	745929637	Meuhedet Pediatric Clinic	HaTikva St 104, Kfar Saba
73	2025-08-07	08:00:00	965413870	261	896973596	222522748	Leumit Health Center	Jabotinsky St 124, Holon
74	2025-06-16	08:30:00	682247730	388	799258702	549041678	Clalit Health Center	Rothschild Ave 146, Modiin
75	2025-08-24	16:00:00	208136962	247	870880025	104731999	Leumit Clinic	Ben Gurion Blvd 112, Ramat Gan
76	2025-01-01	16:30:00	345789475	363	282498842	\N	Maccabi Pediatric Clinic	Herzl St 40, Rishon LeZion
77	2025-08-24	10:30:00	530709488	167	335528238	143764555	Clalit Pediatric Clinic	Sokolov St 44, Ra'anana
78	2025-02-02	16:30:00	680566675	126	195106131	264594643	Maccabi Women's Clinic	Menachem Begin St 93, Haifa
79	2025-04-22	10:15:00	348914405	51	439413734	200778361	Leumit Family Clinic	Ben Gurion Blvd 147, Ashkelon
80	2025-06-12	18:00:00	890176770	307	789955108	958396544	Clalit Women's Clinic	HaPalmach St 139, Ashdod
81	2025-02-22	13:15:00	457553650	1	254904175	106823913	Clalit City Clinic	Begin Blvd 105, Bat Yam
82	2025-12-16	20:15:00	258775091	124	335569735	549847210	Leumit Health Center	Weizmann St 145, Petah Tikva
83	2025-10-16	19:45:00	754600805	175	559056009	588485108	Leumit Clinic	HaNegev St 104, Ra'anana
84	2025-07-15	16:00:00	591839254	379	427989892	803631502	Maccabi Health Center	HaHistadrut St 56, Jerusalem
85	2025-06-09	18:00:00	587650033	243	335569735	716745655	Meuhedet Pediatric Clinic	HaHistadrut St 39, Netanya
86	2025-07-22	13:15:00	348914405	110	494708371	652055112	Leumit Family Clinic	HaHistadrut St 102, Ashkelon
87	2025-01-07	19:30:00	536640092	219	927916320	391559775	Leumit Health Center	HaShalom Rd 19, Haifa
88	2025-11-02	11:30:00	191561261	59	405648081	\N	Leumit Women's Clinic	HaNegev St 149, Ramat Gan
89	2025-10-08	07:45:00	587398835	227	145012488	452367681	Leumit City Clinic	HaPalmach St 11, Haifa
90	2025-01-27	08:15:00	903260938	347	914566516	485241165	Leumit Family Clinic	Ben Gurion Blvd 2, Modiin
91	2025-12-17	19:30:00	510369863	6	314241360	\N	Maccabi Pediatric Clinic	HaTikva St 63, Modiin
92	2025-12-24	08:45:00	730453991	244	508895013	809751526	Clalit Family Clinic	Allenby St 103, Rishon LeZion
93	2025-02-14	17:30:00	300628794	211	111533007	446763595	Maccabi Health Center	Menachem Begin St 68, Rehovot
94	2025-11-19	07:15:00	536709776	233	111533007	358890331	Clalit Family Clinic	Allenby St 100, Haifa
95	2025-06-01	20:15:00	962605402	87	335528238	\N	Leumit Pediatric Clinic	HaNegev St 140, Bnei Brak
96	2025-10-26	09:00:00	155981712	335	111533007	115674283	Meuhedet Women's Clinic	Begin Blvd 122, Ra'anana
97	2025-01-26	19:00:00	689825727	263	530516374	557387584	Leumit Clinic	HaNegev St 102, Tel Aviv
98	2025-07-23	09:30:00	229853224	73	334099421	500823705	Maccabi Pediatric Clinic	Ben Gurion Blvd 17, Modiin
99	2025-04-14	14:45:00	744340871	106	146240027	\N	Clalit Clinic	HaHistadrut St 39, Ramat Gan
100	2025-09-06	18:45:00	135084311	1	349943042	793942949	Leumit Pediatric Clinic	Allenby St 96, Beersheba
101	2025-10-02	12:15:00	256086565	300	175078783	680422772	Meuhedet City Clinic	Begin Blvd 64, Tel Aviv
102	2025-01-26	07:00:00	254630730	259	710030144	692757934	Clalit City Clinic	Sokolov St 78, Herzliya
103	2025-11-13	07:30:00	150349157	47	710030144	608281507	Clalit City Clinic	Herzl St 84, Netanya
104	2025-04-13	19:15:00	965413870	59	312816743	288012548	Maccabi Health Center	HaYarkon St 74, Modiin
105	2025-04-17	14:15:00	418541884	210	670632947	\N	Meuhedet Family Clinic	HaHistadrut St 74, Haifa
106	2025-01-08	06:45:00	163350630	184	300697114	579396263	Clalit Women's Clinic	HaPalmach St 142, Petah Tikva
107	2025-04-27	13:45:00	503988129	390	808943895	210440926	Meuhedet Family Clinic	HaHistadrut St 97, Kfar Saba
108	2025-04-09	15:30:00	498056409	3	765574491	798009672	Leumit Family Clinic	HaHistadrut St 128, Rishon LeZion
109	2025-04-13	09:30:00	546960294	366	775579062	467137650	Clalit Health Center	HaShalom Rd 8, Haifa
110	2025-05-26	19:15:00	512030298	103	896973596	578118209	Leumit Family Clinic	Allenby St 12, Ramat Gan
111	2025-07-13	09:00:00	191561261	285	121502474	475678577	Assuta Hospital	HaYarkon St 11, Petah Tikva
112	2025-08-24	13:30:00	880103575	44	765574491	300885051	Leumit Health Center	Weizmann St 145, Petah Tikva
113	2025-06-11	18:00:00	463857918	118	613307691	310449903	Leumit Women's Clinic	HaTikva St 7, Modiin
114	2025-06-28	15:30:00	155898237	233	869278628	277362370	Meuhedet Family Clinic	HaYarkon St 37, Bat Yam
115	2025-12-07	12:00:00	799742877	347	870880025	112742705	Meuhedet City Clinic	Begin Blvd 64, Tel Aviv
116	2025-07-13	20:30:00	322317846	38	808943895	367550207	Leumit Clinic	Ben Gurion Blvd 112, Ramat Gan
117	2025-10-04	10:15:00	862445507	307	604840053	567352637	Leumit Pediatric Clinic	Begin Blvd 42, Bnei Brak
118	2025-04-05	20:00:00	189128964	99	350299663	857599583	Meuhedet Clinic	Jabotinsky St 142, Kfar Saba
119	2025-04-28	06:00:00	299085717	243	675033386	379926927	Clalit Women's Clinic	HaPalmach St 142, Petah Tikva
120	2025-01-15	16:00:00	221606473	242	160913893	792123494	Meuhedet Family Clinic	HaHistadrut St 144, Beersheba
121	2025-04-24	17:45:00	433513336	21	286582552	634188128	Meuhedet Women's Clinic	HaYarkon St 87, Jerusalem
122	2025-07-13	06:45:00	542297151	32	160913893	793942949	Maccabi Health Center	HaTikva St 93, Beersheba
123	2025-10-15	16:00:00	188769931	244	939238672	770618338	Meuhedet Clinic	Weizmann St 71, Ashkelon
124	2025-03-19	12:30:00	871784867	94	580038886	475678577	Meuhedet Pediatric Clinic	HaHistadrut St 65, Rehovot
125	2025-05-27	17:45:00	737208814	222	327338690	642573144	Clalit Women's Clinic	HaYarkon St 60, Ashkelon
126	2025-09-17	11:30:00	829589264	166	246927292	154992568	Clalit Family Clinic	Menachem Begin St 26, Bat Yam
127	2025-02-03	18:00:00	303722231	358	860923150	154992568	Clalit Pediatric Clinic	Allenby St 107, Ashkelon
128	2025-03-22	16:00:00	465944468	58	703776850	792123494	Maccabi Women's Clinic	Ben Gurion Blvd 85, Ashkelon
129	2025-07-06	14:15:00	208136962	125	146240027	620872913	Sheba Medical Center	HaShalom Rd 83, Tel Aviv
130	2025-03-27	17:15:00	626008407	170	775579062	\N	Meuhedet City Clinic	HaYarkon St 15, Tel Aviv
131	2025-10-23	20:15:00	189899416	197	561707109	477791140	Leumit City Clinic	Weizmann St 138, Modiin
132	2025-02-02	17:00:00	789677587	188	583133229	143764555	Maccabi Family Clinic	Herzl St 103, Jerusalem
133	2025-10-03	17:45:00	343329332	276	951108053	700986555	Maccabi Pediatric Clinic	HaNegev St 5, Ramat Gan
134	2025-01-22	07:30:00	533476073	317	121065055	967167857	Leumit Health Center	Allenby St 40, Bnei Brak
135	2025-10-01	10:15:00	415777602	190	503075904	\N	Maccabi Clinic	HaTikva St 81, Kfar Saba
136	2025-06-15	20:00:00	156313275	131	604840053	\N	Clalit Family Clinic	Allenby St 103, Rishon LeZion
137	2025-04-15	15:00:00	797776394	141	246927292	858675688	Meuhedet Clinic	Rothschild Ave 113, Rishon LeZion
138	2025-01-21	06:30:00	760208651	159	890623488	124787141	Maccabi Family Clinic	HaYarkon St 77, Kfar Saba
139	2025-07-07	18:15:00	771372820	59	675610128	803631502	Leumit Clinic	Sokolov St 20, Ashdod
140	2025-11-04	13:30:00	587650033	129	489601917	154749464	Maccabi Clinic	Weizmann St 12, Jerusalem
141	2025-09-25	14:45:00	563031706	45	510334717	621805679	Maccabi Women's Clinic	Herzl St 112, Tel Aviv
142	2025-03-23	12:15:00	944917553	81	559056009	590833948	Clalit Pediatric Clinic	Herzl St 20, Jerusalem
143	2025-01-16	13:00:00	536640092	175	667143420	\N	Leumit Women's Clinic	HaTikva St 89, Bnei Brak
144	2025-01-13	09:15:00	754151802	41	484821493	632667768	Meuhedet Women's Clinic	Ben Gurion Blvd 112, Beersheba
145	2025-07-09	14:45:00	310637280	376	339014530	173735333	Leumit City Clinic	Weizmann St 138, Modiin
146	2025-03-10	13:00:00	320907039	383	145012488	632667768	Clalit Family Clinic	Allenby St 29, Holon
147	2025-06-05	20:00:00	170140414	300	414131125	\N	Maccabi City Clinic	Jabotinsky St 56, Ra'anana
148	2025-10-19	15:30:00	431925566	216	703776850	\N	Leumit Pediatric Clinic	Sokolov St 30, Petah Tikva
149	2025-07-12	08:45:00	457553650	114	316396883	\N	Leumit Family Clinic	Sokolov St 20, Ashdod
150	2025-08-09	10:00:00	591879309	263	952751158	\N	Maccabi Pediatric Clinic	HaTikva St 63, Modiin
151	2025-07-22	12:30:00	433513336	200	577645975	\N	Clalit Pediatric Clinic	HaHistadrut St 50, Rehovot
152	2025-05-04	07:00:00	822970399	245	375218533	\N	Maccabi Health Center	Menachem Begin St 68, Rehovot
153	2025-06-26	13:30:00	388934046	222	405648081	\N	Meuhedet Women's Clinic	Ben Gurion Blvd 112, Beersheba
154	2025-07-09	14:15:00	920666292	271	152785861	\N	Maccabi Clinic	Menachem Begin St 21, Bat Yam
155	2025-10-13	10:15:00	771372820	34	375913224	120252841	Barzilai Medical Center	HaNegev St 45, Ramat Gan
156	2025-07-21	13:15:00	754151802	137	129452534	162854543	Meuhedet Health Center	Allenby St 129, Jerusalem
157	2025-12-02	16:15:00	463857918	386	703776850	\N	Meuhedet Women's Clinic	Rothschild Ave 65, Ashdod
158	2025-11-11	06:45:00	155981712	27	303635805	379926927	Leumit Pediatric Clinic	HaYarkon St 95, Rishon LeZion
159	2025-08-17	13:15:00	431925566	14	860923150	\N	Meuhedet Clinic	Sokolov St 68, Bat Yam
160	2025-02-23	10:15:00	467713954	346	361945520	146343109	Leumit City Clinic	HaNegev St 36, Haifa
161	2025-02-09	15:30:00	694810573	86	350299663	\N	Clalit City Clinic	Jabotinsky St 41, Bnei Brak
162	2025-01-17	09:00:00	189791206	114	349943042	877651756	Meuhedet City Clinic	Rothschild Ave 131, Ashdod
163	2025-09-04	10:45:00	406254292	64	651938317	372000492	Meuhedet City Clinic	Allenby St 117, Bat Yam
164	2025-02-14	17:30:00	326216990	181	469439493	\N	Meuhedet Women's Clinic	Menachem Begin St 122, Haifa
165	2025-09-03	12:30:00	465944468	119	262180529	567352637	Leumit Family Clinic	HaYarkon St 147, Tel Aviv
166	2025-03-19	13:00:00	789677587	327	589073536	853912682	Clalit Family Clinic	Menachem Begin St 26, Bat Yam
167	2025-06-09	18:00:00	116338238	234	952751158	223034510	Meuhedet Pediatric Clinic	HaHistadrut St 65, Rehovot
168	2025-08-12	09:00:00	366900528	36	335569735	\N	Meuhedet Women's Clinic	HaShalom Rd 102, Ashkelon
169	2025-12-04	07:00:00	682247730	215	205096731	\N	Maccabi City Clinic	Ben Gurion Blvd 61, Bnei Brak
170	2025-11-18	16:45:00	189791206	193	565166657	\N	Leumit Clinic	HaNegev St 42, Herzliya
171	2025-08-13	12:00:00	887631402	124	188163518	216674676	Meuhedet Clinic	Sokolov St 68, Bat Yam
172	2025-12-11	15:00:00	558919861	178	110532551	\N	Leumit Women's Clinic	Ben Gurion Blvd 76, Rehovot
173	2025-08-12	16:15:00	763371666	236	410962502	\N	Clalit Women's Clinic	HaTikva St 7, Ashdod
174	2025-09-07	13:15:00	526256593	274	530516374	515517676	Maccabi Family Clinic	HaTikva St 49, Ramat Gan
175	2025-02-02	20:30:00	946254016	289	740682739	365083334	Leumit Family Clinic	HaHistadrut St 102, Ashkelon
176	2025-02-04	12:00:00	715266007	219	254904175	181098189	Clalit City Clinic	Herzl St 84, Netanya
177	2025-10-17	18:15:00	662729589	57	924888731	467137650	Leumit Pediatric Clinic	HaYarkon St 95, Rishon LeZion
178	2025-10-18	12:00:00	314642987	68	188163518	233025558	Clalit Women's Clinic	Rothschild Ave 149, Haifa
179	2025-07-18	19:30:00	852559916	314	722223783	886553988	Maccabi Clinic	Begin Blvd 98, Ra'anana
180	2025-02-25	06:00:00	184019783	215	724516280	379926927	Maccabi Clinic	Begin Blvd 98, Ra'anana
181	2025-09-19	15:45:00	485521617	259	565661395	595566634	Clalit Family Clinic	Begin Blvd 29, Kfar Saba
182	2025-08-20	13:30:00	607933636	252	300697114	523195752	Leumit Clinic	HaTikva St 85, Herzliya
183	2025-04-12	19:45:00	260362065	25	575013098	515517676	Maccabi Health Center	HaYarkon St 74, Modiin
184	2025-12-25	08:15:00	895588198	89	623490063	641246037	Leumit Family Clinic	HaYarkon St 147, Tel Aviv
185	2025-07-07	15:15:00	757315687	199	651447743	585034134	Leumit Health Center	HaYarkon St 62, Bnei Brak
186	2025-08-28	11:00:00	299085717	167	414131125	300885051	Clalit Clinic	Ben Gurion Blvd 111, Beersheba
187	2025-03-12	10:45:00	306674982	166	286582552	569598179	Leumit Women's Clinic	HaShalom Rd 101, Ashdod
188	2025-04-15	10:30:00	974746813	63	914566516	515517676	Maccabi Health Center	Weizmann St 25, Jerusalem
189	2025-08-19	07:15:00	409960350	242	808943895	104731999	Meuhedet Clinic	HaShalom Rd 118, Jerusalem
190	2025-12-05	11:45:00	229853224	73	589073536	549041678	Clalit City Clinic	Herzl St 84, Netanya
191	2025-01-24	09:00:00	596928327	394	789955108	106374385	Maccabi Family Clinic	Weizmann St 118, Ashkelon
192	2025-12-13	17:45:00	694810573	242	670632947	\N	Leumit Family Clinic	HaHistadrut St 102, Ashkelon
193	2025-01-23	07:45:00	699825997	312	421289999	\N	Maccabi Family Clinic	HaPalmach St 15, Haifa
194	2025-06-09	10:30:00	156313275	280	246927292	991202503	Meuhedet Clinic	Begin Blvd 140, Bat Yam
195	2025-05-18	08:30:00	782770105	71	902246089	931089150	Meuhedet Family Clinic	HaShalom Rd 80, Bat Yam
196	2025-01-09	15:45:00	533476073	150	494708371	717220517	Leumit Family Clinic	Allenby St 12, Ramat Gan
197	2025-01-15	06:30:00	777188208	366	902246089	\N	Leumit City Clinic	HaTikva St 108, Ramat Gan
198	2025-01-03	06:00:00	502455034	139	300697114	228630954	Maccabi City Clinic	HaTikva St 148, Haifa
199	2025-06-21	06:00:00	333409051	346	368803859	927259391	Maccabi Family Clinic	HaYarkon St 77, Kfar Saba
200	2025-10-14	10:00:00	982886900	130	760677936	457148964	Leumit Clinic	HaTikva St 113, Beersheba
201	2025-09-01	13:30:00	582442635	174	565425153	977667032	Clalit Family Clinic	HaHistadrut St 19, Holon
202	2025-01-08	15:00:00	906327198	354	410962502	\N	Clalit Clinic	HaHistadrut St 39, Ramat Gan
203	2025-05-22	12:15:00	434477925	31	757088646	\N	Leumit Health Center	Rothschild Ave 85, Ramat Gan
204	2025-01-05	08:45:00	593065946	271	175078783	977667032	Maccabi Women's Clinic	Jabotinsky St 123, Petah Tikva
205	2025-07-23	07:30:00	275062263	66	492050992	152943249	Maccabi City Clinic	Weizmann St 75, Jerusalem
206	2025-10-23	06:15:00	198401039	315	254904175	323208385	Clalit City Clinic	Begin Blvd 61, Rishon LeZion
207	2025-03-28	14:15:00	536869685	42	939238672	\N	Leumit Pediatric Clinic	Begin Blvd 30, Herzliya
208	2025-06-26	07:45:00	894956091	208	160913893	579396263	Leumit Clinic	Ben Gurion Blvd 112, Ramat Gan
209	2025-03-03	06:45:00	653318684	344	188163518	510589173	Maccabi Family Clinic	Rothschild Ave 32, Rishon LeZion
210	2025-02-14	20:45:00	920666292	21	886939800	974562766	Clalit Clinic	HaHistadrut St 142, Kfar Saba
211	2025-06-01	09:15:00	782770105	4	571289027	543138407	Leumit Pediatric Clinic	Rothschild Ave 32, Petah Tikva
212	2025-05-16	10:30:00	343278287	16	530516374	289805994	Clalit Family Clinic	Begin Blvd 107, Netanya
213	2025-04-26	15:00:00	458111142	352	668035126	367550207	Leumit City Clinic	HaPalmach St 140, Kfar Saba
214	2025-02-19	09:30:00	355235662	194	718084895	858675688	Leumit City Clinic	Begin Blvd 70, Beersheba
215	2025-04-08	19:30:00	431925566	20	747832838	333012046	Leumit Women's Clinic	HaYarkon St 113, Rishon LeZion
216	2025-06-19	16:45:00	895576008	185	334099421	\N	Leumit City Clinic	Weizmann St 138, Modiin
217	2025-01-07	19:15:00	223971678	371	282498842	114916894	Soroka Medical Center	HaYarkon St 6, Ashdod
218	2025-02-20	07:45:00	314642987	76	484821493	627217360	Leumit Women's Clinic	Herzl St 102, Herzliya
219	2025-01-28	14:15:00	463857918	379	385015287	919941861	Clalit Family Clinic	Allenby St 100, Haifa
220	2025-11-25	15:30:00	741606378	219	303635805	442531669	Leumit Clinic	Weizmann St 138, Bnei Brak
221	2025-08-03	12:45:00	963025761	131	312816743	106823913	Leumit Women's Clinic	HaTikva St 38, Ramat Gan
222	2025-12-25	11:45:00	797776394	89	876946737	757351763	Clalit Pediatric Clinic	Ben Gurion Blvd 61, Holon
223	2025-08-15	13:15:00	283767201	43	300697114	143764555	Clalit Women's Clinic	Begin Blvd 34, Bnei Brak
224	2025-11-04	13:00:00	542297151	253	195106131	523195752	Clalit Family Clinic	Menachem Begin St 26, Bat Yam
225	2025-06-08	06:00:00	172001273	328	262180529	717220517	Clalit Women's Clinic	HaTikva St 7, Ashdod
226	2025-06-27	17:30:00	799742877	270	294557346	162854543	Clalit Women's Clinic	HaHistadrut St 148, Ramat Gan
227	2025-04-22	20:15:00	131666625	181	589073536	857599583	Clalit Women's Clinic	HaTikva St 139, Rishon LeZion
228	2025-06-20	09:00:00	508184542	302	668035126	\N	Leumit Pediatric Clinic	HaShalom Rd 52, Modiin
229	2025-07-13	10:30:00	300628794	341	240709151	432026089	Leumit Clinic	Menachem Begin St 20, Herzliya
230	2025-10-22	06:45:00	893684024	399	604840053	143764555	Clalit Family Clinic	Ben Gurion Blvd 143, Bnei Brak
231	2025-04-04	06:15:00	575650818	279	508895013	193901152	Barzilai Medical Center	HaNegev St 45, Ramat Gan
232	2025-12-02	10:30:00	253196823	241	775579062	937895475	Clalit Family Clinic	HaNegev St 107, Bat Yam
233	2025-11-06	06:15:00	275062263	228	686931483	705977773	Leumit Pediatric Clinic	Allenby St 96, Beersheba
234	2025-09-04	08:30:00	811725293	35	121065055	720046881	Maccabi Women's Clinic	Herzl St 16, Modiin
235	2025-03-02	20:45:00	195297250	187	510334717	927259391	Leumit Pediatric Clinic	HaShalom Rd 70, Kfar Saba
236	2025-05-17	11:30:00	757315687	329	565166657	524957376	Leumit Family Clinic	HaNegev St 126, Modiin
237	2025-11-03	12:45:00	704835566	229	175078783	\N	Meuhedet Clinic	Rothschild Ave 130, Rishon LeZion
238	2025-10-15	14:45:00	184019783	3	385321066	\N	Meuhedet City Clinic	Ben Gurion Blvd 96, Ramat Gan
239	2025-04-01	08:30:00	587650033	365	993263579	\N	Meuhedet Family Clinic	HaYarkon St 37, Bat Yam
240	2025-03-21	12:45:00	429596723	159	580038886	\N	Meuhedet Family Clinic	HaShalom Rd 80, Bat Yam
241	2025-11-22	10:00:00	281369713	344	766537646	106374385	Meuhedet Women's Clinic	HaShalom Rd 135, Haifa
242	2025-12-25	18:15:00	852559916	175	561707109	835357628	Leumit City Clinic	Ben Gurion Blvd 96, Bnei Brak
243	2025-12-21	19:45:00	185818355	391	623490063	125478540	Maccabi Pediatric Clinic	Herzl St 144, Rishon LeZion
244	2025-01-28	12:45:00	418541884	28	510334717	792123494	Meuhedet City Clinic	HaPalmach St 122, Modiin
245	2025-01-02	06:30:00	699825997	113	111533007	444687035	Leumit Family Clinic	Ben Gurion Blvd 2, Modiin
246	2025-08-24	19:15:00	367688443	114	565661395	990265405	Maccabi Family Clinic	HaHistadrut St 41, Tel Aviv
247	2025-06-11	12:00:00	267088184	274	127373899	\N	Meuhedet Family Clinic	Menachem Begin St 58, Rehovot
248	2025-07-13	19:00:00	196728836	26	303635805	744541166	Maccabi Clinic	Menachem Begin St 21, Bat Yam
249	2025-11-27	18:00:00	849864109	80	869278628	\N	Clalit Women's Clinic	HaPalmach St 139, Ashdod
250	2025-11-26	11:15:00	754600805	20	613307691	\N	Maccabi Family Clinic	Jabotinsky St 5, Rehovot
251	2025-11-26	06:45:00	903260938	199	146240027	\N	Maccabi Pediatric Clinic	HaTikva St 63, Modiin
252	2025-12-15	16:00:00	974269487	214	508895013	867910701	Meuhedet Women's Clinic	Rothschild Ave 65, Ashdod
253	2025-08-13	14:30:00	657393222	105	770359651	152943249	Meuhedet Pediatric Clinic	Weizmann St 102, Haifa
254	2025-12-19	13:15:00	502455034	21	334099421	\N	Maccabi Family Clinic	Weizmann St 128, Modiin
255	2025-07-21	14:45:00	682247730	392	993263579	\N	Meuhedet City Clinic	Begin Blvd 64, Tel Aviv
256	2025-11-05	17:15:00	367818889	206	130440929	302016206	Meuhedet Clinic	Weizmann St 71, Ashkelon
257	2025-02-04	20:45:00	965413870	327	896973596	484495578	Leumit Clinic	Ben Gurion Blvd 112, Ramat Gan
258	2025-01-08	10:15:00	486579729	223	165682443	588485108	Maccabi Clinic	HaPalmach St 36, Tel Aviv
259	2025-09-23	11:30:00	606515031	292	510716800	896666994	Clalit Pediatric Clinic	Rothschild Ave 56, Ramat Gan
260	2025-12-04	18:00:00	161764941	387	569080510	634188128	Maccabi Family Clinic	Sokolov St 90, Ashkelon
261	2025-10-14	15:00:00	890970312	252	565737791	475678577	Meuhedet Family Clinic	Rothschild Ave 36, Herzliya
262	2025-01-28	17:00:00	358393463	176	765574491	638619639	Leumit Family Clinic	Ben Gurion Blvd 21, Bat Yam
263	2025-09-25	18:45:00	833485809	325	427989892	\N	Maccabi Clinic	Rothschild Ave 133, Rehovot
264	2025-03-14	13:45:00	383641443	76	459613663	608281507	Meuhedet Pediatric Clinic	HaTikva St 104, Kfar Saba
265	2025-11-13	17:30:00	715266007	54	419832401	222522748	Meuhedet Women's Clinic	Ben Gurion Blvd 46, Modiin
266	2025-04-01	10:15:00	477313143	269	767059275	757351763	Leumit Pediatric Clinic	Weizmann St 74, Rishon LeZion
267	2025-08-27	07:00:00	331181020	335	604840053	549041678	Leumit City Clinic	Begin Blvd 70, Beersheba
268	2025-03-18	17:15:00	590652532	52	277290510	467137650	Meuhedet Pediatric Clinic	Begin Blvd 73, Bnei Brak
269	2025-11-01	20:15:00	614959631	118	993263579	106823913	Clalit City Clinic	Jabotinsky St 41, Bnei Brak
270	2025-02-17	18:15:00	415777602	103	762854976	991202503	Clalit City Clinic	Herzl St 84, Netanya
271	2025-01-24	16:00:00	124782507	64	565737791	485241165	Clalit Family Clinic	HaHistadrut St 97, Bat Yam
272	2025-10-16	12:15:00	915339436	232	240709151	694876741	Leumit Health Center	HaYarkon St 62, Bnei Brak
273	2025-10-24	17:30:00	281369713	57	869278628	745929637	Leumit Women's Clinic	Sokolov St 98, Bnei Brak
274	2025-10-03	08:30:00	283767201	212	822386902	\N	Leumit Pediatric Clinic	Sokolov St 30, Petah Tikva
275	2025-10-05	20:00:00	409466719	145	765921635	720046881	Meuhedet Family Clinic	HaYarkon St 37, Bat Yam
276	2025-02-20	11:45:00	512030298	71	484821493	\N	Leumit Health Center	HaYarkon St 112, Modiin
277	2025-03-18	13:30:00	794952734	23	510334717	266685039	Meuhedet Clinic	HaShalom Rd 118, Jerusalem
278	2025-04-08	07:00:00	903260938	320	675033386	857599583	Leumit Women's Clinic	Jabotinsky St 124, Ramat Gan
279	2025-09-24	16:00:00	797569992	20	116809193	\N	Maccabi Family Clinic	HaNegev St 59, Rehovot
280	2025-08-01	16:45:00	406254292	312	933176850	455096535	Clalit Women's Clinic	Herzl St 44, Haifa
281	2025-11-11	19:00:00	144374344	396	128998748	718179719	Shaare Zedek Medical Center	HaNegev St 69, Netanya
282	2025-06-10	09:30:00	741606378	31	832006368	886553988	Leumit City Clinic	HaHistadrut St 136, Kfar Saba
283	2025-01-22	08:45:00	587650033	340	722223783	569598179	Maccabi Family Clinic	Herzl St 103, Jerusalem
284	2025-03-17	15:00:00	267348942	373	582888025	510589173	Leumit Pediatric Clinic	Menachem Begin St 92, Jerusalem
285	2025-03-13	15:30:00	155898237	106	571289027	162854543	Leumit City Clinic	Begin Blvd 66, Rehovot
286	2025-10-04	08:30:00	409466719	301	747832838	567352637	Clalit Women's Clinic	Rothschild Ave 149, Haifa
287	2025-08-19	16:00:00	310637280	271	775579062	913520210	Leumit Clinic	Weizmann St 37, Bnei Brak
288	2025-06-28	19:45:00	129762178	377	236786603	856141290	Clalit Women's Clinic	HaTikva St 139, Rishon LeZion
289	2025-04-10	06:30:00	895588198	114	106107388	\N	Clalit Women's Clinic	Sokolov St 96, Ashkelon
290	2025-07-23	10:00:00	945922559	59	869029092	642778231	Leumit City Clinic	Sokolov St 97, Bnei Brak
291	2025-12-02	12:00:00	851341222	323	318943388	216674676	Clalit Women's Clinic	HaHistadrut St 148, Ramat Gan
292	2025-06-16	16:00:00	366900528	345	286582552	977667032	Leumit City Clinic	Jabotinsky St 3, Rishon LeZion
293	2025-10-11	16:45:00	845115493	264	703776850	120252841	Leumit Clinic	HaNegev St 102, Tel Aviv
294	2025-05-12	07:45:00	375159255	37	480434918	277362370	Leumit Health Center	Herzl St 52, Jerusalem
295	2025-11-08	13:15:00	894548767	135	651938317	857599583	Maccabi Clinic	HaShalom Rd 37, Kfar Saba
296	2025-01-04	07:45:00	476830627	109	767059275	205288611	Leumit Pediatric Clinic	Begin Blvd 130, Ra'anana
297	2025-05-16	07:30:00	284489969	113	530516374	112742705	Maccabi Health Center	HaTikva St 130, Rishon LeZion
298	2025-07-10	12:30:00	223971678	363	581537784	\N	Meuhedet Health Center	Herzl St 74, Modiin
299	2025-03-12	17:00:00	195297250	90	835425519	455096535	Leumit City Clinic	Jabotinsky St 124, Haifa
300	2025-01-06	09:30:00	738045160	338	414316626	\N	Leumit City Clinic	HaPalmach St 11, Haifa
301	2025-11-23	11:15:00	976166486	30	390750761	\N	Leumit Health Center	Weizmann St 145, Petah Tikva
302	2025-04-01	08:30:00	733454157	139	489601917	\N	Clalit Women's Clinic	Sokolov St 82, Petah Tikva
303	2025-04-27	14:30:00	733454157	53	613307691	718179719	Leumit City Clinic	Ben Gurion Blvd 25, Ramat Gan
304	2025-01-22	08:30:00	918984720	325	909580633	154992568	Maccabi Pediatric Clinic	Herzl St 12, Jerusalem
305	2025-09-27	13:30:00	170140414	40	589073536	193901152	Ichilov Hospital	Rothschild Ave 148, Beersheba
306	2025-01-23	08:00:00	170140414	366	620016708	398331058	Meuhedet Health Center	Herzl St 74, Modiin
307	2025-07-28	09:30:00	284004279	101	188163518	609883589	Clalit Pediatric Clinic	Weizmann St 78, Netanya
308	2025-08-16	14:30:00	431782073	204	337501464	444687035	Maccabi Clinic	Weizmann St 78, Tel Aviv
309	2025-11-19	13:15:00	504527711	108	337501464	770618338	Leumit Women's Clinic	HaTikva St 7, Modiin
310	2025-01-24	10:15:00	377899807	149	648046509	\N	Meuhedet Clinic	Weizmann St 71, Ashkelon
311	2025-03-20	19:00:00	860088812	188	146240027	926559749	Meuhedet Pediatric Clinic	HaHistadrut St 65, Rehovot
312	2025-08-22	13:00:00	844513515	176	980860075	205288611	Meuhedet City Clinic	Begin Blvd 64, Tel Aviv
313	2025-12-10	11:45:00	849864109	195	510334717	\N	Leumit Health Center	HaYarkon St 112, Modiin
314	2025-10-12	17:15:00	762364645	135	583133229	468701304	Maccabi Women's Clinic	Sokolov St 14, Petah Tikva
315	2025-11-15	14:15:00	182172500	177	832006368	\N	Meuhedet Pediatric Clinic	HaHistadrut St 39, Netanya
316	2025-12-15	06:15:00	582442635	67	327338690	990265405	Clalit Family Clinic	HaYarkon St 28, Bat Yam
317	2025-12-24	12:45:00	662729589	240	240709151	365083334	Meuhedet Family Clinic	Menachem Begin St 58, Rehovot
318	2025-10-25	07:30:00	415777602	5	765921635	104731999	Meuhedet City Clinic	Rothschild Ave 66, Petah Tikva
319	2025-09-10	14:15:00	542415875	293	767059275	642311259	Clalit Health Center	Herzl St 113, Bat Yam
320	2025-11-25	09:30:00	632274169	260	427852785	120252841	Maccabi Family Clinic	Herzl St 103, Jerusalem
321	2025-05-06	12:15:00	694810573	379	675610128	154749464	Clalit City Clinic	Begin Blvd 17, Ashkelon
322	2025-07-23	20:45:00	734987957	378	130440929	266685039	Maccabi Health Center	HaTikva St 106, Jerusalem
323	2025-04-05	13:00:00	477313143	352	127373899	660542544	Meuhedet Health Center	HaNegev St 36, Herzliya
324	2025-10-21	15:30:00	760208651	121	335569735	705977773	Leumit City Clinic	HaTikva St 78, Petah Tikva
325	2025-06-15	13:30:00	206768692	21	596823946	104731999	Leumit Clinic	HaTikva St 85, Herzliya
326	2025-04-04	13:15:00	727330871	2	623490063	\N	Clalit Pediatric Clinic	HaShalom Rd 49, Jerusalem
327	2025-03-17	13:15:00	348914405	27	933176850	477791140	Leumit Women's Clinic	Begin Blvd 39, Rishon LeZion
328	2025-06-23	19:45:00	476830627	171	523388008	543138407	Meuhedet Pediatric Clinic	Allenby St 8, Modiin
329	2025-12-16	18:45:00	188769931	237	523388008	\N	Leumit Pediatric Clinic	Herzl St 142, Kfar Saba
330	2025-12-02	19:00:00	852559916	67	204520642	853912682	Clalit Pediatric Clinic	Herzl St 20, Jerusalem
331	2025-05-28	18:00:00	343278287	85	832006368	484495578	Maccabi Family Clinic	Weizmann St 118, Ashkelon
332	2025-09-02	14:15:00	844513515	73	484821493	\N	Maccabi Clinic	Rothschild Ave 133, Rehovot
333	2025-06-03	07:15:00	236809338	51	195106131	446763595	Meuhedet Women's Clinic	Sokolov St 123, Netanya
334	2025-07-14	17:30:00	855032071	64	106107388	926151796	Meuhedet Family Clinic	Allenby St 1, Rehovot
335	2025-07-09	08:00:00	657393222	106	799258702	743393691	Clalit City Clinic	Begin Blvd 17, Ashkelon
336	2025-12-19	12:00:00	852559916	399	703776850	358401641	Meuhedet Family Clinic	Rothschild Ave 36, Herzliya
337	2025-09-17	09:30:00	396524353	137	316396883	958396544	Maccabi Family Clinic	HaPalmach St 15, Haifa
338	2025-09-10	19:30:00	813482571	337	451143202	549041678	Leumit Health Center	HaYarkon St 112, Modiin
339	2025-06-08	18:45:00	895588198	72	231324781	660542544	Meuhedet Family Clinic	Rothschild Ave 36, Herzliya
340	2025-11-25	13:45:00	156769696	192	106107388	958396544	Clalit Family Clinic	Ben Gurion Blvd 143, Bnei Brak
341	2025-11-23	07:30:00	287218285	373	809797531	958396544	Leumit City Clinic	Weizmann St 138, Modiin
342	2025-08-20	08:00:00	510369863	292	651938317	744541166	Leumit Family Clinic	HaHistadrut St 128, Rishon LeZion
343	2025-12-22	13:15:00	377899807	56	318943388	585426153	Leumit Pediatric Clinic	Jabotinsky St 76, Tel Aviv
344	2025-10-02	15:30:00	862048623	88	993263579	718179719	Maccabi Clinic	Weizmann St 78, Tel Aviv
345	2025-11-15	17:30:00	139889274	19	356308687	264594643	Meuhedet Clinic	Rothschild Ave 94, Rehovot
346	2025-08-21	08:00:00	154227972	296	162929677	193901152	Leumit Pediatric Clinic	Allenby St 96, Beersheba
347	2025-01-10	19:30:00	741059892	26	596823946	886553988	Clalit Health Center	Menachem Begin St 49, Beersheba
348	2025-12-20	17:00:00	860088812	227	939238672	124787141	Clalit Women's Clinic	Begin Blvd 34, Bnei Brak
349	2025-08-09	12:00:00	230624445	77	333059661	588485108	Leumit Pediatric Clinic	Sokolov St 30, Petah Tikva
350	2025-07-23	18:30:00	762364645	100	471674082	485241165	Maccabi Health Center	Allenby St 53, Kfar Saba
351	2025-12-19	19:45:00	251420151	113	151385895	310258592	Maccabi Family Clinic	Rothschild Ave 32, Rishon LeZion
352	2025-03-27	16:30:00	657393222	36	980860075	367550207	Clalit Women's Clinic	Herzl St 44, Haifa
353	2025-10-24	20:45:00	741059892	139	385015287	\N	Maccabi Pediatric Clinic	HaShalom Rd 40, Kfar Saba
354	2025-06-19	16:45:00	794952734	262	602013357	\N	Clalit Family Clinic	Allenby St 100, Haifa
355	2025-09-18	13:30:00	965413870	290	939238672	164347844	Maccabi Pediatric Clinic	HaPalmach St 79, Jerusalem
356	2025-04-17	07:45:00	760208651	11	312816743	307638987	Maccabi Pediatric Clinic	Herzl St 144, Rishon LeZion
357	2025-05-27	10:30:00	284489969	249	240709151	\N	Meuhedet Women's Clinic	HaYarkon St 87, Jerusalem
358	2025-10-24	13:15:00	906327198	274	188163518	757351763	Meuhedet Health Center	Weizmann St 40, Haifa
359	2025-03-25	13:00:00	174043533	46	510716800	792123494	Clalit Clinic	Menachem Begin St 121, Jerusalem
360	2025-12-06	14:30:00	223302984	304	651447743	792123494	Clalit Health Center	Jabotinsky St 14, Ashdod
361	2025-08-14	16:30:00	406254292	101	548621554	134938340	Clalit Health Center	Menachem Begin St 49, Beersheba
362	2025-12-26	15:45:00	197148858	197	765921635	\N	Leumit Health Center	HaYarkon St 112, Modiin
363	2025-12-18	17:45:00	918984720	22	205096731	181098189	Leumit Clinic	Sokolov St 20, Ashdod
364	2025-04-21	12:30:00	189791206	240	318943388	\N	Meuhedet City Clinic	Menachem Begin St 90, Tel Aviv
365	2025-01-19	19:30:00	154227972	81	277290510	\N	Clalit Women's Clinic	Sokolov St 82, Petah Tikva
366	2025-06-23	11:45:00	510369863	262	240709151	112742705	Meuhedet Family Clinic	HaYarkon St 37, Bat Yam
367	2025-08-13	19:45:00	170140414	226	577645975	254040510	Meuhedet Women's Clinic	HaYarkon St 87, Jerusalem
368	2025-05-28	12:15:00	452938441	311	517697659	405385808	Leumit Clinic	Weizmann St 37, Bnei Brak
369	2025-05-03	06:45:00	188769931	207	439413734	112742705	Leumit Health Center	HaNegev St 1, Herzliya
370	2025-04-09	08:30:00	590778593	258	747832838	\N	Leumit Health Center	HaYarkon St 62, Bnei Brak
371	2025-11-23	06:15:00	730453991	14	620016708	525443476	Leumit Pediatric Clinic	Jabotinsky St 76, Tel Aviv
372	2025-05-26	12:00:00	460087435	108	390750761	\N	Barzilai Medical Center	HaNegev St 45, Ramat Gan
373	2025-04-04	15:45:00	814690335	144	244282748	499722276	Maccabi Women's Clinic	Herzl St 74, Holon
374	2025-12-25	11:00:00	483346047	332	116809193	799658255	Leumit Health Center	Rothschild Ave 85, Ramat Gan
376	2025-08-04	18:30:00	910273798	191	410254424	642778231	Maccabi Pediatric Clinic	Sokolov St 141, Herzliya
377	2025-12-24	06:30:00	880103575	314	757088646	379926927	Meuhedet Women's Clinic	HaShalom Rd 102, Ashkelon
378	2025-01-18	17:30:00	512030298	296	565166657	700986555	Leumit Health Center	Rothschild Ave 88, Modiin
379	2025-09-04	08:45:00	343329332	359	832010443	621805679	Maccabi Women's Clinic	Jabotinsky St 123, Petah Tikva
380	2025-07-20	11:15:00	560347583	220	678506268	\N	Leumit Pediatric Clinic	Ben Gurion Blvd 117, Rehovot
381	2025-10-21	16:45:00	794952734	72	869278628	300685875	Leumit Family Clinic	HaShalom Rd 39, Bat Yam
382	2025-02-23	11:15:00	194165094	179	316396883	236536222	Leumit Health Center	HaPalmach St 78, Ashkelon
383	2025-11-25	06:45:00	887631402	291	385321066	\N	Meuhedet City Clinic	Allenby St 124, Rishon LeZion
384	2025-02-07	19:00:00	915339436	307	939238672	637417326	Leumit Clinic	Herzl St 73, Modiin
385	2025-09-27	20:45:00	582419251	183	595351873	877651756	Leumit City Clinic	HaPalmach St 140, Ra'anana
386	2025-11-20	20:30:00	542297151	261	886939800	162854543	Meuhedet City Clinic	Allenby St 124, Rishon LeZion
387	2025-06-01	13:00:00	568658593	85	722223783	\N	Meuhedet Women's Clinic	Ben Gurion Blvd 46, Modiin
388	2025-07-20	11:15:00	614959631	190	489601917	467137650	Leumit Health Center	HaHistadrut St 16, Ashkelon
389	2025-11-01	10:15:00	662729589	281	262180529	867910701	Maccabi Family Clinic	Weizmann St 128, Modiin
390	2025-03-10	18:45:00	185144803	186	646651118	\N	Meuhedet Clinic	HaYarkon St 62, Ramat Gan
391	2025-06-23	20:45:00	836771587	82	355020965	403951290	Clalit Family Clinic	HaNegev St 15, Holon
392	2025-02-02	12:15:00	530709488	358	799258702	114916894	Leumit Clinic	HaNegev St 102, Tel Aviv
393	2025-04-20	13:45:00	163977003	211	495900140	913520210	Meuhedet City Clinic	Rothschild Ave 131, Ashdod
394	2025-04-20	17:45:00	382178937	37	427989892	595566634	Leumit Clinic	Menachem Begin St 20, Herzliya
395	2025-09-25	17:15:00	914894458	136	121502474	228630954	Meuhedet Family Clinic	HaHistadrut St 144, Beersheba
396	2025-01-12	07:45:00	678621121	188	613307691	154992568	Clalit Health Center	Ben Gurion Blvd 101, Rehovot
397	2025-09-12	09:45:00	868919607	359	335569735	444687035	Maccabi Pediatric Clinic	HaShalom Rd 40, Kfar Saba
398	2025-08-07	13:45:00	920666292	45	240709151	\N	Clalit Women's Clinic	HaPalmach St 139, Ashdod
399	2025-03-05	07:15:00	574857929	16	157794649	\N	Clalit Family Clinic	Allenby St 103, Rishon LeZion
400	2025-09-12	06:30:00	400850159	326	356308687	937895475	Maccabi Women's Clinic	Ben Gurion Blvd 85, Ashkelon
401	2025-01-03	08:45:00	147130620	393	236786603	\N	Clalit Pediatric Clinic	Menachem Begin St 69, Tel Aviv
402	2025-02-26	17:30:00	895576008	180	286582552	\N	Meuhedet Family Clinic	Rothschild Ave 29, Jerusalem
403	2025-08-22	14:00:00	458111142	60	890623488	660542544	Leumit Pediatric Clinic	Weizmann St 74, Rishon LeZion
404	2025-09-20	16:00:00	734987957	119	277290510	\N	Leumit Family Clinic	Allenby St 12, Ramat Gan
405	2025-04-12	17:15:00	403792403	84	447168611	358890331	Maccabi Health Center	Rothschild Ave 118, Rehovot
406	2025-09-05	17:15:00	737208814	13	623490063	186854746	Leumit Clinic	Weizmann St 138, Bnei Brak
407	2025-10-14	10:15:00	595469585	152	254904175	627217360	Meuhedet Women's Clinic	Sokolov St 123, Netanya
408	2025-08-10	08:15:00	862048623	22	215791975	\N	Leumit Clinic	HaHistadrut St 111, Netanya
409	2025-06-13	14:30:00	843075942	199	367041409	853912682	Maccabi Family Clinic	Sokolov St 19, Jerusalem
410	2025-11-18	15:45:00	343278287	293	765921635	\N	Shaare Zedek Medical Center	HaNegev St 69, Netanya
411	2025-01-24	07:45:00	962605402	42	410254424	826996680	Meuhedet Women's Clinic	Rothschild Ave 1, Tel Aviv
412	2025-05-19	14:30:00	173426798	353	927468908	115674283	Maccabi Clinic	Rothschild Ave 133, Rehovot
413	2025-04-23	20:30:00	151910759	156	130440929	139987077	Clalit Women's Clinic	Sokolov St 82, Petah Tikva
414	2025-08-08	10:30:00	514692698	375	993263579	\N	Meuhedet Women's Clinic	Ben Gurion Blvd 46, Modiin
415	2025-05-13	07:00:00	914894458	388	130440929	720046881	Leumit Clinic	Jabotinsky St 51, Ashkelon
416	2025-10-21	19:00:00	322317846	265	710030144	\N	Meuhedet Family Clinic	Menachem Begin St 58, Rehovot
417	2025-04-09	16:45:00	627627838	365	983060617	405385808	Clalit City Clinic	HaTikva St 80, Bat Yam
418	2025-02-19	07:00:00	284489969	21	724516280	413603064	Maccabi Family Clinic	Sokolov St 11, Rehovot
419	2025-01-04	18:00:00	582969573	223	459613663	310449903	Clalit Women's Clinic	Menachem Begin St 136, Ramat Gan
420	2025-12-16	08:00:00	355235662	125	870880025	210440926	Meuhedet Pediatric Clinic	Begin Blvd 73, Bnei Brak
421	2025-04-24	15:15:00	433513336	317	352089792	799658255	Maccabi Health Center	HaYarkon St 132, Ashdod
422	2025-04-12	19:30:00	586562174	285	960240840	266685039	Maccabi Family Clinic	Rothschild Ave 32, Rishon LeZion
423	2025-05-25	20:00:00	563031706	20	408394324	302016206	Maccabi Health Center	Rothschild Ave 118, Rehovot
424	2025-12-03	13:30:00	191561261	73	942705156	\N	Maccabi Pediatric Clinic	Herzl St 12, Jerusalem
425	2025-12-26	09:15:00	274894140	188	375218533	826996680	Maccabi Health Center	HaShalom Rd 91, Netanya
426	2025-02-09	19:45:00	182172500	80	565737791	937895475	Meuhedet City Clinic	Allenby St 117, Bat Yam
427	2025-08-15	06:45:00	582442635	120	129452534	609883589	Clalit Women's Clinic	Sokolov St 96, Ashkelon
428	2025-12-03	07:45:00	945922559	319	604840053	692757934	Clalit Women's Clinic	Sokolov St 82, Petah Tikva
429	2025-06-24	12:15:00	894956091	47	808943895	\N	Clalit City Clinic	Weizmann St 77, Tel Aviv
430	2025-11-19	19:15:00	754600805	124	604840053	112742705	Leumit Family Clinic	Sokolov St 110, Netanya
431	2025-05-26	08:00:00	431925566	203	686931483	307638987	Shaare Zedek Medical Center	HaNegev St 69, Netanya
432	2025-10-12	10:30:00	586562174	36	286582552	991164471	Maccabi Women's Clinic	Menachem Begin St 93, Haifa
433	2025-02-03	17:15:00	223971678	319	375913224	484495578	Leumit City Clinic	Jabotinsky St 3, Rishon LeZion
434	2025-03-20	16:30:00	542415875	98	913568600	186854746	Meuhedet City Clinic	Begin Blvd 64, Tel Aviv
435	2025-02-21	14:00:00	388934046	223	651938317	421967560	Leumit Health Center	Jabotinsky St 37, Ra'anana
436	2025-06-03	19:30:00	277537826	129	942705156	437174782	Leumit City Clinic	HaPalmach St 109, Modiin
437	2025-07-01	13:45:00	894956091	266	335528238	\N	Maccabi Clinic	Allenby St 129, Rehovot
438	2025-02-04	17:15:00	749132937	149	439413734	652055112	Maccabi Clinic	Herzl St 62, Netanya
439	2025-12-03	07:15:00	845115493	259	902246089	826996680	Maccabi Women's Clinic	Sokolov St 14, Petah Tikva
440	2025-06-21	11:45:00	662729589	60	766537646	288012548	Maccabi Pediatric Clinic	HaNegev St 56, Ramat Gan
441	2025-01-24	12:30:00	213596569	186	581537784	358401641	Maccabi Family Clinic	Sokolov St 90, Ashkelon
442	2025-04-28	07:45:00	464558868	191	565425153	560761358	Clalit Health Center	Allenby St 46, Jerusalem
443	2025-04-10	18:15:00	284004279	261	160913893	510589173	Leumit Clinic	HaNegev St 104, Ra'anana
444	2025-11-19	06:45:00	542415875	132	165682443	233341981	Meuhedet Pediatric Clinic	HaShalom Rd 144, Petah Tikva
445	2025-11-19	13:00:00	632274169	124	517697659	691399121	Leumit City Clinic	HaPalmach St 11, Haifa
446	2025-03-23	14:00:00	753729185	269	722223783	222522748	Maccabi Health Center	HaTikva St 86, Holon
447	2025-11-22	12:30:00	263372945	158	983060617	927259391	Meuhedet Health Center	Weizmann St 123, Ashdod
448	2025-11-15	14:00:00	860088812	350	722223783	522199986	Maccabi Clinic	Weizmann St 12, Jerusalem
449	2025-09-02	20:00:00	253196823	330	927468908	\N	Maccabi Pediatric Clinic	Sokolov St 62, Petah Tikva
450	2025-06-27	16:00:00	612117711	362	375218533	134938340	Leumit City Clinic	HaTikva St 78, Petah Tikva
451	2025-07-13	10:30:00	299229343	208	896973596	\N	Leumit Clinic	HaHistadrut St 140, Ra'anana
452	2025-01-19	14:00:00	678621121	340	648046509	522199986	Clalit Women's Clinic	HaHistadrut St 148, Ramat Gan
453	2025-10-09	16:00:00	868919607	357	356308687	146343109	Maccabi City Clinic	Jabotinsky St 56, Ra'anana
454	2025-10-07	19:45:00	849864109	157	286582552	\N	Maccabi City Clinic	Menachem Begin St 59, Kfar Saba
455	2025-04-07	12:30:00	417243925	227	375218533	499722276	Clalit Women's Clinic	HaHistadrut St 148, Ramat Gan
456	2025-10-07	12:00:00	353165680	384	951108053	358890331	Maccabi Family Clinic	Sokolov St 19, Jerusalem
457	2025-08-26	17:00:00	299085717	2	565425153	\N	Maccabi City Clinic	HaPalmach St 85, Beersheba
458	2025-02-09	11:00:00	151948041	118	886939800	406350060	Meuhedet Health Center	Weizmann St 40, Haifa
459	2025-08-20	14:45:00	408340579	218	451143202	523195752	Clalit Health Center	Jabotinsky St 51, Netanya
460	2025-08-12	09:00:00	254630730	62	575013098	152943249	Clalit Family Clinic	Allenby St 29, Holon
461	2025-12-21	13:45:00	464558868	271	508895013	732231442	Maccabi Women's Clinic	Herzl St 74, Holon
462	2025-04-01	13:00:00	180510182	102	705338121	950189399	Leumit Clinic	HaTikva St 85, Herzliya
463	2025-08-14	09:30:00	111387179	302	886939800	535842430	Clalit Pediatric Clinic	HaPalmach St 37, Rehovot
464	2025-01-14	12:00:00	367818889	209	577645975	\N	Leumit Clinic	Jabotinsky St 51, Ashkelon
465	2025-05-05	20:45:00	189899416	320	710030144	297714695	Leumit City Clinic	HaPalmach St 109, Modiin
466	2025-05-10	11:45:00	277537826	311	951108053	\N	Clalit Clinic	Jabotinsky St 56, Ashdod
467	2025-07-23	17:30:00	173426798	38	667143420	\N	Clalit Health Center	Jabotinsky St 14, Ashdod
468	2025-11-19	18:15:00	377899807	373	888469205	\N	Leumit Health Center	HaPalmach St 78, Ashkelon
469	2025-04-19	11:30:00	251420151	42	334099421	\N	Leumit Clinic	Herzl St 73, Modiin
470	2025-09-01	08:00:00	378410529	256	620016708	585426153	Meuhedet City Clinic	HaTikva St 144, Ashkelon
471	2025-11-27	19:45:00	715266007	384	766537646	621805679	Maccabi Pediatric Clinic	HaYarkon St 111, Beersheba
472	2025-09-07	13:15:00	629845815	24	565425153	403951290	Clalit Family Clinic	HaShalom Rd 22, Ra'anana
473	2025-06-26	14:30:00	284489969	205	408394324	680422772	Maccabi Family Clinic	Jabotinsky St 5, Rehovot
474	2025-08-07	16:00:00	429596723	332	414131125	457148964	Maccabi Women's Clinic	Menachem Begin St 93, Haifa
475	2025-08-09	08:30:00	477313143	23	870478094	524957376	Maccabi Clinic	Herzl St 23, Rehovot
476	2025-09-06	12:15:00	509642139	30	510334717	413603064	Maccabi Family Clinic	HaHistadrut St 28, Rishon LeZion
477	2025-10-04	13:45:00	563027137	233	325430239	835357628	Maccabi Women's Clinic	Sokolov St 74, Bnei Brak
478	2025-01-27	12:00:00	275062263	241	316396883	835357628	Meuhedet Pediatric Clinic	HaHistadrut St 91, Haifa
479	2025-07-07	10:45:00	195297250	342	801483903	\N	Meuhedet Women's Clinic	Sokolov St 115, Tel Aviv
480	2025-05-25	15:30:00	163977003	203	613307691	452367681	Leumit Women's Clinic	Begin Blvd 61, Jerusalem
481	2025-10-21	18:30:00	367688443	216	799258702	\N	Maccabi City Clinic	Jabotinsky St 56, Ra'anana
482	2025-07-13	18:30:00	151948041	92	368803859	\N	Clalit Health Center	Allenby St 46, Jerusalem
483	2025-04-07	06:00:00	147130620	87	722223783	700986555	Maccabi Pediatric Clinic	Ben Gurion Blvd 68, Herzliya
484	2025-11-10	14:00:00	799742877	302	620016708	991164471	Maccabi Pediatric Clinic	Rothschild Ave 58, Holon
485	2025-09-18	10:00:00	457553650	28	385321066	733386484	Meuhedet Family Clinic	HaPalmach St 19, Rishon LeZion
486	2025-02-01	13:00:00	738045160	203	530516374	\N	Clalit Clinic	Ben Gurion Blvd 111, Beersheba
487	2025-05-12	07:15:00	916090435	180	675033386	485241165	Leumit Pediatric Clinic	Allenby St 96, Beersheba
488	2025-10-06	12:00:00	185818355	311	670632947	\N	Leumit Women's Clinic	Jabotinsky St 124, Ramat Gan
489	2025-03-09	14:15:00	590818651	71	886939800	867910701	Clalit Health Center	Menachem Begin St 81, Tel Aviv
490	2025-01-01	08:15:00	209176386	205	318943388	867910701	Clalit Health Center	Menachem Begin St 81, Tel Aviv
491	2025-12-23	18:30:00	439631560	209	869278628	292563039	Meuhedet Pediatric Clinic	Jabotinsky St 144, Herzliya
492	2025-12-09	09:00:00	530709488	199	832006368	467137650	Meuhedet City Clinic	Sokolov St 95, Ashkelon
493	2025-05-11	14:30:00	777188208	150	869278628	457148964	Maccabi Health Center	HaShalom Rd 91, Netanya
494	2025-07-08	09:00:00	871784867	144	236786603	\N	Leumit Women's Clinic	Herzl St 102, Herzliya
495	2025-10-14	11:30:00	221634502	257	724516280	310449903	Maccabi Health Center	HaTikva St 86, Holon
496	2025-10-17	11:15:00	358867112	96	770359651	522199986	Meuhedet City Clinic	Herzl St 33, Ra'anana
497	2025-06-13	08:45:00	197148858	298	718084895	186854746	Clalit Women's Clinic	HaTikva St 40, Modiin
498	2025-02-03	19:00:00	899936576	280	325430239	193901152	Maccabi Pediatric Clinic	HaTikva St 63, Modiin
499	2025-02-17	19:15:00	418541884	369	832006368	557387584	Leumit Family Clinic	Ben Gurion Blvd 147, Ashkelon
500	2025-08-01	16:30:00	251420151	33	244282748	\N	Maccabi Pediatric Clinic	HaNegev St 5, Ramat Gan
501	2025-03-11	14:00:00	773426386	101	740682739	856141290	Clalit Pediatric Clinic	Ben Gurion Blvd 16, Ashkelon
502	2025-07-16	09:30:00	877834494	226	146240027	358401641	Clalit Women's Clinic	Begin Blvd 56, Rishon LeZion
503	2025-06-12	18:15:00	855032071	243	581537784	\N	Maccabi Health Center	HaShalom Rd 91, Netanya
504	2025-05-11	17:15:00	582419251	81	869278628	\N	Leumit Health Center	Rothschild Ave 85, Ramat Gan
505	2025-05-11	10:45:00	702769651	2	314241360	638619639	Meuhedet Women's Clinic	HaYarkon St 87, Jerusalem
506	2025-05-01	15:00:00	319864750	91	809797531	391559775	Meuhedet Women's Clinic	Ben Gurion Blvd 46, Modiin
507	2025-10-27	10:15:00	470869626	44	254904175	\N	Meuhedet Pediatric Clinic	HaShalom Rd 144, Petah Tikva
508	2025-05-22	16:15:00	135084311	249	356308687	292563039	Maccabi Pediatric Clinic	HaNegev St 149, Rishon LeZion
509	2025-09-21	11:30:00	131666625	123	294557346	694876741	Maccabi Family Clinic	Herzl St 145, Jerusalem
510	2025-09-04	16:45:00	612117711	214	924888731	358890331	Maccabi Women's Clinic	Herzl St 16, Modiin
511	2025-08-05	10:45:00	299085717	223	277290510	835357628	Leumit Women's Clinic	Begin Blvd 61, Jerusalem
512	2025-05-19	20:00:00	242098030	222	132264095	372000492	Maccabi Family Clinic	Sokolov St 90, Ashkelon
513	2025-11-17	14:30:00	871004539	277	670632947	\N	Clalit Women's Clinic	Rothschild Ave 149, Haifa
514	2025-06-08	11:45:00	267348942	38	870880025	634188128	Maccabi Clinic	Ben Gurion Blvd 128, Ashkelon
515	2025-12-02	06:45:00	890970312	378	738536844	\N	Leumit City Clinic	Rothschild Ave 115, Herzliya
516	2025-11-20	17:15:00	431782073	362	282498842	549041678	Meuhedet Health Center	Weizmann St 40, Haifa
517	2025-06-20	13:30:00	871004539	396	902246089	372000492	Maccabi Women's Clinic	HaShalom Rd 16, Ashdod
518	2025-07-05	16:15:00	760208651	274	378127589	\N	Meuhedet Health Center	Jabotinsky St 37, Rishon LeZion
519	2025-11-05	19:00:00	236809338	386	194967455	585034134	Leumit Family Clinic	Sokolov St 110, Netanya
520	2025-10-16	16:30:00	348914405	4	368803859	181098189	Leumit Family Clinic	Ben Gurion Blvd 2, Modiin
521	2025-12-05	08:15:00	284004279	72	175078783	705977773	Clalit City Clinic	Jabotinsky St 41, Bnei Brak
522	2025-02-15	07:00:00	582442635	232	648046509	585426153	Kaplan Medical Center	Sokolov St 133, Herzliya
523	2025-02-13	07:30:00	762364645	296	668035126	705977773	Leumit Pediatric Clinic	Sokolov St 30, Petah Tikva
524	2025-02-10	18:00:00	976166486	20	471674082	579396263	Leumit Pediatric Clinic	Begin Blvd 30, Herzliya
525	2025-06-20	09:00:00	812170410	310	170476311	967167857	Maccabi Women's Clinic	Sokolov St 74, Bnei Brak
526	2025-04-25	18:30:00	253196823	137	801483903	523195752	Leumit Clinic	HaPalmach St 24, Ra'anana
527	2025-02-02	11:15:00	368041638	27	565425153	134938340	Maccabi Health Center	HaShalom Rd 91, Netanya
528	2025-04-22	10:00:00	542297151	145	495900140	467683186	Meuhedet Pediatric Clinic	Menachem Begin St 23, Haifa
529	2025-08-11	17:00:00	329416185	96	510334717	223034510	Meuhedet Health Center	Jabotinsky St 37, Rishon LeZion
530	2025-09-28	12:00:00	844888238	319	414316626	926559749	Maccabi Clinic	Begin Blvd 98, Ra'anana
531	2025-12-27	06:45:00	860088812	192	240709151	579396263	Leumit Clinic	HaYarkon St 130, Petah Tikva
532	2025-06-26	14:15:00	375159255	96	967238983	745588939	Clalit Health Center	HaShalom Rd 8, Haifa
533	2025-12-22	20:15:00	429596723	29	678506268	124787141	Clalit Pediatric Clinic	Rothschild Ave 56, Ramat Gan
534	2025-10-19	09:45:00	287218285	366	128998748	926559749	Leumit City Clinic	HaNegev St 36, Haifa
535	2025-09-22	06:30:00	122403164	340	605063967	757351763	Clalit Pediatric Clinic	Weizmann St 78, Netanya
536	2025-04-01	06:30:00	946254016	201	886939800	\N	Maccabi Health Center	Allenby St 53, Kfar Saba
537	2025-07-12	11:00:00	704835566	262	808677201	705808415	Maccabi Pediatric Clinic	Herzl St 40, Rishon LeZion
538	2025-06-20	16:45:00	734987957	36	595351873	330948886	Leumit City Clinic	HaPalmach St 11, Haifa
539	2025-10-03	16:15:00	758038866	55	596823946	705808415	Clalit City Clinic	Begin Blvd 61, Rishon LeZion
540	2025-04-26	09:00:00	836728213	129	205096731	291145247	Clalit Family Clinic	HaNegev St 107, Bat Yam
541	2025-01-14	16:15:00	752098694	53	589073536	432026089	Maccabi Pediatric Clinic	HaPalmach St 47, Netanya
542	2025-07-03	15:15:00	510369863	51	146240027	372000492	Clalit City Clinic	HaYarkon St 47, Ashkelon
543	2025-12-15	06:45:00	855032071	119	427852785	946589413	Clalit Women's Clinic	Rothschild Ave 149, Haifa
544	2025-10-18	14:45:00	350031763	211	130440929	200778361	Clalit City Clinic	HaTikva St 121, Jerusalem
545	2025-12-28	16:30:00	811725293	239	909580633	886567223	Maccabi Pediatric Clinic	Sokolov St 141, Herzliya
546	2025-01-10	16:15:00	721698371	355	510334717	578303296	Leumit City Clinic	Sokolov St 97, Bnei Brak
547	2025-12-27	09:15:00	121433639	30	801483903	\N	Leumit City Clinic	HaPalmach St 11, Haifa
548	2025-03-07	09:45:00	944917553	114	325430239	587248600	Clalit Women's Clinic	Begin Blvd 34, Bnei Brak
549	2025-09-24	15:15:00	811725293	396	809797531	292563039	Clalit City Clinic	HaTikva St 80, Bat Yam
550	2025-02-10	16:15:00	206768692	330	801483903	468701304	Meuhedet Women's Clinic	Ben Gurion Blvd 46, Modiin
551	2025-02-10	09:45:00	135745856	368	421289999	858675688	Leumit Health Center	Rothschild Ave 88, Modiin
552	2025-01-23	20:30:00	188709072	116	489601917	877651756	Maccabi Pediatric Clinic	HaNegev St 5, Ramat Gan
553	2025-10-16	06:15:00	805185005	210	503075904	926559749	Meuhedet Family Clinic	HaPalmach St 19, Rishon LeZion
554	2025-11-22	13:00:00	366900528	75	548621554	\N	Meuhedet City Clinic	Herzl St 144, Bat Yam
555	2025-04-28	11:30:00	574857929	269	581537784	967167857	Maccabi Pediatric Clinic	HaPalmach St 49, Bat Yam
556	2025-06-27	09:15:00	502455034	39	121065055	442531669	Meuhedet Family Clinic	Allenby St 1, Rehovot
557	2025-05-27	16:45:00	775101924	276	705338121	788565519	Hadassah Ein Kerem Hospital	Herzl St 24, Haifa
558	2025-11-20	16:15:00	290221251	370	738536844	652055112	Leumit Clinic	HaYarkon St 130, Petah Tikva
559	2025-05-06	19:15:00	974746813	384	723266609	652055112	Maccabi City Clinic	Menachem Begin St 59, Kfar Saba
560	2025-12-08	18:00:00	299085717	94	128998748	\N	Maccabi Family Clinic	Jabotinsky St 5, Rehovot
561	2025-06-04	15:45:00	851341222	280	808943895	112742705	Leumit Pediatric Clinic	Begin Blvd 130, Ra'anana
562	2025-06-21	20:45:00	174306440	218	651938317	120252841	Leumit Health Center	HaHistadrut St 16, Ashkelon
563	2025-07-11	17:30:00	305150698	381	517697659	124787141	Meuhedet Health Center	Jabotinsky St 143, Holon
564	2025-07-18	16:45:00	845115493	204	152785861	\N	Maccabi Health Center	Ben Gurion Blvd 43, Kfar Saba
565	2025-01-07	08:45:00	209176386	375	747832838	139987077	Maccabi Women's Clinic	HaYarkon St 96, Kfar Saba
566	2025-05-22	07:00:00	843075942	199	215791975	928678498	Leumit City Clinic	HaPalmach St 140, Ra'anana
567	2025-06-18	14:15:00	172001273	212	869278628	991202503	Clalit Family Clinic	Menachem Begin St 26, Bat Yam
568	2025-12-09	17:15:00	734987957	224	832010443	788565519	Meuhedet City Clinic	Herzl St 33, Ra'anana
569	2025-10-12	10:15:00	111387179	56	993263579	112742705	Maccabi City Clinic	Rothschild Ave 117, Ashkelon
570	2025-02-12	10:15:00	486579729	290	286582552	\N	Clalit Clinic	HaHistadrut St 71, Ashkelon
571	2025-03-24	11:30:00	155898237	133	517697659	946589413	Leumit City Clinic	Ben Gurion Blvd 25, Ramat Gan
572	2025-07-06	09:00:00	762364645	379	651447743	413603064	Meuhedet Women's Clinic	Sokolov St 58, Beersheba
573	2025-04-13	14:00:00	433513336	215	893399035	134463780	Leumit Health Center	Rothschild Ave 85, Ramat Gan
574	2025-07-10	08:15:00	135745856	223	503075904	\N	Maccabi Pediatric Clinic	HaShalom Rd 40, Kfar Saba
575	2025-05-01	13:00:00	963025761	205	194967455	927259391	Meuhedet Clinic	Weizmann St 19, Rishon LeZion
576	2025-02-21	09:30:00	250708248	127	175078783	733386484	Meuhedet Pediatric Clinic	Menachem Begin St 23, Haifa
577	2025-02-13	11:15:00	277537826	395	890623488	853912682	Leumit Women's Clinic	Ben Gurion Blvd 116, Rehovot
578	2025-05-09	07:45:00	185144803	187	325430239	169095841	Leumit City Clinic	HaTikva St 108, Ramat Gan
579	2025-04-02	06:30:00	894956091	334	246927292	793942949	Maccabi Pediatric Clinic	HaNegev St 149, Rishon LeZion
580	2025-05-06	15:30:00	172617282	42	835425519	444687035	Clalit Family Clinic	Begin Blvd 29, Kfar Saba
581	2025-12-19	12:00:00	188769931	4	747832838	937895475	Clalit Women's Clinic	HaPalmach St 142, Petah Tikva
582	2025-08-13	10:00:00	185144803	358	648046509	\N	Leumit Family Clinic	Sokolov St 110, Netanya
583	2025-07-22	07:45:00	849864109	269	110532551	702439977	Meuhedet Clinic	Ben Gurion Blvd 106, Bat Yam
584	2025-04-09	17:00:00	811725293	37	714051919	\N	Meuhedet City Clinic	HaYarkon St 15, Tel Aviv
585	2025-05-13	14:00:00	154227972	148	405648081	904402564	Leumit Clinic	HaHistadrut St 111, Netanya
586	2025-02-10	10:30:00	890176770	198	188163518	798009672	Leumit Pediatric Clinic	Begin Blvd 68, Modiin
587	2025-02-18	07:00:00	665010330	303	565166657	\N	Leumit Family Clinic	HaTikva St 41, Netanya
588	2025-06-14	10:30:00	383641443	336	303635805	877651756	Meuhedet Women's Clinic	HaPalmach St 110, Ashkelon
589	2025-09-05	10:30:00	738045160	365	714051919	585426153	Maccabi Pediatric Clinic	Ben Gurion Blvd 17, Modiin
590	2025-02-06	09:30:00	174043533	144	390750761	560761358	Clalit Women's Clinic	HaTikva St 9, Haifa
591	2025-05-18	14:00:00	560347583	39	675033386	\N	Maccabi Pediatric Clinic	Herzl St 12, Jerusalem
592	2025-05-02	12:15:00	254630730	284	335569735	926151796	Leumit Health Center	HaYarkon St 112, Modiin
593	2025-04-12	17:15:00	452938441	179	678506268	896666994	Meuhedet City Clinic	HaYarkon St 15, Tel Aviv
594	2025-02-04	10:00:00	165914899	240	493394881	\N	Meuhedet Pediatric Clinic	Herzl St 134, Holon
595	2025-08-27	09:30:00	760208651	254	651938317	\N	Meuhedet Health Center	HaHistadrut St 65, Netanya
596	2025-11-04	13:45:00	679248949	184	983060617	757351763	Maccabi Family Clinic	Allenby St 35, Holon
597	2025-04-24	14:15:00	596928327	292	822386902	372000492	Maccabi Clinic	HaNegev St 74, Ramat Gan
598	2025-10-06	12:45:00	526256593	115	760677936	\N	Meuhedet Health Center	Weizmann St 43, Rishon LeZion
599	2025-01-21	06:45:00	131666625	374	924888731	310449903	Clalit Women's Clinic	Sokolov St 96, Ashkelon
600	2025-08-01	18:30:00	188709072	87	335569735	106374385	Clalit Pediatric Clinic	Sokolov St 136, Rehovot
601	2025-03-13	17:15:00	514134929	315	936879403	642778231	Leumit Clinic	HaYarkon St 130, Petah Tikva
602	2025-10-08	13:45:00	450494685	118	165682443	588485108	Leumit Pediatric Clinic	Rothschild Ave 32, Petah Tikva
603	2025-12-23	07:00:00	333409051	257	447168611	\N	Leumit Clinic	HaHistadrut St 111, Netanya
604	2025-09-14	08:30:00	367818889	274	130440929	181098189	Clalit Women's Clinic	HaTikva St 9, Haifa
605	2025-03-18	07:30:00	773426386	198	869278628	652055112	Maccabi Family Clinic	Herzl St 103, Jerusalem
606	2025-08-12	20:00:00	475277239	344	170476311	358890331	Maccabi Pediatric Clinic	Weizmann St 112, Haifa
607	2025-12-13	20:45:00	715266007	58	967238983	620872913	Leumit Clinic	HaHistadrut St 140, Ra'anana
608	2025-04-07	11:00:00	450494685	243	762854976	406350060	Maccabi Family Clinic	Sokolov St 90, Ashkelon
609	2025-05-06	07:45:00	679248949	319	111533007	720046881	Meuhedet Clinic	Rothschild Ave 130, Rishon LeZion
610	2025-09-06	11:00:00	352506228	376	145012488	525443476	Maccabi Health Center	Rothschild Ave 118, Rehovot
611	2025-02-04	10:30:00	970296727	239	561707109	254040510	Meuhedet Health Center	Herzl St 74, Modiin
612	2025-11-02	19:15:00	726107543	337	410962502	\N	Leumit Health Center	HaYarkon St 112, Modiin
613	2025-08-21	18:30:00	627627838	240	738536844	\N	Clalit Women's Clinic	Begin Blvd 76, Petah Tikva
614	2025-01-20	11:30:00	341446195	271	927468908	223034510	Clalit City Clinic	Ben Gurion Blvd 81, Herzliya
615	2025-05-28	12:00:00	563031706	213	162929677	\N	Maccabi Family Clinic	Sokolov St 11, Rehovot
616	2025-08-09	12:45:00	267088184	66	595351873	\N	Leumit City Clinic	HaYarkon St 136, Holon
617	2025-01-20	06:45:00	574857929	339	246927292	717220517	Clalit Health Center	Allenby St 46, Jerusalem
618	2025-07-11	20:00:00	775101924	135	888469205	809751526	Maccabi Pediatric Clinic	Ben Gurion Blvd 17, Modiin
619	2025-06-15	07:45:00	512030298	253	410962502	991202503	Maccabi Clinic	Ben Gurion Blvd 128, Ashkelon
620	2025-11-09	09:00:00	894956091	132	480434918	223034510	Leumit Family Clinic	HaShalom Rd 39, Bat Yam
621	2025-11-22	20:15:00	744340871	75	375218533	785743985	Meuhedet Family Clinic	HaYarkon St 37, Bat Yam
622	2025-08-04	13:30:00	163977003	153	757088646	991202503	Meuhedet Health Center	Herzl St 74, Modiin
623	2025-06-15	14:00:00	725872450	85	361945520	770913744	Clalit Family Clinic	HaHistadrut St 19, Holon
624	2025-07-17	17:30:00	465944468	88	890623488	\N	Maccabi Pediatric Clinic	Rothschild Ave 58, Holon
625	2025-12-20	06:30:00	122403164	14	492050992	508458268	Leumit Pediatric Clinic	Menachem Begin St 92, Jerusalem
626	2025-01-21	08:00:00	229853224	175	765574491	143764555	Clalit Family Clinic	Begin Blvd 107, Netanya
627	2025-11-27	08:15:00	920666292	40	205096731	946589413	Clalit City Clinic	Herzl St 84, Netanya
628	2025-03-11	11:15:00	892550568	161	385015287	\N	Leumit Clinic	Herzl St 73, Modiin
629	2025-10-04	15:15:00	639156305	2	952751158	330948886	Meuhedet Health Center	Jabotinsky St 143, Holon
630	2025-12-02	15:45:00	248993596	39	668035126	358890331	Leumit Women's Clinic	HaYarkon St 113, Rishon LeZion
631	2025-07-28	09:45:00	509642139	328	170476311	143764555	Clalit Family Clinic	Allenby St 29, Holon
632	2025-07-08	08:30:00	894548767	176	510716800	\N	Maccabi Pediatric Clinic	Weizmann St 16, Rishon LeZion
633	2025-03-19	20:30:00	519814178	386	318943388	904402564	Clalit City Clinic	Begin Blvd 17, Ashkelon
634	2025-04-27	08:00:00	188769931	384	231324781	405385808	Maccabi Clinic	Menachem Begin St 21, Bat Yam
635	2025-06-11	15:30:00	485521617	73	489601917	173735333	Clalit Health Center	Jabotinsky St 14, Ashdod
636	2025-12-10	06:30:00	272193302	73	390750761	913520210	Meuhedet Health Center	HaNegev St 139, Rehovot
637	2025-11-17	20:30:00	275062263	252	933176850	\N	Leumit Pediatric Clinic	Sokolov St 30, Petah Tikva
638	2025-02-11	19:15:00	596928327	250	145012488	\N	Leumit Family Clinic	Sokolov St 110, Netanya
639	2025-01-16	07:15:00	320907039	61	385015287	186854746	Maccabi Women's Clinic	Sokolov St 74, Bnei Brak
640	2025-06-27	10:45:00	229853224	175	651938317	793942949	Meuhedet Family Clinic	HaYarkon St 37, Bat Yam
641	2025-10-03	11:00:00	814384608	355	575013098	578303296	Leumit Clinic	Ben Gurion Blvd 112, Ramat Gan
642	2025-10-10	08:00:00	590652532	358	740682739	367550207	Leumit Pediatric Clinic	Begin Blvd 130, Ra'anana
643	2025-09-18	09:30:00	797569992	60	902246089	931089150	Soroka Medical Center	HaYarkon St 6, Ashdod
644	2025-02-09	18:00:00	575650818	108	129452534	535842430	Maccabi Women's Clinic	Herzl St 74, Holon
645	2025-03-24	12:45:00	612913584	341	623490063	164347844	Maccabi Clinic	Ben Gurion Blvd 128, Ashkelon
646	2025-01-04	10:30:00	682247730	126	675610128	333012046	Meuhedet Women's Clinic	Ben Gurion Blvd 119, Holon
647	2025-12-25	06:15:00	738045160	357	595351873	477791140	Clalit Women's Clinic	HaPalmach St 139, Ashdod
648	2025-11-20	12:00:00	518912049	238	439413734	609883589	Meuhedet Health Center	HaNegev St 36, Herzliya
649	2025-03-16	10:45:00	544949169	246	596823946	757351763	Leumit Pediatric Clinic	HaYarkon St 95, Rishon LeZion
650	2025-12-08	17:15:00	494804448	16	703776850	\N	Leumit Clinic	HaNegev St 104, Ra'anana
651	2025-09-03	18:15:00	782770105	310	651938317	405385808	Leumit Clinic	HaYarkon St 130, Petah Tikva
652	2025-05-18	09:30:00	536869685	381	337501464	\N	Meuhedet City Clinic	Sokolov St 95, Ashkelon
653	2025-10-03	13:15:00	638913607	362	215791975	\N	Leumit Clinic	Herzl St 73, Modiin
654	2025-12-25	09:45:00	657393222	60	106210399	169095841	Leumit Pediatric Clinic	Jabotinsky St 76, Tel Aviv
655	2025-05-24	13:00:00	191561261	175	240709151	146343109	Leumit Clinic	HaPalmach St 24, Ra'anana
656	2025-01-02	14:15:00	326216990	388	303635805	652055112	Clalit Clinic	HaHistadrut St 71, Ashkelon
657	2025-03-19	18:30:00	320907039	357	489601917	\N	Maccabi Women's Clinic	HaYarkon St 96, Kfar Saba
658	2025-02-02	19:45:00	536640092	98	675610128	991202503	Maccabi Pediatric Clinic	HaPalmach St 47, Netanya
659	2025-05-14	09:45:00	463857918	363	427852785	120252841	Leumit City Clinic	Allenby St 107, Beersheba
660	2025-07-18	12:30:00	151948041	51	116809193	266685039	Leumit Clinic	HaNegev St 42, Herzliya
661	2025-05-03	20:30:00	699825997	312	951108053	\N	Maccabi City Clinic	Weizmann St 75, Jerusalem
662	2025-07-09	17:30:00	504527711	156	390750761	931089150	Maccabi Health Center	Ben Gurion Blvd 43, Kfar Saba
663	2025-12-28	19:30:00	329416185	96	565737791	\N	Leumit City Clinic	HaTikva St 108, Ramat Gan
664	2025-07-16	19:15:00	637152102	235	869278628	\N	Meuhedet Pediatric Clinic	Begin Blvd 73, Bnei Brak
665	2025-11-13	15:45:00	805876988	213	162929677	323208385	Leumit Women's Clinic	Herzl St 102, Herzliya
666	2025-04-02	17:15:00	890970312	72	523388008	173735333	Leumit Women's Clinic	Ben Gurion Blvd 116, Rehovot
667	2025-11-24	15:00:00	946254016	334	913568600	535842430	Leumit Clinic	Allenby St 25, Netanya
668	2025-07-02	11:00:00	174306440	291	157794649	153432684	Maccabi Health Center	HaTikva St 130, Rishon LeZion
669	2025-12-10	13:30:00	328312992	200	893399035	\N	Leumit Clinic	HaNegev St 42, Herzliya
670	2025-08-15	14:30:00	916939137	85	146240027	745588939	Clalit Family Clinic	Begin Blvd 107, Netanya
671	2025-02-17	12:30:00	606515031	239	808677201	652055112	Leumit Clinic	Herzl St 62, Kfar Saba
672	2025-05-15	08:45:00	536869685	54	410254424	372000492	Maccabi Women's Clinic	Jabotinsky St 123, Petah Tikva
673	2025-01-16	15:15:00	519814178	142	160913893	\N	Leumit Clinic	Menachem Begin St 20, Herzliya
674	2025-04-21	07:45:00	728873342	59	766537646	705808415	Meuhedet Clinic	Weizmann St 71, Ashkelon
675	2025-07-04	06:30:00	189791206	345	493394881	652055112	Leumit Pediatric Clinic	Begin Blvd 68, Modiin
676	2025-09-27	19:45:00	844513515	156	204520642	372000492	Maccabi Clinic	Menachem Begin St 21, Bat Yam
677	2025-10-28	08:30:00	287218285	61	933176850	770913744	Clalit Women's Clinic	Sokolov St 96, Ashkelon
678	2025-09-22	17:00:00	590652532	396	116809193	732231442	Shaare Zedek Medical Center	HaNegev St 69, Netanya
679	2025-08-13	07:45:00	251420151	66	623490063	620872913	Leumit Pediatric Clinic	Sokolov St 30, Petah Tikva
680	2025-03-06	16:30:00	298404492	171	927468908	467683186	Maccabi Pediatric Clinic	HaTikva St 63, Modiin
681	2025-10-27	17:45:00	612117711	161	385015287	289805994	Meuhedet Health Center	Herzl St 74, Modiin
682	2025-07-13	11:45:00	101565191	295	724516280	579396263	Maccabi Clinic	Rothschild Ave 112, Bnei Brak
683	2025-11-28	20:15:00	300036531	232	936879403	642778231	Meuhedet Pediatric Clinic	Jabotinsky St 144, Herzliya
684	2025-10-15	17:00:00	301023302	209	414131125	640036600	Clalit Family Clinic	HaNegev St 61, Bat Yam
685	2025-11-19	16:00:00	282408614	364	613307691	333012046	Leumit Women's Clinic	HaTikva St 38, Ramat Gan
686	2025-02-28	11:30:00	805185005	3	447168611	437174782	Meuhedet Health Center	Weizmann St 40, Haifa
687	2025-06-22	16:30:00	196728836	26	160913893	300885051	Leumit Clinic	HaPalmach St 24, Ra'anana
688	2025-02-14	11:15:00	139889274	151	939238672	927259391	Leumit Family Clinic	HaHistadrut St 102, Ashkelon
689	2025-07-21	09:30:00	734987957	311	503075904	785743985	Leumit City Clinic	HaTikva St 108, Ramat Gan
690	2025-11-09	12:00:00	294996591	357	215791975	125478540	Clalit Women's Clinic	HaTikva St 7, Ashdod
691	2025-02-08	14:45:00	704835566	383	822386902	444687035	Leumit City Clinic	Ben Gurion Blvd 25, Ramat Gan
692	2025-06-21	15:30:00	282408614	337	718084895	991202503	Clalit City Clinic	HaTikva St 121, Jerusalem
693	2025-09-16	09:45:00	431782073	183	967238983	831565842	Leumit Family Clinic	HaNegev St 126, Modiin
694	2025-08-20	07:00:00	305150698	210	311784393	640036600	Leumit Family Clinic	Ben Gurion Blvd 21, Bat Yam
695	2025-10-21	11:45:00	512030298	64	648046509	477791140	Clalit Women's Clinic	Begin Blvd 76, Petah Tikva
696	2025-04-04	07:15:00	274894140	336	951108053	718179719	Meuhedet Clinic	HaYarkon St 98, Ramat Gan
697	2025-06-24	17:00:00	232412113	167	686931483	379085236	Meuhedet Health Center	Jabotinsky St 143, Holon
698	2025-11-12	07:00:00	890176770	70	277290510	831565842	Clalit City Clinic	Herzl St 84, Netanya
699	2025-04-02	09:00:00	417243925	240	335528238	642311259	Maccabi Family Clinic	Weizmann St 128, Modiin
700	2025-03-10	11:00:00	749132937	378	705338121	152943249	Leumit City Clinic	Weizmann St 35, Kfar Saba
701	2025-10-10	18:00:00	503988129	400	530516374	991164471	Leumit Pediatric Clinic	Allenby St 96, Beersheba
702	2025-12-20	14:30:00	433513336	183	565166657	655853037	Meuhedet Pediatric Clinic	Allenby St 48, Haifa
703	2025-08-25	09:00:00	702769651	131	808943895	620872913	Meuhedet Family Clinic	HaPalmach St 19, Rishon LeZion
704	2025-07-13	18:30:00	638913607	20	530516374	134463780	Maccabi Family Clinic	HaHistadrut St 3, Beersheba
705	2025-02-22	16:00:00	120855999	118	311784393	609883589	Meuhedet Women's Clinic	Rothschild Ave 1, Tel Aviv
706	2025-12-21	06:30:00	855032071	135	933176850	406350060	Meuhedet Clinic	Jabotinsky St 142, Kfar Saba
707	2025-07-06	16:45:00	267088184	271	808943895	457148964	Soroka Medical Center	HaYarkon St 6, Ashdod
708	2025-03-06	06:00:00	406254292	65	888469205	\N	Maccabi Clinic	Begin Blvd 98, Ra'anana
709	2025-09-01	07:00:00	844513515	68	244282748	638619639	Maccabi Pediatric Clinic	Herzl St 40, Rishon LeZion
710	2025-06-22	14:15:00	107106212	141	419832401	\N	Meuhedet City Clinic	Rothschild Ave 131, Ashdod
711	2025-07-13	20:00:00	182172500	123	414131125	485241165	Leumit Health Center	Rothschild Ave 88, Modiin
712	2025-06-20	20:00:00	319864750	194	129452534	991202503	Clalit Women's Clinic	HaTikva St 133, Beersheba
713	2025-04-05	19:15:00	733454157	316	765574491	579396263	Leumit City Clinic	Jabotinsky St 124, Haifa
714	2025-05-09	13:30:00	465944468	141	801483903	\N	Maccabi Family Clinic	HaPalmach St 14, Bat Yam
715	2025-08-22	07:00:00	805876988	393	896973596	379926927	Maccabi Family Clinic	Weizmann St 128, Modiin
716	2025-08-14	16:00:00	587398835	128	316396883	333012046	Meuhedet Family Clinic	HaHistadrut St 74, Haifa
717	2025-08-19	06:45:00	796091497	50	703776850	967167857	Meuhedet Health Center	Weizmann St 40, Haifa
718	2025-01-26	19:15:00	536869685	364	799258702	165928627	Maccabi Pediatric Clinic	Herzl St 12, Jerusalem
719	2025-10-06	20:30:00	403792403	181	646651118	549847210	Leumit Health Center	Allenby St 40, Bnei Brak
720	2025-08-13	06:30:00	533476073	26	339014530	792123494	Maccabi Family Clinic	Jabotinsky St 5, Rehovot
721	2025-02-07	10:15:00	472314962	242	316396883	437174782	Clalit Women's Clinic	Jabotinsky St 116, Modiin
722	2025-03-08	18:00:00	151910759	105	914566516	405385808	Leumit Women's Clinic	Allenby St 105, Ashdod
723	2025-06-15	10:45:00	894548767	61	335569735	310258592	Leumit Pediatric Clinic	HaNegev St 140, Bnei Brak
724	2025-04-18	10:15:00	263372945	355	152785861	266685039	Maccabi Women's Clinic	Herzl St 16, Modiin
725	2025-06-15	10:15:00	760208651	187	286582552	655853037	Maccabi Clinic	HaPalmach St 36, Tel Aviv
726	2025-03-24	14:00:00	542297151	262	335569735	169095841	Maccabi Health Center	HaShalom Rd 91, Netanya
727	2025-08-14	14:15:00	816422554	253	316396883	406350060	Meuhedet Women's Clinic	HaShalom Rd 102, Ashkelon
728	2025-10-11	13:45:00	543629152	188	559056009	\N	Ichilov Hospital	Rothschild Ave 148, Beersheba
729	2025-12-26	14:30:00	587398835	115	651447743	950189399	Meuhedet City Clinic	Jabotinsky St 71, Jerusalem
730	2025-01-07	08:00:00	418541884	369	835425519	452367681	Maccabi Clinic	Herzl St 23, Rehovot
731	2025-10-20	11:15:00	946254016	361	419832401	\N	Leumit Health Center	Allenby St 40, Bnei Brak
732	2025-01-11	17:15:00	163977003	230	890623488	150886100	Maccabi Health Center	HaTikva St 86, Holon
733	2025-08-07	20:45:00	368041638	265	408394324	120252841	Maccabi City Clinic	HaPalmach St 85, Beersheba
734	2025-04-07	06:45:00	641087529	170	740682739	977667032	Maccabi Family Clinic	HaTikva St 98, Bat Yam
735	2025-09-18	14:15:00	626008407	100	832010443	228630954	Maccabi Health Center	Rothschild Ave 118, Rehovot
736	2025-03-05	17:30:00	645957157	216	886939800	587248600	Maccabi Health Center	HaYarkon St 132, Ashdod
737	2025-04-01	19:00:00	591839254	114	337501464	692757934	Leumit City Clinic	HaTikva St 108, Ramat Gan
738	2025-02-07	08:30:00	189899416	43	162929677	310449903	Meuhedet Clinic	HaShalom Rd 118, Jerusalem
739	2025-02-15	06:30:00	469589167	268	335569735	\N	Leumit Family Clinic	HaHistadrut St 102, Ashkelon
740	2025-11-03	18:00:00	124782507	60	427852785	289805994	Meuhedet City Clinic	Allenby St 117, Bat Yam
741	2025-09-12	20:00:00	464558868	266	484821493	967167857	Leumit Health Center	Rothschild Ave 88, Modiin
742	2025-09-16	14:30:00	505288440	221	876946737	608281507	Maccabi City Clinic	Herzl St 15, Rehovot
743	2025-02-02	08:45:00	855172589	375	361945520	560761358	Leumit Pediatric Clinic	Begin Blvd 68, Modiin
744	2025-07-15	16:45:00	486579729	354	128998748	\N	Clalit Family Clinic	HaShalom Rd 22, Ra'anana
745	2025-09-09	15:00:00	378410529	19	870880025	913520210	Maccabi Clinic	Weizmann St 78, Tel Aviv
746	2025-12-24	09:15:00	189128964	113	130440929	967167857	Maccabi Pediatric Clinic	HaTikva St 63, Modiin
747	2025-07-12	11:30:00	894956091	173	121502474	632667768	Maccabi Pediatric Clinic	Ben Gurion Blvd 17, Modiin
748	2025-01-25	17:00:00	836771587	292	314241360	579396263	Meuhedet Women's Clinic	Ben Gurion Blvd 119, Holon
749	2025-08-09	11:30:00	682247730	39	530516374	\N	Leumit Clinic	HaHistadrut St 140, Ra'anana
750	2025-05-03	14:30:00	182172500	252	767059275	444687035	Meuhedet Clinic	Begin Blvd 140, Bat Yam
751	2025-07-23	15:15:00	591879309	102	103198638	620872913	Maccabi City Clinic	HaPalmach St 85, Beersheba
752	2025-11-04	11:00:00	267088184	218	375218533	134938340	Meuhedet Family Clinic	HaNegev St 44, Haifa
753	2025-08-25	19:30:00	475277239	32	596823946	125478540	Maccabi City Clinic	HaPalmach St 28, Modiin
754	2025-06-19	07:15:00	189899416	213	668035126	641246037	Leumit City Clinic	HaPalmach St 109, Modiin
755	2025-08-07	15:45:00	189791206	25	170476311	152943249	Meuhedet Clinic	Weizmann St 71, Ashkelon
756	2025-12-11	09:15:00	284489969	144	165682443	913520210	Leumit Pediatric Clinic	Herzl St 142, Kfar Saba
757	2025-07-27	07:15:00	586562174	283	790255711	809751526	Meuhedet Family Clinic	HaShalom Rd 80, Bat Yam
758	2025-08-11	06:30:00	163350630	17	762854976	858675688	Maccabi Health Center	Rothschild Ave 118, Rehovot
759	2025-09-22	13:00:00	508184542	355	146240027	264594643	Clalit City Clinic	Weizmann St 132, Kfar Saba
760	2025-09-19	13:30:00	771372820	354	770359651	432026089	Clalit Health Center	Herzl St 113, Bat Yam
761	2025-11-17	14:30:00	947243926	219	623490063	926151796	Maccabi Family Clinic	HaYarkon St 77, Kfar Saba
762	2025-11-27	10:00:00	591839254	309	300697114	705977773	Maccabi Health Center	Ben Gurion Blvd 43, Kfar Saba
763	2025-02-24	20:15:00	645957157	77	675610128	\N	Maccabi Women's Clinic	Sokolov St 74, Bnei Brak
764	2025-10-06	18:30:00	947243926	375	121065055	\N	Leumit Women's Clinic	HaNegev St 149, Ramat Gan
765	2025-08-12	14:15:00	536869685	93	942705156	193901152	Leumit Family Clinic	HaTikva St 41, Netanya
766	2025-10-07	13:00:00	797569992	162	808943895	297714695	Leumit Health Center	Rothschild Ave 88, Modiin
767	2025-09-06	15:15:00	415777602	141	188163518	442531669	Meuhedet Pediatric Clinic	HaPalmach St 113, Jerusalem
768	2025-08-14	13:45:00	860088812	249	983060617	233025558	Leumit City Clinic	HaShalom Rd 123, Ra'anana
769	2025-12-06	19:15:00	343278287	213	651938317	210440926	Maccabi Women's Clinic	Jabotinsky St 123, Petah Tikva
770	2025-01-28	16:30:00	890176770	46	480434918	975354103	Clalit Health Center	Menachem Begin St 81, Tel Aviv
771	2025-08-16	14:15:00	254630730	100	886939800	660542544	Leumit Women's Clinic	Ben Gurion Blvd 116, Rehovot
772	2025-11-09	17:30:00	116338238	190	356308687	233025558	Meuhedet Health Center	Jabotinsky St 78, Herzliya
773	2025-10-01	11:15:00	185144803	182	311784393	\N	Maccabi Clinic	Rothschild Ave 112, Bnei Brak
774	2025-03-09	16:15:00	558919861	295	927916320	169095841	Maccabi Pediatric Clinic	Herzl St 144, Rishon LeZion
775	2025-03-26	16:15:00	533354204	344	121065055	200778361	Leumit Family Clinic	Ben Gurion Blvd 21, Bat Yam
776	2025-12-11	15:30:00	536709776	378	333059661	379926927	Leumit Clinic	HaHistadrut St 139, Ra'anana
777	2025-05-03	15:15:00	403792403	116	939238672	266685039	Maccabi Family Clinic	HaTikva St 49, Ramat Gan
778	2025-02-10	15:45:00	420061429	302	246927292	233715310	Meuhedet City Clinic	Rothschild Ave 66, Petah Tikva
779	2025-01-08	13:30:00	124782507	149	451143202	421967560	Maccabi City Clinic	HaPalmach St 28, Modiin
780	2025-06-01	20:00:00	139889274	186	493394881	543138407	Clalit Family Clinic	HaShalom Rd 22, Ra'anana
781	2025-11-05	18:15:00	503988129	324	414131125	364330977	Leumit Pediatric Clinic	Sokolov St 30, Petah Tikva
782	2025-01-17	17:45:00	946254016	19	723266609	549847210	Meuhedet Health Center	HaNegev St 127, Tel Aviv
783	2025-09-24	13:45:00	587398835	20	832006368	\N	Leumit City Clinic	HaPalmach St 109, Modiin
784	2025-12-11	15:15:00	728873342	319	204520642	499722276	Leumit Pediatric Clinic	HaShalom Rd 70, Kfar Saba
785	2025-08-07	15:45:00	475277239	249	316396883	112742705	Leumit Family Clinic	HaHistadrut St 102, Ashkelon
786	2025-02-01	09:30:00	814384608	55	605063967	967167857	Clalit Pediatric Clinic	HaShalom Rd 49, Jerusalem
787	2025-06-17	07:30:00	758038866	400	799258702	358890331	Meuhedet Health Center	Allenby St 129, Jerusalem
788	2025-06-28	14:00:00	689825727	289	595351873	927259391	Meuhedet Family Clinic	Allenby St 1, Rehovot
789	2025-09-15	13:30:00	101565191	381	262180529	358401641	Leumit Clinic	Sokolov St 20, Ashdod
790	2025-04-07	18:30:00	590818651	350	575013098	876785540	Meuhedet City Clinic	Rothschild Ave 66, Petah Tikva
791	2025-03-09	07:15:00	568658593	310	980860075	904402564	Maccabi Pediatric Clinic	HaPalmach St 47, Netanya
792	2025-01-20	09:00:00	110151501	55	961074382	590833948	Clalit Pediatric Clinic	Sokolov St 44, Ra'anana
793	2025-12-04	15:30:00	377899807	228	170476311	444687035	Maccabi Women's Clinic	Herzl St 74, Holon
794	2025-06-16	10:15:00	147130620	277	282498842	233025558	Meuhedet Health Center	Weizmann St 123, Ashdod
795	2025-11-05	07:30:00	177702985	63	869029092	\N	Clalit Pediatric Clinic	Weizmann St 78, Netanya
796	2025-04-06	17:15:00	771372820	166	596823946	134938340	Meuhedet Pediatric Clinic	Begin Blvd 73, Bnei Brak
797	2025-01-14	10:30:00	799742877	54	385321066	745929637	Clalit Pediatric Clinic	HaShalom Rd 49, Jerusalem
798	2025-06-08	11:00:00	470869626	326	927916320	926151796	Maccabi Women's Clinic	Sokolov St 14, Petah Tikva
799	2025-05-08	15:00:00	612117711	396	194967455	330948886	Meuhedet Women's Clinic	Sokolov St 58, Beersheba
800	2025-07-01	08:15:00	518912049	389	355020965	\N	Leumit Clinic	HaYarkon St 130, Petah Tikva
801	2025-05-21	06:00:00	163977003	313	452354109	266685039	Clalit Pediatric Clinic	Herzl St 20, Jerusalem
802	2025-06-23	07:30:00	537493895	309	770359651	288012548	Clalit Women's Clinic	Menachem Begin St 136, Ramat Gan
803	2025-05-08	17:45:00	851341222	355	646651118	877651756	Leumit Clinic	HaHistadrut St 111, Netanya
804	2025-03-18	08:15:00	568658593	69	678506268	717220517	Maccabi Pediatric Clinic	HaPalmach St 49, Bat Yam
805	2025-11-24	06:15:00	877834494	173	175078783	291145247	Leumit City Clinic	HaNegev St 36, Haifa
806	2025-03-24	19:30:00	966268273	324	378127589	146343109	Maccabi Pediatric Clinic	HaNegev St 56, Ramat Gan
807	2025-05-05	08:45:00	341446195	108	510334717	154992568	Soroka Medical Center	HaYarkon St 6, Ashdod
808	2025-10-04	10:30:00	665010330	180	832006368	\N	Meuhedet Women's Clinic	HaYarkon St 98, Haifa
809	2025-10-14	20:00:00	678621121	196	246927292	919941861	Leumit City Clinic	Weizmann St 138, Modiin
810	2025-08-06	09:00:00	574857929	291	471674082	788565519	Maccabi Pediatric Clinic	HaNegev St 5, Ramat Gan
811	2025-11-28	13:45:00	124782507	169	770359651	\N	Clalit Women's Clinic	Rothschild Ave 6, Jerusalem
812	2025-10-21	06:15:00	209732140	107	569080510	928678498	Maccabi Family Clinic	HaPalmach St 15, Haifa
813	2025-07-21	13:00:00	754600805	128	378127589	264594643	Leumit City Clinic	Begin Blvd 66, Rehovot
814	2025-08-01	08:00:00	406254292	52	801483903	809751526	Clalit Pediatric Clinic	Allenby St 107, Ashkelon
815	2025-12-03	13:30:00	560347583	130	770359651	\N	Meuhedet Clinic	Weizmann St 71, Ashkelon
816	2025-11-10	06:30:00	915339436	262	367041409	143764555	Clalit Health Center	Weizmann St 13, Haifa
817	2025-07-08	12:45:00	151910759	197	385321066	\N	Meuhedet Pediatric Clinic	Weizmann St 102, Haifa
818	2025-10-11	17:30:00	715266007	322	651938317	717220517	Meuhedet City Clinic	Jabotinsky St 71, Jerusalem
819	2025-05-28	18:15:00	485521617	234	410962502	991164471	Meuhedet Family Clinic	Allenby St 1, Rehovot
820	2025-09-02	14:15:00	194165094	169	914566516	595566634	Leumit Pediatric Clinic	Allenby St 96, Beersheba
821	2025-08-05	10:30:00	274894140	39	651938317	\N	Maccabi Family Clinic	Sokolov St 19, Jerusalem
822	2025-10-15	07:15:00	906327198	112	459613663	406350060	Maccabi Pediatric Clinic	HaNegev St 56, Ramat Gan
823	2025-04-09	14:15:00	358867112	230	613307691	310449903	Maccabi City Clinic	Ben Gurion Blvd 61, Bnei Brak
824	2025-12-21	10:15:00	754151802	149	571289027	125478540	Maccabi Family Clinic	HaHistadrut St 41, Tel Aviv
825	2025-11-06	14:15:00	627627838	288	110532551	543138407	Maccabi Family Clinic	Sokolov St 6, Haifa
826	2025-03-18	12:15:00	981257093	331	691705874	288012548	Maccabi Pediatric Clinic	HaNegev St 56, Ramat Gan
827	2025-11-23	15:45:00	116338238	317	160913893	\N	Maccabi Clinic	Weizmann St 78, Tel Aviv
828	2025-01-24	16:45:00	976166486	135	808677201	\N	Clalit Pediatric Clinic	Menachem Begin St 69, Tel Aviv
829	2025-09-16	18:00:00	284489969	266	775579062	\N	Leumit Health Center	HaYarkon St 112, Modiin
830	2025-05-09	20:15:00	174043533	371	350299663	\N	Maccabi Health Center	HaShalom Rd 53, Bnei Brak
831	2025-10-03	16:15:00	163350630	163	162929677	585426153	Clalit City Clinic	Begin Blvd 105, Bat Yam
832	2025-09-11	19:30:00	341446195	185	349943042	644870997	Maccabi Pediatric Clinic	HaPalmach St 47, Netanya
833	2025-04-02	07:00:00	560347583	208	691705874	300885051	Clalit Pediatric Clinic	Weizmann St 78, Netanya
834	2025-03-18	15:30:00	418541884	267	993263579	484495578	Leumit Family Clinic	HaTikva St 41, Netanya
835	2025-06-22	13:00:00	916939137	307	385321066	\N	Clalit Women's Clinic	Rothschild Ave 6, Jerusalem
836	2025-08-22	19:15:00	284004279	376	686931483	535842430	Maccabi Clinic	Rothschild Ave 112, Bnei Brak
837	2025-12-13	19:30:00	129762178	273	860923150	323208385	Clalit Women's Clinic	HaTikva St 40, Modiin
838	2025-03-02	15:00:00	726107543	197	623490063	950189399	Maccabi Women's Clinic	HaShalom Rd 16, Ashdod
839	2025-07-08	17:00:00	629845815	177	494708371	\N	Meuhedet City Clinic	Rothschild Ave 66, Petah Tikva
840	2025-08-15	19:45:00	502455034	249	870478094	928678498	Clalit Clinic	Herzl St 148, Herzliya
841	2025-07-15	16:15:00	918984720	375	157794649	136335319	Leumit Clinic	Herzl St 62, Kfar Saba
842	2025-08-04	12:00:00	595469585	44	583133229	621805679	Maccabi Clinic	Ben Gurion Blvd 128, Ashkelon
843	2025-04-21	11:00:00	177702985	190	886939800	543138407	Ziv Medical Center	HaPalmach St 114, Holon
844	2025-04-22	08:30:00	294996591	123	300697114	637417326	Meuhedet Clinic	HaYarkon St 98, Ramat Gan
845	2025-02-23	11:30:00	843075942	319	762854976	379926927	Clalit City Clinic	Weizmann St 60, Haifa
846	2025-04-09	19:00:00	920666292	236	132264095	927259391	Leumit Health Center	Rothschild Ave 88, Modiin
847	2025-10-26	08:00:00	563031706	287	565166657	585034134	Meuhedet Women's Clinic	Menachem Begin St 122, Haifa
848	2025-01-15	13:30:00	906327198	139	231324781	967167857	Leumit City Clinic	HaPalmach St 11, Haifa
849	2025-01-13	10:00:00	486579729	305	262180529	\N	Clalit City Clinic	Begin Blvd 105, Bat Yam
850	2025-12-09	14:00:00	299085717	208	939238672	302016206	Maccabi Pediatric Clinic	Begin Blvd 5, Rehovot
851	2025-02-16	13:15:00	614959631	315	896973596	958396544	Meuhedet Clinic	Rothschild Ave 113, Rishon LeZion
852	2025-09-07	20:30:00	196728836	109	311784393	392263901	Maccabi Health Center	HaHistadrut St 56, Jerusalem
853	2025-07-16	10:15:00	970296727	156	356308687	146343109	Clalit Family Clinic	Allenby St 29, Holon
854	2025-04-15	06:00:00	805185005	308	121065055	674960706	Maccabi Clinic	HaYarkon St 94, Ashdod
855	2025-09-19	10:15:00	196728836	300	832006368	123889591	Leumit Family Clinic	Sokolov St 20, Ashdod
856	2025-09-23	16:45:00	248993596	122	327338690	310258592	Meuhedet Family Clinic	HaNegev St 44, Haifa
857	2025-05-28	20:00:00	463548843	16	722223783	515517676	Meuhedet Women's Clinic	HaYarkon St 98, Haifa
858	2025-03-28	13:00:00	638101487	174	194967455	277362370	Leumit Pediatric Clinic	Herzl St 142, Kfar Saba
859	2025-11-03	19:30:00	283767201	135	318943388	193901152	Clalit Women's Clinic	Begin Blvd 34, Bnei Brak
860	2025-11-12	19:45:00	926419142	359	648046509	523462070	Meuhedet Clinic	Rothschild Ave 130, Rishon LeZion
861	2025-08-04	08:30:00	682247730	374	961074382	291145247	Leumit Women's Clinic	Allenby St 105, Ashdod
862	2025-09-14	19:30:00	679248949	89	993263579	896666994	Leumit Clinic	HaTikva St 113, Beersheba
863	2025-01-26	12:15:00	300036531	190	244282748	302016206	Maccabi Pediatric Clinic	Weizmann St 60, Rishon LeZion
864	2025-10-12	09:45:00	560347583	285	760677936	798009672	Maccabi Family Clinic	HaPalmach St 125, Ashkelon
865	2025-05-14	12:45:00	292536682	202	765921635	146343109	Meuhedet Health Center	Weizmann St 123, Ashdod
866	2025-12-11	11:00:00	329416185	263	559056009	524957376	Meuhedet Pediatric Clinic	HaHistadrut St 39, Netanya
867	2025-09-04	16:45:00	383641443	340	294557346	958396544	Meuhedet Pediatric Clinic	HaHistadrut St 65, Rehovot
868	2025-01-24	08:15:00	135745856	357	790255711	\N	Leumit Health Center	Jabotinsky St 124, Holon
869	2025-07-03	11:45:00	206768692	220	620016708	705977773	Maccabi Clinic	Menachem Begin St 131, Rishon LeZion
870	2025-02-18	07:15:00	297461390	141	162929677	\N	Clalit City Clinic	HaYarkon St 105, Herzliya
871	2025-11-16	09:00:00	538839225	294	152785861	567352637	Clalit Women's Clinic	Begin Blvd 76, Petah Tikva
872	2025-03-21	07:30:00	154227972	178	668035126	\N	Maccabi Family Clinic	HaHistadrut St 28, Rishon LeZion
873	2025-07-13	18:30:00	805876988	24	569080510	200778361	Leumit Health Center	Sokolov St 32, Herzliya
874	2025-11-18	09:45:00	188709072	175	909580633	634188128	Maccabi City Clinic	Weizmann St 75, Jerusalem
875	2025-01-26	16:15:00	177702985	234	582888025	\N	Clalit City Clinic	Herzl St 84, Netanya
876	2025-07-01	20:15:00	305150698	95	747832838	\N	Clalit Women's Clinic	HaPalmach St 142, Petah Tikva
877	2025-08-21	15:30:00	429596723	121	375218533	831565842	Maccabi Clinic	HaTikva St 81, Kfar Saba
878	2025-04-06	12:15:00	812170410	48	724516280	277362370	Maccabi Pediatric Clinic	HaYarkon St 111, Beersheba
879	2025-05-07	19:15:00	345789475	227	596823946	\N	Meuhedet City Clinic	Sokolov St 95, Ashkelon
880	2025-07-26	09:45:00	982886900	275	405648081	913520210	Maccabi Family Clinic	Weizmann St 118, Ashkelon
881	2025-04-26	11:15:00	420061429	257	983060617	\N	Leumit City Clinic	Ben Gurion Blvd 25, Ramat Gan
882	2025-07-03	16:30:00	760208651	191	870880025	525443476	Clalit Women's Clinic	Begin Blvd 34, Bnei Brak
883	2025-07-01	18:15:00	851341222	15	145012488	\N	Maccabi Pediatric Clinic	Weizmann St 112, Haifa
884	2025-02-15	07:15:00	614959631	125	459613663	739732268	Leumit Women's Clinic	Ben Gurion Blvd 116, Rehovot
885	2025-02-21	09:45:00	509642139	349	503075904	153432684	Leumit Clinic	Ben Gurion Blvd 112, Ramat Gan
886	2025-07-14	11:15:00	165914899	360	993263579	946589413	Maccabi Pediatric Clinic	Sokolov St 62, Petah Tikva
887	2025-12-19	10:00:00	477313143	349	835425519	585426153	Maccabi Clinic	Ben Gurion Blvd 128, Ashkelon
888	2025-11-25	09:45:00	396524353	37	967238983	524957376	Meuhedet Women's Clinic	Begin Blvd 122, Ra'anana
889	2025-03-22	20:15:00	198401039	165	361945520	904402564	Clalit Health Center	Weizmann St 13, Haifa
890	2025-03-06	14:00:00	433513336	160	337501464	858675688	Clalit Women's Clinic	Sokolov St 96, Ashkelon
891	2025-02-17	13:30:00	509642139	158	419832401	\N	Clalit Women's Clinic	HaYarkon St 60, Ashkelon
892	2025-12-23	10:45:00	348914405	291	575013098	\N	Meuhedet Family Clinic	HaNegev St 74, Petah Tikva
893	2025-01-05	20:30:00	737208814	55	822386902	200778361	Meuhedet Pediatric Clinic	Jabotinsky St 60, Bat Yam
894	2025-02-05	08:00:00	514692698	10	770359651	205288611	Maccabi Health Center	HaShalom Rd 53, Bnei Brak
895	2025-08-05	15:00:00	963025761	158	927468908	590833948	Maccabi Pediatric Clinic	Rothschild Ave 58, Holon
896	2025-09-20	11:15:00	382178937	219	106210399	637417326	Maccabi Clinic	HaTikva St 81, Kfar Saba
897	2025-04-08	18:30:00	844888238	202	471674082	\N	Leumit Clinic	HaTikva St 113, Beersheba
898	2025-01-10	06:00:00	982886900	272	667143420	644870997	Ichilov Hospital	Rothschild Ave 148, Beersheba
899	2025-03-06	09:30:00	383641443	349	459613663	\N	Meuhedet Clinic	Rothschild Ave 130, Rishon LeZion
900	2025-05-16	12:00:00	292536682	96	561707109	125478540	Meuhedet Women's Clinic	Rothschild Ave 1, Tel Aviv
901	2025-01-04	12:15:00	326216990	348	575013098	444687035	Leumit City Clinic	HaTikva St 78, Petah Tikva
902	2025-08-27	14:30:00	173426798	192	561707109	798009672	Maccabi Women's Clinic	HaPalmach St 107, Holon
903	2025-04-05	08:30:00	450494685	369	510716800	477791140	Meuhedet Health Center	Herzl St 74, Modiin
904	2025-08-09	18:00:00	895588198	154	835425519	886567223	Meuhedet Health Center	HaNegev St 36, Herzliya
905	2025-09-25	13:15:00	305150698	78	967238983	\N	Clalit Family Clinic	HaYarkon St 28, Bat Yam
906	2025-11-27	13:00:00	254630730	316	352089792	585426153	Leumit Pediatric Clinic	Rothschild Ave 32, Petah Tikva
907	2025-01-13	15:45:00	358867112	258	378127589	154992568	Leumit City Clinic	Ben Gurion Blvd 25, Ramat Gan
908	2025-01-06	13:45:00	400850159	154	146240027	\N	Clalit Family Clinic	Allenby St 100, Haifa
909	2025-01-25	07:45:00	639156305	181	378127589	718179719	Meuhedet Clinic	Weizmann St 71, Ashkelon
910	2025-09-01	19:00:00	161764941	168	410254424	254040510	Meuhedet Women's Clinic	Sokolov St 23, Bat Yam
911	2025-05-13	17:30:00	993112782	117	165682443	792123494	Maccabi Women's Clinic	Jabotinsky St 123, Petah Tikva
912	2025-03-24	20:00:00	845115493	235	410962502	\N	Leumit Health Center	Sokolov St 32, Herzliya
913	2025-06-24	09:15:00	383641443	230	909580633	991164471	Leumit Health Center	HaYarkon St 112, Modiin
914	2025-08-13	09:15:00	469589167	47	352089792	\N	Leumit Health Center	Sokolov St 32, Herzliya
915	2025-11-23	08:15:00	844513515	379	427852785	858675688	Maccabi Family Clinic	Sokolov St 11, Rehovot
916	2025-07-12	18:45:00	999168068	51	933176850	523195752	Clalit City Clinic	Weizmann St 60, Haifa
917	2025-09-02	18:15:00	301023302	125	605063967	403951290	Maccabi Clinic	Begin Blvd 98, Ra'anana
918	2025-04-26	08:00:00	154227972	366	648046509	365083334	Maccabi Clinic	Weizmann St 78, Tel Aviv
919	2025-12-01	06:45:00	409960350	29	175078783	549847210	Clalit Health Center	Weizmann St 13, Haifa
920	2025-10-25	16:45:00	542297151	67	980860075	104731999	Clalit Health Center	Ben Gurion Blvd 101, Rehovot
921	2025-08-23	20:00:00	450494685	290	349943042	173735333	Leumit Pediatric Clinic	Jabotinsky St 22, Kfar Saba
922	2025-12-20	14:15:00	263372945	312	686931483	165928627	Maccabi Family Clinic	HaTikva St 98, Bat Yam
923	2025-08-15	19:45:00	606515031	37	888469205	358890331	Clalit Family Clinic	Allenby St 29, Holon
924	2025-04-06	14:00:00	895576008	168	128998748	104731999	Meuhedet Clinic	Rothschild Ave 94, Rehovot
925	2025-10-25	17:30:00	855172589	105	367041409	627217360	Maccabi Clinic	HaShalom Rd 37, Kfar Saba
926	2025-12-02	07:30:00	583707574	214	587927685	124787141	Maccabi Family Clinic	HaNegev St 59, Rehovot
927	2025-06-17	18:45:00	287043819	238	747832838	\N	Meuhedet Women's Clinic	HaYarkon St 87, Jerusalem
928	2025-03-07	10:45:00	287218285	188	765574491	590833948	Leumit Family Clinic	Ben Gurion Blvd 24, Tel Aviv
929	2025-09-06	13:45:00	469589167	233	427852785	632667768	Clalit Clinic	HaHistadrut St 142, Kfar Saba
930	2025-02-13	17:45:00	250708248	205	809797531	289805994	Maccabi Family Clinic	Weizmann St 118, Ashkelon
931	2025-07-13	09:00:00	322317846	300	282498842	732231442	Meuhedet Family Clinic	Begin Blvd 73, Bnei Brak
932	2025-02-11	08:45:00	590818651	266	188163518	165928627	Leumit Women's Clinic	Ben Gurion Blvd 106, Rehovot
933	2025-11-27	16:15:00	177702985	160	421289999	545281216	Meuhedet City Clinic	Rothschild Ave 66, Petah Tikva
934	2025-01-18	17:00:00	542415875	284	808677201	264594643	Leumit Family Clinic	Allenby St 38, Ramat Gan
935	2025-02-27	15:45:00	829589264	167	760677936	330948886	Leumit Clinic	HaNegev St 104, Ra'anana
936	2025-12-05	12:45:00	682247730	226	691705874	717220517	Maccabi Family Clinic	HaHistadrut St 28, Rishon LeZion
937	2025-09-18	09:00:00	184019783	194	571289027	457148964	Clalit Women's Clinic	Menachem Begin St 136, Ramat Gan
938	2025-04-25	10:15:00	587398835	196	832010443	587248600	Clalit Pediatric Clinic	Sokolov St 44, Ra'anana
939	2025-08-20	10:30:00	958722701	248	678506268	\N	Leumit Pediatric Clinic	Rothschild Ave 32, Petah Tikva
940	2025-07-24	16:15:00	161764941	47	770359651	931089150	Clalit City Clinic	Weizmann St 132, Kfar Saba
941	2025-09-24	13:30:00	959505198	127	667143420	\N	Maccabi Health Center	HaTikva St 93, Beersheba
942	2025-03-28	07:00:00	322279900	37	952751158	123889591	Leumit Pediatric Clinic	Begin Blvd 42, Bnei Brak
943	2025-04-17	16:30:00	637152102	206	103198638	405385808	Clalit Women's Clinic	HaTikva St 133, Beersheba
944	2025-02-28	14:00:00	116338238	293	565166657	977667032	Meuhedet Family Clinic	Menachem Begin St 148, Bat Yam
945	2025-12-04	15:45:00	242098030	99	808943895	300685875	Meuhedet Women's Clinic	HaShalom Rd 135, Haifa
946	2025-05-28	08:30:00	151910759	193	375913224	365083334	Leumit Pediatric Clinic	Jabotinsky St 22, Kfar Saba
947	2025-10-12	16:30:00	485521617	331	349943042	549847210	Clalit Health Center	Jabotinsky St 51, Netanya
948	2025-06-08	06:45:00	626008407	101	876946737	522199986	Leumit Clinic	Jabotinsky St 51, Ashkelon
949	2025-05-07	12:15:00	281369713	148	427852785	\N	Leumit Health Center	Weizmann St 145, Petah Tikva
950	2025-05-21	18:15:00	862048623	209	914566516	\N	Clalit Clinic	Herzl St 148, Herzliya
951	2025-08-27	20:45:00	737208814	333	106210399	913520210	Maccabi Health Center	HaTikva St 86, Holon
952	2025-05-17	17:30:00	282408614	370	278345196	567352637	Hadassah Ein Kerem Hospital	Herzl St 24, Haifa
953	2025-08-27	06:15:00	741606378	146	215791975	\N	Meuhedet City Clinic	HaPalmach St 122, Modiin
954	2025-11-08	17:15:00	603632562	187	832006368	\N	Maccabi City Clinic	Ben Gurion Blvd 61, Bnei Brak
955	2025-02-08	20:30:00	434477925	313	110532551	123889591	Clalit Women's Clinic	HaTikva St 133, Beersheba
956	2025-03-01	19:00:00	546960294	57	414316626	364330977	Meuhedet Pediatric Clinic	Herzl St 134, Holon
957	2025-10-22	16:30:00	771372820	231	738536844	310449903	Clalit Clinic	Ben Gurion Blvd 111, Beersheba
958	2025-10-11	09:00:00	174306440	400	410254424	913520210	Clalit Health Center	Menachem Begin St 81, Tel Aviv
959	2025-09-22	13:15:00	505288440	3	762854976	632667768	Meuhedet Pediatric Clinic	HaShalom Rd 144, Petah Tikva
960	2025-02-09	17:45:00	887631402	382	927916320	310258592	Clalit Women's Clinic	Rothschild Ave 6, Jerusalem
961	2025-07-19	09:00:00	762559306	143	942705156	691399121	Meuhedet Family Clinic	Menachem Begin St 58, Rehovot
962	2025-03-20	10:15:00	797569992	63	130440929	302016206	Leumit Pediatric Clinic	Menachem Begin St 92, Jerusalem
963	2025-11-22	06:45:00	543629152	20	130440929	788565519	Meuhedet Family Clinic	Rothschild Ave 36, Herzliya
964	2025-06-04	11:30:00	300036531	19	740682739	\N	Maccabi Women's Clinic	HaYarkon St 77, Modiin
965	2025-03-21	06:45:00	277537826	335	613307691	291145247	Leumit City Clinic	Begin Blvd 66, Rehovot
966	2025-01-25	18:45:00	855032071	291	902246089	579396263	Maccabi City Clinic	Rothschild Ave 117, Ashkelon
967	2025-10-06	13:30:00	563031706	74	724516280	\N	Meuhedet Family Clinic	Menachem Begin St 58, Rehovot
968	2025-04-26	06:00:00	862048623	132	367041409	535842430	Clalit Women's Clinic	HaTikva St 9, Haifa
969	2025-05-17	17:45:00	844513515	346	548621554	826996680	Clalit Women's Clinic	Menachem Begin St 136, Ramat Gan
970	2025-10-27	15:15:00	617124389	320	790255711	467137650	Leumit Family Clinic	HaYarkon St 147, Tel Aviv
971	2025-06-12	12:15:00	124782507	296	494708371	510589173	Maccabi Women's Clinic	Sokolov St 14, Petah Tikva
972	2025-02-21	09:45:00	258775091	271	195106131	831565842	Clalit City Clinic	Sokolov St 78, Herzliya
973	2025-03-19	10:45:00	694810573	125	951108053	310258592	Clalit Family Clinic	Rothschild Ave 27, Bat Yam
974	2025-03-04	14:00:00	460087435	227	762854976	484495578	Maccabi Family Clinic	Jabotinsky St 5, Rehovot
975	2025-06-09	18:45:00	757315687	1	408394324	358890331	Clalit City Clinic	Weizmann St 77, Tel Aviv
976	2025-05-21	11:00:00	508184542	302	244282748	785743985	Meuhedet City Clinic	HaPalmach St 122, Modiin
977	2025-07-06	10:00:00	871784867	107	106210399	928678498	Maccabi Health Center	Rothschild Ave 118, Rehovot
978	2025-11-13	19:00:00	752098694	353	278345196	793942949	Leumit City Clinic	Jabotinsky St 124, Haifa
979	2025-03-04	17:15:00	715266007	163	832010443	500823705	Meuhedet Women's Clinic	HaPalmach St 110, Ashkelon
980	2025-06-25	10:30:00	670190917	181	888469205	146343109	Meuhedet City Clinic	HaYarkon St 15, Tel Aviv
981	2025-11-10	11:00:00	110151501	341	724516280	798009672	Meuhedet Women's Clinic	Ben Gurion Blvd 112, Beersheba
982	2025-05-12	15:45:00	319864750	126	414131125	642311259	Meuhedet City Clinic	HaPalmach St 122, Modiin
983	2025-05-20	12:45:00	970296727	95	801483903	680422772	Leumit City Clinic	Begin Blvd 72, Ramat Gan
984	2025-06-17	11:15:00	283767201	205	121502474	\N	Clalit Women's Clinic	Jabotinsky St 116, Modiin
985	2025-05-09	19:45:00	303722231	301	334099421	162854543	Meuhedet Health Center	HaNegev St 139, Rehovot
986	2025-06-28	11:45:00	375159255	78	350299663	\N	Leumit Pediatric Clinic	HaShalom Rd 70, Kfar Saba
987	2025-05-19	15:15:00	358867112	303	375913224	700986555	Clalit Family Clinic	Allenby St 29, Holon
988	2025-06-02	15:00:00	476830627	123	789955108	\N	Leumit City Clinic	HaYarkon St 136, Holon
989	2025-10-17	09:45:00	123928798	151	414316626	991202503	Soroka Medical Center	HaYarkon St 6, Ashdod
990	2025-10-28	13:15:00	812170410	371	942705156	937895475	Maccabi Family Clinic	Rothschild Ave 32, Rishon LeZion
991	2025-12-08	11:30:00	814690335	275	675610128	222522748	Clalit City Clinic	Jabotinsky St 41, Bnei Brak
992	2025-07-14	15:15:00	331181020	165	710030144	323208385	Clalit Women's Clinic	HaPalmach St 139, Ashdod
993	2025-03-24	13:15:00	724199106	341	510334717	549847210	Maccabi Family Clinic	HaPalmach St 14, Bat Yam
994	2025-09-20	18:15:00	542415875	51	577645975	403951290	Meuhedet Family Clinic	HaYarkon St 37, Bat Yam
995	2025-02-17	13:15:00	959505198	173	822386902	578118209	Clalit Pediatric Clinic	Allenby St 107, Ashkelon
996	2025-12-23	15:30:00	914894458	352	983060617	146343109	Maccabi Health Center	HaYarkon St 132, Ashdod
997	2025-07-21	13:15:00	110151501	187	808943895	743393691	Clalit Family Clinic	Begin Blvd 29, Kfar Saba
998	2025-10-05	14:30:00	124782507	5	675033386	143764555	Clalit City Clinic	HaYarkon St 47, Ashkelon
999	2025-07-19	09:30:00	606515031	142	368803859	694876741	Clalit Health Center	Ben Gurion Blvd 101, Rehovot
1000	2025-02-22	08:15:00	409466719	12	724516280	587248600	Leumit Women's Clinic	Begin Blvd 61, Jerusalem
1001	2025-07-27	15:30:00	383641443	197	668035126	134938340	Leumit Family Clinic	Ben Gurion Blvd 21, Bat Yam
1002	2025-11-13	12:30:00	135084311	72	808677201	\N	Meuhedet Women's Clinic	Sokolov St 58, Beersheba
1003	2025-06-23	16:00:00	966268273	214	333059661	106823913	Clalit Health Center	Rothschild Ave 146, Modiin
1004	2025-05-16	17:00:00	314642987	5	339014530	358401641	Leumit City Clinic	Ben Gurion Blvd 96, Bnei Brak
1005	2025-07-23	06:00:00	657393222	8	667143420	333012046	Maccabi Pediatric Clinic	HaYarkon St 111, Beersheba
1006	2025-08-19	20:00:00	209732140	27	705338121	990265405	Hadassah Ein Kerem Hospital	Herzl St 24, Haifa
1007	2025-08-26	18:15:00	536869685	395	710030144	\N	Leumit Pediatric Clinic	HaShalom Rd 52, Modiin
1008	2025-03-05	12:00:00	371217957	374	421289999	\N	Ziv Medical Center	HaPalmach St 114, Holon
1009	2025-06-14	11:15:00	161764941	268	111533007	\N	Maccabi Pediatric Clinic	HaNegev St 56, Ramat Gan
1010	2025-01-03	12:45:00	329416185	264	335528238	590833948	Maccabi Pediatric Clinic	Weizmann St 16, Rishon LeZion
1011	2025-05-17	11:45:00	209176386	269	775579062	803631502	Leumit Health Center	Jabotinsky St 37, Ra'anana
1012	2025-04-23	13:15:00	799742877	124	121502474	\N	Maccabi Clinic	Menachem Begin St 131, Rishon LeZion
1013	2025-03-10	19:30:00	596928327	144	368803859	857599583	Leumit Family Clinic	Ben Gurion Blvd 21, Bat Yam
1014	2025-11-02	20:45:00	704835566	12	318943388	640036600	Clalit Pediatric Clinic	Ben Gurion Blvd 61, Holon
1015	2025-08-13	14:30:00	227095527	379	447168611	\N	Leumit City Clinic	Begin Blvd 70, Beersheba
1016	2025-05-11	08:45:00	797776394	6	459613663	515517676	Maccabi City Clinic	HaTikva St 148, Haifa
1017	2025-06-05	08:00:00	431782073	221	350299663	803631502	Leumit City Clinic	Jabotinsky St 3, Rishon LeZion
1018	2025-01-12	09:30:00	182172500	331	565425153	467137650	Leumit Clinic	Herzl St 73, Modiin
1019	2025-02-18	06:00:00	329416185	11	523388008	499722276	Leumit Women's Clinic	HaNegev St 115, Ramat Gan
1020	2025-07-12	19:00:00	748336036	340	356308687	524957376	Leumit City Clinic	Allenby St 107, Beersheba
1021	2025-02-19	10:15:00	230624445	100	160913893	477791140	Maccabi Women's Clinic	Menachem Begin St 93, Haifa
1022	2025-05-17	15:45:00	408340579	186	162929677	446763595	Leumit Pediatric Clinic	Jabotinsky St 22, Kfar Saba
1023	2025-07-27	16:30:00	439631560	19	801483903	432026089	Maccabi Health Center	Ben Gurion Blvd 43, Kfar Saba
1024	2025-03-25	14:15:00	409466719	6	106210399	638619639	Clalit City Clinic	Ben Gurion Blvd 81, Herzliya
1025	2025-11-11	08:15:00	144374344	170	157794649	302016206	Maccabi Clinic	Menachem Begin St 131, Rishon LeZion
1026	2025-10-24	12:30:00	476830627	394	495900140	974562766	Maccabi Clinic	Allenby St 129, Rehovot
1027	2025-03-01	20:15:00	560347583	304	160913893	\N	Maccabi Family Clinic	Weizmann St 118, Ashkelon
1028	2025-10-04	08:15:00	382178937	296	766537646	522199986	Leumit Family Clinic	Ben Gurion Blvd 24, Tel Aviv
1029	2025-04-12	18:30:00	287043819	360	876946737	636489403	Clalit Pediatric Clinic	Ben Gurion Blvd 61, Holon
1030	2025-10-01	06:45:00	638913607	127	278345196	642778231	Clalit Family Clinic	Begin Blvd 107, Netanya
1031	2025-12-20	18:00:00	799742877	153	489601917	\N	Maccabi Women's Clinic	Ben Gurion Blvd 85, Ashkelon
1032	2025-01-17	06:45:00	129762178	256	870880025	549041678	Maccabi City Clinic	HaTikva St 89, Ashdod
1033	2025-12-06	16:45:00	464558868	80	494708371	638619639	Maccabi City Clinic	Herzl St 15, Rehovot
1034	2025-12-22	12:30:00	976166486	230	205096731	\N	Clalit City Clinic	Weizmann St 60, Haifa
1035	2025-10-27	11:45:00	763371666	187	766537646	181098189	Meuhedet Health Center	Herzl St 74, Modiin
1036	2025-06-25	17:15:00	910273798	136	335528238	358890331	Clalit Women's Clinic	HaTikva St 7, Ashdod
1037	2025-03-27	16:45:00	485521617	398	246927292	200778361	Leumit City Clinic	Ben Gurion Blvd 25, Ramat Gan
1038	2025-10-19	09:45:00	417243925	196	367041409	277362370	Maccabi Women's Clinic	HaYarkon St 77, Modiin
1039	2025-07-03	07:45:00	272193302	323	886939800	164347844	Clalit Family Clinic	Ben Gurion Blvd 143, Bnei Brak
1040	2025-10-08	08:00:00	168877637	52	620016708	106823913	Leumit Clinic	Ben Gurion Blvd 112, Ramat Gan
1041	2025-05-10	19:15:00	851341222	186	530516374	523195752	Clalit Women's Clinic	Rothschild Ave 149, Haifa
1042	2025-07-20	12:45:00	814690335	188	523388008	432026089	Meuhedet City Clinic	Rothschild Ave 131, Ashdod
1043	2025-12-24	07:15:00	906327198	260	960240840	120252841	Maccabi Family Clinic	HaPalmach St 14, Bat Yam
1044	2025-07-16	06:00:00	189791206	201	808943895	484495578	Maccabi Pediatric Clinic	Sokolov St 62, Petah Tikva
1045	2025-02-14	14:15:00	809200522	118	799258702	620872913	Meuhedet Pediatric Clinic	HaHistadrut St 44, Bnei Brak
1046	2025-11-11	07:15:00	243794689	212	130440929	\N	Hadassah Ein Kerem Hospital	Herzl St 24, Haifa
1047	2025-01-04	09:30:00	816422554	26	909580633	904402564	Meuhedet Family Clinic	HaYarkon St 37, Bat Yam
1048	2025-03-23	09:15:00	518986031	360	933176850	636489403	Clalit Pediatric Clinic	Ben Gurion Blvd 16, Ashkelon
1049	2025-09-21	08:15:00	207067497	12	427852785	717220517	Leumit Pediatric Clinic	Weizmann St 74, Rishon LeZion
1050	2025-08-07	06:30:00	799742877	288	300697114	896666994	Clalit Family Clinic	Allenby St 100, Haifa
1051	2025-03-15	08:15:00	741059892	382	129452534	858675688	Clalit Health Center	HaTikva St 30, Rishon LeZion
1052	2025-07-17	11:30:00	638101487	180	349943042	857599583	Leumit Pediatric Clinic	Allenby St 96, Beersheba
1053	2025-06-15	08:30:00	702769651	263	325430239	856141290	Clalit Family Clinic	HaShalom Rd 22, Ra'anana
1054	2025-11-08	13:15:00	274894140	158	352089792	826996680	Leumit City Clinic	Jabotinsky St 124, Haifa
1055	2025-07-06	06:00:00	926419142	138	277290510	886553988	Hadassah Ein Kerem Hospital	Herzl St 24, Haifa
1056	2025-02-16	17:00:00	626008407	390	902246089	705808415	Leumit Health Center	HaNegev St 1, Herzliya
1057	2025-08-13	13:45:00	485521617	217	722223783	522199986	Leumit Family Clinic	Allenby St 12, Ramat Gan
1058	2025-01-24	08:15:00	542297151	15	993263579	446763595	Leumit Health Center	Sokolov St 32, Herzliya
1059	2025-12-03	10:00:00	593065946	392	809797531	\N	Clalit Women's Clinic	Rothschild Ave 149, Haifa
1060	2025-07-05	14:15:00	473412170	33	765921635	926559749	Clalit Family Clinic	HaHistadrut St 19, Holon
1061	2025-04-12	20:00:00	680566675	163	860923150	595566634	Maccabi City Clinic	HaYarkon St 142, Jerusalem
1062	2025-04-25	09:15:00	963025761	349	316396883	523195752	Leumit Women's Clinic	Herzl St 102, Herzliya
1063	2025-12-27	14:15:00	440428166	194	577645975	510589173	Maccabi Family Clinic	Sokolov St 11, Rehovot
1064	2025-06-19	11:15:00	629845815	395	277290510	365083334	Meuhedet City Clinic	Sokolov St 95, Ashkelon
1065	2025-04-17	18:00:00	256086565	364	333059661	120252841	Meuhedet Family Clinic	HaHistadrut St 74, Haifa
1066	2025-04-03	13:30:00	209732140	113	447168611	567352637	Meuhedet City Clinic	Ben Gurion Blvd 96, Ramat Gan
1067	2025-07-09	13:00:00	595469585	371	427852785	\N	Clalit Family Clinic	HaNegev St 15, Holon
1068	2025-05-28	15:00:00	406254292	352	128998748	391559775	Maccabi Women's Clinic	HaHistadrut St 89, Ashdod
1069	2025-07-13	18:00:00	590652532	267	471674082	297714695	Leumit Family Clinic	HaHistadrut St 128, Rishon LeZion
1070	2025-03-10	15:45:00	450494685	108	325430239	115674283	Clalit Clinic	HaShalom Rd 48, Modiin
1071	2025-03-28	13:15:00	388934046	222	595351873	446763595	Clalit Women's Clinic	Rothschild Ave 6, Jerusalem
1072	2025-01-14	14:45:00	366900528	20	355020965	692757934	Leumit Clinic	Ben Gurion Blvd 112, Ramat Gan
1073	2025-08-01	20:00:00	378410529	325	303635805	770618338	Leumit Health Center	Sokolov St 32, Herzliya
1074	2025-07-21	19:30:00	993112782	390	195106131	627217360	Clalit Women's Clinic	Rothschild Ave 6, Jerusalem
1075	2025-10-11	07:15:00	915928506	249	215791975	124787141	Clalit Family Clinic	HaNegev St 107, Bat Yam
1076	2025-03-09	20:15:00	310637280	253	714051919	974562766	Leumit Women's Clinic	HaShalom Rd 101, Ashdod
1077	2025-01-07	20:45:00	916090435	331	890623488	705977773	Meuhedet Women's Clinic	Sokolov St 66, Netanya
1078	2025-08-20	14:15:00	533476073	148	832010443	634188128	Maccabi Family Clinic	HaPalmach St 15, Haifa
1079	2025-05-16	10:00:00	587650033	162	151385895	700986555	Meuhedet Clinic	HaYarkon St 98, Ramat Gan
1080	2025-08-10	06:00:00	170140414	158	876946737	\N	Leumit Pediatric Clinic	HaShalom Rd 52, Modiin
1081	2025-02-15	09:45:00	682247730	113	205096731	720046881	Maccabi Clinic	Weizmann St 78, Tel Aviv
1082	2025-08-02	06:15:00	457553650	347	927916320	694876741	Maccabi Pediatric Clinic	Sokolov St 62, Petah Tikva
1083	2025-09-05	11:30:00	583707574	46	128998748	123889591	Meuhedet Pediatric Clinic	HaPalmach St 113, Jerusalem
1084	2025-10-05	13:30:00	920666292	28	361945520	990265405	Meuhedet Pediatric Clinic	Menachem Begin St 23, Haifa
1085	2025-03-12	11:15:00	762364645	55	939238672	803631502	Clalit Family Clinic	HaNegev St 15, Holon
1086	2025-07-28	13:00:00	982886900	369	960240840	557387584	Leumit Clinic	Sokolov St 20, Ashdod
1087	2025-12-19	11:45:00	174306440	174	890623488	164347844	Leumit Health Center	HaYarkon St 62, Bnei Brak
1088	2025-05-12	15:15:00	947243926	278	762854976	\N	Meuhedet Women's Clinic	Ben Gurion Blvd 112, Beersheba
1089	2025-09-02	15:45:00	348914405	131	145012488	292563039	Clalit Health Center	HaTikva St 30, Rishon LeZion
1090	2025-10-10	15:30:00	591879309	239	648046509	\N	Maccabi Clinic	HaTikva St 81, Kfar Saba
1091	2025-05-25	07:00:00	163350630	312	419832401	379085236	Meuhedet Women's Clinic	Sokolov St 115, Tel Aviv
1092	2025-12-11	20:15:00	383641443	15	870880025	867910701	Maccabi Health Center	HaTikva St 106, Jerusalem
1093	2025-08-21	09:30:00	409466719	400	927916320	\N	Maccabi Clinic	Herzl St 23, Rehovot
1094	2025-07-04	09:15:00	670190917	51	575013098	106374385	Maccabi Clinic	HaPalmach St 36, Tel Aviv
1095	2025-07-02	17:30:00	287043819	34	489601917	655853037	Clalit Pediatric Clinic	Herzl St 20, Jerusalem
1096	2025-09-19	07:00:00	519814178	316	121065055	223034510	Meuhedet City Clinic	HaHistadrut St 124, Rehovot
1097	2025-04-28	18:15:00	195297250	297	111533007	644870997	Maccabi Health Center	Ben Gurion Blvd 43, Kfar Saba
1098	2025-08-10	08:00:00	755228375	284	300697114	323208385	Clalit Women's Clinic	Begin Blvd 34, Bnei Brak
1099	2025-06-10	14:15:00	250708248	32	767059275	\N	Clalit Women's Clinic	HaPalmach St 11, Holon
1100	2025-12-09	08:30:00	962605402	359	146240027	587248600	Clalit City Clinic	Begin Blvd 17, Ashkelon
1101	2025-05-02	14:15:00	944917553	148	691705874	\N	Maccabi Pediatric Clinic	Herzl St 12, Jerusalem
1102	2025-07-11	11:30:00	465944468	50	385321066	588485108	Meuhedet Health Center	Jabotinsky St 143, Holon
1103	2025-01-13	17:00:00	590818651	310	194967455	297714695	Leumit Clinic	HaYarkon St 124, Modiin
1104	2025-05-24	11:15:00	958722701	78	408394324	173735333	Clalit Women's Clinic	Rothschild Ave 6, Jerusalem
1105	2025-06-08	11:45:00	230624445	9	914566516	292563039	Maccabi Clinic	HaPalmach St 36, Tel Aviv
1106	2025-10-05	19:15:00	737208814	350	703776850	680422772	Leumit Pediatric Clinic	Weizmann St 74, Rishon LeZion
1107	2025-07-15	13:30:00	797569992	110	738536844	236536222	Maccabi Women's Clinic	HaYarkon St 77, Modiin
1108	2025-12-09	11:00:00	464558868	258	770359651	\N	Maccabi Pediatric Clinic	HaPalmach St 47, Netanya
1109	2025-11-25	14:45:00	724199106	169	188163518	867910701	Clalit Family Clinic	HaYarkon St 102, Bat Yam
1110	2025-03-14	13:30:00	306674982	175	936879403	523462070	Maccabi Family Clinic	HaHistadrut St 28, Rishon LeZion
1111	2025-05-10	16:15:00	409466719	65	765574491	\N	Leumit Clinic	Weizmann St 138, Bnei Brak
1112	2025-02-10	19:00:00	282408614	161	766537646	\N	Leumit Pediatric Clinic	Menachem Begin St 92, Jerusalem
1113	2025-04-06	13:15:00	978090247	227	960240840	674960706	Leumit Pediatric Clinic	HaNegev St 140, Bnei Brak
1114	2025-07-22	14:45:00	739103170	331	240709151	457148964	Meuhedet Women's Clinic	Menachem Begin St 122, Haifa
1115	2025-04-14	11:30:00	154227972	22	565737791	856141290	Maccabi Women's Clinic	Herzl St 16, Modiin
1116	2025-08-01	19:15:00	460087435	288	589073536	302016206	Meuhedet Family Clinic	Rothschild Ave 29, Jerusalem
1117	2025-06-20	15:30:00	322317846	53	723266609	788565519	Meuhedet Pediatric Clinic	Begin Blvd 73, Bnei Brak
1118	2025-10-12	11:45:00	546960294	378	936879403	152943249	Clalit Pediatric Clinic	HaPalmach St 37, Rehovot
1119	2025-02-06	07:45:00	263372945	137	808677201	\N	Meuhedet Family Clinic	Menachem Begin St 58, Rehovot
1120	2025-09-02	16:15:00	121433639	299	352089792	835357628	Leumit Health Center	HaPalmach St 78, Ashkelon
1121	2025-05-22	09:15:00	364653026	330	517697659	\N	Leumit Health Center	HaYarkon St 62, Bnei Brak
1122	2025-10-15	08:15:00	465944468	4	106210399	560761358	Clalit Family Clinic	Allenby St 103, Rishon LeZion
1123	2025-10-23	10:00:00	184019783	50	368803859	717220517	Meuhedet Pediatric Clinic	HaHistadrut St 65, Rehovot
1124	2025-10-27	17:00:00	358867112	390	822386902	\N	Clalit Health Center	Rothschild Ave 146, Modiin
1125	2025-08-24	10:30:00	297461390	54	427989892	876785540	Meuhedet Health Center	HaNegev St 139, Rehovot
1126	2025-06-05	18:00:00	135084311	362	581537784	590833948	Leumit Health Center	HaPalmach St 78, Ashkelon
1127	2025-08-01	06:00:00	300628794	101	738536844	913520210	Meuhedet City Clinic	HaPalmach St 122, Modiin
1128	2025-04-03	07:45:00	575650818	64	799258702	446763595	Leumit City Clinic	Sokolov St 97, Bnei Brak
1129	2025-02-25	06:00:00	582442635	94	427852785	173735333	Meuhedet Clinic	Rothschild Ave 94, Rehovot
1130	2025-12-14	19:00:00	537493895	340	204520642	475678577	Meuhedet Pediatric Clinic	Jabotinsky St 144, Herzliya
1131	2025-04-23	10:15:00	949677625	19	790255711	524957376	Clalit Women's Clinic	HaYarkon St 60, Ashkelon
1132	2025-04-18	07:30:00	894956091	388	314241360	125478540	Leumit Family Clinic	HaShalom Rd 39, Bat Yam
1133	2025-05-24	14:00:00	378410529	90	294557346	\N	Meuhedet City Clinic	HaYarkon St 15, Tel Aviv
1134	2025-01-14	11:45:00	122403164	313	589073536	153432684	Maccabi City Clinic	HaPalmach St 85, Beersheba
1135	2025-01-07	18:30:00	251420151	232	951108053	277362370	Maccabi Health Center	Weizmann St 25, Jerusalem
1136	2025-05-02	16:15:00	161764941	127	809797531	432026089	Leumit Pediatric Clinic	Begin Blvd 30, Herzliya
1137	2025-11-18	12:00:00	737208814	261	503075904	798009672	Leumit Clinic	HaNegev St 102, Tel Aviv
1138	2025-02-22	16:45:00	129762178	75	595351873	858675688	Maccabi Women's Clinic	Sokolov St 14, Petah Tikva
1139	2025-01-07	20:00:00	151948041	84	356308687	169095841	Leumit Women's Clinic	HaTikva St 38, Ramat Gan
1140	2025-05-21	09:30:00	762559306	160	983060617	210440926	Leumit Clinic	HaHistadrut St 139, Ra'anana
1141	2025-07-01	13:00:00	895576008	8	595351873	165928627	Maccabi Pediatric Clinic	Sokolov St 141, Herzliya
1142	2025-04-22	18:45:00	300036531	2	983060617	288012548	Leumit Clinic	HaHistadrut St 111, Netanya
1143	2025-06-15	09:45:00	794952734	153	775579062	\N	Meuhedet Clinic	Jabotinsky St 142, Kfar Saba
1144	2025-09-03	19:00:00	483346047	154	121065055	125478540	Clalit City Clinic	Weizmann St 77, Tel Aviv
1145	2025-02-17	06:15:00	463548843	391	896973596	485241165	Clalit Family Clinic	Allenby St 103, Rishon LeZion
1146	2025-10-25	06:15:00	298404492	67	623490063	\N	Meuhedet Women's Clinic	HaYarkon St 87, Jerusalem
1147	2025-11-27	11:00:00	920666292	298	427989892	\N	Clalit Health Center	HaTikva St 30, Rishon LeZion
1148	2025-04-27	07:45:00	538839225	246	808677201	233715310	Meuhedet Family Clinic	HaYarkon St 37, Bat Yam
1149	2025-08-01	18:00:00	653318684	235	523388008	990265405	Maccabi Pediatric Clinic	Begin Blvd 5, Rehovot
1150	2025-12-15	14:45:00	836728213	63	942705156	216674676	Clalit City Clinic	Begin Blvd 105, Bat Yam
1151	2025-10-06	15:30:00	352506228	158	766537646	578118209	Maccabi Pediatric Clinic	Herzl St 12, Jerusalem
1152	2025-12-04	16:15:00	871784867	4	738536844	264594643	Meuhedet Pediatric Clinic	HaShalom Rd 144, Petah Tikva
1153	2025-12-12	10:00:00	880103575	203	517697659	990265405	Maccabi Family Clinic	HaTikva St 49, Ramat Gan
1154	2025-01-22	18:15:00	348914405	317	809797531	307638987	Leumit Women's Clinic	HaTikva St 7, Modiin
1155	2025-09-07	16:45:00	945922559	113	790255711	\N	Maccabi City Clinic	HaYarkon St 142, Jerusalem
1156	2025-01-21	15:00:00	298404492	9	489601917	444687035	Meuhedet Health Center	HaHistadrut St 65, Netanya
1157	2025-12-01	19:45:00	180510182	14	278345196	\N	Maccabi Clinic	Herzl St 62, Netanya
1158	2025-12-13	12:30:00	843075942	266	188163518	452367681	Maccabi Women's Clinic	HaPalmach St 107, Holon
1159	2025-05-22	09:45:00	741059892	319	510716800	310449903	Leumit City Clinic	HaPalmach St 140, Kfar Saba
1160	2025-03-19	14:00:00	197148858	284	714051919	632667768	Leumit City Clinic	HaYarkon St 136, Holon
1161	2025-02-25	11:00:00	715266007	261	583133229	\N	Clalit Women's Clinic	HaPalmach St 11, Holon
1162	2025-11-05	13:45:00	322317846	342	530516374	266685039	Clalit Health Center	Herzl St 113, Bat Yam
1163	2025-07-21	16:00:00	653318684	301	757088646	535842430	Leumit Pediatric Clinic	HaShalom Rd 52, Modiin
1164	2025-06-02	13:00:00	748336036	252	870478094	931089150	Maccabi Clinic	Rothschild Ave 112, Bnei Brak
1165	2025-04-08	10:30:00	944917553	114	775579062	525443476	Leumit Family Clinic	Rothschild Ave 127, Petah Tikva
1166	2025-08-26	11:00:00	351451084	321	993263579	398331058	Maccabi Pediatric Clinic	HaNegev St 5, Ramat Gan
1167	2025-07-20	15:45:00	282408614	345	675610128	640036600	Meuhedet Women's Clinic	Ben Gurion Blvd 46, Modiin
1168	2025-06-24	08:15:00	502455034	344	410962502	457148964	Meuhedet City Clinic	HaPalmach St 122, Modiin
1169	2025-05-28	16:30:00	260362065	355	747832838	150886100	Leumit Women's Clinic	HaTikva St 38, Ramat Gan
1170	2025-02-14	10:00:00	184019783	266	188163518	153432684	Maccabi Pediatric Clinic	HaNegev St 149, Rishon LeZion
1171	2025-10-05	19:30:00	366900528	368	352089792	716745655	Maccabi Family Clinic	HaTikva St 49, Ramat Gan
1172	2025-01-22	13:45:00	457553650	26	375913224	136335319	Leumit City Clinic	HaPalmach St 140, Kfar Saba
1173	2025-10-04	12:00:00	294996591	229	757088646	379085236	Rambam Health Campus	HaYarkon St 65, Jerusalem
1174	2025-02-10	16:30:00	944917553	10	623490063	\N	Meuhedet Women's Clinic	HaPalmach St 110, Ashkelon
1175	2025-01-03	17:00:00	762364645	341	913568600	585034134	Leumit Family Clinic	Sokolov St 20, Ashdod
1176	2025-01-26	07:30:00	894548767	44	789955108	\N	Clalit Family Clinic	HaHistadrut St 97, Bat Yam
1177	2025-08-15	20:30:00	367818889	346	767059275	\N	Leumit City Clinic	Rothschild Ave 115, Herzliya
1178	2025-06-19	13:15:00	195297250	214	375913224	745929637	Leumit City Clinic	HaPalmach St 11, Haifa
1179	2025-01-09	19:45:00	232412113	44	205096731	421967560	Leumit City Clinic	HaPalmach St 140, Ra'anana
1180	2025-05-02	16:00:00	277537826	106	565737791	\N	Clalit Women's Clinic	HaTikva St 7, Ashdod
1181	2025-11-16	12:00:00	350031763	103	909580633	652055112	Leumit Pediatric Clinic	Begin Blvd 42, Bnei Brak
1182	2025-07-08	08:15:00	282408614	256	334099421	\N	Clalit Family Clinic	Begin Blvd 29, Kfar Saba
1183	2025-07-22	11:00:00	149181012	257	559056009	292563039	Meuhedet Family Clinic	Menachem Begin St 58, Rehovot
1184	2025-09-25	13:15:00	593065946	383	459613663	991202503	Maccabi Family Clinic	Weizmann St 118, Ashkelon
1185	2025-11-24	15:30:00	168877637	93	927916320	\N	Ziv Medical Center	HaPalmach St 114, Holon
1186	2025-11-23	15:30:00	248993596	113	927468908	484495578	Maccabi Women's Clinic	HaYarkon St 77, Modiin
1187	2025-01-12	10:45:00	903260938	94	909580633	446763595	Meuhedet Health Center	Weizmann St 43, Rishon LeZion
1188	2025-09-02	09:15:00	749132937	318	160913893	223034510	Leumit Clinic	HaNegev St 102, Tel Aviv
1189	2025-10-17	06:15:00	638913607	54	909580633	300885051	Clalit City Clinic	HaYarkon St 105, Herzliya
1190	2025-02-21	16:00:00	526256593	342	188163518	123889591	Clalit Family Clinic	HaYarkon St 28, Bat Yam
1191	2025-04-28	07:00:00	439631560	30	335528238	186854746	Clalit Pediatric Clinic	HaYarkon St 84, Bnei Brak
1192	2025-07-10	10:30:00	503988129	164	876946737	\N	Meuhedet Clinic	Jabotinsky St 142, Kfar Saba
1193	2025-04-26	13:30:00	890176770	277	335569735	106823913	Clalit Clinic	HaHistadrut St 71, Ashkelon
1194	2025-05-26	16:30:00	375159255	57	427989892	739732268	Hadassah Ein Kerem Hospital	Herzl St 24, Haifa
1195	2025-09-07	17:45:00	409466719	208	480434918	\N	Leumit City Clinic	HaTikva St 108, Ramat Gan
1196	2025-10-11	10:30:00	355235662	195	236786603	297714695	Meuhedet Family Clinic	HaShalom Rd 80, Bat Yam
1197	2025-06-28	07:45:00	135084311	98	510716800	919941861	Leumit City Clinic	Jabotinsky St 124, Haifa
1198	2025-11-24	12:30:00	833485809	254	951108053	793942949	Meuhedet Pediatric Clinic	HaPalmach St 113, Jerusalem
1199	2025-04-05	07:45:00	542415875	32	869278628	114916894	Clalit Pediatric Clinic	Herzl St 20, Jerusalem
1200	2025-05-23	20:00:00	510369863	265	705338121	788565519	Maccabi Health Center	HaHistadrut St 56, Jerusalem
1201	2025-09-05	11:15:00	151948041	366	152785861	236536222	Maccabi Pediatric Clinic	Ben Gurion Blvd 17, Modiin
1202	2025-05-24	12:15:00	329416185	387	587927685	674960706	Maccabi Women's Clinic	Menachem Begin St 93, Haifa
1203	2025-10-28	16:45:00	836728213	1	312816743	\N	Maccabi Family Clinic	Sokolov St 11, Rehovot
1204	2025-06-12	07:30:00	741606378	162	936879403	134938340	Leumit Women's Clinic	HaNegev St 149, Ramat Gan
1205	2025-09-04	10:45:00	409466719	68	314241360	307638987	Clalit City Clinic	Begin Blvd 105, Bat Yam
1206	2025-10-06	10:00:00	213596569	131	130440929	545281216	Meuhedet City Clinic	Allenby St 124, Rishon LeZion
1207	2025-12-23	06:45:00	505288440	376	651938317	717220517	Meuhedet Health Center	HaNegev St 36, Herzliya
1208	2025-10-22	10:45:00	156313275	112	510716800	228630954	Leumit Clinic	HaNegev St 42, Herzliya
1209	2025-06-12	16:00:00	970296727	376	747832838	634188128	Leumit City Clinic	Weizmann St 138, Modiin
1210	2025-03-08	17:30:00	326216990	208	246927292	500823705	Clalit Women's Clinic	HaHistadrut St 148, Ramat Gan
1211	2025-11-01	14:45:00	862445507	267	303635805	877651756	Clalit Pediatric Clinic	Sokolov St 44, Ra'anana
1212	2025-06-23	07:30:00	514692698	336	106107388	856141290	Leumit City Clinic	HaTikva St 78, Petah Tikva
1213	2025-05-22	08:45:00	844513515	188	835425519	636489403	Clalit Women's Clinic	HaPalmach St 11, Holon
1214	2025-07-07	07:15:00	949677625	223	952751158	\N	Hadassah Ein Kerem Hospital	Herzl St 24, Haifa
1215	2025-05-14	15:00:00	251420151	78	204520642	642573144	Meuhedet Women's Clinic	HaHistadrut St 126, Netanya
1216	2025-10-21	18:00:00	914894458	371	565425153	720046881	Clalit Women's Clinic	HaTikva St 133, Beersheba
1217	2025-12-01	09:30:00	189128964	198	602013357	181098189	Leumit Clinic	HaTikva St 113, Beersheba
1218	2025-05-24	08:15:00	721698371	219	517697659	877651756	Maccabi Pediatric Clinic	HaTikva St 63, Modiin
1219	2025-10-25	13:30:00	420061429	283	408394324	\N	Leumit Health Center	Jabotinsky St 37, Ra'anana
1220	2025-10-23	17:15:00	122403164	142	294557346	134938340	Meuhedet City Clinic	HaTikva St 144, Ashkelon
1221	2025-02-11	19:30:00	230624445	308	927916320	692757934	Leumit Clinic	Weizmann St 37, Bnei Brak
1222	2025-04-08	11:15:00	350031763	390	130440929	919941861	Leumit Family Clinic	Ben Gurion Blvd 21, Bat Yam
1223	2025-08-22	19:00:00	914894458	205	571289027	\N	Leumit Clinic	Herzl St 73, Modiin
1224	2025-10-08	10:15:00	977648192	36	355020965	585034134	Clalit Women's Clinic	HaHistadrut St 148, Ramat Gan
1225	2025-02-23	19:30:00	486579729	250	286582552	523462070	Leumit City Clinic	HaYarkon St 136, Holon
1226	2025-09-03	19:45:00	811725293	92	668035126	150886100	Clalit Family Clinic	Menachem Begin St 26, Bat Yam
1227	2025-06-27	10:15:00	163977003	400	127373899	499722276	Meuhedet City Clinic	Jabotinsky St 71, Jerusalem
1228	2025-06-13	12:45:00	916939137	380	503075904	886553988	Leumit Health Center	Jabotinsky St 37, Ra'anana
1229	2025-08-10	11:30:00	741059892	235	569080510	641246037	Clalit City Clinic	Jabotinsky St 41, Bnei Brak
1230	2025-12-04	07:45:00	946244382	353	678506268	467683186	Leumit City Clinic	Sokolov St 97, Bnei Brak
1231	2025-11-01	16:45:00	928091898	122	583133229	642573144	Leumit Pediatric Clinic	Herzl St 142, Kfar Saba
1232	2025-06-26	14:00:00	733226714	11	775579062	641246037	Leumit Clinic	HaYarkon St 124, Modiin
1233	2025-09-13	17:00:00	256086565	128	648046509	405385808	Meuhedet Health Center	Jabotinsky St 78, Herzliya
1234	2025-10-07	07:00:00	533354204	319	646651118	330948886	Maccabi Pediatric Clinic	HaNegev St 149, Rishon LeZion
1235	2025-08-13	07:15:00	632274169	264	575013098	877651756	Leumit Health Center	Rothschild Ave 85, Ramat Gan
1236	2025-08-09	10:00:00	727330871	372	469439493	691399121	Maccabi Pediatric Clinic	Ben Gurion Blvd 17, Modiin
1237	2025-06-17	20:45:00	868919607	79	870880025	\N	Clalit Clinic	Ben Gurion Blvd 111, Beersheba
1238	2025-03-15	16:00:00	290221251	240	581537784	379926927	Clalit Family Clinic	HaHistadrut St 19, Holon
1239	2025-07-27	17:45:00	974746813	235	933176850	567352637	Maccabi Pediatric Clinic	HaPalmach St 49, Bat Yam
1240	2025-06-24	12:45:00	163977003	108	127373899	\N	Maccabi Women's Clinic	HaYarkon St 77, Modiin
1241	2025-08-25	20:45:00	978090247	275	790255711	946589413	Leumit Pediatric Clinic	Sokolov St 30, Petah Tikva
1242	2025-03-20	07:30:00	206768692	74	765574491	153432684	Meuhedet City Clinic	HaTikva St 144, Ashkelon
1243	2025-07-13	19:30:00	326216990	250	339014530	222522748	Meuhedet Health Center	Weizmann St 40, Haifa
1244	2025-10-17	14:30:00	287043819	388	494708371	\N	Meuhedet Clinic	HaYarkon St 62, Ramat Gan
1245	2025-11-02	08:45:00	287043819	256	160913893	\N	Meuhedet City Clinic	Rothschild Ave 131, Ashdod
1246	2025-11-25	10:15:00	662729589	310	127373899	977667032	Leumit Clinic	Herzl St 73, Modiin
1247	2025-07-17	17:15:00	464558868	320	766537646	578303296	Maccabi Health Center	HaTikva St 86, Holon
1248	2025-02-13	13:30:00	299085717	126	893399035	467137650	Clalit Women's Clinic	HaTikva St 7, Ashdod
1249	2025-07-14	17:15:00	862048623	309	789955108	803631502	Meuhedet Clinic	Sokolov St 68, Bat Yam
1250	2025-10-27	11:45:00	689825727	208	493394881	413603064	Meuhedet Family Clinic	HaNegev St 74, Petah Tikva
1251	2025-07-27	16:00:00	993112782	82	375218533	499722276	Maccabi Family Clinic	HaNegev St 59, Rehovot
1252	2025-08-05	16:15:00	322279900	347	757088646	300885051	Clalit Pediatric Clinic	Herzl St 20, Jerusalem
1253	2025-07-14	18:30:00	299085717	142	495900140	535842430	Clalit Women's Clinic	Herzl St 44, Haifa
1254	2025-12-21	16:00:00	251420151	277	767059275	967167857	Leumit City Clinic	Weizmann St 138, Modiin
1255	2025-07-06	14:30:00	299229343	17	469439493	\N	Maccabi City Clinic	Ben Gurion Blvd 61, Bnei Brak
1256	2025-11-10	20:45:00	849864109	391	459613663	627217360	Clalit Pediatric Clinic	Sokolov St 44, Ra'anana
1257	2025-07-13	06:45:00	331181020	207	686931483	632667768	Meuhedet Family Clinic	HaHistadrut St 144, Beersheba
1258	2025-08-25	12:00:00	583707574	46	390750761	793942949	Meuhedet Family Clinic	Rothschild Ave 29, Jerusalem
1259	2025-09-01	20:30:00	306674982	86	337501464	515517676	Clalit Pediatric Clinic	HaHistadrut St 50, Rehovot
1260	2025-06-16	10:00:00	189791206	139	767059275	950189399	Meuhedet Women's Clinic	Sokolov St 23, Bat Yam
1261	2025-12-17	06:00:00	197148858	287	952751158	946589413	Meuhedet Pediatric Clinic	Menachem Begin St 23, Haifa
1262	2025-10-10	19:15:00	297461390	143	896973596	652055112	Maccabi Women's Clinic	Herzl St 74, Holon
1263	2025-05-05	13:30:00	890970312	318	188163518	587248600	Meuhedet Pediatric Clinic	Allenby St 8, Modiin
1264	2025-11-16	15:45:00	300628794	54	914566516	627217360	Meuhedet Clinic	Sokolov St 68, Bat Yam
1265	2025-01-21	06:15:00	292169783	213	157794649	958396544	Meuhedet Pediatric Clinic	Jabotinsky St 60, Bat Yam
1266	2025-01-15	06:30:00	388934046	236	581537784	\N	Meuhedet Pediatric Clinic	HaShalom Rd 144, Petah Tikva
1267	2025-07-23	20:00:00	420061429	180	832006368	674960706	Maccabi Women's Clinic	HaYarkon St 96, Kfar Saba
1268	2025-01-09	16:00:00	797569992	175	675610128	\N	Meuhedet City Clinic	Allenby St 124, Rishon LeZion
1269	2025-09-21	11:30:00	124782507	299	967238983	162854543	Clalit Clinic	Menachem Begin St 121, Jerusalem
1270	2025-06-06	08:00:00	253196823	133	571289027	398331058	Leumit Women's Clinic	Ben Gurion Blvd 116, Rehovot
1271	2025-04-26	12:45:00	715266007	180	767059275	560761358	Meuhedet Pediatric Clinic	Herzl St 134, Holon
1272	2025-07-01	09:15:00	243794689	319	327338690	588485108	Maccabi Women's Clinic	Herzl St 112, Tel Aviv
1273	2025-04-22	14:00:00	504527711	321	277290510	744541166	Clalit Family Clinic	HaNegev St 107, Bat Yam
1274	2025-03-03	18:30:00	724199106	323	799258702	379926927	Meuhedet Family Clinic	HaPalmach St 19, Rishon LeZion
1275	2025-10-25	10:30:00	963025761	305	508895013	744541166	Leumit Women's Clinic	Ben Gurion Blvd 42, Bat Yam
1276	2025-01-03	15:45:00	333409051	39	188163518	165928627	Meuhedet City Clinic	HaHistadrut St 124, Rehovot
1277	2025-08-18	20:15:00	463548843	347	390750761	297714695	Clalit Women's Clinic	Rothschild Ave 6, Jerusalem
1278	2025-01-06	19:30:00	367818889	192	195106131	620872913	Meuhedet Family Clinic	Menachem Begin St 148, Bat Yam
1279	2025-01-25	09:00:00	844513515	51	678506268	717220517	Maccabi Clinic	HaYarkon St 94, Ashdod
1280	2025-04-20	08:15:00	206768692	339	106107388	867910701	Maccabi Family Clinic	Herzl St 103, Jerusalem
1281	2025-03-07	12:45:00	195297250	223	565425153	803631502	Maccabi Health Center	HaTikva St 93, Beersheba
1282	2025-10-11	12:45:00	504527711	136	355020965	560761358	Clalit Pediatric Clinic	HaPalmach St 44, Ashdod
1283	2025-08-22	09:15:00	694810573	1	471674082	798009672	Meuhedet Family Clinic	Rothschild Ave 36, Herzliya
1284	2025-04-17	09:30:00	490061917	174	902246089	114916894	Maccabi Family Clinic	Herzl St 145, Jerusalem
1285	2025-09-23	09:00:00	949677625	100	523388008	379085236	Meuhedet Family Clinic	Menachem Begin St 58, Rehovot
1286	2025-08-03	19:15:00	253196823	128	240709151	974562766	Leumit Women's Clinic	HaTikva St 38, Ramat Gan
1287	2025-03-05	18:15:00	364653026	40	492050992	578303296	Meuhedet City Clinic	Rothschild Ave 66, Petah Tikva
1288	2025-03-03	14:00:00	796091497	179	385015287	578118209	Soroka Medical Center	HaYarkon St 6, Ashdod
1289	2025-11-26	19:00:00	101565191	273	896973596	\N	Meuhedet Women's Clinic	Menachem Begin St 122, Haifa
1290	2025-09-14	12:45:00	185818355	94	236786603	974562766	Leumit Pediatric Clinic	HaNegev St 140, Bnei Brak
1291	2025-12-27	06:00:00	358393463	233	961074382	406350060	Leumit City Clinic	Begin Blvd 72, Ramat Gan
1292	2025-07-28	08:30:00	749132937	365	723266609	637417326	Leumit Health Center	Herzl St 52, Jerusalem
1293	2025-11-03	17:45:00	504527711	171	648046509	112742705	Maccabi Health Center	HaYarkon St 132, Ashdod
1294	2025-04-05	20:45:00	253196823	50	452354109	621805679	Meuhedet Clinic	HaYarkon St 62, Ramat Gan
1295	2025-08-25	20:00:00	290221251	387	595351873	297714695	Clalit Women's Clinic	Sokolov St 96, Ashkelon
1296	2025-06-01	19:45:00	678621121	179	447168611	990265405	Maccabi Health Center	HaTikva St 63, Jerusalem
1297	2025-07-03	07:30:00	542415875	22	427989892	228630954	Clalit City Clinic	Begin Blvd 105, Bat Yam
1298	2025-09-02	10:45:00	178288655	373	581537784	136335319	Maccabi Pediatric Clinic	HaPalmach St 47, Netanya
1299	2025-09-21	20:30:00	812170410	77	414316626	291145247	Meuhedet Clinic	Jabotinsky St 142, Kfar Saba
1300	2025-07-08	16:00:00	587398835	154	860923150	499722276	Meuhedet Clinic	Begin Blvd 140, Bat Yam
1301	2025-02-26	14:30:00	813482571	308	390750761	379085236	Rambam Health Campus	HaYarkon St 65, Jerusalem
1302	2025-04-23	10:30:00	418541884	41	723266609	718179719	Maccabi Pediatric Clinic	Ben Gurion Blvd 68, Herzliya
1303	2025-07-20	09:45:00	498056409	391	152785861	358890331	Clalit Family Clinic	HaShalom Rd 22, Ra'anana
1304	2025-04-23	12:00:00	382178937	299	494708371	991202503	Clalit Women's Clinic	HaTikva St 139, Rishon LeZion
1305	2025-05-12	08:00:00	287218285	254	933176850	421967560	Meuhedet Health Center	Weizmann St 43, Rishon LeZion
1306	2025-04-16	08:45:00	333409051	230	503075904	958396544	Maccabi City Clinic	HaTikva St 148, Haifa
1307	2025-01-26	10:45:00	526256593	199	316396883	\N	Leumit Family Clinic	Ben Gurion Blvd 24, Tel Aviv
1308	2025-01-12	17:15:00	760208651	352	236786603	379926927	Leumit Women's Clinic	Ben Gurion Blvd 141, Ashkelon
1309	2025-01-19	07:45:00	463857918	28	860923150	543138407	Meuhedet Family Clinic	HaShalom Rd 80, Bat Yam
1310	2025-02-02	20:45:00	139889274	291	582888025	\N	Clalit Family Clinic	HaHistadrut St 97, Bat Yam
1311	2025-04-24	06:45:00	753729185	151	767059275	621805679	Clalit Family Clinic	Allenby St 100, Haifa
1312	2025-06-20	14:45:00	614959631	240	548621554	134938340	Meuhedet Health Center	Jabotinsky St 37, Rishon LeZion
1313	2025-01-22	19:30:00	490061917	188	582888025	928678498	Meuhedet City Clinic	HaTikva St 144, Ashkelon
1314	2025-05-06	16:00:00	469589167	269	503075904	205288611	Meuhedet Clinic	Jabotinsky St 142, Kfar Saba
1315	2025-08-01	09:00:00	213596569	156	770359651	302016206	Clalit Health Center	Herzl St 113, Bat Yam
1316	2025-07-13	13:15:00	247145715	125	587927685	\N	Meuhedet Pediatric Clinic	Allenby St 8, Modiin
1317	2025-02-03	07:15:00	460087435	61	983060617	500823705	Leumit Health Center	Sokolov St 32, Herzliya
1318	2025-05-19	12:15:00	590652532	178	493394881	705808415	Clalit Family Clinic	Allenby St 29, Holon
1319	2025-05-20	18:30:00	637152102	398	405648081	799658255	Leumit Clinic	Weizmann St 138, Bnei Brak
1320	2025-03-07	14:00:00	300036531	265	215791975	627217360	Leumit City Clinic	HaShalom Rd 123, Ra'anana
1321	2025-04-05	18:30:00	603632562	71	132264095	642573144	Maccabi Clinic	Ben Gurion Blvd 128, Ashkelon
1322	2025-08-08	12:00:00	383641443	352	311784393	788565519	Leumit Family Clinic	Sokolov St 110, Netanya
1323	2025-12-26	14:45:00	518986031	340	602013357	310449903	Meuhedet Clinic	Rothschild Ave 113, Rishon LeZion
1325	2025-07-11	20:45:00	574857929	223	565737791	205288611	Meuhedet Women's Clinic	Ben Gurion Blvd 46, Modiin
1326	2025-10-19	10:45:00	163350630	281	580038886	974562766	Clalit Pediatric Clinic	HaPalmach St 37, Rehovot
1327	2025-01-19	17:45:00	796091497	173	116809193	169095841	Maccabi Health Center	HaShalom Rd 53, Bnei Brak
1328	2025-03-14	14:45:00	155898237	326	596823946	300885051	Leumit Health Center	Rothschild Ave 85, Ramat Gan
1329	2025-04-09	20:30:00	590778593	263	110532551	210440926	Maccabi Pediatric Clinic	HaNegev St 149, Rishon LeZion
1330	2025-08-01	12:00:00	287218285	220	160913893	803631502	Clalit Women's Clinic	HaTikva St 7, Ashdod
1331	2025-08-22	20:30:00	464558868	135	469439493	333012046	Leumit City Clinic	Begin Blvd 72, Ramat Gan
1332	2025-02-15	10:00:00	603369296	381	447168611	595566634	Meuhedet Pediatric Clinic	HaShalom Rd 144, Petah Tikva
1333	2025-06-27	11:30:00	275062263	87	623490063	379926927	Meuhedet City Clinic	Begin Blvd 64, Tel Aviv
1334	2025-11-17	14:45:00	196728836	340	294557346	164347844	Maccabi Women's Clinic	Menachem Begin St 93, Haifa
1335	2025-12-20	15:45:00	135084311	76	670632947	139987077	Clalit Pediatric Clinic	Sokolov St 136, Rehovot
1336	2025-06-19	18:45:00	178288655	37	103198638	876785540	Meuhedet Family Clinic	HaPalmach St 19, Rishon LeZion
1337	2025-04-14	08:45:00	694810573	152	355020965	300685875	Leumit Women's Clinic	Ben Gurion Blvd 76, Rehovot
1338	2025-09-21	17:45:00	558919861	37	869029092	\N	Leumit Clinic	Herzl St 73, Modiin
1339	2025-10-06	11:00:00	368041638	291	385015287	193901152	Maccabi Pediatric Clinic	Weizmann St 60, Rishon LeZion
1340	2025-09-28	12:00:00	111387179	70	335569735	634188128	Meuhedet Clinic	Rothschild Ave 113, Rishon LeZion
1341	2025-12-09	08:45:00	189128964	389	583133229	652055112	Leumit City Clinic	Ben Gurion Blvd 25, Ramat Gan
1342	2025-12-06	18:45:00	614959631	285	130440929	636489403	Meuhedet City Clinic	Jabotinsky St 71, Jerusalem
1343	2025-03-20	09:15:00	196728836	289	738536844	310258592	Leumit Pediatric Clinic	HaYarkon St 95, Rishon LeZion
1344	2025-02-08	15:15:00	814690335	46	378127589	835357628	Clalit Women's Clinic	Sokolov St 96, Ashkelon
1345	2025-05-09	19:00:00	794952734	216	517697659	104731999	Leumit Health Center	Weizmann St 145, Petah Tikva
1346	2025-09-02	20:45:00	946254016	303	421289999	310258592	Leumit Women's Clinic	Begin Blvd 39, Rishon LeZion
1347	2025-08-19	09:15:00	400850159	186	349943042	\N	Maccabi Clinic	Rothschild Ave 112, Bnei Brak
1348	2025-07-02	10:15:00	242098030	213	565737791	567352637	Meuhedet Pediatric Clinic	HaHistadrut St 44, Bnei Brak
1349	2025-01-16	14:00:00	172001273	354	361945520	694876741	Clalit City Clinic	Herzl St 84, Netanya
1350	2025-12-05	12:30:00	593065946	169	762854976	718179719	Meuhedet Pediatric Clinic	HaHistadrut St 91, Haifa
1351	2025-11-03	10:30:00	970296727	265	262180529	\N	Meuhedet City Clinic	Menachem Begin St 90, Tel Aviv
1352	2025-02-16	08:00:00	177702985	380	127373899	484495578	Clalit Clinic	Jabotinsky St 56, Ashdod
1353	2025-07-26	14:30:00	283767201	349	132264095	\N	Meuhedet Pediatric Clinic	HaHistadrut St 91, Haifa
1354	2025-01-17	10:15:00	752098694	393	765574491	\N	Maccabi Pediatric Clinic	HaTikva St 63, Modiin
1355	2025-08-14	12:15:00	122403164	105	151385895	798009672	Meuhedet City Clinic	Menachem Begin St 90, Tel Aviv
1356	2025-10-14	10:15:00	637152102	371	722223783	\N	Meuhedet Women's Clinic	HaHistadrut St 126, Netanya
1357	2025-05-13	20:30:00	546960294	274	390750761	919941861	Maccabi Health Center	HaShalom Rd 53, Bnei Brak
1358	2025-09-17	17:15:00	490061917	284	311784393	297714695	Meuhedet Family Clinic	HaNegev St 74, Petah Tikva
1359	2025-05-25	09:30:00	530709488	69	789955108	557387584	Meuhedet Family Clinic	HaPalmach St 19, Rishon LeZion
1360	2025-08-24	07:30:00	916917936	7	410254424	146343109	Maccabi Pediatric Clinic	Sokolov St 141, Herzliya
1361	2025-08-09	14:00:00	586562174	398	355020965	785743985	Maccabi Women's Clinic	Sokolov St 74, Bnei Brak
1362	2025-02-09	07:15:00	258775091	10	231324781	455096535	Shaare Zedek Medical Center	HaNegev St 69, Netanya
1363	2025-05-15	09:00:00	506237409	353	646651118	\N	Leumit Clinic	HaYarkon St 130, Petah Tikva
1364	2025-03-23	14:00:00	431925566	5	215791975	636489403	Leumit Clinic	HaPalmach St 24, Ra'anana
1365	2025-01-12	08:45:00	593065946	110	747832838	\N	Clalit Health Center	Allenby St 46, Jerusalem
1366	2025-10-06	17:30:00	533476073	302	646651118	717220517	Meuhedet City Clinic	Allenby St 124, Rishon LeZion
1367	2025-12-16	18:00:00	518986031	24	162929677	358890331	Clalit Pediatric Clinic	HaPalmach St 44, Ashdod
1368	2025-09-19	13:15:00	299229343	306	480434918	\N	Leumit City Clinic	HaYarkon St 136, Holon
1369	2025-02-28	18:00:00	486579729	51	316396883	587248600	Meuhedet Women's Clinic	Ben Gurion Blvd 119, Holon
1370	2025-06-07	14:30:00	537493895	354	195106131	154749464	Shaare Zedek Medical Center	HaNegev St 69, Netanya
1371	2025-07-12	18:15:00	360443298	217	967238983	974562766	Meuhedet Health Center	Weizmann St 123, Ashdod
1518	2025-06-03	11:15:00	258775091	307	427989892	732231442	Leumit Clinic	HaNegev St 42, Herzliya
1372	2025-08-27	14:15:00	738045160	382	339014530	\N	Leumit Women's Clinic	Ben Gurion Blvd 141, Ashkelon
1373	2025-10-05	12:45:00	582442635	168	762854976	379085236	Clalit Health Center	Weizmann St 13, Haifa
1374	2025-09-18	19:00:00	583707574	127	231324781	608281507	Clalit Family Clinic	HaNegev St 15, Holon
1375	2025-08-19	14:15:00	123928798	260	523388008	876785540	Clalit Family Clinic	HaYarkon St 28, Bat Yam
1376	2025-04-02	06:15:00	733454157	377	262180529	\N	Rambam Health Campus	HaYarkon St 65, Jerusalem
1377	2025-10-01	13:30:00	814384608	96	939238672	652055112	Leumit Health Center	Allenby St 40, Bnei Brak
1378	2025-09-07	17:15:00	903260938	282	767059275	\N	Maccabi Clinic	HaNegev St 74, Ramat Gan
1379	2025-10-25	17:00:00	607933636	118	583133229	636489403	Meuhedet Clinic	Rothschild Ave 130, Rishon LeZion
1380	2025-09-23	07:30:00	796091497	177	577645975	468701304	Maccabi Health Center	HaYarkon St 132, Ashdod
1381	2025-11-06	06:45:00	504527711	337	106210399	330948886	Meuhedet Women's Clinic	Sokolov St 58, Beersheba
1382	2025-04-07	10:30:00	290221251	72	215791975	560761358	Meuhedet Family Clinic	HaHistadrut St 74, Haifa
1383	2025-06-26	11:45:00	170140414	208	494708371	595566634	Leumit City Clinic	HaTikva St 78, Petah Tikva
1384	2025-06-16	15:30:00	748336036	395	493394881	705808415	Meuhedet Women's Clinic	Sokolov St 115, Tel Aviv
1385	2025-06-08	06:30:00	274894140	400	602013357	106374385	Maccabi Pediatric Clinic	HaYarkon St 111, Beersheba
1386	2025-06-20	17:15:00	814690335	372	775579062	\N	Meuhedet Pediatric Clinic	Jabotinsky St 60, Bat Yam
1387	2025-02-09	14:45:00	591879309	188	738536844	358401641	Leumit Women's Clinic	HaNegev St 149, Ramat Gan
1388	2025-04-21	14:00:00	221634502	75	913568600	692757934	Meuhedet Women's Clinic	Rothschild Ave 1, Tel Aviv
1389	2025-05-09	18:30:00	916939137	201	993263579	\N	Maccabi Family Clinic	Rothschild Ave 32, Rishon LeZion
1390	2025-07-15	07:30:00	752098694	237	244282748	139987077	Maccabi Clinic	Allenby St 129, Rehovot
1391	2025-01-22	17:15:00	890970312	3	575013098	421967560	Meuhedet Clinic	Rothschild Ave 113, Rishon LeZion
1392	2025-09-07	18:15:00	836728213	368	646651118	\N	Clalit Pediatric Clinic	Sokolov St 136, Rehovot
1393	2025-12-27	13:00:00	836728213	221	565425153	186854746	Meuhedet City Clinic	Sokolov St 95, Ashkelon
1394	2025-04-10	08:15:00	329416185	325	350299663	770913744	Maccabi Family Clinic	Jabotinsky St 5, Rehovot
1395	2025-10-03	08:15:00	962605402	373	246927292	164347844	Ichilov Hospital	Rothschild Ave 148, Beersheba
1396	2025-02-14	11:30:00	632274169	275	762854976	\N	Meuhedet Clinic	Rothschild Ave 94, Rehovot
1397	2025-03-27	10:45:00	116338238	281	762854976	523195752	Clalit Family Clinic	Ben Gurion Blvd 143, Bnei Brak
1398	2025-07-03	18:45:00	343278287	175	801483903	560761358	Leumit Health Center	Rothschild Ave 85, Ramat Gan
1399	2025-05-06	08:45:00	275062263	232	808943895	\N	Clalit City Clinic	HaTikva St 80, Bat Yam
1400	2025-01-05	06:30:00	844888238	356	339014530	484495578	Clalit Women's Clinic	Begin Blvd 56, Rishon LeZion
1401	2025-11-10	17:30:00	627627838	79	747832838	798009672	Clalit Women's Clinic	Begin Blvd 76, Petah Tikva
1402	2025-03-14	11:30:00	670190917	93	106210399	302016206	Meuhedet Health Center	Weizmann St 123, Ashdod
1403	2025-03-26	16:30:00	754600805	188	146240027	567352637	Leumit Pediatric Clinic	Jabotinsky St 76, Tel Aviv
1404	2025-08-17	08:00:00	739103170	182	581537784	223034510	Meuhedet City Clinic	Rothschild Ave 131, Ashdod
1405	2025-06-02	16:00:00	360443298	266	231324781	200778361	Leumit Family Clinic	Sokolov St 110, Netanya
1406	2025-11-05	10:45:00	254630730	368	770359651	302016206	Leumit Women's Clinic	HaHistadrut St 41, Haifa
1407	2025-05-23	15:00:00	762364645	290	762854976	379085236	Clalit City Clinic	Jabotinsky St 41, Bnei Brak
1408	2025-04-25	09:45:00	322317846	332	282498842	549041678	Maccabi Health Center	Weizmann St 25, Jerusalem
1409	2025-03-04	14:15:00	375159255	177	165682443	569598179	Leumit Family Clinic	Allenby St 12, Ramat Gan
1410	2025-01-20	15:00:00	367818889	14	339014530	974562766	Maccabi Women's Clinic	HaYarkon St 96, Kfar Saba
1411	2025-11-01	08:30:00	131666625	51	646651118	578118209	Maccabi Pediatric Clinic	HaNegev St 149, Rishon LeZion
1412	2025-07-27	09:30:00	632577955	126	240709151	567352637	Clalit Family Clinic	HaNegev St 61, Bat Yam
1413	2025-03-20	08:15:00	814384608	17	762854976	743393691	Maccabi Clinic	Menachem Begin St 21, Bat Yam
1414	2025-09-02	20:45:00	292536682	255	651938317	\N	Leumit Family Clinic	Ben Gurion Blvd 2, Modiin
1415	2025-07-19	16:30:00	754600805	268	152785861	\N	Clalit City Clinic	Sokolov St 78, Herzliya
1416	2025-02-07	18:45:00	894548767	339	492050992	913520210	Maccabi Clinic	HaYarkon St 94, Ashdod
1417	2025-12-05	20:15:00	652037078	211	530516374	525443476	Clalit Women's Clinic	Menachem Begin St 136, Ramat Gan
1418	2025-01-23	17:45:00	263372945	194	651447743	\N	Meuhedet Health Center	Weizmann St 40, Haifa
1419	2025-06-04	17:45:00	519814178	370	503075904	\N	Leumit Pediatric Clinic	Begin Blvd 30, Herzliya
1420	2025-03-15	12:30:00	877834494	74	740682739	857599583	Clalit Pediatric Clinic	Ben Gurion Blvd 61, Holon
1421	2025-05-21	11:15:00	431925566	160	170476311	692757934	Leumit City Clinic	HaPalmach St 109, Modiin
1422	2025-07-28	16:00:00	129762178	20	355020965	310449903	Meuhedet Women's Clinic	Ben Gurion Blvd 119, Holon
1423	2025-10-11	11:45:00	871784867	77	459613663	798009672	Meuhedet Pediatric Clinic	Allenby St 48, Haifa
1424	2025-06-17	19:15:00	170140414	116	571289027	720046881	Maccabi Pediatric Clinic	Sokolov St 141, Herzliya
1425	2025-10-17	19:45:00	426410380	214	493394881	\N	Maccabi Women's Clinic	HaPalmach St 107, Holon
1426	2025-10-11	18:15:00	299229343	311	162929677	\N	Leumit Women's Clinic	Ben Gurion Blvd 76, Rehovot
1427	2025-11-04	11:30:00	177702985	317	405648081	302016206	Leumit City Clinic	Jabotinsky St 124, Haifa
1428	2025-11-20	07:00:00	844513515	332	722223783	928678498	Maccabi Health Center	Weizmann St 98, Ashkelon
1429	2025-09-22	14:30:00	350031763	106	106210399	\N	Meuhedet Health Center	HaNegev St 139, Rehovot
1430	2025-06-09	06:30:00	981257093	77	890623488	967167857	Leumit Health Center	Allenby St 40, Bnei Brak
1431	2025-08-15	11:15:00	533476073	70	960240840	291145247	Clalit City Clinic	HaTikva St 80, Bat Yam
1432	2025-09-20	10:30:00	494804448	28	314241360	523462070	Maccabi City Clinic	HaPalmach St 85, Beersheba
1433	2025-09-14	16:45:00	472314962	199	896973596	590833948	Clalit Clinic	Menachem Begin St 121, Jerusalem
1434	2025-05-24	17:45:00	483346047	75	375913224	\N	Leumit Health Center	Jabotinsky St 124, Holon
1435	2025-01-20	11:45:00	431782073	218	595351873	391559775	Maccabi Pediatric Clinic	Sokolov St 62, Petah Tikva
1436	2025-03-25	17:15:00	420061429	26	110532551	297714695	Leumit City Clinic	HaPalmach St 140, Kfar Saba
1437	2025-02-26	15:45:00	926419142	75	809797531	\N	Meuhedet Family Clinic	Rothschild Ave 29, Jerusalem
1438	2025-03-15	08:00:00	195297250	203	582888025	652055112	Meuhedet Family Clinic	Rothschild Ave 36, Herzliya
1439	2025-07-02	08:45:00	378410529	11	111533007	\N	Clalit Family Clinic	Allenby St 29, Holon
1440	2025-02-14	07:00:00	180510182	27	909580633	928678498	Maccabi Health Center	HaHistadrut St 56, Jerusalem
1441	2025-05-28	09:30:00	207067497	241	765921635	642573144	Maccabi Women's Clinic	Herzl St 16, Modiin
1442	2025-05-24	13:45:00	483346047	91	927916320	446763595	Maccabi Women's Clinic	Herzl St 16, Modiin
1443	2025-10-15	16:15:00	916090435	177	390750761	391559775	Meuhedet Pediatric Clinic	HaShalom Rd 144, Petah Tikva
1444	2025-01-18	12:30:00	822970399	24	686931483	421967560	Clalit Women's Clinic	Rothschild Ave 149, Haifa
1445	2025-09-25	20:30:00	590778593	183	151385895	193901152	Clalit Clinic	Ben Gurion Blvd 111, Beersheba
1446	2025-01-10	14:15:00	906327198	50	170476311	291145247	Maccabi Health Center	HaTikva St 130, Rishon LeZion
1447	2025-05-05	16:00:00	730453991	112	691705874	\N	Clalit Women's Clinic	Rothschild Ave 6, Jerusalem
1448	2025-10-02	07:00:00	970296727	110	484821493	641246037	Clalit Women's Clinic	HaTikva St 40, Modiin
1449	2025-04-14	15:45:00	290221251	341	349943042	858675688	Clalit Health Center	Rothschild Ave 146, Modiin
1450	2025-08-26	09:30:00	343278287	90	668035126	367550207	Leumit City Clinic	Begin Blvd 70, Beersheba
1451	2025-08-27	12:30:00	892550568	175	439413734	856141290	Leumit City Clinic	Begin Blvd 70, Beersheba
1452	2025-11-22	20:45:00	748336036	178	300697114	300685875	Meuhedet Pediatric Clinic	Allenby St 8, Modiin
1453	2025-05-15	14:45:00	833485809	65	333059661	\N	Leumit Women's Clinic	HaTikva St 7, Modiin
1454	2025-01-18	20:15:00	895576008	242	914566516	233715310	Leumit Pediatric Clinic	Jabotinsky St 22, Kfar Saba
1455	2025-05-02	20:30:00	829589264	2	530516374	525443476	Clalit Health Center	Rothschild Ave 146, Modiin
1456	2025-08-25	20:15:00	836728213	192	294557346	853912682	Meuhedet Clinic	Weizmann St 19, Rishon LeZion
1457	2025-07-13	11:00:00	914894458	32	175078783	853912682	Maccabi Pediatric Clinic	HaPalmach St 79, Jerusalem
1458	2025-12-16	16:30:00	974269487	349	495900140	302016206	Clalit Pediatric Clinic	Herzl St 20, Jerusalem
1459	2025-09-26	16:00:00	131666625	142	602013357	858675688	Meuhedet Health Center	HaNegev St 127, Tel Aviv
1460	2025-11-23	17:30:00	851341222	214	869278628	585034134	Meuhedet Health Center	Sokolov St 132, Rishon LeZion
1461	2025-06-01	14:45:00	367818889	61	902246089	523195752	Meuhedet Women's Clinic	HaYarkon St 98, Haifa
1462	2025-12-10	14:45:00	946254016	73	194967455	549847210	Leumit City Clinic	Jabotinsky St 3, Rishon LeZion
1463	2025-02-10	12:45:00	752098694	241	799258702	455096535	Meuhedet Health Center	HaHistadrut St 65, Netanya
1464	2025-02-21	18:45:00	733226714	115	913568600	\N	Leumit Clinic	Sokolov St 20, Ashdod
1465	2025-02-06	20:30:00	947243926	14	967238983	\N	Meuhedet Women's Clinic	HaPalmach St 110, Ashkelon
1466	2025-06-26	19:15:00	797569992	100	170476311	236536222	Maccabi Clinic	HaShalom Rd 37, Kfar Saba
1467	2025-06-13	08:30:00	726107543	389	561707109	455096535	Leumit Pediatric Clinic	HaNegev St 140, Bnei Brak
1468	2025-07-07	18:00:00	893684024	302	327338690	926559749	Leumit Family Clinic	Rothschild Ave 127, Petah Tikva
1469	2025-10-11	13:30:00	797776394	32	111533007	139987077	Maccabi Women's Clinic	Herzl St 16, Modiin
1470	2025-03-09	06:30:00	970296727	181	484821493	946589413	Meuhedet City Clinic	Ben Gurion Blvd 96, Ramat Gan
1471	2025-08-12	16:45:00	232412113	267	714051919	123889591	Leumit City Clinic	HaPalmach St 109, Modiin
1472	2025-10-08	14:45:00	894548767	15	989164091	223034510	Clalit Health Center	Weizmann St 13, Haifa
1473	2025-04-25	16:30:00	120855999	335	385321066	302016206	Clalit Pediatric Clinic	Rothschild Ave 56, Ramat Gan
1474	2025-01-10	20:30:00	893684024	214	565661395	\N	Maccabi City Clinic	HaTikva St 148, Haifa
1475	2025-03-09	10:15:00	415777602	213	246927292	\N	Meuhedet Health Center	Weizmann St 40, Haifa
1476	2025-04-20	14:30:00	612117711	281	349943042	991164471	Clalit Pediatric Clinic	HaPalmach St 37, Rehovot
1477	2025-09-26	17:30:00	849864109	22	723266609	302016206	Meuhedet Women's Clinic	HaShalom Rd 102, Ashkelon
1478	2025-10-06	08:45:00	812170410	310	799258702	\N	Ziv Medical Center	HaPalmach St 114, Holon
1479	2025-08-16	14:15:00	836728213	118	668035126	886567223	Maccabi City Clinic	Allenby St 142, Modiin
1480	2025-11-23	18:00:00	184019783	205	939238672	641246037	Maccabi Family Clinic	HaHistadrut St 28, Rishon LeZion
1481	2025-03-09	09:30:00	194165094	266	152785861	300685875	Leumit Women's Clinic	HaTikva St 38, Ramat Gan
1482	2025-08-27	16:00:00	811725293	251	909580633	169095841	Leumit Health Center	HaHistadrut St 16, Ashkelon
1483	2025-10-26	18:45:00	603369296	397	993263579	\N	Barzilai Medical Center	HaNegev St 45, Ramat Gan
1484	2025-11-22	15:45:00	368041638	264	765574491	467137650	Leumit Pediatric Clinic	Begin Blvd 30, Herzliya
1485	2025-01-01	20:45:00	811725293	40	646651118	\N	Maccabi Family Clinic	HaHistadrut St 28, Rishon LeZion
1486	2025-09-06	06:15:00	426410380	154	111533007	153432684	Clalit Family Clinic	HaShalom Rd 22, Ra'anana
1487	2025-03-27	20:30:00	738045160	241	939238672	455096535	Meuhedet Health Center	Jabotinsky St 37, Rishon LeZion
1488	2025-06-14	06:45:00	310637280	111	375218533	392263901	Maccabi Family Clinic	Sokolov St 11, Rehovot
1489	2025-09-09	11:45:00	189899416	43	439413734	233341981	Meuhedet Family Clinic	Begin Blvd 73, Bnei Brak
1490	2025-02-14	18:30:00	319864750	319	356308687	367550207	Leumit Health Center	Sokolov St 32, Herzliya
1491	2025-08-17	08:45:00	185818355	168	492050992	307638987	Clalit Pediatric Clinic	HaPalmach St 37, Rehovot
1492	2025-05-07	20:30:00	542415875	108	789955108	525443476	Maccabi Family Clinic	HaNegev St 59, Rehovot
1493	2025-02-08	19:15:00	350031763	165	278345196	154992568	Clalit City Clinic	Begin Blvd 17, Ashkelon
1494	2025-09-28	19:30:00	754151802	322	565737791	233341981	Meuhedet Women's Clinic	Ben Gurion Blvd 119, Holon
1495	2025-09-10	06:15:00	928091898	25	447168611	146343109	Maccabi Women's Clinic	Jabotinsky St 123, Petah Tikva
1496	2025-12-16	07:15:00	303722231	54	165682443	\N	Meuhedet Women's Clinic	Ben Gurion Blvd 46, Modiin
1497	2025-11-18	12:15:00	197148858	16	790255711	372000492	Clalit City Clinic	Begin Blvd 61, Rishon LeZion
1498	2025-08-13	06:45:00	294996591	394	128998748	446763595	Meuhedet Pediatric Clinic	HaHistadrut St 91, Haifa
1499	2025-11-02	10:45:00	733454157	390	325430239	\N	Clalit City Clinic	HaYarkon St 47, Ashkelon
1500	2025-09-08	10:45:00	894956091	298	993263579	744541166	Maccabi Family Clinic	HaPalmach St 15, Haifa
1501	2025-06-04	07:45:00	494804448	392	254904175	254040510	Maccabi Clinic	Weizmann St 12, Jerusalem
1502	2025-12-09	15:00:00	632274169	176	577645975	673012407	Clalit City Clinic	HaTikva St 80, Bat Yam
1503	2025-04-11	16:30:00	213596569	29	327338690	660542544	Meuhedet Women's Clinic	HaPalmach St 110, Ashkelon
1504	2025-07-07	13:00:00	249140620	190	116809193	\N	Meuhedet Women's Clinic	Sokolov St 123, Netanya
1505	2025-04-06	16:00:00	189791206	43	390750761	896666994	Maccabi Pediatric Clinic	HaPalmach St 49, Bat Yam
1506	2025-07-01	15:30:00	409960350	384	587927685	\N	Leumit City Clinic	HaPalmach St 140, Ra'anana
1507	2025-09-03	13:30:00	657393222	28	770359651	233715310	Maccabi Pediatric Clinic	HaNegev St 5, Ramat Gan
1508	2025-04-07	17:45:00	460087435	399	691705874	543138407	Clalit Clinic	Herzl St 148, Herzliya
1509	2025-07-08	11:30:00	862445507	386	132264095	146343109	Clalit Clinic	Menachem Begin St 121, Jerusalem
1510	2025-04-23	11:30:00	773426386	287	494708371	508458268	Maccabi Clinic	Begin Blvd 98, Ra'anana
1511	2025-03-11	17:30:00	665010330	67	767059275	228630954	Maccabi Health Center	Rothschild Ave 118, Rehovot
1512	2025-10-24	06:00:00	485521617	114	352089792	700986555	Meuhedet Pediatric Clinic	Jabotinsky St 60, Bat Yam
1513	2025-04-03	07:30:00	287043819	121	106210399	632667768	Clalit Family Clinic	HaShalom Rd 22, Ra'anana
1514	2025-08-24	16:15:00	299229343	13	103198638	569598179	Meuhedet Pediatric Clinic	HaPalmach St 113, Jerusalem
1515	2025-01-19	13:30:00	292169783	285	623490063	578118209	Leumit Family Clinic	HaHistadrut St 128, Rishon LeZion
1516	2025-07-26	07:00:00	207067497	254	960240840	\N	Leumit Women's Clinic	HaHistadrut St 41, Haifa
1517	2025-11-17	18:15:00	543629152	1	530516374	\N	Ichilov Hospital	Rothschild Ave 148, Beersheba
1519	2025-09-08	17:15:00	596928327	374	960240840	\N	Leumit Women's Clinic	HaYarkon St 113, Rishon LeZion
1520	2025-12-01	12:45:00	977648192	99	909580633	644870997	Maccabi Clinic	Menachem Begin St 131, Rishon LeZion
1521	2025-05-19	09:15:00	274894140	38	469439493	205288611	Maccabi Clinic	Rothschild Ave 133, Rehovot
1522	2025-05-11	16:15:00	156313275	250	951108053	745929637	Meuhedet Health Center	Weizmann St 40, Haifa
1523	2025-05-01	10:45:00	606515031	17	350299663	991202503	Meuhedet Pediatric Clinic	HaHistadrut St 91, Haifa
1524	2025-09-04	16:30:00	248993596	205	740682739	153432684	Leumit Health Center	Weizmann St 145, Petah Tikva
1525	2025-04-23	16:15:00	463857918	364	705338121	680422772	Clalit Clinic	Herzl St 148, Herzliya
1526	2025-11-05	11:30:00	679248949	14	492050992	323208385	Clalit Women's Clinic	HaTikva St 9, Haifa
1527	2025-08-11	11:00:00	894548767	221	651938317	136335319	Meuhedet Health Center	Jabotinsky St 78, Herzliya
1528	2025-11-12	10:15:00	149181012	388	530516374	379085236	Clalit Clinic	HaShalom Rd 48, Modiin
1529	2025-12-14	20:30:00	300036531	228	714051919	632667768	Leumit Women's Clinic	HaNegev St 149, Ramat Gan
1530	2025-04-14	15:30:00	367688443	343	405648081	\N	Meuhedet Pediatric Clinic	Allenby St 8, Modiin
1531	2025-09-06	17:15:00	849864109	208	510716800	\N	Maccabi Clinic	Rothschild Ave 112, Bnei Brak
1532	2025-01-26	17:00:00	431782073	263	157794649	164347844	Leumit Family Clinic	Allenby St 12, Ramat Gan
1533	2025-08-22	07:30:00	752098694	257	890623488	621805679	Clalit Women's Clinic	Sokolov St 82, Petah Tikva
1534	2025-01-09	07:45:00	208136962	201	106210399	835357628	Meuhedet Women's Clinic	Sokolov St 123, Netanya
1535	2025-09-07	11:00:00	626008407	147	194967455	186854746	Clalit Family Clinic	HaYarkon St 102, Bat Yam
1536	2025-10-06	08:00:00	314642987	216	832010443	379926927	Leumit Women's Clinic	Sokolov St 98, Bnei Brak
1537	2025-04-03	17:30:00	353165680	292	361945520	609883589	Leumit City Clinic	Allenby St 107, Beersheba
1538	2025-02-14	10:30:00	530709488	147	116809193	302016206	Leumit City Clinic	HaYarkon St 136, Holon
1539	2025-06-06	07:15:00	505288440	74	165682443	826996680	Leumit Women's Clinic	Sokolov St 98, Bnei Brak
1540	2025-07-02	20:30:00	267088184	166	459613663	745929637	Leumit Pediatric Clinic	Begin Blvd 68, Modiin
1541	2025-11-07	08:15:00	637152102	79	565166657	\N	Leumit Clinic	HaNegev St 42, Herzliya
1542	2025-02-14	19:45:00	591839254	182	356308687	652055112	Maccabi Women's Clinic	Ben Gurion Blvd 85, Ashkelon
1543	2025-12-13	16:15:00	704835566	188	327338690	446763595	Maccabi Clinic	Weizmann St 78, Tel Aviv
1544	2025-04-15	12:15:00	457553650	55	294557346	660542544	Meuhedet City Clinic	Jabotinsky St 71, Jerusalem
1545	2025-01-19	06:00:00	946254016	207	936879403	856141290	Clalit Family Clinic	HaYarkon St 28, Bat Yam
1546	2025-11-11	19:15:00	829589264	68	286582552	694876741	Meuhedet Women's Clinic	Sokolov St 23, Bat Yam
1547	2025-03-22	15:45:00	504527711	192	132264095	733386484	Leumit Pediatric Clinic	Begin Blvd 37, Petah Tikva
1548	2025-04-12	13:45:00	221606473	169	231324781	153432684	Maccabi Family Clinic	Jabotinsky St 5, Rehovot
1549	2025-09-23	06:30:00	738045160	277	808677201	392263901	Maccabi Pediatric Clinic	Herzl St 40, Rishon LeZion
1550	2025-08-01	20:30:00	762559306	113	724516280	152943249	Meuhedet Pediatric Clinic	Menachem Begin St 23, Haifa
1551	2025-09-28	19:30:00	253196823	143	605063967	627217360	Meuhedet City Clinic	Begin Blvd 64, Tel Aviv
1552	2025-09-06	08:00:00	161764941	15	103198638	484495578	Leumit Health Center	Allenby St 40, Bnei Brak
1553	2025-03-25	17:30:00	434477925	144	580038886	\N	Maccabi Family Clinic	HaTikva St 49, Ramat Gan
1554	2025-04-13	14:00:00	161764941	203	765574491	\N	Leumit Family Clinic	HaTikva St 41, Netanya
1555	2025-12-05	13:30:00	483346047	251	175078783	788565519	Maccabi Clinic	Weizmann St 78, Tel Aviv
1556	2025-08-01	15:00:00	253196823	358	670632947	264594643	Maccabi City Clinic	HaPalmach St 85, Beersheba
1557	2025-11-10	07:15:00	993112782	4	414316626	637417326	Meuhedet Clinic	Sokolov St 68, Bat Yam
1558	2025-10-22	09:30:00	852559916	322	410962502	104731999	Meuhedet Health Center	Allenby St 129, Jerusalem
1559	2025-02-07	17:15:00	845115493	360	421289999	652055112	Maccabi City Clinic	Herzl St 15, Rehovot
1560	2025-04-18	16:45:00	172617282	79	145012488	652055112	Kaplan Medical Center	Sokolov St 133, Herzliya
1561	2025-06-04	10:00:00	794952734	44	390750761	403951290	Clalit Pediatric Clinic	Ben Gurion Blvd 61, Holon
1562	2025-09-22	07:00:00	976166486	187	651938317	134938340	Clalit Pediatric Clinic	Menachem Begin St 69, Tel Aviv
1563	2025-07-07	06:00:00	408340579	280	127373899	123889591	Maccabi Clinic	Weizmann St 78, Tel Aviv
1564	2025-12-02	09:00:00	855032071	299	933176850	510589173	Meuhedet Family Clinic	HaYarkon St 37, Bat Yam
1565	2025-06-26	07:45:00	292169783	152	675033386	510589173	Maccabi Pediatric Clinic	Weizmann St 112, Haifa
1566	2025-12-21	09:15:00	944917553	223	980860075	288012548	Clalit Women's Clinic	HaTikva St 139, Rishon LeZion
1567	2025-11-03	13:00:00	329416185	223	651938317	525443476	Meuhedet Health Center	HaNegev St 127, Tel Aviv
1568	2025-02-17	13:30:00	679248949	280	262180529	545281216	Maccabi Pediatric Clinic	HaPalmach St 79, Jerusalem
1569	2025-09-01	08:30:00	899936576	120	757088646	803631502	Clalit Health Center	Menachem Begin St 81, Tel Aviv
1570	2025-05-03	08:15:00	251420151	163	327338690	578303296	Clalit Pediatric Clinic	Menachem Begin St 69, Tel Aviv
1571	2025-05-28	17:00:00	844888238	168	766537646	705808415	Meuhedet Pediatric Clinic	Begin Blvd 73, Bnei Brak
1572	2025-04-14	11:00:00	172001273	272	605063967	222522748	Maccabi Women's Clinic	Sokolov St 14, Petah Tikva
1573	2025-01-18	11:15:00	301023302	243	459613663	125478540	Maccabi Family Clinic	HaPalmach St 14, Bat Yam
1574	2025-07-15	17:15:00	637152102	29	493394881	\N	Maccabi Family Clinic	Jabotinsky St 5, Rehovot
1575	2025-08-09	07:30:00	188709072	315	602013357	770618338	Maccabi Family Clinic	HaTikva St 49, Ramat Gan
1576	2025-02-27	19:45:00	512030298	363	349943042	310258592	Maccabi Clinic	HaPalmach St 36, Tel Aviv
1577	2025-05-25	19:00:00	984346343	266	327338690	680422772	Leumit City Clinic	HaShalom Rd 123, Ra'anana
1578	2025-11-25	19:00:00	741059892	42	410962502	636489403	Leumit Women's Clinic	HaYarkon St 113, Rishon LeZion
1579	2025-07-03	11:00:00	970296727	161	960240840	793942949	Clalit Family Clinic	Allenby St 103, Rishon LeZion
1580	2025-06-14	06:00:00	458111142	124	523388008	\N	Leumit City Clinic	Ben Gurion Blvd 96, Bnei Brak
1581	2025-11-17	10:15:00	362385152	220	762854976	310449903	Clalit City Clinic	Weizmann St 132, Kfar Saba
1582	2025-09-07	18:00:00	809200522	176	801483903	398331058	Leumit Women's Clinic	Herzl St 102, Herzliya
1583	2025-01-19	06:15:00	916939137	6	583133229	210440926	Clalit Women's Clinic	HaPalmach St 142, Petah Tikva
1584	2025-06-12	10:00:00	254630730	61	408394324	744541166	Clalit Health Center	Weizmann St 13, Haifa
1585	2025-05-22	11:30:00	358867112	243	152785861	\N	Meuhedet Health Center	HaHistadrut St 65, Netanya
1586	2025-03-02	07:15:00	543629152	7	530516374	608281507	Clalit Health Center	Ben Gurion Blvd 101, Rehovot
1587	2025-09-10	12:45:00	682247730	351	121065055	\N	Leumit Health Center	Jabotinsky St 37, Ra'anana
1588	2025-05-26	15:45:00	982886900	250	790255711	\N	Leumit City Clinic	HaPalmach St 109, Modiin
1589	2025-01-13	08:00:00	536640092	142	277290510	\N	Meuhedet Family Clinic	HaNegev St 74, Petah Tikva
1590	2025-05-05	08:00:00	946254016	399	367041409	931089150	Clalit Health Center	Menachem Begin St 49, Beersheba
1591	2025-07-12	10:00:00	272193302	82	175078783	216674676	Meuhedet Women's Clinic	Sokolov St 58, Beersheba
1592	2025-01-22	15:30:00	382178937	322	508895013	799658255	Maccabi Health Center	HaTikva St 106, Jerusalem
1593	2025-10-23	17:45:00	542415875	12	613307691	634188128	Leumit Pediatric Clinic	HaShalom Rd 52, Modiin
1594	2025-02-13	19:45:00	429596723	136	121502474	379926927	Leumit City Clinic	HaTikva St 78, Petah Tikva
1595	2025-06-10	08:30:00	730453991	296	668035126	634188128	Meuhedet Family Clinic	Menachem Begin St 148, Bat Yam
1596	2025-09-11	15:45:00	944917553	284	517697659	165928627	Clalit City Clinic	Weizmann St 77, Tel Aviv
1597	2025-10-04	13:45:00	490061917	141	799258702	692757934	Leumit City Clinic	HaTikva St 78, Petah Tikva
1598	2025-04-18	10:00:00	726107543	375	194967455	398331058	Maccabi Family Clinic	HaHistadrut St 28, Rishon LeZion
1599	2025-10-12	18:15:00	789677587	171	327338690	637417326	Leumit City Clinic	Jabotinsky St 124, Haifa
1600	2025-11-12	17:15:00	292536682	185	205096731	\N	Leumit Women's Clinic	HaTikva St 7, Modiin
1601	2025-08-07	06:15:00	617124389	229	110532551	\N	Meuhedet Pediatric Clinic	HaTikva St 104, Kfar Saba
1602	2025-10-09	11:00:00	439631560	293	860923150	333012046	Meuhedet Health Center	HaNegev St 139, Rehovot
1603	2025-02-06	14:00:00	568658593	165	204520642	254040510	Leumit Clinic	Herzl St 73, Modiin
1604	2025-10-03	08:00:00	301023302	346	565661395	627217360	Leumit Pediatric Clinic	Jabotinsky St 22, Kfar Saba
1605	2025-02-07	15:15:00	149181012	277	240709151	991202503	Maccabi Clinic	HaYarkon St 94, Ashdod
1606	2025-12-05	17:45:00	560347583	180	668035126	826996680	Clalit Clinic	Jabotinsky St 56, Ashdod
1607	2025-12-28	15:00:00	637152102	45	162929677	485241165	Meuhedet Health Center	HaNegev St 36, Herzliya
1608	2025-04-13	12:15:00	612117711	325	157794649	403951290	Leumit Women's Clinic	Ben Gurion Blvd 42, Bat Yam
1609	2025-01-12	17:30:00	348914405	240	282498842	216674676	Clalit Women's Clinic	Herzl St 44, Haifa
1610	2025-03-01	13:00:00	375159255	120	510334717	831565842	Meuhedet Clinic	Ben Gurion Blvd 106, Bat Yam
1611	2025-04-25	08:15:00	129762178	76	909580633	222522748	Clalit Health Center	Jabotinsky St 51, Netanya
1612	2025-02-02	13:45:00	209176386	21	517697659	716745655	Maccabi City Clinic	Allenby St 142, Modiin
1613	2025-06-23	17:15:00	626008407	375	356308687	743393691	Leumit Pediatric Clinic	Begin Blvd 68, Modiin
1614	2025-09-12	08:15:00	155981712	376	195106131	\N	Clalit Pediatric Clinic	Ben Gurion Blvd 16, Ashkelon
1615	2025-10-21	07:00:00	755228375	22	128998748	958396544	Maccabi Pediatric Clinic	Begin Blvd 5, Rehovot
1616	2025-09-24	11:15:00	582419251	85	565661395	\N	Meuhedet Family Clinic	Allenby St 1, Rehovot
1617	2025-05-04	10:45:00	326216990	56	762854976	\N	Maccabi Clinic	Allenby St 129, Rehovot
1618	2025-11-16	16:15:00	188709072	52	757088646	125478540	Clalit Women's Clinic	HaPalmach St 139, Ashdod
1619	2025-04-25	15:30:00	276643268	208	335528238	\N	Leumit City Clinic	HaTikva St 108, Ramat Gan
1620	2025-05-04	10:45:00	753729185	46	316396883	\N	Leumit Health Center	Jabotinsky St 37, Ra'anana
1621	2025-04-06	14:30:00	122403164	32	314241360	\N	Maccabi Clinic	HaTikva St 81, Kfar Saba
1622	2025-09-13	14:15:00	890970312	267	170476311	\N	Maccabi Family Clinic	Weizmann St 128, Modiin
1623	2025-05-10	18:30:00	928091898	160	896973596	254040510	Maccabi Health Center	HaShalom Rd 91, Netanya
1624	2025-10-19	07:45:00	603369296	332	766537646	927259391	Meuhedet Health Center	HaNegev St 139, Rehovot
1625	2025-12-13	09:00:00	797569992	20	116809193	437174782	Clalit City Clinic	Herzl St 84, Netanya
1626	2025-07-25	18:15:00	903260938	279	678506268	446763595	Meuhedet Women's Clinic	Sokolov St 66, Netanya
1627	2025-01-27	17:30:00	191561261	249	559056009	150886100	Leumit City Clinic	Weizmann St 35, Kfar Saba
1628	2025-09-09	17:00:00	595469585	199	294557346	\N	Meuhedet Health Center	Allenby St 129, Jerusalem
1629	2025-05-01	15:30:00	833485809	195	876946737	739732268	Leumit Clinic	Jabotinsky St 21, Rehovot
1630	2025-01-16	18:00:00	287043819	288	767059275	291145247	Maccabi Health Center	Weizmann St 25, Jerusalem
1631	2025-06-18	14:30:00	805185005	320	740682739	379926927	Leumit Pediatric Clinic	Sokolov St 30, Petah Tikva
1632	2025-02-27	10:15:00	536709776	276	927468908	798009672	Maccabi Clinic	Rothschild Ave 112, Bnei Brak
1633	2025-01-17	07:15:00	161764941	215	765574491	578303296	Clalit Pediatric Clinic	HaPalmach St 44, Ashdod
1634	2025-10-04	06:30:00	915928506	180	767059275	927259391	Leumit Health Center	Rothschild Ave 88, Modiin
1635	2025-09-18	09:15:00	123928798	140	106107388	692757934	Leumit Clinic	Menachem Begin St 20, Herzliya
1636	2025-09-11	16:15:00	887631402	386	188163518	886553988	Meuhedet Women's Clinic	Menachem Begin St 122, Haifa
1637	2025-05-15	15:45:00	533354204	32	569080510	499722276	Meuhedet Health Center	HaNegev St 36, Herzliya
1638	2025-04-16	14:30:00	155981712	216	765921635	\N	Maccabi Family Clinic	HaPalmach St 14, Bat Yam
1639	2025-01-01	16:15:00	680566675	223	835425519	124787141	Meuhedet Clinic	Rothschild Ave 130, Rishon LeZion
1640	2025-07-12	10:30:00	862445507	383	246927292	210440926	Maccabi Family Clinic	HaYarkon St 77, Kfar Saba
1641	2025-09-20	09:30:00	822970399	100	767059275	\N	Meuhedet Pediatric Clinic	Begin Blvd 73, Bnei Brak
1642	2025-11-21	06:45:00	464558868	95	989164091	831565842	Meuhedet City Clinic	Begin Blvd 64, Tel Aviv
1643	2025-08-04	14:00:00	343329332	195	789955108	926559749	Soroka Medical Center	HaYarkon St 6, Ashdod
1644	2025-07-27	11:15:00	250708248	355	244282748	\N	Leumit Clinic	HaHistadrut St 139, Ra'anana
1645	2025-04-23	13:00:00	418541884	296	924888731	134463780	Clalit Family Clinic	Begin Blvd 29, Kfar Saba
1646	2025-03-03	12:00:00	301023302	383	602013357	\N	Meuhedet Family Clinic	HaHistadrut St 74, Haifa
1647	2025-09-27	17:15:00	172617282	133	405648081	\N	Leumit Women's Clinic	Ben Gurion Blvd 106, Rehovot
1648	2025-02-06	10:00:00	612117711	167	157794649	136335319	Maccabi Health Center	Weizmann St 25, Jerusalem
1649	2025-03-06	07:30:00	734987957	321	678506268	139987077	Maccabi Health Center	HaYarkon St 132, Ashdod
1650	2025-10-11	11:45:00	962605402	299	405648081	739732268	Maccabi Clinic	Menachem Begin St 21, Bat Yam
1651	2025-02-16	12:00:00	209732140	328	110532551	744541166	Maccabi City Clinic	HaTikva St 148, Haifa
1652	2025-07-14	12:00:00	340100295	371	157794649	720046881	Meuhedet Pediatric Clinic	Begin Blvd 73, Bnei Brak
1653	2025-08-14	17:00:00	679248949	265	801483903	146343109	Clalit Family Clinic	Begin Blvd 107, Netanya
1654	2025-06-23	18:00:00	586562174	77	668035126	585426153	Clalit Women's Clinic	HaTikva St 139, Rishon LeZion
1655	2025-03-22	10:15:00	368041638	113	106210399	674960706	Leumit Clinic	HaTikva St 85, Herzliya
1656	2025-08-10	18:45:00	760208651	305	980860075	\N	Maccabi Pediatric Clinic	HaNegev St 5, Ramat Gan
1657	2025-07-10	11:45:00	185144803	393	951108053	632667768	Assuta Hospital	HaYarkon St 11, Petah Tikva
1658	2025-08-11	16:45:00	892550568	283	613307691	974562766	Clalit Family Clinic	HaYarkon St 28, Bat Yam
1659	2025-12-06	17:15:00	641087529	4	933176850	700986555	Meuhedet Family Clinic	Rothschild Ave 36, Herzliya
1660	2025-03-17	08:45:00	297461390	62	337501464	904402564	Meuhedet Pediatric Clinic	Menachem Begin St 23, Haifa
1661	2025-05-25	07:45:00	614959631	245	469439493	266685039	Leumit Pediatric Clinic	Rothschild Ave 32, Petah Tikva
1662	2025-02-18	08:00:00	434477925	313	913568600	743393691	Clalit Pediatric Clinic	Herzl St 20, Jerusalem
1663	2025-04-04	17:15:00	207067497	135	349943042	\N	Meuhedet Family Clinic	HaPalmach St 19, Rishon LeZion
1664	2025-10-02	17:45:00	463857918	3	678506268	705808415	Leumit Health Center	HaNegev St 29, Bat Yam
1665	2025-06-20	12:00:00	773426386	320	510334717	323208385	Maccabi Family Clinic	HaHistadrut St 3, Beersheba
1666	2025-11-13	14:30:00	944917553	91	246927292	364330977	Maccabi City Clinic	Jabotinsky St 56, Ra'anana
1667	2025-12-03	13:45:00	799742877	242	106210399	421967560	Leumit Clinic	Herzl St 62, Kfar Saba
1668	2025-12-01	19:15:00	586562174	344	933176850	557387584	Clalit Women's Clinic	Begin Blvd 76, Petah Tikva
1669	2025-05-08	09:00:00	890970312	267	924888731	549041678	Meuhedet Pediatric Clinic	HaPalmach St 113, Jerusalem
1670	2025-06-15	18:15:00	915928506	30	286582552	134463780	Leumit Pediatric Clinic	Begin Blvd 42, Bnei Brak
1671	2025-11-08	07:00:00	465944468	57	303635805	403951290	Leumit Health Center	Allenby St 40, Bnei Brak
1672	2025-10-07	06:15:00	721698371	396	902246089	717220517	Maccabi Women's Clinic	HaPalmach St 107, Holon
1673	2025-05-06	06:00:00	144374344	235	722223783	\N	Meuhedet Family Clinic	HaNegev St 44, Haifa
1674	2025-07-06	15:30:00	762364645	366	421289999	379085236	Leumit Women's Clinic	Ben Gurion Blvd 76, Rehovot
1675	2025-04-28	14:15:00	150349157	222	809797531	333012046	Maccabi Family Clinic	HaTikva St 49, Ramat Gan
1676	2025-06-16	06:45:00	420061429	60	244282748	437174782	Meuhedet Women's Clinic	HaShalom Rd 102, Ashkelon
1677	2025-03-10	07:30:00	797776394	333	646651118	886567223	Maccabi Family Clinic	Weizmann St 128, Modiin
1678	2025-09-08	14:30:00	116338238	84	801483903	524957376	Leumit Women's Clinic	HaTikva St 89, Bnei Brak
1679	2025-04-04	19:30:00	348914405	202	589073536	134463780	Maccabi Clinic	Allenby St 129, Rehovot
1680	2025-03-11	20:00:00	514692698	190	565737791	632667768	Leumit Health Center	HaNegev St 29, Bat Yam
1681	2025-05-19	20:15:00	362385152	205	602013357	\N	Leumit Family Clinic	HaHistadrut St 128, Rishon LeZion
1682	2025-02-25	06:30:00	251420151	84	678506268	297714695	Leumit Women's Clinic	Ben Gurion Blvd 141, Ashkelon
1683	2025-03-27	10:45:00	371217957	73	565737791	652055112	Clalit Women's Clinic	Sokolov St 96, Ashkelon
1684	2025-07-17	14:30:00	180510182	193	368803859	\N	Leumit City Clinic	Jabotinsky St 3, Rishon LeZion
1685	2025-09-02	10:30:00	197148858	303	355020965	392263901	Maccabi Women's Clinic	Herzl St 112, Tel Aviv
1686	2025-05-22	18:45:00	977648192	373	103198638	\N	Clalit Women's Clinic	HaTikva St 139, Rishon LeZion
1687	2025-02-03	17:15:00	477313143	326	691705874	\N	Leumit City Clinic	Jabotinsky St 124, Haifa
1688	2025-05-11	16:45:00	892550568	116	767059275	134463780	Meuhedet Family Clinic	Allenby St 1, Rehovot
1689	2025-05-09	13:00:00	439631560	135	587927685	379926927	Clalit Pediatric Clinic	HaYarkon St 84, Bnei Brak
1690	2025-06-17	14:00:00	191561261	381	145012488	358890331	Meuhedet Pediatric Clinic	HaTikva St 104, Kfar Saba
1691	2025-03-12	12:00:00	603632562	33	605063967	210440926	Meuhedet Family Clinic	HaNegev St 121, Petah Tikva
1692	2025-06-23	06:45:00	188769931	99	902246089	853912682	Maccabi Clinic	Herzl St 23, Rehovot
1694	2025-07-20	06:00:00	868919607	224	205096731	\N	Leumit Clinic	HaHistadrut St 140, Ra'anana
1695	2025-01-27	14:45:00	111387179	151	960240840	702439977	Maccabi City Clinic	Rothschild Ave 117, Ashkelon
1696	2025-08-21	18:00:00	174306440	84	282498842	590833948	Maccabi Women's Clinic	Ben Gurion Blvd 85, Ashkelon
1697	2025-06-10	08:45:00	910273798	12	565425153	785743985	Meuhedet Clinic	Weizmann St 71, Ashkelon
1698	2025-12-08	09:15:00	670190917	379	162929677	\N	Maccabi Health Center	HaTikva St 86, Holon
1699	2025-12-25	06:30:00	378410529	181	503075904	950189399	Rambam Health Campus	HaYarkon St 65, Jerusalem
1700	2025-07-22	14:00:00	129762178	193	316396883	608281507	Maccabi Family Clinic	Herzl St 49, Holon
1701	2025-12-08	19:00:00	595469585	236	967238983	437174782	Shaare Zedek Medical Center	HaNegev St 69, Netanya
1702	2025-09-16	20:30:00	345789475	151	832010443	515517676	Maccabi Clinic	HaPalmach St 36, Tel Aviv
1703	2025-11-21	16:30:00	450494685	104	194967455	641246037	Leumit Health Center	HaShalom Rd 19, Haifa
1704	2025-11-24	18:45:00	467713954	273	675610128	413603064	Leumit Health Center	Rothschild Ave 85, Ramat Gan
1705	2025-03-06	18:45:00	249140620	323	808943895	950189399	Clalit Pediatric Clinic	Ben Gurion Blvd 61, Holon
1706	2025-04-23	09:00:00	757315687	179	668035126	886553988	Clalit Family Clinic	HaShalom Rd 22, Ra'anana
1707	2025-10-24	16:45:00	107106212	187	188163518	543138407	Leumit City Clinic	HaTikva St 108, Ramat Gan
1708	2025-09-09	09:15:00	358393463	11	914566516	\N	Clalit City Clinic	Sokolov St 78, Herzliya
1709	2025-11-11	17:00:00	797776394	141	886939800	165928627	Leumit Family Clinic	Rothschild Ave 127, Petah Tikva
1710	2025-02-04	15:15:00	977648192	58	145012488	856141290	Leumit City Clinic	HaPalmach St 109, Modiin
1711	2025-12-17	17:30:00	514134929	74	337501464	124787141	Meuhedet Pediatric Clinic	Begin Blvd 123, Ra'anana
1712	2025-12-04	08:15:00	542297151	239	832010443	124787141	Meuhedet Health Center	Jabotinsky St 37, Rishon LeZion
1713	2025-01-01	15:00:00	582419251	29	151385895	330948886	Clalit Women's Clinic	Rothschild Ave 6, Jerusalem
1714	2025-01-27	08:30:00	348914405	286	262180529	788565519	Meuhedet City Clinic	Herzl St 144, Bat Yam
1715	2025-10-17	06:00:00	440428166	382	770359651	\N	Clalit Pediatric Clinic	HaPalmach St 37, Rehovot
1716	2025-09-17	11:15:00	275062263	115	352089792	549847210	Clalit City Clinic	HaYarkon St 47, Ashkelon
1717	2025-03-24	14:30:00	299085717	372	913568600	809751526	Meuhedet Women's Clinic	Sokolov St 115, Tel Aviv
1718	2025-11-03	15:15:00	730453991	349	121065055	717220517	Maccabi Family Clinic	HaYarkon St 77, Kfar Saba
1719	2025-06-01	19:45:00	737208814	153	414131125	745929637	Maccabi Pediatric Clinic	Weizmann St 16, Rishon LeZion
1720	2025-12-21	13:00:00	156769696	282	350299663	477791140	Leumit City Clinic	HaShalom Rd 123, Ra'anana
1721	2025-04-26	16:45:00	298404492	185	983060617	233341981	Meuhedet Pediatric Clinic	HaHistadrut St 44, Bnei Brak
1722	2025-08-04	11:30:00	504527711	196	204520642	926559749	Maccabi Clinic	Rothschild Ave 133, Rehovot
1723	2025-07-22	15:00:00	946254016	235	410254424	745929637	Meuhedet Pediatric Clinic	Jabotinsky St 144, Herzliya
1724	2025-09-08	15:30:00	519814178	142	339014530	499722276	Leumit City Clinic	Begin Blvd 72, Ramat Gan
1725	2025-12-18	12:45:00	963025761	237	493394881	587248600	Maccabi Health Center	HaYarkon St 132, Ashdod
1726	2025-09-13	10:30:00	993112782	366	646651118	641246037	Leumit Family Clinic	HaTikva St 41, Netanya
1727	2025-02-08	12:00:00	887631402	372	503075904	\N	Maccabi Women's Clinic	HaHistadrut St 89, Ashdod
1728	2025-10-13	16:30:00	946244382	376	927468908	181098189	Clalit Women's Clinic	Rothschild Ave 6, Jerusalem
1729	2025-08-28	07:00:00	272193302	350	106210399	\N	Leumit City Clinic	HaTikva St 108, Ramat Gan
1730	2025-08-06	17:45:00	726107543	138	914566516	\N	Leumit Family Clinic	HaShalom Rd 39, Bat Yam
1731	2025-07-23	20:00:00	498056409	12	860923150	233025558	Maccabi Pediatric Clinic	Herzl St 12, Jerusalem
1732	2025-02-12	17:15:00	797776394	195	767059275	967167857	Maccabi Clinic	Herzl St 23, Rehovot
1733	2025-02-16	15:15:00	536709776	237	860923150	785743985	Meuhedet Clinic	Weizmann St 19, Rishon LeZion
1734	2025-06-12	17:30:00	439631560	211	890623488	680422772	Clalit Women's Clinic	HaTikva St 139, Rishon LeZion
1735	2025-06-24	16:45:00	498056409	271	909580633	636489403	Leumit Clinic	HaHistadrut St 111, Netanya
1736	2025-06-20	16:30:00	915339436	251	421289999	406350060	Clalit Pediatric Clinic	HaPalmach St 44, Ashdod
1737	2025-05-09	06:15:00	855032071	87	896973596	691399121	Leumit City Clinic	Sokolov St 97, Bnei Brak
1738	2025-10-28	14:15:00	470869626	47	405648081	391559775	Clalit Women's Clinic	Jabotinsky St 116, Modiin
1739	2025-08-05	20:45:00	946244382	78	718084895	700986555	Leumit Women's Clinic	Sokolov St 98, Bnei Brak
1740	2025-08-14	14:30:00	574857929	393	414131125	\N	Leumit Pediatric Clinic	Weizmann St 74, Rishon LeZion
1741	2025-10-14	17:45:00	993112782	218	530516374	367550207	Meuhedet Women's Clinic	Ben Gurion Blvd 46, Modiin
1742	2025-06-01	20:30:00	916917936	331	667143420	595566634	Clalit Health Center	Herzl St 113, Bat Yam
1743	2025-08-09	18:15:00	590778593	74	129452534	484495578	Leumit Health Center	HaNegev St 1, Herzliya
1744	2025-03-16	06:45:00	254630730	198	145012488	\N	Maccabi Pediatric Clinic	HaPalmach St 47, Netanya
1745	2025-10-06	12:45:00	958722701	66	106210399	330948886	Leumit Health Center	HaHistadrut St 16, Ashkelon
1746	2025-01-23	12:00:00	590818651	261	361945520	372000492	Meuhedet Health Center	HaNegev St 36, Herzliya
1747	2025-04-03	12:30:00	314642987	118	705338121	\N	Leumit City Clinic	Ben Gurion Blvd 96, Bnei Brak
1748	2025-10-03	18:45:00	632577955	293	980860075	484495578	Meuhedet Clinic	Ben Gurion Blvd 106, Bat Yam
1749	2025-12-19	16:30:00	862048623	245	175078783	904402564	Leumit Women's Clinic	Sokolov St 98, Bnei Brak
1750	2025-03-12	16:15:00	213596569	5	300697114	152943249	Leumit City Clinic	Weizmann St 138, Modiin
1751	2025-07-02	20:30:00	796091497	274	561707109	358890331	Clalit Health Center	Ben Gurion Blvd 101, Rehovot
1752	2025-04-16	17:45:00	294996591	150	675610128	660542544	Meuhedet Family Clinic	Menachem Begin St 58, Rehovot
1753	2025-04-15	11:15:00	155981712	185	705338121	\N	Clalit City Clinic	Weizmann St 77, Tel Aviv
1754	2025-11-10	11:00:00	298404492	8	686931483	\N	Meuhedet Health Center	Sokolov St 132, Rishon LeZion
1755	2025-05-14	07:00:00	163350630	106	960240840	877651756	Meuhedet Clinic	Sokolov St 68, Bat Yam
1756	2025-06-24	18:45:00	242098030	301	583133229	718179719	Maccabi Clinic	HaTikva St 81, Kfar Saba
1757	2025-08-24	19:45:00	420061429	71	349943042	\N	Hadassah Ein Kerem Hospital	Herzl St 24, Haifa
1758	2025-10-03	14:00:00	657393222	141	589073536	739732268	Maccabi Health Center	Weizmann St 25, Jerusalem
1759	2025-08-11	09:15:00	844513515	313	419832401	745588939	Clalit Pediatric Clinic	Allenby St 107, Ashkelon
1760	2025-01-27	12:30:00	805185005	110	757088646	162854543	Clalit Women's Clinic	Begin Blvd 34, Bnei Brak
1761	2025-08-23	18:30:00	253196823	336	989164091	104731999	Leumit Clinic	HaHistadrut St 140, Ra'anana
1762	2025-07-22	15:15:00	463548843	384	762854976	831565842	Maccabi Family Clinic	Herzl St 49, Holon
1763	2025-01-10	19:30:00	144374344	154	914566516	193901152	Sheba Medical Center	HaShalom Rd 83, Tel Aviv
1764	2025-09-10	07:15:00	862048623	230	410962502	\N	Maccabi Family Clinic	HaHistadrut St 3, Beersheba
1765	2025-07-19	06:00:00	871784867	128	312816743	743393691	Meuhedet City Clinic	Sokolov St 95, Ashkelon
1766	2025-04-19	13:30:00	894548767	310	414316626	\N	Maccabi Pediatric Clinic	Rothschild Ave 58, Holon
1767	2025-03-10	09:15:00	536709776	75	106210399	510589173	Maccabi Health Center	HaYarkon St 74, Modiin
1768	2025-10-24	16:00:00	122403164	274	106210399	254040510	Meuhedet City Clinic	HaHistadrut St 124, Rehovot
1769	2025-05-05	10:00:00	639156305	346	236786603	990265405	Meuhedet Health Center	Sokolov St 132, Rishon LeZion
1770	2025-06-12	06:30:00	741606378	236	152785861	793942949	Meuhedet Health Center	Weizmann St 40, Haifa
1771	2025-02-03	19:15:00	877834494	40	160913893	173735333	Leumit Health Center	Herzl St 52, Jerusalem
1772	2025-02-16	18:00:00	887631402	222	408394324	485241165	Leumit Family Clinic	Ben Gurion Blvd 24, Tel Aviv
1773	2025-08-19	10:00:00	174306440	158	352089792	165928627	Maccabi Family Clinic	Sokolov St 11, Rehovot
1774	2025-04-23	10:30:00	822970399	34	832010443	717220517	Maccabi Pediatric Clinic	Herzl St 144, Rishon LeZion
1775	2025-08-24	10:15:00	974746813	173	439413734	716745655	Leumit Women's Clinic	HaTikva St 7, Modiin
1776	2025-09-04	06:45:00	755228375	113	151385895	716745655	Clalit Pediatric Clinic	Herzl St 20, Jerusalem
1777	2025-01-14	14:30:00	906327198	137	510334717	896666994	Meuhedet Pediatric Clinic	HaHistadrut St 91, Haifa
1778	2025-04-10	18:00:00	946244382	290	602013357	798009672	Maccabi Pediatric Clinic	Ben Gurion Blvd 17, Modiin
1779	2025-03-20	09:45:00	993112782	91	648046509	637417326	Clalit Pediatric Clinic	Sokolov St 136, Rehovot
1780	2025-05-11	20:00:00	135745856	380	160913893	254040510	Meuhedet Clinic	Ben Gurion Blvd 106, Bat Yam
1781	2025-01-18	12:45:00	305150698	374	145012488	826996680	Maccabi Clinic	Ben Gurion Blvd 128, Ashkelon
1782	2025-04-21	15:45:00	593065946	74	195106131	143764555	Leumit Health Center	HaYarkon St 62, Bnei Brak
1783	2025-11-13	06:00:00	297461390	131	762854976	\N	Leumit Clinic	Jabotinsky St 21, Rehovot
1784	2025-06-18	16:15:00	797776394	271	577645975	442531669	Meuhedet Women's Clinic	HaHistadrut St 126, Netanya
1785	2025-01-07	15:00:00	377899807	10	723266609	585426153	Clalit Women's Clinic	Begin Blvd 76, Petah Tikva
1786	2025-06-07	20:00:00	236809338	331	691705874	205288611	Maccabi Family Clinic	Weizmann St 118, Ashkelon
1787	2025-02-01	11:30:00	862445507	379	385015287	974562766	Leumit Clinic	Herzl St 62, Kfar Saba
1788	2025-02-26	10:15:00	984346343	311	121065055	\N	Meuhedet Pediatric Clinic	Herzl St 134, Holon
1789	2025-03-03	18:45:00	811725293	235	414131125	154749464	Leumit Family Clinic	Sokolov St 110, Netanya
1790	2025-02-05	18:00:00	439631560	263	493394881	\N	Leumit City Clinic	HaYarkon St 136, Holon
1791	2025-04-10	20:30:00	758038866	288	335569735	\N	Leumit Women's Clinic	Ben Gurion Blvd 141, Ashkelon
1792	2025-12-21	18:00:00	662729589	150	236786603	535842430	Maccabi Health Center	Weizmann St 25, Jerusalem
1793	2025-04-13	15:00:00	737208814	13	602013357	702439977	Maccabi Clinic	Allenby St 129, Rehovot
1794	2025-12-26	10:15:00	993112782	49	766537646	\N	Leumit City Clinic	Begin Blvd 66, Rehovot
1795	2025-11-09	16:00:00	358393463	391	822386902	522199986	Maccabi Family Clinic	Allenby St 35, Holon
1796	2025-05-23	09:30:00	473412170	331	130440929	524957376	Clalit Family Clinic	Allenby St 103, Rishon LeZion
1797	2025-10-23	11:45:00	116338238	242	909580633	233025558	Maccabi Women's Clinic	Menachem Begin St 93, Haifa
1798	2025-03-17	18:00:00	699825997	25	508895013	150886100	Maccabi Clinic	HaPalmach St 36, Tel Aviv
1799	2025-07-09	06:30:00	725872450	385	378127589	620872913	Meuhedet Family Clinic	HaHistadrut St 144, Beersheba
1800	2025-02-12	12:30:00	326216990	335	334099421	193901152	Clalit Family Clinic	Begin Blvd 29, Kfar Saba
1801	2025-09-22	11:30:00	331181020	225	724516280	560761358	Clalit City Clinic	Ben Gurion Blvd 81, Herzliya
1802	2025-02-07	13:00:00	728873342	73	160913893	655853037	Leumit Health Center	HaPalmach St 78, Ashkelon
1803	2025-07-01	13:30:00	403792403	187	870880025	\N	Leumit Pediatric Clinic	Weizmann St 74, Rishon LeZion
1804	2025-07-07	11:30:00	721698371	34	993263579	799658255	Maccabi Pediatric Clinic	Herzl St 12, Jerusalem
1805	2025-12-19	17:45:00	476830627	364	760677936	169095841	Maccabi Pediatric Clinic	Herzl St 12, Jerusalem
1806	2025-07-07	10:15:00	727330871	395	623490063	928678498	Leumit Pediatric Clinic	Begin Blvd 37, Petah Tikva
1807	2025-11-01	19:15:00	887631402	325	262180529	181098189	Maccabi City Clinic	Ben Gurion Blvd 61, Bnei Brak
1808	2025-10-19	14:00:00	124782507	323	760677936	307638987	Meuhedet Women's Clinic	HaYarkon St 98, Haifa
1809	2025-02-21	20:15:00	287218285	137	648046509	500823705	Clalit Health Center	Jabotinsky St 51, Netanya
1810	2025-01-23	18:15:00	916917936	200	675610128	\N	Maccabi Pediatric Clinic	HaNegev St 149, Rishon LeZion
1811	2025-06-24	06:30:00	816422554	38	960240840	\N	Meuhedet Pediatric Clinic	Jabotinsky St 60, Bat Yam
1812	2025-06-25	16:15:00	465944468	144	390750761	\N	Leumit Health Center	HaNegev St 1, Herzliya
1813	2025-06-10	13:00:00	403792403	140	121065055	165928627	Meuhedet Pediatric Clinic	HaTikva St 104, Kfar Saba
1814	2025-06-02	07:30:00	258775091	216	121502474	\N	Leumit Clinic	HaNegev St 104, Ra'anana
1815	2025-10-16	10:00:00	762559306	178	194967455	475678577	Maccabi Pediatric Clinic	HaPalmach St 92, Holon
1816	2025-01-07	14:30:00	303722231	106	240709151	545281216	Clalit Pediatric Clinic	HaYarkon St 84, Bnei Brak
1817	2025-12-16	09:15:00	298404492	257	936879403	\N	Clalit Health Center	Rothschild Ave 146, Modiin
1818	2025-02-20	10:30:00	999168068	383	703776850	702439977	Maccabi Clinic	HaTikva St 81, Kfar Saba
1819	2025-05-24	18:00:00	702769651	160	254904175	233341981	Leumit Clinic	Herzl St 73, Modiin
1820	2025-04-02	14:00:00	328312992	246	352089792	\N	Maccabi Family Clinic	HaHistadrut St 3, Beersheba
1821	2025-02-10	18:15:00	607933636	337	722223783	569598179	Maccabi Clinic	Allenby St 129, Rehovot
1822	2025-06-10	18:00:00	974746813	191	757088646	310449903	Leumit Pediatric Clinic	Begin Blvd 42, Bnei Brak
1823	2025-01-10	12:15:00	350031763	381	896973596	523462070	Maccabi Health Center	HaYarkon St 132, Ashdod
1824	2025-05-04	15:30:00	508184542	292	390750761	857599583	Leumit Health Center	HaYarkon St 62, Bnei Brak
1825	2025-01-19	11:30:00	844513515	115	489601917	500823705	Meuhedet Pediatric Clinic	Allenby St 8, Modiin
1826	2025-12-27	15:45:00	814690335	225	651447743	289805994	Leumit Pediatric Clinic	Begin Blvd 68, Modiin
1827	2025-05-22	07:00:00	797776394	44	565166657	578303296	Leumit Pediatric Clinic	Jabotinsky St 22, Kfar Saba
1828	2025-10-06	17:30:00	477313143	300	489601917	549847210	Leumit Women's Clinic	HaTikva St 7, Modiin
1829	2025-06-23	10:30:00	322279900	378	282498842	302016206	Maccabi Family Clinic	HaNegev St 59, Rehovot
1830	2025-09-13	07:15:00	944917553	316	439413734	634188128	Leumit City Clinic	HaPalmach St 11, Haifa
1831	2025-05-11	10:30:00	537493895	115	335528238	\N	Leumit Pediatric Clinic	HaNegev St 140, Bnei Brak
1832	2025-10-27	17:15:00	748336036	96	110532551	608281507	Meuhedet Women's Clinic	Begin Blvd 122, Ra'anana
1833	2025-02-24	10:15:00	131666625	289	822386902	475678577	Meuhedet Pediatric Clinic	Allenby St 8, Modiin
1834	2025-10-01	20:00:00	297461390	328	952751158	\N	Leumit City Clinic	HaPalmach St 109, Modiin
1835	2025-05-28	15:15:00	982886900	333	869278628	186854746	Maccabi Pediatric Clinic	HaYarkon St 111, Beersheba
1836	2025-06-10	19:00:00	894548767	389	714051919	\N	Meuhedet City Clinic	HaPalmach St 122, Modiin
1837	2025-02-23	11:30:00	748336036	144	277290510	\N	Maccabi City Clinic	HaPalmach St 28, Modiin
1838	2025-11-18	11:45:00	946254016	280	577645975	146343109	Meuhedet Family Clinic	HaShalom Rd 80, Bat Yam
1839	2025-07-26	20:00:00	188709072	15	303635805	300885051	Clalit Clinic	HaShalom Rd 48, Modiin
1840	2025-05-02	12:15:00	343278287	312	766537646	720046881	Leumit Pediatric Clinic	HaYarkon St 95, Rishon LeZion
1841	2025-09-13	11:00:00	537493895	218	503075904	691399121	Meuhedet Health Center	Sokolov St 132, Rishon LeZion
1842	2025-01-06	12:30:00	251420151	23	767059275	236536222	Meuhedet City Clinic	HaPalmach St 122, Modiin
1843	2025-07-18	18:30:00	358393463	319	469439493	632667768	Leumit Family Clinic	Ben Gurion Blvd 24, Tel Aviv
1844	2025-11-27	12:45:00	129762178	79	421289999	475678577	Leumit City Clinic	Weizmann St 138, Modiin
1845	2025-03-10	07:15:00	256086565	71	703776850	228630954	Maccabi City Clinic	Jabotinsky St 56, Ra'anana
1846	2025-10-17	14:00:00	319864750	284	188163518	485241165	Meuhedet Health Center	Herzl St 74, Modiin
1847	2025-11-15	18:45:00	757315687	1	760677936	991164471	Maccabi Clinic	Allenby St 129, Rehovot
1848	2025-01-05	10:00:00	155981712	77	686931483	123889591	Clalit Clinic	HaShalom Rd 48, Modiin
1849	2025-07-06	06:45:00	383641443	261	503075904	\N	Clalit Women's Clinic	Rothschild Ave 149, Haifa
1850	2025-03-28	10:15:00	310637280	241	451143202	485241165	Leumit City Clinic	HaPalmach St 109, Modiin
1851	2025-07-25	10:15:00	249140620	285	378127589	634188128	Leumit Women's Clinic	Ben Gurion Blvd 76, Rehovot
1852	2025-07-15	07:15:00	168877637	26	240709151	585426153	Maccabi Women's Clinic	HaYarkon St 77, Modiin
1853	2025-07-27	17:30:00	490061917	75	559056009	578118209	Leumit Clinic	HaTikva St 85, Herzliya
1854	2025-09-23	09:00:00	319864750	266	132264095	\N	Leumit Family Clinic	HaShalom Rd 39, Bat Yam
1855	2025-06-13	10:30:00	348914405	229	808943895	186854746	Clalit Family Clinic	Menachem Begin St 26, Bat Yam
1856	2025-07-21	08:15:00	514692698	36	356308687	831565842	Leumit Pediatric Clinic	HaYarkon St 95, Rishon LeZion
1857	2025-03-06	15:30:00	763371666	245	548621554	\N	Meuhedet Women's Clinic	Sokolov St 123, Netanya
1858	2025-06-19	11:15:00	173426798	221	325430239	809751526	Maccabi Clinic	HaPalmach St 36, Tel Aviv
1859	2025-06-12	13:00:00	287218285	127	939238672	310449903	Maccabi Health Center	Menachem Begin St 68, Rehovot
1860	2025-05-09	20:15:00	292169783	267	244282748	590833948	Leumit Family Clinic	HaHistadrut St 102, Ashkelon
1861	2025-02-20	12:45:00	574857929	191	510716800	143764555	Maccabi Family Clinic	Weizmann St 118, Ashkelon
1862	2025-03-04	17:00:00	944917553	179	128998748	579396263	Leumit Clinic	HaNegev St 102, Tel Aviv
1863	2025-05-24	13:30:00	871784867	203	765574491	702439977	Clalit City Clinic	HaYarkon St 47, Ashkelon
1864	2025-07-07	16:45:00	760208651	183	151385895	\N	Maccabi Clinic	Ben Gurion Blvd 128, Ashkelon
1865	2025-06-18	15:00:00	928091898	1	890623488	307638987	Meuhedet City Clinic	Allenby St 124, Rishon LeZion
1866	2025-02-25	06:30:00	582969573	123	914566516	975354103	Sheba Medical Center	HaShalom Rd 83, Tel Aviv
1867	2025-11-23	15:30:00	895588198	306	675610128	788565519	Maccabi Pediatric Clinic	Ben Gurion Blvd 17, Modiin
1868	2025-09-09	17:00:00	506237409	31	355020965	\N	Clalit Family Clinic	Rothschild Ave 27, Bat Yam
1869	2025-09-28	14:15:00	536640092	384	724516280	300685875	Clalit Women's Clinic	Begin Blvd 56, Rishon LeZion
1870	2025-10-07	07:15:00	614959631	10	766537646	442531669	Meuhedet Family Clinic	HaShalom Rd 80, Bat Yam
1871	2025-05-03	09:45:00	855172589	287	215791975	124787141	Leumit Clinic	HaHistadrut St 140, Ra'anana
1872	2025-11-23	19:30:00	209176386	128	471674082	\N	Maccabi Pediatric Clinic	HaPalmach St 92, Holon
1873	2025-02-06	14:15:00	999168068	80	510716800	136335319	Meuhedet Clinic	Sokolov St 68, Bat Yam
1874	2025-12-08	14:15:00	431925566	274	668035126	977667032	Meuhedet Pediatric Clinic	Herzl St 134, Holon
1875	2025-08-18	19:15:00	431782073	49	896973596	323208385	Leumit Clinic	Herzl St 62, Kfar Saba
1876	2025-09-21	09:15:00	977648192	265	678506268	\N	Maccabi Women's Clinic	HaHistadrut St 89, Ashdod
1877	2025-01-12	17:00:00	129762178	92	427852785	904402564	Meuhedet Clinic	HaShalom Rd 118, Jerusalem
1878	2025-06-23	13:15:00	537493895	44	334099421	926151796	Maccabi Health Center	HaYarkon St 132, Ashdod
1879	2025-01-01	15:00:00	607933636	87	587927685	\N	Leumit City Clinic	Jabotinsky St 124, Haifa
1880	2025-09-27	20:00:00	355235662	86	244282748	\N	Maccabi Women's Clinic	Herzl St 74, Holon
1881	2025-04-04	12:00:00	626008407	186	282498842	120252841	Leumit Health Center	Allenby St 40, Bnei Brak
1882	2025-08-12	11:00:00	762364645	309	318943388	744541166	Clalit Pediatric Clinic	HaPalmach St 37, Rehovot
1883	2025-09-07	08:45:00	177702985	212	106210399	744541166	Clalit Women's Clinic	HaYarkon St 60, Ashkelon
1884	2025-01-11	06:45:00	465944468	233	410254424	365083334	Maccabi Pediatric Clinic	HaYarkon St 111, Beersheba
1885	2025-11-21	08:45:00	326216990	88	231324781	186854746	Meuhedet City Clinic	Begin Blvd 64, Tel Aviv
1886	2025-03-26	09:15:00	345789475	201	913568600	457148964	Maccabi Family Clinic	Jabotinsky St 5, Rehovot
1887	2025-06-16	13:00:00	657393222	130	909580633	233341981	Maccabi Health Center	HaTikva St 63, Jerusalem
1888	2025-05-20	16:45:00	974746813	315	175078783	545281216	Maccabi Pediatric Clinic	Rothschild Ave 58, Holon
1889	2025-11-28	16:15:00	860088812	352	195106131	300885051	Leumit Women's Clinic	Ben Gurion Blvd 42, Bat Yam
1890	2025-01-26	11:30:00	993112782	337	452354109	732231442	Meuhedet Pediatric Clinic	HaHistadrut St 44, Bnei Brak
1891	2025-07-27	16:15:00	163977003	243	869029092	535842430	Maccabi Family Clinic	Herzl St 145, Jerusalem
1892	2025-03-07	07:30:00	221634502	146	808677201	358401641	Meuhedet Clinic	Rothschild Ave 113, Rishon LeZion
1893	2025-11-15	07:00:00	371217957	127	835425519	162854543	Leumit City Clinic	HaPalmach St 11, Haifa
1894	2025-11-19	16:00:00	188765341	358	583133229	510589173	Leumit Health Center	Sokolov St 32, Herzliya
1895	2025-09-12	17:00:00	926419142	136	106107388	858675688	Leumit Clinic	Weizmann St 138, Bnei Brak
1896	2025-02-12	09:15:00	469589167	197	583133229	467683186	Maccabi Family Clinic	HaHistadrut St 28, Rishon LeZion
1897	2025-11-26	18:15:00	367818889	198	452354109	358401641	Meuhedet Health Center	Jabotinsky St 143, Holon
1898	2025-11-10	08:30:00	890970312	90	517697659	569598179	Leumit Pediatric Clinic	Begin Blvd 130, Ra'anana
1899	2025-08-16	06:15:00	797776394	252	678506268	717220517	Meuhedet Health Center	Jabotinsky St 37, Rishon LeZion
1900	2025-07-26	09:00:00	352506228	264	705338121	549847210	Maccabi City Clinic	HaPalmach St 85, Beersheba
1901	2025-11-26	14:00:00	299229343	296	286582552	\N	Meuhedet Pediatric Clinic	HaPalmach St 113, Jerusalem
1902	2025-01-16	14:00:00	174306440	272	493394881	136335319	Leumit Family Clinic	Sokolov St 110, Netanya
1903	2025-04-16	17:15:00	473412170	126	503075904	928678498	Clalit Clinic	Jabotinsky St 56, Ashdod
1904	2025-04-01	14:30:00	409466719	14	980860075	608281507	Meuhedet Women's Clinic	Sokolov St 123, Netanya
1905	2025-03-16	09:00:00	508184542	294	646651118	991202503	Leumit Clinic	HaHistadrut St 111, Netanya
1906	2025-11-21	15:45:00	111387179	196	469439493	798009672	Hadassah Ein Kerem Hospital	Herzl St 24, Haifa
1907	2025-01-11	16:45:00	542297151	172	205096731	946589413	Leumit Clinic	Jabotinsky St 51, Ashkelon
1908	2025-02-20	18:45:00	680566675	192	517697659	405385808	Meuhedet Clinic	Weizmann St 71, Ashkelon
1909	2025-02-11	13:00:00	560347583	213	675610128	367550207	Leumit Health Center	HaYarkon St 62, Bnei Brak
1910	2025-05-27	20:00:00	510369863	138	385015287	\N	Maccabi Health Center	Weizmann St 98, Ashkelon
1911	2025-06-04	16:45:00	467713954	67	335528238	896666994	Leumit Women's Clinic	HaYarkon St 113, Rishon LeZion
1912	2025-10-21	16:45:00	107106212	355	581537784	146343109	Clalit Family Clinic	HaYarkon St 28, Bat Yam
1913	2025-02-23	10:00:00	963025761	165	808943895	200778361	Rambam Health Campus	HaYarkon St 65, Jerusalem
1914	2025-04-14	18:00:00	632577955	240	523388008	510589173	Clalit City Clinic	Jabotinsky St 41, Bnei Brak
1915	2025-11-09	12:30:00	191561261	343	646651118	233025558	Meuhedet Family Clinic	HaHistadrut St 144, Beersheba
1916	2025-04-12	18:00:00	290221251	396	318943388	524957376	Clalit Clinic	Ben Gurion Blvd 111, Beersheba
1917	2025-05-09	20:30:00	860088812	282	651447743	120252841	Clalit Family Clinic	HaHistadrut St 97, Bat Yam
1918	2025-08-05	19:30:00	249140620	169	325430239	\N	Maccabi Women's Clinic	Herzl St 112, Tel Aviv
1919	2025-12-24	20:00:00	284489969	169	582888025	609883589	Meuhedet Family Clinic	HaPalmach St 19, Rishon LeZion
1920	2025-01-23	14:15:00	367818889	336	710030144	\N	Clalit Family Clinic	HaHistadrut St 19, Holon
1921	2025-09-12	09:00:00	799742877	272	508895013	114916894	Maccabi Women's Clinic	Herzl St 74, Holon
1922	2025-06-06	14:15:00	760208651	29	356308687	545281216	Meuhedet Pediatric Clinic	HaHistadrut St 39, Netanya
1923	2025-05-14	10:30:00	483346047	24	503075904	\N	Clalit Women's Clinic	HaHistadrut St 148, Ramat Gan
1924	2025-03-26	06:45:00	470869626	347	410254424	\N	Clalit Women's Clinic	HaTikva St 9, Haifa
1925	2025-06-08	10:15:00	189128964	15	314241360	691399121	Leumit City Clinic	Weizmann St 138, Modiin
1926	2025-08-13	10:00:00	754151802	363	927916320	323208385	Leumit Women's Clinic	Ben Gurion Blvd 116, Rehovot
1927	2025-07-10	20:15:00	894985571	214	294557346	\N	Leumit Pediatric Clinic	Ben Gurion Blvd 117, Rehovot
1928	2025-01-09	18:00:00	469589167	80	103198638	974562766	Clalit Pediatric Clinic	HaPalmach St 37, Rehovot
1929	2025-01-20	17:15:00	475277239	24	390750761	\N	Leumit Clinic	HaHistadrut St 111, Netanya
1930	2025-05-27	12:15:00	198401039	265	375218533	733386484	Clalit Family Clinic	Begin Blvd 107, Netanya
1931	2025-08-26	20:00:00	782770105	212	311784393	660542544	Sheba Medical Center	HaShalom Rd 83, Tel Aviv
1932	2025-09-20	09:15:00	209732140	314	893399035	\N	Meuhedet City Clinic	Herzl St 144, Bat Yam
1933	2025-08-01	18:45:00	174043533	245	914566516	745588939	Maccabi Pediatric Clinic	HaPalmach St 49, Bat Yam
1934	2025-09-16	11:15:00	388934046	302	325430239	809751526	Meuhedet Family Clinic	Begin Blvd 73, Bnei Brak
1935	2025-09-10	14:45:00	590652532	40	325430239	134938340	Meuhedet City Clinic	Menachem Begin St 90, Tel Aviv
1936	2025-04-22	14:15:00	276643268	229	738536844	990265405	Clalit Clinic	Ben Gurion Blvd 111, Beersheba
1937	2025-01-09	09:45:00	682247730	349	151385895	134938340	Leumit City Clinic	Allenby St 107, Beersheba
1938	2025-06-27	09:15:00	893684024	94	530516374	233341981	Maccabi Clinic	HaShalom Rd 37, Kfar Saba
1939	2025-06-19	15:15:00	965413870	237	262180529	216674676	Maccabi Pediatric Clinic	HaPalmach St 92, Holon
1940	2025-12-19	06:30:00	129762178	223	914566516	292563039	Leumit Family Clinic	Sokolov St 20, Ashdod
1941	2025-06-18	12:15:00	274894140	225	765574491	927259391	Maccabi Clinic	HaPalmach St 36, Tel Aviv
1942	2025-12-15	20:30:00	310637280	330	282498842	831565842	Clalit Women's Clinic	Herzl St 44, Haifa
1943	2025-04-26	08:30:00	408340579	328	705338121	557387584	Maccabi Pediatric Clinic	HaShalom Rd 40, Kfar Saba
1944	2025-10-20	18:45:00	843075942	247	870478094	115674283	Meuhedet Clinic	Ben Gurion Blvd 9, Rishon LeZion
1945	2025-07-27	12:00:00	156313275	172	668035126	733386484	Sheba Medical Center	HaShalom Rd 83, Tel Aviv
1946	2025-03-09	07:30:00	582442635	391	170476311	333012046	Leumit Health Center	Allenby St 40, Bnei Brak
1947	2025-02-07	12:15:00	409466719	146	495900140	330948886	Clalit City Clinic	Sokolov St 78, Herzliya
1948	2025-03-17	16:45:00	612117711	9	722223783	525443476	Meuhedet Pediatric Clinic	Weizmann St 102, Haifa
1949	2025-07-18	10:00:00	893684024	128	967238983	523195752	Maccabi Pediatric Clinic	Sokolov St 62, Petah Tikva
1950	2025-02-07	19:15:00	536640092	199	983060617	919941861	Maccabi Pediatric Clinic	HaPalmach St 47, Netanya
1951	2025-07-09	06:30:00	590652532	11	414131125	886553988	Maccabi City Clinic	HaPalmach St 28, Modiin
1952	2025-07-25	12:15:00	149181012	229	809797531	499722276	Maccabi Clinic	HaPalmach St 36, Tel Aviv
1953	2025-04-04	08:45:00	887631402	33	902246089	391559775	Meuhedet City Clinic	HaHistadrut St 124, Rehovot
1954	2025-10-14	20:00:00	463548843	286	580038886	181098189	Leumit Women's Clinic	Sokolov St 98, Bnei Brak
1955	2025-08-02	08:30:00	789677587	130	809797531	297714695	Leumit Clinic	Herzl St 62, Kfar Saba
1956	2025-02-15	18:15:00	689825727	355	952751158	216674676	Maccabi Pediatric Clinic	Herzl St 12, Jerusalem
1957	2025-02-28	16:00:00	188769931	302	170476311	595566634	Maccabi Family Clinic	HaNegev St 59, Rehovot
1958	2025-01-28	16:30:00	267348942	262	613307691	330948886	Maccabi Pediatric Clinic	Weizmann St 60, Rishon LeZion
1959	2025-03-16	10:30:00	319864750	343	571289027	991164471	Clalit Health Center	Jabotinsky St 51, Netanya
1960	2025-06-13	20:45:00	591879309	368	111533007	\N	Leumit Family Clinic	Ben Gurion Blvd 2, Modiin
1961	2025-03-04	09:15:00	163350630	342	484821493	585426153	Maccabi Family Clinic	HaHistadrut St 28, Rishon LeZion
1962	2025-03-19	11:15:00	290221251	18	303635805	608281507	Clalit Pediatric Clinic	HaShalom Rd 49, Jerusalem
1963	2025-10-13	16:00:00	417243925	141	339014530	484495578	Meuhedet Clinic	Sokolov St 68, Bat Yam
1964	2025-03-01	19:15:00	110151501	228	325430239	567352637	Clalit City Clinic	Sokolov St 78, Herzliya
1965	2025-01-02	09:00:00	704835566	70	333059661	831565842	Leumit Pediatric Clinic	Begin Blvd 68, Modiin
1966	2025-08-26	09:15:00	272193302	294	517697659	\N	Meuhedet Women's Clinic	Ben Gurion Blvd 119, Holon
1967	2025-05-24	11:15:00	221634502	277	902246089	655853037	Leumit Pediatric Clinic	Menachem Begin St 92, Jerusalem
1968	2025-05-01	12:45:00	682247730	171	747832838	634188128	Meuhedet Clinic	Rothschild Ave 94, Rehovot
1969	2025-09-16	17:45:00	892550568	121	808677201	642778231	Clalit Women's Clinic	HaTikva St 7, Ashdod
1970	2025-01-10	11:45:00	251420151	67	668035126	770618338	Maccabi Pediatric Clinic	Sokolov St 62, Petah Tikva
1971	2025-04-17	17:30:00	283767201	84	489601917	457148964	Leumit Women's Clinic	Ben Gurion Blvd 76, Rehovot
1972	2025-05-28	15:15:00	498056409	138	111533007	222522748	Leumit Clinic	Weizmann St 37, Bnei Brak
1973	2025-10-09	16:30:00	699825997	369	410962502	330948886	Leumit Clinic	HaHistadrut St 111, Netanya
1974	2025-09-05	15:45:00	726107543	33	678506268	222522748	Clalit Women's Clinic	Sokolov St 96, Ashkelon
1975	2025-07-10	12:00:00	314642987	288	651938317	644870997	Clalit Health Center	Weizmann St 13, Haifa
1976	2025-08-18	08:00:00	409960350	123	703776850	146343109	Leumit Health Center	HaShalom Rd 19, Haifa
1977	2025-03-28	18:30:00	945922559	289	808943895	216674676	Clalit Health Center	Menachem Begin St 49, Beersheba
1978	2025-06-13	14:45:00	894985571	356	604840053	432026089	Clalit Pediatric Clinic	HaPalmach St 37, Rehovot
1979	2025-03-17	16:00:00	836728213	240	565425153	223034510	Leumit Women's Clinic	Ben Gurion Blvd 141, Ashkelon
1980	2025-01-28	15:30:00	607933636	274	419832401	578303296	Maccabi Family Clinic	Herzl St 145, Jerusalem
1981	2025-06-24	17:15:00	207067497	346	215791975	975354103	Meuhedet Health Center	Jabotinsky St 143, Holon
1982	2025-06-19	06:30:00	258775091	231	111533007	114916894	Barzilai Medical Center	HaNegev St 45, Ramat Gan
1983	2025-09-05	20:30:00	946244382	291	902246089	499722276	Maccabi Family Clinic	HaYarkon St 77, Kfar Saba
1984	2025-03-05	18:00:00	504527711	363	356308687	\N	Meuhedet City Clinic	Ben Gurion Blvd 96, Ramat Gan
1985	2025-05-01	17:45:00	299085717	32	151385895	104731999	Leumit City Clinic	Rothschild Ave 115, Herzliya
1986	2025-05-16	17:00:00	396524353	30	240709151	123889591	Leumit Clinic	Jabotinsky St 21, Rehovot
1987	2025-08-19	10:30:00	813482571	29	808677201	\N	Leumit Health Center	Herzl St 52, Jerusalem
1988	2025-03-24	10:00:00	285594371	32	215791975	333012046	Clalit Women's Clinic	Jabotinsky St 116, Modiin
1989	2025-04-27	12:30:00	367818889	135	835425519	652055112	Leumit Clinic	HaHistadrut St 111, Netanya
1990	2025-09-19	16:15:00	797776394	69	414316626	\N	Clalit City Clinic	Begin Blvd 61, Rishon LeZion
1991	2025-05-11	13:30:00	294996591	261	484821493	421967560	Clalit City Clinic	HaTikva St 80, Bat Yam
1992	2025-10-10	13:30:00	403792403	192	106107388	\N	Leumit Women's Clinic	HaShalom Rd 101, Ashdod
1993	2025-04-02	20:45:00	122403164	26	484821493	926151796	Clalit Pediatric Clinic	HaPalmach St 37, Rehovot
1994	2025-11-06	07:00:00	542415875	300	205096731	\N	Leumit Health Center	HaHistadrut St 16, Ashkelon
1995	2025-02-28	18:30:00	172617282	321	493394881	181098189	Clalit City Clinic	Herzl St 84, Netanya
1996	2025-09-14	18:15:00	367688443	154	604840053	\N	Leumit Health Center	Weizmann St 145, Petah Tikva
1997	2025-05-03	11:15:00	910273798	375	157794649	557387584	Meuhedet Family Clinic	Begin Blvd 74, Jerusalem
1998	2025-09-18	13:30:00	844888238	329	740682739	134938340	Meuhedet Clinic	Weizmann St 71, Ashkelon
1999	2025-09-19	17:30:00	460087435	267	495900140	310258592	Leumit City Clinic	Jabotinsky St 3, Rishon LeZion
2000	2025-12-10	06:00:00	431782073	256	130440929	\N	Meuhedet Pediatric Clinic	HaTikva St 104, Kfar Saba
\.


--
-- TOC entry 3408 (class 0 OID 41076)
-- Dependencies: 222
-- Data for Name: transport_assistant; Type: TABLE DATA; Schema: public; Owner: esti
--

COPY public.transport_assistant (volunteer_id, has_medical_training) FROM stdin;
928678498	Y
642778231	Y
950189399	N
595566634	N
523462070	N
277362370	Y
557387584	N
106823913	N
522199986	N
798009672	N
660542544	Y
333012046	N
455096535	Y
732231442	Y
468701304	Y
770618338	Y
674960706	Y
193901152	N
876785540	N
510589173	Y
644870997	N
143764555	N
913520210	Y
112742705	Y
937895475	Y
442531669	N
567352637	N
372000492	Y
406350060	Y
919941861	N
927259391	Y
134938340	Y
467683186	Y
181098189	Y
477791140	N
757351763	Y
104731999	N
636489403	Y
655853037	N
266685039	N
733386484	Y
392263901	N
904402564	N
367550207	N
946589413	N
413603064	Y
515517676	Y
146343109	N
744541166	Y
535842430	N
169095841	N
716745655	Y
743393691	Y
745588939	Y
525443476	Y
545281216	N
549847210	N
467137650	N
297714695	N
291145247	N
485241165	N
858675688	N
975354103	N
150886100	Y
136335319	N
292563039	Y
330948886	N
233715310	Y
153432684	Y
990265405	Y
588485108	Y
977667032	Y
543138407	N
421967560	Y
967167857	Y
717220517	Y
300685875	Y
457148964	Y
254040510	N
432026089	N
587248600	Y
452367681	N
200778361	Y
585034134	N
358401641	Y
358890331	Y
694876741	N
788565519	Y
139987077	Y
637417326	N
857599583	N
702439977	N
364330977	Y
569598179	N
853912682	Y
638619639	Y
124787141	Y
608281507	Y
310258592	N
446763595	Y
835357628	N
115674283	N
974562766	N
867910701	Y
931089150	N
323208385	Y
579396263	N
991202503	N
652055112	Y
114916894	Y
809751526	Y
302016206	Y
609883589	N
886567223	N
523195752	N
120252841	N
307638987	N
379085236	Y
164347844	Y
705977773	N
585426153	Y
560761358	N
886553988	Y
365083334	Y
958396544	Y
785743985	N
173735333	Y
700986555	Y
590833948	N
500823705	Y
739732268	Y
673012407	Y
123889591	Y
310449903	Y
621805679	N
233341981	Y
803631502	Y
691399121	N
620872913	Y
475678577	Y
216674676	N
792123494	N
162854543	N
627217360	N
549041678	N
770913744	Y
398331058	Y
642311259	Y
152943249	N
680422772	N
896666994	Y
705808415	N
222522748	N
508458268	Y
692757934	N
856141290	N
134463780	N
233025558	Y
745929637	Y
991164471	N
877651756	Y
640036600	Y
210440926	N
484495578	N
205288611	Y
403951290	N
391559775	Y
228630954	N
154749464	Y
718179719	Y
641246037	Y
642573144	N
405385808	Y
165928627	Y
926559749	N
831565842	Y
236536222	N
437174782	N
264594643	N
125478540	Y
632667768	Y
288012548	N
444687035	N
926151796	N
720046881	N
186854746	N
634188128	N
826996680	N
524957376	Y
300885051	N
379926927	Y
793942949	Y
499722276	Y
578118209	Y
154992568	N
223034510	N
289805994	N
578303296	Y
106374385	Y
799658255	N
\.


--
-- TOC entry 3404 (class 0 OID 40966)
-- Dependencies: 218
-- Data for Name: vehicle; Type: TABLE DATA; Schema: public; Owner: esti
--

COPY public.vehicle (vehicle_id, license_plate, type, capacity) FROM stdin;
1	7656769	Accessible van	8
2	9336409	car	4
3	7051995	Ambulance	7
4	4682154	car	8
5	9945157	car	7
6	8872915	Accessible van	4
7	3201424	Accessible van	8
8	1377643	Accessible van	7
9	5677607	Ambulance	7
10	8399189	car	8
11	3384341	Accessible van	6
12	5170359	car	5
13	3287580	car	8
14	6445234	Accessible van	8
15	5039585	Ambulance	7
16	6964574	Ambulance	7
17	1832682	Ambulance	8
18	9851039	car	6
19	1744443	car	5
20	8121666	Accessible van	4
21	7690724	Accessible van	6
22	2762429	Accessible van	8
23	4769662	Accessible van	6
24	3310727	Accessible van	7
25	7238977	Accessible van	7
26	5059553	Ambulance	8
27	4703570	Accessible van	7
28	3408998	Ambulance	8
29	1091343	Ambulance	6
30	2368769	car	4
31	7846750	car	8
32	7984318	Ambulance	6
33	1068620	car	8
34	2919526	Accessible van	7
35	8108381	car	5
36	8184480	car	4
37	2550217	Ambulance	8
38	4796021	car	8
39	2747357	car	6
40	2198058	Ambulance	8
41	8299487	Ambulance	7
42	4956166	Accessible van	5
43	2559683	Accessible van	4
44	7617326	car	4
45	7653801	car	6
46	6649902	Ambulance	8
47	5233837	car	4
48	1750969	car	8
49	6330455	Ambulance	5
50	7992500	Accessible van	4
51	8099730	car	6
52	1377637	Accessible van	6
53	2408452	car	8
54	6319789	car	4
55	1313765	Accessible van	4
56	9116322	Ambulance	5
57	1587869	Ambulance	6
58	2873267	Ambulance	5
59	7888526	Ambulance	6
60	3276379	car	5
61	7149677	Ambulance	7
62	3689446	Accessible van	7
63	3098335	Ambulance	5
64	8773955	Accessible van	4
65	5159618	Accessible van	7
66	5369073	car	5
67	3612756	Ambulance	4
68	1408159	Accessible van	4
69	9265839	Ambulance	4
70	4279526	car	8
71	8862381	Accessible van	4
72	3154632	Accessible van	7
73	4702665	Ambulance	5
74	7595154	Ambulance	7
75	8440796	Ambulance	5
76	6539009	car	8
77	9271386	car	7
78	2365620	Ambulance	8
79	3337094	car	8
80	2710806	Accessible van	8
81	9947482	Ambulance	6
82	8397217	Ambulance	6
83	5815248	Ambulance	7
84	3593109	Ambulance	8
85	1940212	Ambulance	8
86	8040166	car	7
87	6820232	car	7
88	8017396	Accessible van	5
89	8859692	car	7
90	6723317	car	6
91	2538676	car	8
92	1934770	Accessible van	5
93	5923799	Ambulance	4
94	2523862	car	5
95	6341488	car	7
96	1919885	Accessible van	8
97	6159921	car	8
98	9034050	Ambulance	4
99	8667805	Accessible van	6
100	1812066	Ambulance	6
101	8003560	Accessible van	5
102	5448346	Accessible van	7
103	5767453	car	6
104	9343412	Ambulance	6
105	3150968	car	8
106	8319682	Ambulance	4
107	8044609	Ambulance	5
108	7228276	Accessible van	4
109	6693860	Ambulance	4
110	3414212	car	4
111	8613772	car	5
112	4497422	car	4
113	1594834	Ambulance	7
114	8586134	car	8
115	6427915	Ambulance	6
116	5395477	Accessible van	5
117	5027268	Ambulance	5
118	6034111	Ambulance	5
119	3944756	Accessible van	7
120	1745503	Ambulance	8
121	6526293	car	7
122	9780595	Ambulance	4
123	5466754	Accessible van	4
124	5952401	car	8
125	3220423	Ambulance	7
126	3483372	Ambulance	6
127	5565524	car	8
128	7365294	Ambulance	6
129	2396971	car	5
130	5853057	Ambulance	8
131	4884907	Accessible van	4
132	7727854	car	4
133	7567241	Ambulance	6
134	1536353	Ambulance	8
135	8826647	Accessible van	6
136	6942224	Accessible van	4
137	7060545	Accessible van	8
138	9848537	Ambulance	5
139	8643331	Ambulance	4
140	2901273	Ambulance	5
141	3538118	Ambulance	5
142	6718471	Accessible van	8
143	6036611	car	4
144	3662381	car	7
145	7983120	Ambulance	7
146	4863301	car	4
147	2800463	Accessible van	4
148	9196697	Accessible van	7
149	9081556	Ambulance	8
150	6223760	Accessible van	8
151	1258198	car	4
152	4751557	Ambulance	6
153	3249899	Accessible van	5
154	6045702	Ambulance	4
155	4675111	car	6
156	9159244	Accessible van	5
157	4146157	Ambulance	7
158	7704223	Ambulance	7
159	3388816	Ambulance	5
160	4676693	Accessible van	8
161	4494656	car	7
162	2862062	Ambulance	6
163	4605148	Accessible van	7
164	2503871	Ambulance	7
165	6374048	Accessible van	4
166	7370275	Ambulance	6
167	3224895	Accessible van	6
168	6851817	Ambulance	7
169	2224034	Ambulance	6
170	3376220	car	5
171	7142553	car	8
172	7694737	Accessible van	8
173	3309704	Accessible van	6
174	9945018	Accessible van	7
175	1121968	Ambulance	4
176	8942472	Ambulance	4
177	8474296	car	7
178	7442899	Ambulance	7
179	5079345	Accessible van	5
180	1788243	Ambulance	8
181	2230479	car	6
182	4632190	Ambulance	6
183	7238626	Accessible van	8
184	6806352	car	8
185	3472514	Accessible van	4
186	2356227	car	4
187	1718521	car	6
188	5312989	car	7
189	3708705	Accessible van	4
190	3132858	Ambulance	8
191	9607022	Ambulance	5
192	4593271	car	5
193	4021252	Ambulance	8
194	7601063	Accessible van	7
195	6790875	Accessible van	6
196	5266671	Accessible van	6
197	7728439	car	4
198	2186044	Ambulance	7
199	7498762	car	8
200	9856628	car	7
201	2235752	Accessible van	5
202	4089158	car	7
203	9791769	Ambulance	5
204	6015922	Accessible van	4
205	2221350	Accessible van	6
206	1415483	Accessible van	4
207	5449081	Accessible van	7
208	9155156	Ambulance	7
209	6266086	Ambulance	6
210	8341041	Ambulance	8
211	1387269	Accessible van	7
212	1074922	car	5
213	3227317	car	7
214	9315781	car	5
215	7939969	car	4
216	9309801	car	5
217	8826144	car	7
218	7907089	Accessible van	5
219	9400531	Ambulance	6
220	5721787	Ambulance	5
221	3440983	Accessible van	7
222	3431594	car	7
223	9402997	car	6
224	6345244	car	6
225	8865276	car	4
226	5448876	Accessible van	8
227	1800938	Accessible van	5
228	3316350	car	5
229	2336436	Accessible van	8
230	5401550	Accessible van	5
231	5286250	Ambulance	8
232	2221786	car	6
233	7201808	car	5
234	9678426	car	7
235	2973620	Ambulance	8
236	5475781	Accessible van	7
237	1701892	Ambulance	6
238	3027222	Ambulance	4
239	4256905	Accessible van	8
240	6389238	Ambulance	8
241	1760542	Ambulance	5
242	6776208	Accessible van	7
243	2931020	Ambulance	6
244	8392157	Ambulance	8
245	8236771	Accessible van	8
246	5301590	car	7
247	8772007	Accessible van	8
248	8183936	Ambulance	4
249	1760195	car	5
250	4352901	Ambulance	6
251	8259267	Ambulance	6
252	2611827	car	4
253	8320100	Accessible van	7
254	2560388	Accessible van	7
255	2123035	Ambulance	7
256	3606741	car	8
257	1079314	Accessible van	4
258	7721105	Ambulance	7
259	6704074	car	4
260	7390203	Ambulance	5
261	3934670	car	5
262	9475205	car	6
263	3331992	Accessible van	6
264	9422895	Accessible van	8
265	7228630	car	4
266	2971462	Ambulance	6
267	1784662	Accessible van	5
268	6251775	Ambulance	5
269	5249142	Accessible van	6
270	2854778	car	5
271	2009480	car	5
272	2927461	car	7
273	9004220	car	7
274	7167374	Accessible van	7
275	8785425	car	5
276	2993675	Ambulance	5
277	5521272	car	4
278	3027150	Accessible van	8
279	6597490	Ambulance	7
280	4836422	Accessible van	4
281	8297469	Accessible van	6
282	5935096	Ambulance	6
283	1593578	car	5
284	5598012	Ambulance	4
285	5579927	Ambulance	6
286	8143281	Accessible van	6
287	4537085	car	5
288	6092087	Ambulance	4
289	8776260	car	5
290	7561283	car	4
291	8945260	car	5
292	3409402	car	6
293	5319224	Accessible van	6
294	5701883	car	5
295	6345681	Accessible van	4
296	2640047	Ambulance	8
297	8673626	Ambulance	5
298	9755714	Accessible van	7
299	3225719	car	6
300	9412128	Ambulance	7
301	6455032	Ambulance	4
302	4520807	Accessible van	8
303	8536908	Accessible van	6
304	8112280	car	7
305	5167586	Ambulance	5
306	2487349	Accessible van	7
307	8232541	car	7
308	2159101	Ambulance	8
309	7280551	Ambulance	7
310	6520185	Ambulance	7
311	6707819	Ambulance	5
312	5875575	Ambulance	5
313	5169629	car	5
314	4600932	Ambulance	8
315	7327609	Accessible van	7
316	5581155	Accessible van	4
317	5831044	Accessible van	4
318	5614507	Accessible van	8
319	4826059	car	5
320	3007385	Ambulance	7
321	4475208	Ambulance	6
322	6274422	Accessible van	5
323	7083704	Accessible van	4
324	4309854	Ambulance	7
325	3922138	car	8
326	4823924	Accessible van	4
327	3400680	car	8
328	7256000	car	7
329	2931688	Ambulance	8
330	3198885	Accessible van	7
331	5101024	car	8
332	2259047	Ambulance	5
333	9645077	Ambulance	4
334	1059751	Ambulance	7
335	5485979	Ambulance	6
336	8861911	car	4
337	9629253	Accessible van	6
338	6249037	car	8
339	6058395	car	7
340	1655898	Accessible van	8
341	6511292	Accessible van	5
342	9280585	car	8
343	9886380	car	8
344	6178491	Ambulance	8
345	6668800	car	5
346	9263149	car	6
347	8333628	Ambulance	8
348	8105852	car	4
349	9201092	Accessible van	8
350	6369902	Ambulance	7
351	9729679	car	7
352	3339110	Ambulance	7
353	3463066	Accessible van	5
354	5411293	car	7
355	6711095	car	5
356	5188039	car	6
357	3668101	car	5
358	9324084	Accessible van	6
359	1849440	Ambulance	4
360	8495798	Accessible van	4
361	6245265	car	6
362	1799449	Accessible van	5
363	8466873	Ambulance	8
364	3484681	Ambulance	7
365	5838597	Accessible van	6
366	6486811	Accessible van	5
367	3693016	Ambulance	8
368	1238349	Accessible van	8
369	8446857	Ambulance	8
370	5561432	car	4
371	7813320	car	4
372	5205602	Ambulance	6
373	9941878	car	5
374	9254954	car	5
375	8038781	Ambulance	6
376	7507811	car	8
377	3691736	Accessible van	6
378	7258546	Accessible van	7
379	4588017	car	8
380	3707538	Accessible van	8
381	8061987	Accessible van	6
382	3355651	Ambulance	4
383	1983255	Accessible van	4
384	4547249	Ambulance	8
385	1959884	Ambulance	7
386	5704718	Accessible van	8
387	9745642	Accessible van	7
388	6365807	Accessible van	8
389	6694270	Ambulance	7
390	3384771	Ambulance	5
391	9889450	car	7
392	5705590	Ambulance	8
393	1312023	car	8
394	8571823	Ambulance	6
395	8881807	car	6
396	5613345	Accessible van	5
397	1461118	car	7
398	6402234	car	8
399	9377126	Accessible van	7
400	5958663	Ambulance	6
\.


--
-- TOC entry 3405 (class 0 OID 40976)
-- Dependencies: 219
-- Data for Name: volunteer; Type: TABLE DATA; Schema: public; Owner: esti
--

COPY public.volunteer (volunteer_id, first_name, last_name, date_of_birth, phone_number, city) FROM stdin;
799258702	Shira	Tzadok	1975-09-30	502548748	Tel Aviv
646651118	Idan	Malka	2005-05-24	551651485	Ashdod
632667768	Inbal	Malka	1959-03-03	522064160	Petah Tikva
303635805	Hila	Ben-David	1954-11-12	515480487	Haifa
636489403	Omer	Ziv	1985-06-01	587931058	Netanya
205288611	Shira	Avraham	1996-07-01	562661295	Holon
809797531	Ron	Ziv	1992-07-17	532686000	Holon
942705156	Michal	Abutbul	1961-01-13	536597420	Petah Tikva
314241360	Daniel	Cohen	1959-03-20	556197579	Ashdod
121065055	Noa	Malka	1990-10-25	527353800	Rishon LeZion
543138407	Idan	Hazan	1968-09-25	580935738	Holon
489601917	Tomer	Katz	1988-08-27	523573012	Haifa
989164091	Noa	Hazan	1972-04-11	521643945	Haifa
720046881	Ofir	Barak	1963-03-31	517387840	Rishon LeZion
385321066	Omer	Amar	1977-12-24	538746989	Ashdod
282498842	Amit	Tzadok	1958-11-29	509391469	Haifa
867910701	Aviv	Barak	1970-11-08	522451422	Holon
216674676	Ron	Avraham	1979-05-18	503950679	Ramat Gan
200778361	Idan	Shemesh	1973-08-16	544414600	Haifa
623490063	Aviv	Levi	1964-12-18	583657247	Jerusalem
718084895	Eyal	Ben-David	1984-01-19	561799937	Holon
890623488	Tomer	Peretz	1991-03-13	528310067	Ramat Gan
222522748	Tal	Abutbul	2002-02-08	504248209	Holon
675610128	Tomer	Sharon	1974-10-26	558246139	Holon
732231442	Aviv	Cohen	1995-11-09	526733570	Jerusalem
567352637	Tal	Ben-David	1998-09-25	591329923	Ashdod
437174782	Aviv	Abutbul	1990-03-23	519756398	Ramat Gan
896973596	Lior	Hazan	1954-10-06	550105186	Be'er Sheva
124787141	Ori	Cohen	1999-09-05	578460545	Haifa
587248600	Aviv	Cohen	1991-12-21	560255322	Petah Tikva
151385895	Tomer	Cohen	1974-08-09	553340541	Tel Aviv
667143420	Hila	Abutbul	1999-05-17	511394101	Ramat Gan
403951290	Idan	Ziv	1961-04-12	582020250	Tel Aviv
799658255	Tomer	Amar	1963-05-15	530199332	Be'er Sheva
946589413	Amit	Ben-David	1972-03-24	505602886	Jerusalem
375913224	Shira	Barak	1962-01-31	560162887	Ramat Gan
110532551	Michal	Malka	1961-07-07	578923393	Rishon LeZion
869029092	Ofir	Cohen	2004-10-01	548186896	Haifa
913568600	Ron	Dayan	1991-11-17	518856364	Ramat Gan
130440929	Aviv	Hazan	1964-10-22	596099531	Haifa
193901152	Amit	Cohen	1972-10-06	546987261	Netanya
115674283	Lior	Ziv	1973-05-28	590266696	Be'er Sheva
294557346	Tomer	Golan	1995-05-23	513017142	Ramat Gan
745588939	Inbal	Levi	1968-07-25	508200250	Haifa
604840053	Guy	Cohen	2003-01-24	510460126	Rishon LeZion
186854746	Omer	Barak	1977-07-25	535531307	Haifa
785743985	Ori	Hazan	1968-02-01	531256766	Holon
379926927	Hila	Amar	2001-01-05	566515941	Petah Tikva
335569735	Amit	Shemesh	1997-05-23	545679667	Netanya
500823705	Ron	Ziv	1972-03-12	529658324	Be'er Sheva
655853037	Tomer	Peretz	1988-08-16	598681915	Haifa
620872913	Ron	Tzadok	1987-06-23	531653146	Holon
822386902	Tal	Avraham	1971-04-27	569727413	Tel Aviv
793942949	Lior	Amar	1957-09-08	590366874	Jerusalem
494708371	Aviv	Hazan	1960-07-06	532890401	Be'er Sheva
406350060	Lior	Hazan	1997-05-24	597270153	Ashdod
744541166	Amit	Cohen	1983-01-21	543410306	Netanya
608281507	Idan	Shemesh	1973-01-21	506863618	Netanya
233025558	Ron	Ben-David	1957-03-25	597883546	Be'er Sheva
775579062	Ori	Harari	1954-06-22	551351992	Ramat Gan
565737791	Ofir	Tzadok	1976-12-05	549848863	Petah Tikva
278345196	Tal	Abutbul	2006-09-15	542269001	Netanya
714051919	Tal	Katz	1963-02-18	500840996	Jerusalem
927468908	Tomer	Peretz	1997-08-02	536218532	Netanya
651938317	Ofir	Avraham	1972-01-21	597749327	Ramat Gan
467137650	Omer	Levi	1965-03-24	571709184	Petah Tikva
675033386	Guy	Avraham	2004-09-02	584545411	Netanya
581537784	Shira	Golan	1984-04-18	595776833	Ashdod
569080510	Inbal	Kaplan	1991-10-10	525096733	Holon
933176850	Aviv	Kaplan	2002-04-02	584980456	Haifa
924888731	Guy	Dayan	1983-05-03	514597303	Jerusalem
123889591	Lior	Mizrahi	1992-05-26	586217670	Be'er Sheva
316396883	Yonatan	Tzadok	1954-11-21	535367288	Petah Tikva
974562766	Eyal	Tzadok	1961-11-04	505725768	Ramat Gan
588485108	Tomer	Mizrahi	1959-05-09	579129854	Jerusalem
139987077	Aviv	Amar	2001-04-03	558731899	Ramat Gan
503075904	Amit	Kaplan	1964-05-16	588177424	Ashdod
150886100	Tal	Levi	1991-05-11	576561256	Ashdod
766537646	Eyal	Kaplan	1956-09-06	531923096	Haifa
705808415	Yonatan	Cohen	1979-05-10	509722970	Haifa
525443476	Tal	Ben-David	1993-11-14	540892883	Ramat Gan
327338690	Hila	Golan	1991-10-31	568245777	Jerusalem
579396263	Tal	Barak	1964-04-22	561105126	Jerusalem
980860075	Amit	Barak	1983-06-24	549909612	Tel Aviv
578118209	Lior	Hazan	1962-11-26	582009472	Holon
121502474	Amit	Dayan	1957-01-28	504839963	Ramat Gan
788565519	Aviv	Hazan	1975-03-17	573569890	Rishon LeZion
337501464	Eyal	Golan	1979-01-17	588706751	Holon
722223783	Ofir	Ben-David	1956-12-11	539588951	Holon
745929637	Tomer	Kaplan	1978-07-31	526355368	Be'er Sheva
446763595	Daniel	Hazan	1968-07-11	507015538	Be'er Sheva
164347844	Hila	Dayan	2000-08-23	554612204	Rishon LeZion
153432684	Michal	Dayan	1971-03-19	546002085	Haifa
367041409	Shira	Ben-David	1999-08-13	531339287	Holon
913520210	Noa	Barak	1961-03-23	530877322	Rishon LeZion
297714695	Idan	Levi	1978-04-19	552338026	Be'er Sheva
339014530	Guy	Shemesh	1992-04-30	575153270	Ramat Gan
236786603	Omer	Hazan	1981-11-19	522120742	Holon
831565842	Daniel	Sharon	1996-06-19	592291892	Holon
254904175	Eyal	Shemesh	2005-03-26	582811526	Petah Tikva
154749464	Daniel	Malka	1964-09-30	592256224	Tel Aviv
106823913	Shira	Cohen	1970-05-05	526512513	Rishon LeZion
414316626	Aviv	Hazan	1965-04-16	545577125	Rishon LeZion
770359651	Shira	Peretz	1966-04-12	584387234	Ramat Gan
703776850	Aviv	Hazan	1982-04-15	500409307	Ashdod
160913893	Rotem	Golan	1955-12-02	569375580	Haifa
571289027	Idan	Avraham	1966-06-09	506592351	Rishon LeZion
300685875	Guy	Golan	2004-05-09	584042821	Rishon LeZion
580038886	Michal	Dayan	1976-11-01	557545087	Tel Aviv
379085236	Daniel	Golan	1982-04-01	500598772	Petah Tikva
352089792	Inbal	Sharon	1999-10-26	554391985	Rishon LeZion
809751526	Guy	Shemesh	2004-04-01	502853346	Netanya
790255711	Eyal	Golan	1971-02-13	591148965	Jerusalem
927259391	Idan	Peretz	1972-05-21	507852305	Petah Tikva
300697114	Rotem	Avraham	1965-01-23	538812105	Rishon LeZion
427989892	Amit	Ben-David	2001-12-14	574094395	Holon
277290510	Idan	Katz	1980-04-06	524148056	Netanya
146343109	Aviv	Avraham	1956-11-12	508811347	Tel Aviv
421289999	Amit	Dayan	1986-04-06	595602013	Be'er Sheva
808943895	Hila	Mizrahi	1969-05-14	573918223	Petah Tikva
523388008	Lior	Levi	1967-10-24	565250011	Netanya
195106131	Amit	Golan	1985-07-21	503174212	Tel Aviv
104731999	Noa	Shemesh	2002-01-10	509479297	Haifa
951108053	Ori	Barak	1978-01-09	513861312	Holon
134938340	Tomer	Malka	1974-12-31	598847597	Haifa
960240840	Lior	Hazan	1969-09-19	555900800	Ashdod
375218533	Ori	Katz	1969-05-26	564822406	Holon
931089150	Eyal	Kaplan	1955-11-04	579129126	Be'er Sheva
627217360	Noa	Sharon	1999-02-23	525898010	Be'er Sheva
765921635	Guy	Barak	1967-05-17	523454348	Ashdod
175078783	Shira	Shemesh	1981-05-06	546603614	Holon
181098189	Eyal	Amar	1976-07-26	595070553	Tel Aviv
578303296	Tomer	Golan	1973-03-10	551738957	Ashdod
801483903	Guy	Malka	1958-12-15	590596926	Be'er Sheva
652055112	Ron	Amar	2006-11-09	576793850	Tel Aviv
205096731	Shira	Levi	1973-03-23	525627162	Petah Tikva
765574491	Daniel	Ben-David	1978-02-15	557091621	Ramat Gan
967167857	Ron	Shemesh	1997-11-19	584090415	Rishon LeZion
288012548	Tal	Amar	1988-11-23	567982918	Haifa
716745655	Omer	Golan	1981-06-06	552491244	Be'er Sheva
349943042	Tomer	Malka	2000-06-21	507801709	Ashdod
835357628	Tal	Shemesh	1990-09-20	548974665	Tel Aviv
926151796	Noa	Malka	1976-10-06	566884596	Holon
170476311	Omer	Katz	1956-02-10	537403732	Ramat Gan
152943249	Amit	Harari	1962-01-29	576085127	Be'er Sheva
405385808	Inbal	Levi	1972-01-03	515879683	Tel Aviv
162854543	Ron	Peretz	1966-05-20	508016754	Petah Tikva
480434918	Omer	Ben-David	1993-09-27	580466618	Haifa
355020965	Guy	Ziv	1972-04-18	561527612	Ramat Gan
111533007	Eyal	Barak	1956-10-31	553150947	Petah Tikva
602013357	Lior	Levi	1961-08-10	508619534	Be'er Sheva
637417326	Tal	Levi	1994-10-29	500996677	Haifa
886553988	Ori	Levi	1983-10-21	566849747	Petah Tikva
367550207	Rotem	Avraham	1977-10-03	564358688	Haifa
876785540	Daniel	Tzadok	2003-10-23	542213814	Netanya
767059275	Lior	Tzadok	1975-07-30	501681821	Ashdod
165682443	Shira	Levi	1983-12-05	581156196	Haifa
419832401	Idan	Ziv	1995-06-26	564485052	Petah Tikva
410962502	Guy	Ben-David	1989-01-12	514665546	Be'er Sheva
468701304	Yonatan	Cohen	1962-02-06	568279258	Rishon LeZion
565661395	Michal	Hazan	1980-06-11	574080971	Tel Aviv
335528238	Ori	Avraham	1993-06-20	559246404	Haifa
112742705	Ori	Mizrahi	1967-03-02	574775356	Rishon LeZion
902246089	Aviv	Ziv	1971-07-26	574362698	Netanya
983060617	Omer	Katz	1957-04-02	544747934	Jerusalem
634188128	Tal	Harari	2002-06-18	530312165	Holon
358890331	Omer	Sharon	1983-11-27	502325897	Haifa
585034134	Lior	Tzadok	1954-05-07	596588879	Be'er Sheva
508458268	Tomer	Ziv	1989-08-11	550374958	Rishon LeZion
569598179	Ofir	Avraham	1990-11-15	598790529	Netanya
640036600	Omer	Tzadok	2000-12-20	565460824	Petah Tikva
858675688	Daniel	Cohen	2003-03-10	567897881	Netanya
770913744	Ofir	Dayan	2004-09-20	575786674	Be'er Sheva
549847210	Noa	Malka	2004-05-21	560499776	Jerusalem
548621554	Hila	Ziv	1999-11-13	531961261	Netanya
484495578	Idan	Cohen	1967-08-22	594778742	Rishon LeZion
686931483	Michal	Ziv	1979-01-06	503384375	Haifa
670632947	Guy	Golan	1983-07-31	585474841	Petah Tikva
414131125	Ofir	Dayan	1958-12-29	598994037	Rishon LeZion
447168611	Hila	Katz	1999-06-07	538277703	Holon
545281216	Lior	Mizrahi	1976-09-13	543735840	Tel Aviv
927916320	Aviv	Levi	1996-08-20	511037100	Petah Tikva
743393691	Ofir	Dayan	1975-08-05	597856448	Petah Tikva
803631502	Rotem	Malka	1999-05-17	566188609	Netanya
757351763	Lior	Cohen	1962-09-17	545001162	Haifa
826996680	Rotem	Shemesh	2003-03-18	511263991	Ashdod
143764555	Yonatan	Hazan	1974-09-01	512072213	Haifa
492050992	Rotem	Amar	1988-09-27	585064384	Holon
311784393	Tomer	Malka	1975-04-12	540478154	Rishon LeZion
886939800	Ori	Barak	1999-08-12	558842241	Ashdod
286582552	Daniel	Amar	1982-01-08	534307655	Ashdod
668035126	Eyal	Shemesh	1976-06-05	587445608	Be'er Sheva
378127589	Rotem	Ziv	1981-08-12	567117271	Petah Tikva
760677936	Yonatan	Levi	2001-09-04	572211445	Netanya
738536844	Shira	Malka	1974-05-08	568754079	Haifa
132264095	Noa	Golan	1991-12-16	595531443	Haifa
926559749	Shira	Golan	1962-11-22	567445569	Be'er Sheva
589073536	Yonatan	Ben-David	1967-04-15	545599488	Netanya
860923150	Rotem	Ziv	1982-11-04	537839387	Tel Aviv
595351873	Hila	Katz	1999-06-24	550407077	Be'er Sheva
718179719	Daniel	Avraham	1980-01-12	507794379	Netanya
577645975	Michal	Cohen	2000-04-27	546370800	Holon
642311259	Tal	Shemesh	2005-02-20	584013150	Jerusalem
262180529	Rotem	Mizrahi	1966-01-27	506544405	Netanya
835425519	Eyal	Malka	1996-02-12	571622587	Ramat Gan
870880025	Ori	Harari	1992-12-16	533432544	Be'er Sheva
832010443	Aviv	Levi	1974-09-17	530659636	Be'er Sheva
739732268	Rotem	Kaplan	1981-11-12	518413905	Petah Tikva
125478540	Ron	Levi	1991-07-09	533056049	Rishon LeZion
484821493	Yonatan	Golan	1954-04-05	557973156	Tel Aviv
596823946	Tal	Amar	1974-11-28	537376543	Holon
950189399	Aviv	Kaplan	1973-10-03	503078049	Haifa
510716800	Yonatan	Tzadok	1968-07-14	588263110	Holon
116809193	Idan	Harari	1983-06-26	568113178	Netanya
557387584	Shira	Avraham	1993-09-12	576024932	Holon
856141290	Eyal	Kaplan	1995-07-07	549305251	Haifa
127373899	Guy	Katz	1998-10-13	577595609	Jerusalem
452354109	Idan	Shemesh	1976-02-28	571899898	Ramat Gan
244282748	Ofir	Mizrahi	1985-11-15	591432981	Ashdod
888469205	Guy	Hazan	1984-04-17	511282383	Jerusalem
264594643	Guy	Shemesh	1984-04-26	520759795	Netanya
103198638	Ori	Shemesh	2000-03-16	589521001	Ramat Gan
990265405	Noa	Barak	1968-10-09	517950491	Ramat Gan
961074382	Ori	Amar	1989-01-06	587557964	Ramat Gan
991164471	Tal	Barak	1986-06-07	533465260	Jerusalem
937895475	Ofir	Mizrahi	2004-04-24	599444299	Haifa
442531669	Amit	Shemesh	1965-10-11	571233761	Holon
952751158	Guy	Mizrahi	1999-01-24	546107063	Tel Aviv
691399121	Daniel	Hazan	1960-01-01	516987942	Petah Tikva
204520642	Amit	Levi	1973-07-17	507031999	Netanya
312816743	Ofir	Barak	1989-04-22	504297733	Petah Tikva
524957376	Tomer	Kaplan	1999-05-29	500242368	Haifa
886567223	Michal	Tzadok	1997-04-20	563590903	Jerusalem
644870997	Inbal	Katz	1977-01-15	532695643	Ramat Gan
246927292	Amit	Tzadok	1960-08-02	522440577	Ashdod
510334717	Yonatan	Malka	2005-05-06	549888865	Holon
587927685	Ron	Shemesh	1970-03-19	581778740	Petah Tikva
762854976	Omer	Dayan	2000-01-06	508564505	Ramat Gan
106210399	Tal	Kaplan	1975-05-10	551455444	Rishon LeZion
673012407	Amit	Harari	1969-07-08	544474742	Jerusalem
648046509	Yonatan	Ben-David	1967-10-13	506880178	Ramat Gan
134463780	Daniel	Shemesh	1964-04-04	522101894	Be'er Sheva
432026089	Tomer	Malka	1955-11-23	579069076	Petah Tikva
372000492	Tal	Ziv	1957-05-17	508277267	Haifa
451143202	Hila	Sharon	1970-11-22	555806876	Rishon LeZion
106107388	Ori	Sharon	1996-05-15	510225140	Ashdod
390750761	Tomer	Sharon	1986-07-25	516781180	Rishon LeZion
291145247	Aviv	Malka	1995-10-30	532584846	Be'er Sheva
914566516	Ofir	Hazan	2006-07-11	577380153	Jerusalem
530516374	Amit	Katz	1959-03-10	588743541	Rishon LeZion
694876741	Michal	Ziv	1985-03-22	565922917	Be'er Sheva
228630954	Michal	Abutbul	1982-06-07	503729065	Ramat Gan
310449903	Yonatan	Hazan	1997-01-31	582169382	Ramat Gan
477791140	Daniel	Amar	1993-05-28	562310811	Holon
595566634	Lior	Harari	1967-06-18	549009887	Jerusalem
188163518	Inbal	Kaplan	2003-02-11	517314648	Haifa
641246037	Omer	Shemesh	2001-08-13	524842402	Tel Aviv
385015287	Lior	Dayan	1980-05-11	555091006	Ashdod
333059661	Omer	Harari	1987-11-15	562622794	Ramat Gan
832006368	Daniel	Levi	1981-06-05	503802073	Be'er Sheva
146240027	Guy	Levi	1970-11-01	599997765	Jerusalem
808677201	Noa	Golan	1964-04-09	528449660	Tel Aviv
651447743	Rotem	Barak	1998-11-16	524177643	Holon
129452534	Ron	Ben-David	2001-01-08	533409679	Tel Aviv
292563039	Ori	Malka	1954-08-10	599716427	Holon
757088646	Shira	Sharon	2005-05-02	558551545	Petah Tikva
405648081	Shira	Sharon	2006-08-19	587876684	Jerusalem
152785861	Yonatan	Golan	1961-06-26	564843096	Netanya
467683186	Ron	Avraham	2007-03-15	523539229	Rishon LeZion
549041678	Hila	Abutbul	1983-03-01	537809668	Tel Aviv
277362370	Daniel	Peretz	1969-02-14	551600536	Be'er Sheva
909580633	Ron	Ben-David	1966-03-14	567529810	Netanya
459613663	Ori	Barak	2001-08-02	591026670	Rishon LeZion
515517676	Amit	Harari	1989-06-23	578655896	Jerusalem
958396544	Idan	Shemesh	1985-11-04	560128842	Holon
991202503	Tal	Cohen	1957-08-25	589354477	Rishon LeZion
869278628	Tal	Shemesh	1992-02-29	536540342	Be'er Sheva
334099421	Ori	Avraham	1971-03-10	558097742	Ashdod
523462070	Inbal	Avraham	1962-06-28	583624078	Netanya
421967560	Omer	Mizrahi	1985-04-17	598733444	Tel Aviv
318943388	Eyal	Kaplan	1963-04-22	504145425	Tel Aviv
136335319	Tal	Avraham	1985-11-06	535437292	Tel Aviv
691705874	Omer	Malka	1999-08-29	555777346	Holon
408394324	Idan	Malka	1990-05-17	517920717	Haifa
323208385	Inbal	Kaplan	1992-04-07	571531922	Ashdod
733386484	Noa	Levi	1994-10-02	599648892	Be'er Sheva
427852785	Omer	Harari	1975-10-28	528916428	Holon
605063967	Ori	Barak	2005-08-16	579663448	Holon
904402564	Eyal	Abutbul	1984-05-07	569524326	Jerusalem
499722276	Ori	Ben-David	1995-12-03	500320974	Ashdod
740682739	Daniel	Hazan	2003-03-06	531057104	Ashdod
559056009	Inbal	Katz	1988-07-31	592150994	Rishon LeZion
993263579	Ori	Malka	1983-04-09	500030773	Be'er Sheva
565425153	Omer	Kaplan	1991-07-07	522914102	Petah Tikva
266685039	Guy	Harari	1984-07-29	549264904	Ashdod
770618338	Idan	Ben-David	1965-01-22	593834457	Rishon LeZion
692757934	Shira	Ziv	2004-11-01	516687809	Rishon LeZion
162929677	Hila	Abutbul	1986-07-14	507768657	Ramat Gan
717220517	Idan	Dayan	1984-11-09	530015089	Netanya
977667032	Tal	Malka	1971-11-14	544329829	Tel Aviv
660542544	Rotem	Harari	2005-05-22	519101184	Holon
364330977	Eyal	Dayan	1971-01-21	577986060	Haifa
391559775	Michal	Malka	1997-08-16	525036512	Be'er Sheva
173735333	Omer	Hazan	1973-02-06	544337053	Netanya
508895013	Eyal	Harari	2006-05-06	541537924	Petah Tikva
609883589	Omer	Avraham	2007-02-25	595332562	Be'er Sheva
565166657	Amit	Abutbul	1989-09-14	518375534	Petah Tikva
642778231	Shira	Cohen	1987-03-17	548509327	Tel Aviv
114916894	Michal	Golan	1996-11-17	516131846	Jerusalem
233341981	Ori	Malka	1970-07-06	519783370	Tel Aviv
620016708	Ofir	Golan	1972-12-01	566086596	Holon
700986555	Omer	Ben-David	1984-03-01	500798730	Jerusalem
233715310	Lior	Shemesh	1959-07-03	533264315	Netanya
452367681	Daniel	Avraham	2002-10-15	520499849	Jerusalem
919941861	Inbal	Hazan	1973-09-03	547500627	Holon
231324781	Inbal	Avraham	1970-03-10	541420702	Haifa
893399035	Shira	Barak	1972-09-20	504691307	Netanya
356308687	Daniel	Sharon	1977-01-31	595844179	Rishon LeZion
621805679	Inbal	Peretz	1975-12-27	510305271	Ramat Gan
358401641	Ofir	Mizrahi	1990-12-27	585883523	Be'er Sheva
876946737	Daniel	Malka	1959-09-18	538265809	Tel Aviv
300885051	Aviv	Dayan	1963-08-25	562551084	Be'er Sheva
857599583	Daniel	Amar	1964-06-29	511533580	Haifa
798009672	Inbal	Levi	1969-12-20	541921787	Be'er Sheva
106374385	Ron	Shemesh	1980-04-18	555143554	Ramat Gan
522199986	Inbal	Sharon	2001-06-15	583726965	Ramat Gan
307638987	Michal	Golan	1964-08-17	510416068	Be'er Sheva
561707109	Hila	Malka	2002-04-21	561215726	Ashdod
853912682	Omer	Levi	1968-10-15	595321525	Petah Tikva
939238672	Inbal	Avraham	1958-08-08	538306976	Netanya
638619639	Rotem	Avraham	1982-06-18	567100363	Ashdod
870478094	Ron	Katz	1981-12-19	501678235	Rishon LeZion
535842430	Shira	Tzadok	1976-09-30	597354592	Tel Aviv
967238983	Yonatan	Tzadok	1991-02-26	516438475	Netanya
361945520	Amit	Peretz	1985-12-08	586457993	Tel Aviv
444687035	Omer	Kaplan	1982-07-11	598785404	Be'er Sheva
792123494	Amit	Amar	1958-06-20	553795710	Tel Aviv
583133229	Ori	Golan	1968-04-21	526204060	Rishon LeZion
724516280	Daniel	Dayan	1982-10-27	581665146	Haifa
705338121	Amit	Hazan	1980-09-25	575132611	Rishon LeZion
325430239	Omer	Levi	2006-08-13	581306045	Holon
680422772	Michal	Malka	1993-12-23	514839954	Petah Tikva
789955108	Idan	Cohen	2001-07-24	533151044	Ramat Gan
254040510	Lior	Mizrahi	1955-07-24	526816316	Rishon LeZion
710030144	Michal	Sharon	2006-04-30	579914542	Ashdod
289805994	Hila	Golan	1993-05-28	527306888	Haifa
485241165	Daniel	Harari	1980-02-12	501696908	Jerusalem
936879403	Inbal	Kaplan	1986-09-09	503602147	Be'er Sheva
365083334	Idan	Avraham	1954-08-19	510400774	Jerusalem
590833948	Michal	Harari	1978-03-03	577129450	Haifa
723266609	Hila	Mizrahi	1974-07-21	507370353	Petah Tikva
705977773	Michal	Dayan	2005-07-03	538036278	Ashdod
896666994	Shira	Cohen	1980-10-08	558429860	Ashdod
413603064	Ron	Barak	1982-09-29	509562216	Holon
350299663	Lior	Tzadok	1990-11-09	536849279	Haifa
475678577	Rotem	Sharon	2005-02-05	558102820	Rishon LeZion
330948886	Tomer	Malka	2004-03-22	501983069	Holon
642573144	Hila	Ziv	1991-05-25	520592957	Netanya
517697659	Noa	Ben-David	1995-04-13	567341054	Netanya
678506268	Eyal	Barak	1969-03-28	583086705	Rishon LeZion
392263901	Lior	Golan	1987-06-16	536334322	Rishon LeZion
398331058	Tomer	Dayan	1969-02-28	562469891	Haifa
165928627	Aviv	Golan	1972-10-20	500149273	Netanya
702439977	Noa	Katz	1983-11-21	558231784	Petah Tikva
613307691	Amit	Barak	1987-04-12	573309773	Rishon LeZion
333012046	Eyal	Abutbul	1956-03-16	558925172	Be'er Sheva
457148964	Daniel	Golan	1980-09-10	589747353	Be'er Sheva
368803859	Aviv	Ben-David	1977-02-07	530453938	Petah Tikva
223034510	Tomer	Amar	1999-09-30	548975867	Petah Tikva
154992568	Daniel	Malka	2000-06-12	512780591	Be'er Sheva
194967455	Tomer	Amar	1981-09-29	557874835	Be'er Sheva
169095841	Inbal	Harari	2003-07-06	528970720	Ashdod
128998748	Yonatan	Golan	1965-06-18	512501732	Haifa
928678498	Tal	Dayan	1986-01-14	501521078	Jerusalem
510589173	Tomer	Hazan	1962-12-01	554895978	Be'er Sheva
877651756	Eyal	Dayan	1996-07-29	532902107	Jerusalem
145012488	Inbal	Tzadok	1990-07-30	520324968	Ashdod
120252841	Eyal	Malka	1956-01-25	521045864	Be'er Sheva
439413734	Noa	Levi	1981-01-16	554618639	Petah Tikva
215791975	Eyal	Katz	1994-07-05	587006748	Ashdod
469439493	Hila	Ben-David	1992-08-21	566083604	Tel Aviv
747832838	Yonatan	Avraham	1999-05-07	562904470	Holon
560761358	Omer	Levi	1956-01-28	513788633	Be'er Sheva
240709151	Amit	Abutbul	1959-12-11	537318995	Haifa
523195752	Inbal	Barak	1997-12-20	518511572	Holon
471674082	Hila	Harari	1983-05-26	557787527	Tel Aviv
210440926	Amit	Tzadok	1963-06-19	577457402	Holon
310258592	Shira	Cohen	1985-08-25	528027013	Petah Tikva
585426153	Guy	Katz	1966-08-06	508668507	Netanya
157794649	Shira	Barak	1957-08-26	524199608	Ashdod
493394881	Hila	Abutbul	1971-12-08	565272589	Ashdod
236536222	Ori	Shemesh	1980-01-11	556011093	Jerusalem
455096535	Hila	Barak	1976-07-04	550518966	Rishon LeZion
410254424	Eyal	Katz	1968-08-19	513575129	Ramat Gan
975354103	Noa	Sharon	1985-03-04	585127311	Netanya
582888025	Idan	Avraham	1976-06-21	551826249	Ramat Gan
674960706	Shira	Ben-David	1977-03-13	590601535	Petah Tikva
575013098	Michal	Ziv	2006-01-12	588830924	Be'er Sheva
495900140	Ron	Katz	1980-01-12	587949137	Ashdod
302016206	Hila	Ziv	1985-05-06	537844220	Ramat Gan
\.


--
-- TOC entry 3244 (class 2606 OID 41040)
-- Name: destination destination_pkey; Type: CONSTRAINT; Schema: public; Owner: esti
--

ALTER TABLE ONLY public.destination
    ADD CONSTRAINT destination_pkey PRIMARY KEY (destination_name, destination_address);


--
-- TOC entry 3246 (class 2606 OID 41070)
-- Name: driver driver_pkey; Type: CONSTRAINT; Schema: public; Owner: esti
--

ALTER TABLE ONLY public.driver
    ADD CONSTRAINT driver_pkey PRIMARY KEY (volunteer_id);


--
-- TOC entry 3238 (class 2606 OID 40965)
-- Name: patient patient_pkey; Type: CONSTRAINT; Schema: public; Owner: esti
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_pkey PRIMARY KEY (patient_id);


--
-- TOC entry 3250 (class 2606 OID 41090)
-- Name: ride ride_pkey; Type: CONSTRAINT; Schema: public; Owner: esti
--

ALTER TABLE ONLY public.ride
    ADD CONSTRAINT ride_pkey PRIMARY KEY (ride_id);


--
-- TOC entry 3248 (class 2606 OID 41080)
-- Name: transport_assistant transport_assistant_pkey; Type: CONSTRAINT; Schema: public; Owner: esti
--

ALTER TABLE ONLY public.transport_assistant
    ADD CONSTRAINT transport_assistant_pkey PRIMARY KEY (volunteer_id);


--
-- TOC entry 3240 (class 2606 OID 40970)
-- Name: vehicle vehicle_pkey; Type: CONSTRAINT; Schema: public; Owner: esti
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT vehicle_pkey PRIMARY KEY (vehicle_id);


--
-- TOC entry 3242 (class 2606 OID 40980)
-- Name: volunteer volunteer_pkey; Type: CONSTRAINT; Schema: public; Owner: esti
--

ALTER TABLE ONLY public.volunteer
    ADD CONSTRAINT volunteer_pkey PRIMARY KEY (volunteer_id);


--
-- TOC entry 3251 (class 2606 OID 41071)
-- Name: driver driver_volunteer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: esti
--

ALTER TABLE ONLY public.driver
    ADD CONSTRAINT driver_volunteer_id_fkey FOREIGN KEY (volunteer_id) REFERENCES public.volunteer(volunteer_id);


--
-- TOC entry 3253 (class 2606 OID 41106)
-- Name: ride ride_assistant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: esti
--

ALTER TABLE ONLY public.ride
    ADD CONSTRAINT ride_assistant_id_fkey FOREIGN KEY (assistant_id) REFERENCES public.transport_assistant(volunteer_id);


--
-- TOC entry 3254 (class 2606 OID 41111)
-- Name: ride ride_destination_name_destination_address_fkey; Type: FK CONSTRAINT; Schema: public; Owner: esti
--

ALTER TABLE ONLY public.ride
    ADD CONSTRAINT ride_destination_name_destination_address_fkey FOREIGN KEY (destination_name, destination_address) REFERENCES public.destination(destination_name, destination_address);


--
-- TOC entry 3255 (class 2606 OID 41101)
-- Name: ride ride_driver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: esti
--

ALTER TABLE ONLY public.ride
    ADD CONSTRAINT ride_driver_id_fkey FOREIGN KEY (driver_id) REFERENCES public.driver(volunteer_id);


--
-- TOC entry 3256 (class 2606 OID 73729)
-- Name: ride ride_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: esti
--

ALTER TABLE ONLY public.ride
    ADD CONSTRAINT ride_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patient(patient_id) ON DELETE CASCADE;


--
-- TOC entry 3257 (class 2606 OID 41096)
-- Name: ride ride_vehicle_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: esti
--

ALTER TABLE ONLY public.ride
    ADD CONSTRAINT ride_vehicle_id_fkey FOREIGN KEY (vehicle_id) REFERENCES public.vehicle(vehicle_id);


--
-- TOC entry 3252 (class 2606 OID 41081)
-- Name: transport_assistant transport_assistant_volunteer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: esti
--

ALTER TABLE ONLY public.transport_assistant
    ADD CONSTRAINT transport_assistant_volunteer_id_fkey FOREIGN KEY (volunteer_id) REFERENCES public.volunteer(volunteer_id);


-- Completed on 2025-04-27 13:49:52 UTC

--
-- PostgreSQL database dump complete
--

