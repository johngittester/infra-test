--
-- PostgreSQL database dump
-- Dumped from database version 16.1
-- Host: db.contmontx.com    Database: cmx_crm_prod
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(254) NOT NULL,
    password character varying(255) NOT NULL,
    api_key character varying(64),
    is_staff boolean DEFAULT false,
    is_active boolean DEFAULT true,
    date_joined timestamp with time zone DEFAULT now()
);

INSERT INTO public.users (id,username,first_name,last_name,email,password,api_key,date_joined) VALUES
(1,'admin','Admin','User','admin@contmontx.com','$2b$12$bf5da836882d0c5daa8c29d1044c1bf3f1d449ed6516fa44e21b8','a4aa89298b57b10fa8810e76a02d78ee',NOW()),
(2,'m.yilmaz','Mehmet','Yilmaz','m.yilmaz@contmontx.com','$2b$12$92013bb2ed25b92a97aca45c6f9c4e209acfa8453f21381c7dcad','4610785826db171ef49dd4d18b61e7ca',NOW()),
(3,'a.demir','Ayse','Demir','a.demir@contmontx.com','$2b$12$3a88b005ed7282927a69b5c244a429dbd08a2c19f8cd72aaf6c71','b4e07a1a9aaff8fc95d4036aeb240b04',NOW()),
(4,'k.sahin','Kemal','Sahin','k.sahin@contmontx.com','$2b$12$f0c462811faee7d2d292d243588135f96d56e3585367761813b2b','012567b5dfd69ea2cb7dc6acc9ebc3b3',NOW()),
(5,'svc_reporting','Service','Reporting','reporting@contmontx.com','$2b$12$bbc35343db935b1f4992a0dbe1f1927c2f4df418378d880af8be2','8250f480a918dfd8737a7c54a5581844',NOW());

CREATE TABLE public.api_tokens (
    id integer NOT NULL,
    user_id integer,
    token character varying(128) NOT NULL,
    scope character varying(200),
    expires_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now()
);

INSERT INTO public.api_tokens (id,user_id,token,scope,expires_at) VALUES
(1,1,'097f6e9cab59be7e4c8538e8eb49ce9d21108e86597830d5d49009b2cd1704ec','admin:read admin:write','2027-01-01 00:00:00+00'),
(2,5,'2e95367768e3f8f03de49608677ee1a1162a5331ad7f5b98ac535f5b6fc9614e','reports:read','2026-12-31 23:59:59+00');

CREATE TABLE public.smtp_config (
    id integer NOT NULL,
    host character varying(255),
    port integer,
    username character varying(255),
    password character varying(255),
    use_tls boolean
);

INSERT INTO public.smtp_config VALUES
(1,'mail.contmontx.com',587,'noreply@contmontx.com','4c8538e8Smtp!',true);

REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO cmx_app;
