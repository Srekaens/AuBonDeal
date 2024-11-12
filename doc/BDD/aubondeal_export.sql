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

