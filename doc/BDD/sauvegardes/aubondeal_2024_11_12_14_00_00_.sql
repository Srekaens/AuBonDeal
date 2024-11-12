--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Homebrew)
-- Dumped by pg_dump version 16.4 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: justindidelot
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO justindidelot;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: hash_password(); Type: FUNCTION; Schema: public; Owner: justinuser
--

CREATE FUNCTION public.hash_password() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.user_password := crypt(NEW.user_password, gen_salt('bf'));
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.hash_password() OWNER TO justinuser;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: belong; Type: TABLE; Schema: public; Owner: justindidelot
--

CREATE TABLE public.belong (
    product_uuid uuid NOT NULL,
    order_number integer NOT NULL
);


ALTER TABLE public.belong OWNER TO justindidelot;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: justindidelot
--

CREATE TABLE public.orders (
    order_number integer NOT NULL,
    order_total_cost_ht numeric(10,2),
    order_total_quantity integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    deliver_at timestamp without time zone,
    user_uuid uuid NOT NULL,
    CONSTRAINT orders_order_total_cost_ht_check CHECK ((order_total_cost_ht >= (0)::numeric)),
    CONSTRAINT orders_order_total_quantity_check CHECK ((order_total_quantity >= 0))
);


ALTER TABLE public.orders OWNER TO justindidelot;

--
-- Name: orders_order_number_seq; Type: SEQUENCE; Schema: public; Owner: justindidelot
--

CREATE SEQUENCE public.orders_order_number_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_order_number_seq OWNER TO justindidelot;

--
-- Name: orders_order_number_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: justindidelot
--

ALTER SEQUENCE public.orders_order_number_seq OWNED BY public.orders.order_number;


--
-- Name: products; Type: TABLE; Schema: public; Owner: justindidelot
--

CREATE TABLE public.products (
    product_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    product_name character varying(100) NOT NULL,
    product_description text,
    product_price numeric(10,2) NOT NULL,
    product_quantity integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT products_product_price_check CHECK ((product_price >= (0)::numeric)),
    CONSTRAINT products_product_quantity_check CHECK ((product_quantity >= 0))
);


ALTER TABLE public.products OWNER TO justindidelot;

--
-- Name: users; Type: TABLE; Schema: public; Owner: justindidelot
--

CREATE TABLE public.users (
    user_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    user_pseudo character varying(50) NOT NULL,
    username character varying(100) NOT NULL,
    user_password character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO justindidelot;

--
-- Name: orders order_number; Type: DEFAULT; Schema: public; Owner: justindidelot
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_number SET DEFAULT nextval('public.orders_order_number_seq'::regclass);


--
-- Data for Name: belong; Type: TABLE DATA; Schema: public; Owner: justindidelot
--

COPY public.belong (product_uuid, order_number) FROM stdin;
7ff3950e-29e2-4a0e-896d-fe682871e346	1
f4469745-0ea9-4a0b-b598-8692f06497f4	2
7ff3950e-29e2-4a0e-896d-fe682871e346	2
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: justindidelot
--

COPY public.orders (order_number, order_total_cost_ht, order_total_quantity, created_at, deliver_at, user_uuid) FROM stdin;
1	2000.00	1	2024-11-07 11:22:46.480741	\N	065f4e2c-dd5d-408f-a028-7121cdcf72eb
2	3200.00	2	2024-11-07 11:22:46.480741	\N	a302800b-d0b3-450b-a806-a9b7964e2bd5
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: justindidelot
--

COPY public.products (product_uuid, product_name, product_description, product_price, product_quantity, created_at, updated_at) FROM stdin;
7ff3950e-29e2-4a0e-896d-fe682871e346	PC Portable	MSI YAFOY	2000.00	10	2024-11-07 11:18:36.893887	2024-11-07 11:18:36.893887
f4469745-0ea9-4a0b-b598-8692f06497f4	Iphone 16	IPHONE DE FOU	1600.00	4	2024-11-07 11:18:36.893887	2024-11-07 11:18:36.893887
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: justindidelot
--

COPY public.users (user_uuid, user_pseudo, username, user_password, created_at) FROM stdin;
aff7753d-736c-4e36-8025-e2c1517fb1ca	Ayahoub	ayahoublafofolle@gmail.com	$2a$06$m9ngjoYWp7k9PdriPljSb.OmSudlrkb79nAxYWdn.AD.ns2BsJyoK	2024-11-07 11:11:41.252052
065f4e2c-dd5d-408f-a028-7121cdcf72eb	MessaPrincesse	messayafoy@gmail.com	$2a$06$D6.juooVrznzFIj20Uaeyuqaor8j2RVHHbOoPXRdKITOmvoND6.De	2024-11-07 11:11:41.252052
a302800b-d0b3-450b-a806-a9b7964e2bd5	Abdel	envoietonadresse@gmail.com	$2a$06$7.cVb8D1a3mONNaNrrHL.ebu/oD8fqBojtmF8f.um2BNhu.xI4BQa	2024-11-07 11:11:41.252052
030f17d4-4fe0-46a5-ad43-19334d7a4b68	bobolabete	borislalegende@gmail.com	$2a$06$fvo8SLq2r0zJFjtoPXCMCuxB1vgFx46iH2UpTNYO1Tb05j8vAE3be	2024-11-08 09:41:51.854779
bc2b9be1-fedc-4030-b61b-1f6b49554b44	celialapuduchlip	celiapuduchlip@gmail.com	$2a$06$w66cXh.fyq0.W5cFAFPlXetDD.GmIiuJUyVxEMBSV7xcsV4LUY2eu	2024-11-08 20:00:34.413869
\.


--
-- Name: orders_order_number_seq; Type: SEQUENCE SET; Schema: public; Owner: justindidelot
--

SELECT pg_catalog.setval('public.orders_order_number_seq', 2, true);


--
-- Name: belong belong_pkey; Type: CONSTRAINT; Schema: public; Owner: justindidelot
--

ALTER TABLE ONLY public.belong
    ADD CONSTRAINT belong_pkey PRIMARY KEY (product_uuid, order_number);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: justindidelot
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_number);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: justindidelot
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_uuid);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: justindidelot
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_uuid);


--
-- Name: users before_insert_or_update_user_password; Type: TRIGGER; Schema: public; Owner: justindidelot
--

CREATE TRIGGER before_insert_or_update_user_password BEFORE INSERT OR UPDATE OF user_password ON public.users FOR EACH ROW EXECUTE FUNCTION public.hash_password();


--
-- Name: belong belong_order_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: justindidelot
--

ALTER TABLE ONLY public.belong
    ADD CONSTRAINT belong_order_number_fkey FOREIGN KEY (order_number) REFERENCES public.orders(order_number) ON UPDATE CASCADE;


--
-- Name: belong belong_product_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: justindidelot
--

ALTER TABLE ONLY public.belong
    ADD CONSTRAINT belong_product_uuid_fkey FOREIGN KEY (product_uuid) REFERENCES public.products(product_uuid) ON UPDATE CASCADE;


--
-- Name: orders orders_user_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: justindidelot
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_uuid_fkey FOREIGN KEY (user_uuid) REFERENCES public.users(user_uuid) ON UPDATE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: justindidelot
--

GRANT ALL ON SCHEMA public TO justinuser;


--
-- Name: TABLE belong; Type: ACL; Schema: public; Owner: justindidelot
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.belong TO justinuser;


--
-- Name: TABLE orders; Type: ACL; Schema: public; Owner: justindidelot
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.orders TO justinuser;


--
-- Name: SEQUENCE orders_order_number_seq; Type: ACL; Schema: public; Owner: justindidelot
--

GRANT SELECT,USAGE ON SEQUENCE public.orders_order_number_seq TO justinuser;


--
-- Name: TABLE products; Type: ACL; Schema: public; Owner: justindidelot
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.products TO justinuser;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: justindidelot
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.users TO justinuser;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: justindidelot
--

ALTER DEFAULT PRIVILEGES FOR ROLE justindidelot IN SCHEMA public GRANT SELECT,INSERT,DELETE,UPDATE ON TABLES TO justinuser;


--
-- PostgreSQL database dump complete
--

