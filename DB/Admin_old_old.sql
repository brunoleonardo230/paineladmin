--
-- PostgreSQL database dump
--

-- Dumped from database version 10.11
-- Dumped by pg_dump version 10.11

-- Started on 2020-01-20 23:39:53

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
-- TOC entry 6 (class 2615 OID 24576)
-- Name: geral; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA geral;


ALTER SCHEMA geral OWNER TO postgres;

--
-- TOC entry 2972 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA geral; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA geral IS 'Schema das tabelas gerais do sistema de gestao da STC';


--
-- TOC entry 236 (class 1255 OID 24577)
-- Name: fn_dias_uteis(date, date, integer); Type: FUNCTION; Schema: geral; Owner: postgres
--

CREATE FUNCTION geral.fn_dias_uteis(p_dt_inicio date, p_dt_fim date, p_cod_municipio integer DEFAULT 2111300) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
   v_total_dias integer;
    v_total_feriados integer;
    v_total_dias_uteis integer;
    v_dia_semana integer;
begin
    
    --município de slz no ibge --2111300
    
    --conta quantidade de dias
    select p_dt_fim - p_dt_inicio
    into v_total_dias;
      
    --busca os feriados do período
    select count(*)
    into v_total_feriados
    from geral.tb_feriados
    where (int_cod_municipio = p_cod_municipio or int_cod_municipio is null) --pega os municipais e os demais
    and int_dia_da_semana not in (0, 6) -- elimina feriados de domingo(0) e sabado(6);
    and dt_feriado between p_dt_inicio and p_dt_fim;

    v_total_dias_uteis = v_total_dias;
    
    select extract(DOW from p_dt_inicio)
     into v_dia_semana;
    
     FOR i IN 1 .. v_total_dias loop
         
        if v_dia_semana in(0, 6) then
            v_total_dias_uteis = v_total_dias_uteis - 1;
        end if;
    
        select extract(DOW from p_dt_inicio + i)
         into v_dia_semana;
    
    END LOOP;

    select extract(DOW from p_dt_fim)
     into v_dia_semana;

    if v_dia_semana in(0, 6) then
	v_total_dias_uteis:= v_total_dias_uteis - v_total_feriados;
    else 
	v_total_dias_uteis:= v_total_dias_uteis - v_total_feriados + 1;
    end if;

    RETURN  v_total_dias_uteis;

    END;
$$;


ALTER FUNCTION geral.fn_dias_uteis(p_dt_inicio date, p_dt_fim date, p_cod_municipio integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 197 (class 1259 OID 24578)
-- Name: tb_anexo; Type: TABLE; Schema: geral; Owner: postgres
--

CREATE TABLE geral.tb_anexo (
    int_anexo_id integer NOT NULL,
    str_nome character varying(255),
    mimetype character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    str_nome_original character varying(255)
);


ALTER TABLE geral.tb_anexo OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 24584)
-- Name: tb_anexo_int_anexo_id_seq; Type: SEQUENCE; Schema: geral; Owner: postgres
--

CREATE SEQUENCE geral.tb_anexo_int_anexo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE geral.tb_anexo_int_anexo_id_seq OWNER TO postgres;

--
-- TOC entry 2973 (class 0 OID 0)
-- Dependencies: 198
-- Name: tb_anexo_int_anexo_id_seq; Type: SEQUENCE OWNED BY; Schema: geral; Owner: postgres
--

ALTER SEQUENCE geral.tb_anexo_int_anexo_id_seq OWNED BY geral.tb_anexo.int_anexo_id;


--
-- TOC entry 199 (class 1259 OID 24586)
-- Name: tb_categoria_recurso; Type: TABLE; Schema: geral; Owner: postgres
--

CREATE TABLE geral.tb_categoria_recurso (
    int_categoria_recurso_id integer NOT NULL,
    str_nome character varying(45) NOT NULL,
    str_icone character varying(45) NOT NULL,
    int_ordem integer NOT NULL,
    bol_ativo boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE geral.tb_categoria_recurso OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 24590)
-- Name: tb_categoria_recurso_int_categoria_recurso_id_seq; Type: SEQUENCE; Schema: geral; Owner: postgres
--

CREATE SEQUENCE geral.tb_categoria_recurso_int_categoria_recurso_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE geral.tb_categoria_recurso_int_categoria_recurso_id_seq OWNER TO postgres;

--
-- TOC entry 2974 (class 0 OID 0)
-- Dependencies: 200
-- Name: tb_categoria_recurso_int_categoria_recurso_id_seq; Type: SEQUENCE OWNED BY; Schema: geral; Owner: postgres
--

ALTER SEQUENCE geral.tb_categoria_recurso_int_categoria_recurso_id_seq OWNED BY geral.tb_categoria_recurso.int_categoria_recurso_id;


--
-- TOC entry 201 (class 1259 OID 24592)
-- Name: tb_feriados; Type: TABLE; Schema: geral; Owner: postgres
--

CREATE TABLE geral.tb_feriados (
    int_feriado_id integer NOT NULL,
    dt_feriado date,
    str_nome_feriado character varying(200),
    int_dia_da_semana integer,
    int_cod_municipio integer,
    int_tipo_feriado integer
);


ALTER TABLE geral.tb_feriados OWNER TO postgres;

--
-- TOC entry 2975 (class 0 OID 0)
-- Dependencies: 201
-- Name: COLUMN tb_feriados.int_cod_municipio; Type: COMMENT; Schema: geral; Owner: postgres
--

COMMENT ON COLUMN geral.tb_feriados.int_cod_municipio IS ' --se estadual ou federal é nulo';


--
-- TOC entry 2976 (class 0 OID 0)
-- Dependencies: 201
-- Name: COLUMN tb_feriados.int_tipo_feriado; Type: COMMENT; Schema: geral; Owner: postgres
--

COMMENT ON COLUMN geral.tb_feriados.int_tipo_feriado IS '--1 nacional, 2 -estadual 3- municipal';


--
-- TOC entry 202 (class 1259 OID 24595)
-- Name: tb_feriados_int_feriado_id_seq; Type: SEQUENCE; Schema: geral; Owner: postgres
--

CREATE SEQUENCE geral.tb_feriados_int_feriado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE geral.tb_feriados_int_feriado_id_seq OWNER TO postgres;

--
-- TOC entry 2977 (class 0 OID 0)
-- Dependencies: 202
-- Name: tb_feriados_int_feriado_id_seq; Type: SEQUENCE OWNED BY; Schema: geral; Owner: postgres
--

ALTER SEQUENCE geral.tb_feriados_int_feriado_id_seq OWNED BY geral.tb_feriados.int_feriado_id;


--
-- TOC entry 203 (class 1259 OID 24597)
-- Name: tb_mensagens; Type: TABLE; Schema: geral; Owner: postgres
--

CREATE TABLE geral.tb_mensagens (
    int_mensagem_id integer NOT NULL,
    int_sistema_id integer NOT NULL,
    str_mensagem text NOT NULL,
    dta_ini timestamp(0) without time zone NOT NULL,
    dta_fim timestamp(0) without time zone NOT NULL,
    bol_ativo boolean NOT NULL,
    ind_tipo character varying(1) NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    str_titulo character varying(255),
    deleted_at timestamp(0) without time zone
);


ALTER TABLE geral.tb_mensagens OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 24603)
-- Name: tb_mensagens_int_mensagem_id_seq; Type: SEQUENCE; Schema: geral; Owner: postgres
--

CREATE SEQUENCE geral.tb_mensagens_int_mensagem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE geral.tb_mensagens_int_mensagem_id_seq OWNER TO postgres;

--
-- TOC entry 2978 (class 0 OID 0)
-- Dependencies: 204
-- Name: tb_mensagens_int_mensagem_id_seq; Type: SEQUENCE OWNED BY; Schema: geral; Owner: postgres
--

ALTER SEQUENCE geral.tb_mensagens_int_mensagem_id_seq OWNED BY geral.tb_mensagens.int_mensagem_id;


--
-- TOC entry 205 (class 1259 OID 24605)
-- Name: tb_modulo; Type: TABLE; Schema: geral; Owner: postgres
--

CREATE TABLE geral.tb_modulo (
    int_modulo_id integer NOT NULL,
    str_nome character varying(150) NOT NULL,
    str_descricao character varying(300) NOT NULL,
    str_icone character varying(45) NOT NULL,
    bol_ativo boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    str_nome_fantasia character varying
);


ALTER TABLE geral.tb_modulo OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 24612)
-- Name: tb_modulo_int_modulo_id_seq; Type: SEQUENCE; Schema: geral; Owner: postgres
--

CREATE SEQUENCE geral.tb_modulo_int_modulo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE geral.tb_modulo_int_modulo_id_seq OWNER TO postgres;

--
-- TOC entry 2979 (class 0 OID 0)
-- Dependencies: 206
-- Name: tb_modulo_int_modulo_id_seq; Type: SEQUENCE OWNED BY; Schema: geral; Owner: postgres
--

ALTER SEQUENCE geral.tb_modulo_int_modulo_id_seq OWNED BY geral.tb_modulo.int_modulo_id;


--
-- TOC entry 207 (class 1259 OID 24614)
-- Name: tb_perfil; Type: TABLE; Schema: geral; Owner: postgres
--

CREATE TABLE geral.tb_perfil (
    int_perfil_id integer NOT NULL,
    str_nome character varying(150) NOT NULL,
    str_descricao character varying(300) NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    int_perfil_modulo_id integer NOT NULL
);


ALTER TABLE geral.tb_perfil OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 24617)
-- Name: tb_perfil_int_perfil_id_seq; Type: SEQUENCE; Schema: geral; Owner: postgres
--

CREATE SEQUENCE geral.tb_perfil_int_perfil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE geral.tb_perfil_int_perfil_id_seq OWNER TO postgres;

--
-- TOC entry 2980 (class 0 OID 0)
-- Dependencies: 208
-- Name: tb_perfil_int_perfil_id_seq; Type: SEQUENCE OWNED BY; Schema: geral; Owner: postgres
--

ALTER SEQUENCE geral.tb_perfil_int_perfil_id_seq OWNED BY geral.tb_perfil.int_perfil_id;


--
-- TOC entry 209 (class 1259 OID 24619)
-- Name: tb_perfil_permissao; Type: TABLE; Schema: geral; Owner: postgres
--

CREATE TABLE geral.tb_perfil_permissao (
    int_perfil_permissao_perfil_id integer NOT NULL,
    int_perfil_permissao_permissao_id integer NOT NULL
);


ALTER TABLE geral.tb_perfil_permissao OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 24622)
-- Name: tb_perfil_usuario; Type: TABLE; Schema: geral; Owner: postgres
--

CREATE TABLE geral.tb_perfil_usuario (
    int_perfil_usuario_usuario_id integer NOT NULL,
    int_perfil_usuario_perfil_id integer NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE geral.tb_perfil_usuario OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 24625)
-- Name: tb_permissao; Type: TABLE; Schema: geral; Owner: postgres
--

CREATE TABLE geral.tb_permissao (
    int_permissao_id integer NOT NULL,
    str_nome character varying(45) NOT NULL,
    str_descricao character varying(300) NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    int_permissao_recurso_id integer NOT NULL
);


ALTER TABLE geral.tb_permissao OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 24628)
-- Name: tb_permissao_int_permissao_id_seq; Type: SEQUENCE; Schema: geral; Owner: postgres
--

CREATE SEQUENCE geral.tb_permissao_int_permissao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE geral.tb_permissao_int_permissao_id_seq OWNER TO postgres;

--
-- TOC entry 2981 (class 0 OID 0)
-- Dependencies: 212
-- Name: tb_permissao_int_permissao_id_seq; Type: SEQUENCE OWNED BY; Schema: geral; Owner: postgres
--

ALTER SEQUENCE geral.tb_permissao_int_permissao_id_seq OWNED BY geral.tb_permissao.int_permissao_id;


--
-- TOC entry 213 (class 1259 OID 24630)
-- Name: tb_recurso; Type: TABLE; Schema: geral; Owner: postgres
--

CREATE TABLE geral.tb_recurso (
    int_recurso_id integer NOT NULL,
    int_modulo_id integer NOT NULL,
    int_categoria_recurso_id integer NOT NULL,
    str_nome character varying(150) NOT NULL,
    str_descricao character varying(300) NOT NULL,
    str_icone character varying(45) NOT NULL,
    bol_ativo boolean DEFAULT true NOT NULL,
    int_ordem integer NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE geral.tb_recurso OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 24637)
-- Name: tb_recurso_int_recurso_id_seq; Type: SEQUENCE; Schema: geral; Owner: postgres
--

CREATE SEQUENCE geral.tb_recurso_int_recurso_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE geral.tb_recurso_int_recurso_id_seq OWNER TO postgres;

--
-- TOC entry 2982 (class 0 OID 0)
-- Dependencies: 214
-- Name: tb_recurso_int_recurso_id_seq; Type: SEQUENCE OWNED BY; Schema: geral; Owner: postgres
--

ALTER SEQUENCE geral.tb_recurso_int_recurso_id_seq OWNED BY geral.tb_recurso.int_recurso_id;


--
-- TOC entry 215 (class 1259 OID 24639)
-- Name: tb_tce_unidade; Type: TABLE; Schema: geral; Owner: postgres
--

CREATE TABLE geral.tb_tce_unidade (
    int_unidade_tce_id integer NOT NULL,
    str_unidade text,
    str_tipo character varying,
    str_sigla character varying,
    int_tce_id integer
);


ALTER TABLE geral.tb_tce_unidade OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 24645)
-- Name: tb_tce_unidade_int_unidade_tce_id_seq; Type: SEQUENCE; Schema: geral; Owner: postgres
--

CREATE SEQUENCE geral.tb_tce_unidade_int_unidade_tce_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE geral.tb_tce_unidade_int_unidade_tce_id_seq OWNER TO postgres;

--
-- TOC entry 2983 (class 0 OID 0)
-- Dependencies: 216
-- Name: tb_tce_unidade_int_unidade_tce_id_seq; Type: SEQUENCE OWNED BY; Schema: geral; Owner: postgres
--

ALTER SEQUENCE geral.tb_tce_unidade_int_unidade_tce_id_seq OWNED BY geral.tb_tce_unidade.int_unidade_tce_id;


--
-- TOC entry 217 (class 1259 OID 24647)
-- Name: tb_unidade; Type: TABLE; Schema: geral; Owner: postgres
--

CREATE TABLE geral.tb_unidade (
    int_unidade_id integer NOT NULL,
    str_unidade character varying(255) NOT NULL,
    str_sigla character varying(255),
    str_cnpj_unidade character varying(14),
    str_cpf_representante character varying(11),
    str_nome_representante character varying(150),
    str_unidade_status character varying(10),
    str_email character varying(60),
    int_tce_unidade_id integer
);


ALTER TABLE geral.tb_unidade OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 24653)
-- Name: tb_usuario; Type: TABLE; Schema: geral; Owner: postgres
--

CREATE TABLE geral.tb_usuario (
    int_usuario_id integer NOT NULL,
    str_nome character varying(150) NOT NULL,
    str_email character varying(150) NOT NULL,
    str_telefone character varying(15),
    str_usuario character varying(45),
    str_senha character varying(100) NOT NULL,
    bol_ativo boolean DEFAULT true NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    int_cpf bigint,
    str_cargo character varying(50),
    bol_alterar_senha boolean DEFAULT true NOT NULL,
    str_link_doc character varying(255),
    dta_ultimo_login timestamp without time zone
);


ALTER TABLE geral.tb_usuario OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24661)
-- Name: tb_usuario_anexo; Type: TABLE; Schema: geral; Owner: postgres
--

CREATE TABLE geral.tb_usuario_anexo (
    int_usuario_id integer NOT NULL,
    int_anexo_id integer NOT NULL
);


ALTER TABLE geral.tb_usuario_anexo OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 24664)
-- Name: tb_usuario_int_usuario_id_seq; Type: SEQUENCE; Schema: geral; Owner: postgres
--

CREATE SEQUENCE geral.tb_usuario_int_usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE geral.tb_usuario_int_usuario_id_seq OWNER TO postgres;

--
-- TOC entry 2984 (class 0 OID 0)
-- Dependencies: 220
-- Name: tb_usuario_int_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: geral; Owner: postgres
--

ALTER SEQUENCE geral.tb_usuario_int_usuario_id_seq OWNED BY geral.tb_usuario.int_usuario_id;


--
-- TOC entry 221 (class 1259 OID 24666)
-- Name: tb_usuario_mensagem; Type: TABLE; Schema: geral; Owner: postgres
--

CREATE TABLE geral.tb_usuario_mensagem (
    int_usuario_id integer NOT NULL,
    int_mensagem_id integer NOT NULL,
    int_num_leitura integer NOT NULL,
    bol_lido boolean NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    int_usuario_mensagem_id integer NOT NULL
);


ALTER TABLE geral.tb_usuario_mensagem OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 24669)
-- Name: tb_usuario_mensagem_int_usuario_mensagem_id_seq; Type: SEQUENCE; Schema: geral; Owner: postgres
--

CREATE SEQUENCE geral.tb_usuario_mensagem_int_usuario_mensagem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE geral.tb_usuario_mensagem_int_usuario_mensagem_id_seq OWNER TO postgres;

--
-- TOC entry 2985 (class 0 OID 0)
-- Dependencies: 222
-- Name: tb_usuario_mensagem_int_usuario_mensagem_id_seq; Type: SEQUENCE OWNED BY; Schema: geral; Owner: postgres
--

ALTER SEQUENCE geral.tb_usuario_mensagem_int_usuario_mensagem_id_seq OWNED BY geral.tb_usuario_mensagem.int_usuario_mensagem_id;


--
-- TOC entry 223 (class 1259 OID 24671)
-- Name: tb_usuario_unidade; Type: TABLE; Schema: geral; Owner: postgres
--

CREATE TABLE geral.tb_usuario_unidade (
    int_usuario_id integer NOT NULL,
    int_unidade_id integer NOT NULL
);


ALTER TABLE geral.tb_usuario_unidade OWNER TO postgres;

--
-- TOC entry 2759 (class 2604 OID 24674)
-- Name: tb_anexo int_anexo_id; Type: DEFAULT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_anexo ALTER COLUMN int_anexo_id SET DEFAULT nextval('geral.tb_anexo_int_anexo_id_seq'::regclass);


--
-- TOC entry 2761 (class 2604 OID 24675)
-- Name: tb_categoria_recurso int_categoria_recurso_id; Type: DEFAULT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_categoria_recurso ALTER COLUMN int_categoria_recurso_id SET DEFAULT nextval('geral.tb_categoria_recurso_int_categoria_recurso_id_seq'::regclass);


--
-- TOC entry 2762 (class 2604 OID 24676)
-- Name: tb_feriados int_feriado_id; Type: DEFAULT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_feriados ALTER COLUMN int_feriado_id SET DEFAULT nextval('geral.tb_feriados_int_feriado_id_seq'::regclass);


--
-- TOC entry 2763 (class 2604 OID 24677)
-- Name: tb_mensagens int_mensagem_id; Type: DEFAULT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_mensagens ALTER COLUMN int_mensagem_id SET DEFAULT nextval('geral.tb_mensagens_int_mensagem_id_seq'::regclass);


--
-- TOC entry 2765 (class 2604 OID 24678)
-- Name: tb_modulo int_modulo_id; Type: DEFAULT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_modulo ALTER COLUMN int_modulo_id SET DEFAULT nextval('geral.tb_modulo_int_modulo_id_seq'::regclass);


--
-- TOC entry 2766 (class 2604 OID 24679)
-- Name: tb_perfil int_perfil_id; Type: DEFAULT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_perfil ALTER COLUMN int_perfil_id SET DEFAULT nextval('geral.tb_perfil_int_perfil_id_seq'::regclass);


--
-- TOC entry 2767 (class 2604 OID 24680)
-- Name: tb_permissao int_permissao_id; Type: DEFAULT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_permissao ALTER COLUMN int_permissao_id SET DEFAULT nextval('geral.tb_permissao_int_permissao_id_seq'::regclass);


--
-- TOC entry 2769 (class 2604 OID 24681)
-- Name: tb_recurso int_recurso_id; Type: DEFAULT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_recurso ALTER COLUMN int_recurso_id SET DEFAULT nextval('geral.tb_recurso_int_recurso_id_seq'::regclass);


--
-- TOC entry 2770 (class 2604 OID 24682)
-- Name: tb_tce_unidade int_unidade_tce_id; Type: DEFAULT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_tce_unidade ALTER COLUMN int_unidade_tce_id SET DEFAULT nextval('geral.tb_tce_unidade_int_unidade_tce_id_seq'::regclass);


--
-- TOC entry 2773 (class 2604 OID 24683)
-- Name: tb_usuario int_usuario_id; Type: DEFAULT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_usuario ALTER COLUMN int_usuario_id SET DEFAULT nextval('geral.tb_usuario_int_usuario_id_seq'::regclass);


--
-- TOC entry 2774 (class 2604 OID 24684)
-- Name: tb_usuario_mensagem int_usuario_mensagem_id; Type: DEFAULT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_usuario_mensagem ALTER COLUMN int_usuario_mensagem_id SET DEFAULT nextval('geral.tb_usuario_mensagem_int_usuario_mensagem_id_seq'::regclass);


--
-- TOC entry 2940 (class 0 OID 24578)
-- Dependencies: 197
-- Data for Name: tb_anexo; Type: TABLE DATA; Schema: geral; Owner: postgres
--

INSERT INTO geral.tb_anexo VALUES (1, '201810031538588674.pdf', 'application/pdf', '2018-10-03 14:44:34', '2018-10-03 14:44:34', '8º Fórum de Profissionais PHP do Estado do Maranhão.pdf');
INSERT INTO geral.tb_anexo VALUES (2, '201810031538588779.pdf', 'application/pdf', '2018-10-03 14:46:19', '2018-10-03 14:46:19', '3Contrato-Criação-de-logotipo.pdf');


--
-- TOC entry 2942 (class 0 OID 24586)
-- Dependencies: 199
-- Data for Name: tb_categoria_recurso; Type: TABLE DATA; Schema: geral; Owner: postgres
--

INSERT INTO geral.tb_categoria_recurso VALUES (1, 'Cadastros', 'fa-cog', 1, true, '2015-05-20 11:30:00', '2015-05-20 11:30:00');
INSERT INTO geral.tb_categoria_recurso VALUES (2, 'Relatórios', 'fa-cog ipsum', 2, true, '2015-05-20 11:30:00', '2015-05-20 11:30:00');
INSERT INTO geral.tb_categoria_recurso VALUES (3, 'Consultas', 'fa-eye', 3, true, '2015-07-07 16:59:45', '2015-07-07 16:59:45');
INSERT INTO geral.tb_categoria_recurso VALUES (4, 'Dashboard', 'fa-home', 0, true, '2015-07-08 14:40:00', '2015-07-08 14:40:00');
INSERT INTO geral.tb_categoria_recurso VALUES (5, 'Categoria Invisível', 'fa-hidden', 100, false, '2015-07-30 12:49:23', '2015-07-30 12:49:23');
INSERT INTO geral.tb_categoria_recurso VALUES (6, 'Manual', 'fa-file-pdf-o', 4, true, '2016-01-28 10:26:49', '2016-01-28 10:26:49');
INSERT INTO geral.tb_categoria_recurso VALUES (7, 'Atividade', 'fa-exchange', 1, true, '2018-09-21 14:49:16', '2018-09-21 14:49:16');


--
-- TOC entry 2944 (class 0 OID 24592)
-- Dependencies: 201
-- Data for Name: tb_feriados; Type: TABLE DATA; Schema: geral; Owner: postgres
--



--
-- TOC entry 2946 (class 0 OID 24597)
-- Dependencies: 203
-- Data for Name: tb_mensagens; Type: TABLE DATA; Schema: geral; Owner: postgres
--

INSERT INTO geral.tb_mensagens VALUES (14, 3, 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '2016-05-12 00:00:00', '2016-05-18 00:00:00', true, 'M', '2016-05-13 17:46:42', '2016-05-13 18:10:55', 'Testando inserção de Mensagem', '2016-05-13 18:10:55');
INSERT INTO geral.tb_mensagens VALUES (13, 3, 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '2016-05-10 00:00:00', '2016-05-20 00:00:00', true, 'C', '2016-05-13 15:40:09', '2016-05-13 18:12:07', 'Outro Teste Editando mensagem', '2016-05-13 18:12:07');
INSERT INTO geral.tb_mensagens VALUES (12, 3, 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '2016-05-10 00:00:00', '2016-05-20 00:00:00', true, 'C', '2016-05-13 15:39:50', '2016-05-13 18:12:17', 'Outro Teste', '2016-05-13 18:12:17');
INSERT INTO geral.tb_mensagens VALUES (9, 1, 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '2016-05-10 00:00:00', '2016-05-27 00:00:00', true, 'M', '2016-05-13 15:05:30', '2016-05-16 14:22:27', 'Testando inserção de Mensagem', '2016-05-16 14:22:27');
INSERT INTO geral.tb_mensagens VALUES (4, 5, 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '2016-05-09 00:00:00', '2016-05-10 00:00:00', true, 'M', '2016-05-09 00:00:00', '2016-05-13 18:24:21', 'Adicionando verificaçção de Ok', '2016-05-13 18:24:21');
INSERT INTO geral.tb_mensagens VALUES (7, 2, 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '2016-05-12 00:00:00', '2016-05-14 00:00:00', true, 'M', '2016-05-09 00:00:00', '2016-05-10 00:00:00', 'Adicionando sessao, ola, ola de Ok', NULL);
INSERT INTO geral.tb_mensagens VALUES (8, 1, 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '2016-05-10 00:00:00', '2016-05-27 00:00:00', true, 'C', '2016-05-13 15:03:42', '2016-05-13 15:03:42', 'Testando inserção de Mensagem', NULL);
INSERT INTO geral.tb_mensagens VALUES (10, 1, 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '2016-05-11 00:00:00', '2016-05-26 00:00:00', true, 'C', '2016-05-13 15:24:34', '2016-05-13 15:24:34', 'Testando Teste', NULL);
INSERT INTO geral.tb_mensagens VALUES (5, 4, 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '2016-05-09 00:00:00', '2016-05-10 00:00:00', true, 'C', '2016-05-09 00:00:00', '2016-05-13 18:21:15', 'Adicionando outra de Ok', '2016-05-13 18:21:15');
INSERT INTO geral.tb_mensagens VALUES (11, 3, 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '2016-05-10 00:00:00', '2016-05-20 00:00:00', true, 'C', '2016-05-13 15:30:14', '2016-05-13 18:24:17', 'Outro Teste Mamãe', '2016-05-13 18:24:17');
INSERT INTO geral.tb_mensagens VALUES (6, 2, 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '2016-05-18 00:00:00', '2016-05-27 00:00:00', true, 'M', '2016-05-09 00:00:00', '2016-05-16 15:05:59', 'Adicionando sessao, ola, ola de Ok', '2016-05-16 15:05:59');
INSERT INTO geral.tb_mensagens VALUES (15, 5, 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '2016-05-16 00:00:00', '2016-05-19 00:00:00', true, 'M', '2016-05-16 11:18:42', '2016-05-16 14:49:03', 'Modificação no Aditivo', NULL);
INSERT INTO geral.tb_mensagens VALUES (16, 1, 'Testando', '2016-05-15 00:00:00', '2016-05-26 00:00:00', true, 'M', '2016-05-16 15:05:18', '2016-05-16 15:05:44', 'Testando notificacao Via Chrome Editado', NULL);
INSERT INTO geral.tb_mensagens VALUES (17, 5, '1. Adicionado função tal

2. Revisto o tal

3. Essas ferramentas são softwares de medição e permitem ao usuário, a qualquer tempo, medir a qualidade de sua conexão banda larga (Internet), fixa ou móvel, visualizando os resultados imediatamente, bem como o histórico das medições anteriores. Os resultados apresentados pelos softwares são medidas momentâneas da qualidade de conexão e indicam uma referência para o acompanhamento do desempenho da banda larga.

4. Essas ferramentas são softwares de medição e permitem ao usuário, a qualquer tempo, medir a qualidade de sua conexão banda larga (Internet), fixa ou móvel, visualizando os resultados imediatamente, bem como o histórico das medições anteriores. Os resultados apresentados pelos softwares são medidas momentâneas da qualidade de conexão e indicam uma referência para o acompanhamento do desempenho da banda larga.', '2016-05-01 00:00:00', '2016-07-31 00:00:00', true, 'C', '2016-05-16 15:24:45', '2016-05-16 15:24:45', 'Detalhes da nova versão do Contratta - 16/05/2016', NULL);
INSERT INTO geral.tb_mensagens VALUES (18, 1, 'Al&ocirc;&lt;br&gt;Pessoal&lt;br&gt;', '2016-05-16 00:00:00', '2016-05-21 00:00:00', true, 'M', '2016-05-16 16:22:20', '2016-05-16 16:34:14', 'Testando inserção de Mensagem 123', NULL);
INSERT INTO geral.tb_mensagens VALUES (19, 5, '&lt;span&gt;&lt;br&gt;Melhorias apresentadas nova vers&atilde;o do sistema:&lt;/span&gt;&lt;br&gt;&lt;ol&gt;&lt;li&gt;Adicionado fun&ccedil;&atilde;o tal&lt;br&gt;&lt;/li&gt;&lt;li&gt;Revisto o tal&amp;nbsp;&lt;/li&gt;&lt;li&gt;Essas ferramentas são softwares de medição e permitem ao usuário, a qualquer tempo, medir a qualidade de sua conexão banda larga (Internet), fixa ou móvel, visualizando os resultados imediatamente, bem como o histórico das medições anteriores. Os resultados apresentados pelos softwares são medidas momentâneas da qualidade de conexão e indicam uma referência para o acompanhamento do desempenho da banda larga.&amp;nbsp;&lt;/li&gt;&lt;li&gt;Essas ferramentas são softwares de medição e permitem ao usuário, a qualquer tempo, medir a qualidade de sua conexão banda larga (Internet), fixa ou móvel, visualizando os resultados imediatamente, bem como o histórico das medições anteriores. Os resultados apresentados pelos softwares são medidas momentâneas da qualidade de conexão e indicam uma referência para o acompanhamento do desempenho da banda larga.&lt;/li&gt;&lt;/ol&gt;', '2016-05-01 00:00:00', '2016-05-19 00:00:00', true, 'C', '2016-05-19 16:43:18', '2016-05-19 16:43:18', 'Detalhes da nova versão do Contratta - 16/05/20169', NULL);
INSERT INTO geral.tb_mensagens VALUES (20, 1, 'Testando mam&atilde;o eu&lt;br&gt;To na globo&lt;br&gt;', '2016-05-18 00:00:00', '2016-05-31 00:00:00', true, 'M', '2016-05-20 14:21:50', '2016-05-20 14:21:50', 'Testando, Eh Nois', NULL);
INSERT INTO geral.tb_mensagens VALUES (21, 3, 'testando notifica&ccedil;&otilde;es do admin', '2019-04-02 00:00:00', '2019-04-02 00:00:00', true, 'M', '2019-04-02 10:14:15', '2019-04-02 10:14:15', 'Teste de notificações', NULL);
INSERT INTO geral.tb_mensagens VALUES (23, 8, 'Novo filtro adicionado em Cadastros &amp;gt; Tomadas de Contas. Filtro por&amp;nbsp;Tipo de movimenta&ccedil;&atilde;o. &Eacute; poss&iacute;vel filtrar selecionando a movimenta&ccedil;&atilde;o e/ou informando o per&iacute;odo em que ela foi registrada no sistema.', '2019-06-18 00:00:00', '2019-06-19 00:00:00', true, 'C', '2019-06-18 11:57:21', '2019-06-18 11:57:21', 'Novo filtro adicionado ao suprema50', NULL);
INSERT INTO geral.tb_mensagens VALUES (22, 1, 'testando notifica&ccedil;&otilde;es do admin', '2019-04-02 00:00:00', '2019-04-03 00:00:00', true, 'M', '2019-04-02 11:03:37', '2020-01-19 04:07:08', 'testando notificação', '2020-01-19 04:07:08');
INSERT INTO geral.tb_mensagens VALUES (24, 1, 'teste', '2020-01-18 00:00:00', '2020-01-20 00:00:00', true, 'M', '2020-01-19 04:10:31', '2020-01-19 04:10:31', 'teste', NULL);


--
-- TOC entry 2948 (class 0 OID 24605)
-- Dependencies: 205
-- Data for Name: tb_modulo; Type: TABLE DATA; Schema: geral; Owner: postgres
--

INSERT INTO geral.tb_modulo VALUES (1, 'admin', 'Admin', 'fa-cog', true, '2015-05-20 11:30:00', '2015-05-20 11:30:00', 'Admin');
INSERT INTO geral.tb_modulo VALUES (15, 'log-viewer', 'Logs do App', 'fa-archive', true, '2019-06-05 14:55:25', '2019-06-05 14:55:25', 'AppLogs');
INSERT INTO geral.tb_modulo VALUES (17, 'asd', 'asdddd', 'asd', true, '2020-01-16 23:40:41', '2020-01-16 23:40:41', 'asda');


--
-- TOC entry 2950 (class 0 OID 24614)
-- Dependencies: 207
-- Data for Name: tb_perfil; Type: TABLE DATA; Schema: geral; Owner: postgres
--

INSERT INTO geral.tb_perfil VALUES (1, 'Administrador', 'Administrador do módulo ADMIN.', '2015-07-07 18:34:55', '2015-07-07 18:34:55', 1);
INSERT INTO geral.tb_perfil VALUES (35, 'Administrador', 'Administrador de Logs', '2019-06-05 14:59:28', '2019-06-05 14:59:28', 15);
INSERT INTO geral.tb_perfil VALUES (42, 'teste', 'teste', '2020-01-19 03:17:22', '2020-01-19 03:17:22', 17);
INSERT INTO geral.tb_perfil VALUES (43, 'testeAdm', 'asdddd', '2020-01-19 08:37:06', '2020-01-19 08:37:06', 1);


--
-- TOC entry 2952 (class 0 OID 24619)
-- Dependencies: 209
-- Data for Name: tb_perfil_permissao; Type: TABLE DATA; Schema: geral; Owner: postgres
--

INSERT INTO geral.tb_perfil_permissao VALUES (1, 5);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 6);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 7);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 8);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 9);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 10);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 11);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 12);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 13);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 14);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 16);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 17);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 18);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 19);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 20);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 21);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 22);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 23);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 24);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 26);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 27);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 28);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 496);
INSERT INTO geral.tb_perfil_permissao VALUES (42, 585);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 92);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 116);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 119);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 121);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 122);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 123);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 124);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 125);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 384);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 385);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 383);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 1);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 2);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 3);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 117);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 120);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 496);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 4);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 5);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 6);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 7);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 116);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 119);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 384);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 385);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 383);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 23);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 24);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 26);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 27);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 92);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 21);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 22);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 18);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 19);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 20);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 14);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 16);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 17);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 11);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 12);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 13);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 8);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 9);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 10);
INSERT INTO geral.tb_perfil_permissao VALUES (43, 28);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 479);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 480);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 4);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 120);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 2);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 117);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 1);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 3);
INSERT INTO geral.tb_perfil_permissao VALUES (35, 498);
INSERT INTO geral.tb_perfil_permissao VALUES (35, 499);
INSERT INTO geral.tb_perfil_permissao VALUES (35, 500);
INSERT INTO geral.tb_perfil_permissao VALUES (35, 501);


--
-- TOC entry 2953 (class 0 OID 24622)
-- Dependencies: 210
-- Data for Name: tb_perfil_usuario; Type: TABLE DATA; Schema: geral; Owner: postgres
--

INSERT INTO geral.tb_perfil_usuario VALUES (2, 1, '2015-07-07 18:45:14', '2015-07-07 18:45:14');
INSERT INTO geral.tb_perfil_usuario VALUES (3, 1, '2015-07-07 18:46:34', '2015-07-07 18:46:34');
INSERT INTO geral.tb_perfil_usuario VALUES (5, 1, '2015-07-07 18:46:46', '2015-07-07 18:46:46');
INSERT INTO geral.tb_perfil_usuario VALUES (147, 1, '2016-02-26 17:18:02', '2016-02-26 17:18:02');
INSERT INTO geral.tb_perfil_usuario VALUES (31, 1, '2016-04-12 15:10:13', '2016-04-12 15:10:13');
INSERT INTO geral.tb_perfil_usuario VALUES (148, 1, '2016-05-13 11:20:59', '2016-05-13 11:20:59');
INSERT INTO geral.tb_perfil_usuario VALUES (169, 1, '2016-06-01 15:41:52', '2016-06-01 15:41:52');
INSERT INTO geral.tb_perfil_usuario VALUES (171, 1, '2016-08-22 18:05:33', '2016-08-22 18:05:33');
INSERT INTO geral.tb_perfil_usuario VALUES (202, 1, '2018-02-20 10:43:56', '2018-02-20 10:43:56');
INSERT INTO geral.tb_perfil_usuario VALUES (172, 1, '2016-08-29 10:42:36', '2016-08-29 10:42:36');
INSERT INTO geral.tb_perfil_usuario VALUES (176, 35, '2019-09-03 10:04:41', '2019-09-03 10:04:41');
INSERT INTO geral.tb_perfil_usuario VALUES (1, 1, '2018-04-18 09:50:22', '2018-04-18 09:50:22');
INSERT INTO geral.tb_perfil_usuario VALUES (206, 1, '2018-04-27 17:27:45', '2018-04-27 17:27:45');
INSERT INTO geral.tb_perfil_usuario VALUES (208, 1, '2018-04-30 14:12:46', '2018-04-30 14:12:46');
INSERT INTO geral.tb_perfil_usuario VALUES (9, 1, '2018-01-11 15:48:57', '2018-01-11 15:48:57');
INSERT INTO geral.tb_perfil_usuario VALUES (201, 1, '2018-02-15 19:54:44', '2018-02-15 19:54:44');
INSERT INTO geral.tb_perfil_usuario VALUES (210, 1, '2020-01-19 08:51:02', '2020-01-19 08:51:02');
INSERT INTO geral.tb_perfil_usuario VALUES (210, 35, '2019-06-05 15:00:43', '2019-06-05 15:00:43');
INSERT INTO geral.tb_perfil_usuario VALUES (148, 35, '2019-07-08 10:15:43', '2019-07-08 10:15:43');
INSERT INTO geral.tb_perfil_usuario VALUES (176, 1, '2019-07-31 09:12:33', '2019-07-31 09:12:33');


--
-- TOC entry 2954 (class 0 OID 24625)
-- Dependencies: 211
-- Data for Name: tb_permissao; Type: TABLE DATA; Schema: geral; Owner: postgres
--

INSERT INTO geral.tb_permissao VALUES (1, 'index', 'Página inicial de módulos.', '2015-07-07 15:23:47', '2015-07-07 15:23:47', 1);
INSERT INTO geral.tb_permissao VALUES (2, 'create', 'Criação de novo módulo.', '2015-07-07 15:24:36', '2015-07-07 15:24:36', 1);
INSERT INTO geral.tb_permissao VALUES (3, 'delete', 'Deletar módulo.', '2015-07-07 15:24:53', '2015-07-07 15:24:53', 1);
INSERT INTO geral.tb_permissao VALUES (4, 'index', 'Página inicial de usuários.', '2015-07-07 15:37:16', '2015-07-07 15:37:16', 2);
INSERT INTO geral.tb_permissao VALUES (5, 'create', 'Página de cadastro de usuários.', '2015-07-07 15:37:54', '2015-07-07 15:37:54', 2);
INSERT INTO geral.tb_permissao VALUES (6, 'edit', 'Página para editar usuários.', '2015-07-07 15:38:40', '2015-07-07 15:38:40', 2);
INSERT INTO geral.tb_permissao VALUES (7, 'delete', 'Deletar usuário.', '2015-07-07 15:39:12', '2015-07-07 15:39:12', 2);
INSERT INTO geral.tb_permissao VALUES (8, 'index', 'Página inicial de categorias recursos.', '2015-07-07 15:47:18', '2015-07-07 15:47:18', 3);
INSERT INTO geral.tb_permissao VALUES (9, 'create', 'Criação de nova categoria recurso.', '2015-07-07 15:48:18', '2015-07-07 15:48:18', 3);
INSERT INTO geral.tb_permissao VALUES (10, 'delete', 'Deletar categoria.', '2015-07-07 15:48:41', '2015-07-07 15:48:41', 3);
INSERT INTO geral.tb_permissao VALUES (11, 'index', 'Página inicial de recursos.', '2015-07-07 16:03:14', '2015-07-07 16:03:14', 4);
INSERT INTO geral.tb_permissao VALUES (12, 'create', 'Criação de novo recurso.', '2015-07-07 16:03:39', '2015-07-07 16:03:39', 4);
INSERT INTO geral.tb_permissao VALUES (13, 'delete', 'Deletar recurso.', '2015-07-07 16:04:12', '2015-07-07 16:04:12', 4);
INSERT INTO geral.tb_permissao VALUES (14, 'index', 'Página inicial de permissões.', '2015-07-07 16:09:25', '2015-07-07 16:09:25', 5);
INSERT INTO geral.tb_permissao VALUES (16, 'create', 'Criação de nova permissão.', '2015-07-07 16:10:13', '2015-07-07 16:10:13', 5);
INSERT INTO geral.tb_permissao VALUES (17, 'delete', 'Deletar permissão.', '2015-07-07 16:10:32', '2015-07-07 16:10:32', 5);
INSERT INTO geral.tb_permissao VALUES (18, 'index', 'Página inicial de perfis.', '2015-07-07 16:22:45', '2015-07-07 16:22:45', 6);
INSERT INTO geral.tb_permissao VALUES (19, 'create', 'Criação de novo perfil.', '2015-07-07 16:23:14', '2015-07-07 16:23:14', 6);
INSERT INTO geral.tb_permissao VALUES (20, 'delete', 'Deletar perfil.', '2015-07-07 16:23:36', '2015-07-07 16:23:36', 6);
INSERT INTO geral.tb_permissao VALUES (21, 'index', 'Página inicial de perfis permissões.', '2015-07-07 16:31:01', '2015-07-07 16:31:01', 7);
INSERT INTO geral.tb_permissao VALUES (22, 'atribuirpermissoes', 'Página para atribuir permissões a um perfil.', '2015-07-07 16:32:01', '2015-07-07 16:32:01', 7);
INSERT INTO geral.tb_permissao VALUES (23, 'index', 'Página inicial de perfis usuários.', '2015-07-07 16:39:47', '2015-07-07 16:39:47', 8);
INSERT INTO geral.tb_permissao VALUES (24, 'atribuirperfis', 'Página para atribuir perfis a um usuário.', '2015-07-07 16:40:56', '2015-07-07 16:40:56', 8);
INSERT INTO geral.tb_permissao VALUES (26, 'desvincularperfil', 'Deletar um perfil de um usuário.', '2015-07-07 16:42:30', '2015-07-07 16:42:30', 8);
INSERT INTO geral.tb_permissao VALUES (27, 'atribuir', 'Atribuir um perfil a um usuário', '2015-07-07 16:43:28', '2015-07-07 16:43:28', 8);
INSERT INTO geral.tb_permissao VALUES (28, 'index', 'Página inicial de admin.', '2015-07-07 16:52:21', '2015-07-07 16:52:21', 9);
INSERT INTO geral.tb_permissao VALUES (92, 'perfis', 'Atribuir perfis ao usuario', '2015-11-04 14:55:20', '2015-11-04 14:55:20', 8);
INSERT INTO geral.tb_permissao VALUES (102, 'index', 'Index', '2015-11-16 18:44:11', '2015-11-16 18:44:11', 28);
INSERT INTO geral.tb_permissao VALUES (103, 'atribuirusuarios', 'Vincular usuário a uma unidade', '2015-11-16 18:44:37', '2015-11-16 18:44:37', 28);
INSERT INTO geral.tb_permissao VALUES (104, 'edit', 'Editar Unidade', '2015-11-26 10:44:11', '2015-11-26 10:44:11', 28);
INSERT INTO geral.tb_permissao VALUES (585, 'teste', 'teste', '2020-01-19 03:09:02', '2020-01-19 03:09:02', 114);
INSERT INTO geral.tb_permissao VALUES (116, 'generatenewpassword', 'Gerador de nova senha automatica.', '2016-03-08 17:40:28', '2016-03-08 17:40:28', 2);
INSERT INTO geral.tb_permissao VALUES (117, 'import', 'Importe de usuários', '2016-03-15 11:45:29', '2016-03-15 11:45:29', 1);
INSERT INTO geral.tb_permissao VALUES (119, 'messagereaded', 'Realiza processo de marcar mensagem de  notificações de alteração do sistema como lido pelo usuário', '2016-05-09 17:06:09', '2016-05-09 17:06:09', 2);
INSERT INTO geral.tb_permissao VALUES (120, 'notification', 'Area de listagem das notificações de alterações realizadas no sistema.', '2016-05-10 16:47:32', '2016-05-10 16:47:32', 1);
INSERT INTO geral.tb_permissao VALUES (121, 'create', 'Criação de Mensagens de Notificações de Alterações no Sistema.', '2016-05-13 10:47:18', '2016-05-13 10:47:18', 32);
INSERT INTO geral.tb_permissao VALUES (122, 'index', 'Listagem das mensagens de Notificações do Sistema', '2016-05-13 12:17:19', '2016-05-13 12:17:19', 32);
INSERT INTO geral.tb_permissao VALUES (123, 'edit', 'Edição de Mensagens de Notificação', '2016-05-13 15:17:04', '2016-05-13 15:17:04', 32);
INSERT INTO geral.tb_permissao VALUES (124, 'view', 'Visualização de Mensagens de Notificação', '2016-05-13 15:17:26', '2016-05-13 15:17:26', 32);
INSERT INTO geral.tb_permissao VALUES (125, 'delete', 'Remove uma notificação ', '2016-05-13 17:28:10', '2016-05-13 17:28:10', 32);
INSERT INTO geral.tb_permissao VALUES (384, 'atribuir', 'Atribuir Perfil', '2018-10-03 14:22:41', '2018-10-03 14:22:41', 2);
INSERT INTO geral.tb_permissao VALUES (385, 'desvincularperfil', 'Desvincular Perfil de usuario', '2018-10-03 14:23:08', '2018-10-03 14:23:08', 2);
INSERT INTO geral.tb_permissao VALUES (383, 'atribuirperfis', 'Atribuir Perfis ao Usuario', '2018-10-03 14:21:55', '2018-10-03 14:21:55', 2);
INSERT INTO geral.tb_permissao VALUES (499, 'index', 'página inicial de logs', '2019-06-05 14:58:10', '2019-06-05 14:58:10', 101);
INSERT INTO geral.tb_permissao VALUES (479, 'index', 'página inicial de migração', '2019-01-28 15:37:46', '2019-01-28 15:37:46', 93);
INSERT INTO geral.tb_permissao VALUES (480, 'migrar-modulo', 'Faz a migração de todas as permissões do módulo para outro banco', '2019-01-28 16:42:27', '2019-01-28 16:42:27', 93);
INSERT INTO geral.tb_permissao VALUES (496, 'index', 'página inicial do sistema', '2019-05-24 15:55:46', '2019-05-24 15:55:46', 1);
INSERT INTO geral.tb_permissao VALUES (498, 'index', 'página inicial de logs', '2019-06-05 14:57:34', '2019-06-05 14:57:34', 100);
INSERT INTO geral.tb_permissao VALUES (500, 'data', 'filtros de logs', '2019-06-05 14:58:51', '2019-06-05 14:58:51', 101);
INSERT INTO geral.tb_permissao VALUES (501, 'delete', 'Deletar Logs', '2019-06-05 14:59:07', '2019-06-05 14:59:07', 101);


--
-- TOC entry 2956 (class 0 OID 24630)
-- Dependencies: 213
-- Data for Name: tb_recurso; Type: TABLE DATA; Schema: geral; Owner: postgres
--

INSERT INTO geral.tb_recurso VALUES (1, 1, 1, 'modulos', 'Módulos', 'fa-cog', true, 1, '2015-07-07 15:23:03', '2015-07-07 15:23:03');
INSERT INTO geral.tb_recurso VALUES (2, 1, 1, 'usuarios', 'Usuários', 'fa-user', true, 2, '2015-07-07 15:36:26', '2015-07-07 15:36:26');
INSERT INTO geral.tb_recurso VALUES (3, 1, 1, 'categoriasrecursos', 'Categorias de Recursos', 'fa-navicon', true, 3, '2015-07-07 15:46:34', '2015-07-07 15:46:34');
INSERT INTO geral.tb_recurso VALUES (4, 1, 1, 'recursos', 'Recursos', 'fa-share-alt', true, 4, '2015-07-07 16:00:27', '2015-07-07 16:00:27');
INSERT INTO geral.tb_recurso VALUES (5, 1, 1, 'permissoes', 'Permissões', 'fa-lock', true, 5, '2015-07-07 16:08:47', '2015-07-07 16:08:47');
INSERT INTO geral.tb_recurso VALUES (6, 1, 1, 'perfis', 'Perfis', 'fa-users', true, 6, '2015-07-07 16:21:10', '2015-07-07 16:21:10');
INSERT INTO geral.tb_recurso VALUES (7, 1, 1, 'perfispermissoes', 'Perfis Permissões', 'fa-exchange', true, 7, '2015-07-07 16:29:51', '2015-07-07 16:29:51');
INSERT INTO geral.tb_recurso VALUES (8, 1, 1, 'perfisusuarios', 'Perfis Usuários', 'fa-exchange', true, 8, '2015-07-07 16:38:47', '2015-07-07 16:38:47');
INSERT INTO geral.tb_recurso VALUES (9, 1, 4, 'index', 'Home', 'fa-home', true, 0, '2015-07-07 16:51:57', '2015-07-07 16:51:57');
INSERT INTO geral.tb_recurso VALUES (28, 1, 1, 'unidades', 'Unidades', 'fa-cog', true, 9, '2015-11-16 18:43:59', '2015-11-16 18:43:59');
INSERT INTO geral.tb_recurso VALUES (32, 1, 1, 'notificacoes', 'Notificações', 'fa-bell-o', true, 10, '2016-05-13 10:01:55', '2016-05-13 10:01:55');
INSERT INTO geral.tb_recurso VALUES (114, 17, 1, 'teste', 'teste', 'asd', true, 1, '2020-01-19 03:07:26', '2020-01-19 03:07:26');
INSERT INTO geral.tb_recurso VALUES (93, 1, 7, 'migracao', 'Migração', 'fa-archive', true, 2, '2019-01-28 15:37:17', '2019-01-28 15:37:17');
INSERT INTO geral.tb_recurso VALUES (100, 15, 4, 'index', 'Página de inicial de logs', 'fa-archive', true, 1, '2019-06-05 14:56:07', '2019-06-05 14:56:07');
INSERT INTO geral.tb_recurso VALUES (101, 15, 5, 'logs', 'Logs do App', 'fa-archive', true, 1, '2019-06-05 14:57:07', '2019-06-05 14:57:07');


--
-- TOC entry 2958 (class 0 OID 24639)
-- Dependencies: 215
-- Data for Name: tb_tce_unidade; Type: TABLE DATA; Schema: geral; Owner: postgres
--

INSERT INTO geral.tb_tce_unidade VALUES (1, 'POLÍCIA MILITAR DO MARANHÃO ', 'ORGÃO', NULL, 433);
INSERT INTO geral.tb_tce_unidade VALUES (2, 'COLÉGIO MILITAR TIRADENTES IV', 'UNIDADE', 'CAXIAS ', 150023438);
INSERT INTO geral.tb_tce_unidade VALUES (3, 'TRIBUNAL DE CONTAS DO ESTADO DO MARANHÃO ', 'ORGÃO', NULL, 435);
INSERT INTO geral.tb_tce_unidade VALUES (4, 'TRIBUNAL DE CONTAS DO ESTADO DO MARANHÃO ', 'UNIDADE', NULL, 435);
INSERT INTO geral.tb_tce_unidade VALUES (5, 'FUNDO DE MODERNIZAÇÃO DO TRIBUNAL DE CONTAS DO ESTADO DO MARANHÃO ', 'UNIDADE', NULL, 150016097);
INSERT INTO geral.tb_tce_unidade VALUES (6, 'NÃO INFORMADO ', 'UNIDADE', NULL, 0);
INSERT INTO geral.tb_tce_unidade VALUES (7, 'SECRETARIA DE ESTADO DA FAZENDA DO MARANHÃO ', 'ORGÃO', NULL, 440);
INSERT INTO geral.tb_tce_unidade VALUES (8, 'SECRETARIA DE ESTADO DA FAZENDA DO MARANHÃO ', 'UNIDADE', NULL, 440);
INSERT INTO geral.tb_tce_unidade VALUES (9, 'FUNDO DE FORTALECIMENTO DA ADMINISTRAÇÃO TRIBUTÁRIA DO MARANHÃO ', 'UNIDADE', NULL, 150019679);
INSERT INTO geral.tb_tce_unidade VALUES (11, 'FUNDO ESTADUAL DE DESENVOLVIMENTO INDUSTRIAL DO MARANHÃO ', 'UNIDADE', NULL, 150014807);
INSERT INTO geral.tb_tce_unidade VALUES (12, 'SECRETARIA DE ESTADO DA CULTURA E TURISMO DO MARANHÃO ', 'ORGÃO', NULL, 446);
INSERT INTO geral.tb_tce_unidade VALUES (13, 'SECRETARIA DE ESTADO DA CULTURA E TURISMO DO MARANHÃO ', 'UNIDADE', NULL, 446);
INSERT INTO geral.tb_tce_unidade VALUES (14, 'FUNDAÇÃO DA MEMÓRIA REPUBLICANA BRASILEIRA ', 'UNIDADE', NULL, 150015390);
INSERT INTO geral.tb_tce_unidade VALUES (15, 'FUNDO DE DESENVOLVIMENTO DA CULTURA MARANHENSE ', 'UNIDADE', NULL, 150019678);
INSERT INTO geral.tb_tce_unidade VALUES (16, 'SECRETARIA DE ESTADO DO ESPORTE E LAZER DO MARANHÃO ', 'ORGÃO', NULL, 447);
INSERT INTO geral.tb_tce_unidade VALUES (17, 'SECRETARIA DE ESTADO DO ESPORTE E LAZER DO MARANHÃO ', 'UNIDADE', NULL, 447);
INSERT INTO geral.tb_tce_unidade VALUES (18, 'SECRETARIA DE ESTADO DE PLANEJAMENTO E ORÇAMENTO DO MARANHÃO ', 'ORGÃO', NULL, 482);
INSERT INTO geral.tb_tce_unidade VALUES (19, 'ENCARGOS GERAIS DO ESTADO', 'UNIDADE', 'SEPLAN ', 150019057);
INSERT INTO geral.tb_tce_unidade VALUES (20, 'SECRETARIA DE ESTADO DE PLANEJAMENTO E ORÇAMENTO DO MARANHÃO ', 'UNIDADE', NULL, 482);
INSERT INTO geral.tb_tce_unidade VALUES (21, 'ENCARGOS FINANCEIROS DO ESTADO DO MARANHÃO', 'UNIDADE', 'SEPLAN ', 150019058);
INSERT INTO geral.tb_tce_unidade VALUES (22, 'SECRETARIA DE ESTADO DA AGRICULTURA, PECUÁRIA E PESCA DO MARANHÃO ', 'ORGÃO', NULL, 483);
INSERT INTO geral.tb_tce_unidade VALUES (23, 'SECRETARIA DE ESTADO DA AGRICULTURA, PECUÁRIA E PESCA DO MARANHÃO ', 'UNIDADE', NULL, 483);
INSERT INTO geral.tb_tce_unidade VALUES (24, 'AGÊNCIA ESTADUAL DE DEFESA AGROPECÚARIA DO MARANHÃO ', 'UNIDADE', NULL, 943);
INSERT INTO geral.tb_tce_unidade VALUES (25, 'SECRETARIA DE ESTADO DA SEGURANÇA PÚBLICA DO MARANHÃO ', 'ORGÃO', NULL, 485);
INSERT INTO geral.tb_tce_unidade VALUES (26, 'SECRETARIA DE ESTADO DE SEGURANÇA PÚBLICA DO MARANHÃO ', 'UNIDADE', NULL, 485);
INSERT INTO geral.tb_tce_unidade VALUES (27, 'POLÍCIA CIVIL DO ESTADO DO MARANHÃO ', 'UNIDADE', NULL, 2252730);
INSERT INTO geral.tb_tce_unidade VALUES (28, 'POLÍCIA MILITAR DO MARANHÃO', 'UNIDADE', 'PM/MA ', 433);
INSERT INTO geral.tb_tce_unidade VALUES (29, 'CORPO DE BOMBEIROS MILITAR DO ESTADO DO MARANHÃO ', 'UNIDADE', NULL, 2252732);
INSERT INTO geral.tb_tce_unidade VALUES (30, 'SEGUNDO BATALHAO DE POLICIA MILITAR/CAXIAS ', 'UNIDADE', NULL, 2252655);
INSERT INTO geral.tb_tce_unidade VALUES (31, 'TERCEIRO BATALHÃO DE POLÍCIA MILITAR/IMPERATRIZ ', 'UNIDADE', NULL, 2252549);
INSERT INTO geral.tb_tce_unidade VALUES (32, 'SÉTIMO BATALHAO DE POLICIA MILITAR/PINDARE', 'UNIDADE', 'MIRIM ', 2252639);
INSERT INTO geral.tb_tce_unidade VALUES (33, 'QUINTO BATALHAO DE POLICIA MILITAR/BARRA DO CORDA ', 'UNIDADE', NULL, 2252659);
INSERT INTO geral.tb_tce_unidade VALUES (34, 'DÉCIMO PRIMEIRO BATALHÃO DE POLÍCIA MILITAR/TIMON ', 'UNIDADE', NULL, 2252512);
INSERT INTO geral.tb_tce_unidade VALUES (35, 'QUINTA COMPANHIA INDEPENDENTE DE POLÍCIA MILITAR/AÇAILÂNDIA ', 'UNIDADE', NULL, 2252661);
INSERT INTO geral.tb_tce_unidade VALUES (36, 'QUARTO BATALHÃO DA POLÍCIA MILITAR/BALSAS ', 'UNIDADE', NULL, 2252922);
INSERT INTO geral.tb_tce_unidade VALUES (37, 'DÉCIMO SEXTO BATALHÃO DE POLÍCIA MILITAR DE CHAPADINHA ', 'UNIDADE', NULL, 2252677);
INSERT INTO geral.tb_tce_unidade VALUES (38, 'DÉCIMO BATALHÃO DE POLÍCIA MILITAR/PINHEIRO ', 'UNIDADE', NULL, 2252763);
INSERT INTO geral.tb_tce_unidade VALUES (39, 'DÉCIMO OITAVO BATALHÃO DE POLICIA MILITAR DE PRESIDENTE DUTRA ', 'UNIDADE', NULL, 150020198);
INSERT INTO geral.tb_tce_unidade VALUES (40, 'DÉCIMO SÉTIMO BATALHÃO DE POLICIA MILITAR/CODÓ ', 'UNIDADE', NULL, 150018877);
INSERT INTO geral.tb_tce_unidade VALUES (41, '4º GRUPAMENTO DE BOMBEIROS MILITAR/BALSAS ', 'UNIDADE', NULL, 2252926);
INSERT INTO geral.tb_tce_unidade VALUES (42, 'TERCEIRO GRUPAMENTO DE BOMBEIROS MILITAR/IMPERATRIZ ', 'UNIDADE', NULL, 2253184);
INSERT INTO geral.tb_tce_unidade VALUES (43, 'DÉCIMO NONO BATALHÃO DE POLICIA MILITAR', 'UNIDADE', 'PEDREIRAS ', 150019558);
INSERT INTO geral.tb_tce_unidade VALUES (44, 'DÉCIMA TERCEIRA COMPANHIA MILITAR INDEPENDENTE ', 'UNIDADE', NULL, 2252700);
INSERT INTO geral.tb_tce_unidade VALUES (45, 'PRIMEIRA COMPANHIA INDEPENDENTE/COLINAS ', 'UNIDADE', NULL, 150020318);
INSERT INTO geral.tb_tce_unidade VALUES (46, '2º ESQUADRÃO DE POLÍCIA MONTADA DE JOÃO LISBOA ', 'UNIDADE', NULL, 2252761);
INSERT INTO geral.tb_tce_unidade VALUES (47, 'OITAVO BATALHÃO DE BOMBEIROS MILITAR 8º BBM', 'UNIDADE', 'PINHEIRO ', 150020058);
INSERT INTO geral.tb_tce_unidade VALUES (48, 'QUINTO BATALHÃO DE BOMBEIROS MILITAR DE CAXIAS ', 'UNIDADE', NULL, 2253185);
INSERT INTO geral.tb_tce_unidade VALUES (49, '12º BATALHÃO DE POLICIA MILITAR DE ESTREITO ', 'UNIDADE', NULL, 150012881);
INSERT INTO geral.tb_tce_unidade VALUES (50, 'DÉCIMO QUINTO BATALHÃO DE POLICIA MILITAR DE BACABAL ', 'UNIDADE', NULL, 2252676);
INSERT INTO geral.tb_tce_unidade VALUES (51, '15ª COMPANHIA INDEPENDENTE DE GRAJAÚ ', 'UNIDADE', NULL, 150020273);
INSERT INTO geral.tb_tce_unidade VALUES (52, '14º BATALHAO DE POLICIA MILITAR DE IMPERATRIZ ', 'UNIDADE', NULL, 150019237);
INSERT INTO geral.tb_tce_unidade VALUES (53, 'COLEGIO MILITAR TIRADENTES II', 'UNIDADE', 'IMPERATRIZ ', 150019117);
INSERT INTO geral.tb_tce_unidade VALUES (54, 'COLEGIO MILITAR TIRADENTES III', 'UNIDADE', 'BACABAL ', 150019519);
INSERT INTO geral.tb_tce_unidade VALUES (55, 'CENTRO DE FORMAÇÃO E APERFEIÇOAMENTO DE PRAÇAS ', 'UNIDADE', NULL, 150020269);
INSERT INTO geral.tb_tce_unidade VALUES (56, 'ACADEMIA DE POLICIA MILITAR GONÇALVES DIAS ', 'UNIDADE', NULL, 150020267);
INSERT INTO geral.tb_tce_unidade VALUES (57, 'BATALHÃO DE POLICIA DE CHOQUE ', 'UNIDADE', NULL, 150020268);
INSERT INTO geral.tb_tce_unidade VALUES (58, 'BATALHÃO DE POLICIA AMBIENTAL ', 'UNIDADE', NULL, 150020270);
INSERT INTO geral.tb_tce_unidade VALUES (59, 'COMPANHIA DE POLICIA RODOVIÁRIA INDEPENDENTE DO ESTADO DO MARANHÃO ', 'UNIDADE', NULL, 150020298);
INSERT INTO geral.tb_tce_unidade VALUES (60, 'SEGUNDA COMPANHIA INDEPENDENTE/MIRINZAL ', 'UNIDADE', NULL, 150020320);
INSERT INTO geral.tb_tce_unidade VALUES (61, 'TERCEIRA CIA INDEPENDENTE/AMARANTE ', 'UNIDADE', NULL, 150020321);
INSERT INTO geral.tb_tce_unidade VALUES (62, 'COORDENADORIA ESTADUAL DE PROTEÇÃO E DEFESA CIVIL DO ESTADO DO MARANHÃO ', 'UNIDADE', NULL, 150020272);
INSERT INTO geral.tb_tce_unidade VALUES (63, 'TERCEIRA COMPANHIA INDEPENDENTE DE BOMBEIROS MILITAR EM ITAPECURU', 'UNIDADE', 'MIRIM ', 150019477);
INSERT INTO geral.tb_tce_unidade VALUES (64, 'QUARTA CIA INDEPENDENTE DE BOMBEIROS MILITAR/BARREIRINHAS ', 'UNIDADE', NULL, 150020323);
INSERT INTO geral.tb_tce_unidade VALUES (65, 'SETIMO BATALHAO DE BOMBEIROS MILITAR/TIMON ', 'UNIDADE', NULL, 150020324);
INSERT INTO geral.tb_tce_unidade VALUES (66, 'SEXTA COMPANHIA INDEPENDENTE DE BOMBEIROS MILITAR DE AÇAILÂNDIA ', 'UNIDADE', NULL, 150020098);
INSERT INTO geral.tb_tce_unidade VALUES (67, 'NONO BATALHAO DE BOMBEIROS MILITAR/ESTREITO ', 'UNIDADE', NULL, 150020325);
INSERT INTO geral.tb_tce_unidade VALUES (68, '1ª COMPANHIA INDEPENDENTE DE BOMBEIROS MILITAR DE SÃO JOSÉ DE RIBAMAR ', 'UNIDADE', NULL, 150020159);
INSERT INTO geral.tb_tce_unidade VALUES (69, 'DEPARTAMENTO ESTADUAL DE TRÂNSITO DO ESTADO DO MARANHÃO ', 'UNIDADE', NULL, 2252644);
INSERT INTO geral.tb_tce_unidade VALUES (70, 'SEXTA COMPANHIA INDEPENDENTE/S.J. DOS PATOS ', 'UNIDADE', NULL, 2252682);
INSERT INTO geral.tb_tce_unidade VALUES (71, '7º BATALHAO DE BOMBEIROS MILITAR DE TIMON ', 'UNIDADE', NULL, 150019598);
INSERT INTO geral.tb_tce_unidade VALUES (72, 'FUNDO ESPECIAL DE SEGURANÇA PUBLICA DO MARANHÃO ', 'UNIDADE', NULL, 150019658);
INSERT INTO geral.tb_tce_unidade VALUES (73, 'FUNDO ESTADUAL DE POLITICAS SOBRE DROGAS DO MARANHAO', 'UNIDADE', 'FEPOD ', 150019659);
INSERT INTO geral.tb_tce_unidade VALUES (74, 'SEGUNDA COMPANHIA DE POLICIA MILITAR INDEPENDENTE DE BACABAL ', 'UNIDADE', NULL, 150015517);
INSERT INTO geral.tb_tce_unidade VALUES (75, 'DÉCIMO BATALHÃO DE BOMBEIROS MILITAR/ SÃO JOSÉ DE RIBAMAR ', 'UNIDADE', NULL, 150024072);
INSERT INTO geral.tb_tce_unidade VALUES (76, 'VIGÉSIMO NONO BATALHÃO DE POLICIA MILITAR / ZÉ DOCA ', 'UNIDADE', NULL, 150024041);
INSERT INTO geral.tb_tce_unidade VALUES (77, 'VIGÉSIMO OITAVO BATALHÃO DE POLICIA MILITAR/ ITAPECURU MIRIM ', 'UNIDADE', NULL, 150024040);
INSERT INTO geral.tb_tce_unidade VALUES (78, 'DÉCIMA SEXTA COMPANHIA INDEPENDENTE DE BOMBEIROS MILITAR/ SÃO LUÍS ', 'UNIDADE', NULL, 150024085);
INSERT INTO geral.tb_tce_unidade VALUES (79, 'DÉCIMA QUINTA COMPANHIA INDEPENDENTE DE BOMBEIROS MILITAR/ CODÓ ', 'UNIDADE', NULL, 150024084);
INSERT INTO geral.tb_tce_unidade VALUES (80, 'DÉCIMA QUARTA COMPANHIA INDEPENDENTE DE BOMBEIROS MILITAR/ CAROLINA ', 'UNIDADE', NULL, 150024083);
INSERT INTO geral.tb_tce_unidade VALUES (81, 'DÉCIMA TERCEIRA COMPANHIA INDEPENDENTE DE BOMBEIROS MILITAR/ TRIZIDELA DO VALE ', 'UNIDADE', NULL, 150024082);
INSERT INTO geral.tb_tce_unidade VALUES (82, 'DÉCIMO SEGUNDO BATALHÃO DE BOMBEIROS MILITAR/ AÇAILÂNDIA ', 'UNIDADE', NULL, 150024081);
INSERT INTO geral.tb_tce_unidade VALUES (83, 'PRIMEIRO REGIMENTO DE POLICIA MONTADA/ SÃO LUÍS ', 'UNIDADE', NULL, 150024080);
INSERT INTO geral.tb_tce_unidade VALUES (84, 'TRIGÉSIMO SÉTIMO BATALHÃO DE POLICIA MILITAR/ GRAJAÚ ', 'UNIDADE', NULL, 150024079);
INSERT INTO geral.tb_tce_unidade VALUES (85, 'TRIGÉSIMO QUINTO BATALHÃO DE POLICIA MILITAR/ SÃO JOÃO DOS PATOS ', 'UNIDADE', NULL, 150024078);
INSERT INTO geral.tb_tce_unidade VALUES (86, 'TRIGÉSIMO QUARTO BATALHÃO DE POLICIA MILITAR/ AMARANTE ', 'UNIDADE', NULL, 150024077);
INSERT INTO geral.tb_tce_unidade VALUES (87, 'BATALHÃO DE POLICIA MILITAR DE TURISMO ', 'UNIDADE', NULL, 150023578);
INSERT INTO geral.tb_tce_unidade VALUES (88, 'TRIGÉSIMO TERCEIRO BATALHÃO DE POLICIA MILITAR/ COLINAS ', 'UNIDADE', NULL, 150024076);
INSERT INTO geral.tb_tce_unidade VALUES (89, 'COLÉGIO MILITAR TIRADENTES V', 'UNIDADE', 'TIMON ', 150023879);
INSERT INTO geral.tb_tce_unidade VALUES (90, 'VIGÉSIMO SÉTIMO BATALHÃO DA POLICIA MILITAR/ ROSÁRIO 27° BPM ', 'UNIDADE', NULL, 150022905);
INSERT INTO geral.tb_tce_unidade VALUES (91, 'TRIGÉSIMO SEGUNDO BATALHÃO DE POLICIA MILITAR/ CIDELÂNDIA ', 'UNIDADE', NULL, 150024075);
INSERT INTO geral.tb_tce_unidade VALUES (92, 'TRIGÉSIMO SEXTO BATALHÃO DE POLICIA MILITAR/ VIANA ', 'UNIDADE', NULL, 150024074);
INSERT INTO geral.tb_tce_unidade VALUES (93, 'TRIGÉSIMO BATALHÃO DE POLICIA MILITAR/ BURITICUPU ', 'UNIDADE', NULL, 150024042);
INSERT INTO geral.tb_tce_unidade VALUES (94, 'TRIGÉSIMO PRIMEIRO BATALHÃO DE POLICIA MILITAR/ GOVERNADOR NUNES FREIRE ', 'UNIDADE', NULL, 150024043);
INSERT INTO geral.tb_tce_unidade VALUES (95, 'DÉCIMO PRIMEIRO BATALHÃO DE BOMBEIROS/ ITAPECURU MIRIM ', 'UNIDADE', NULL, 150024000);
INSERT INTO geral.tb_tce_unidade VALUES (96, 'SECRETARIA DE ESTADO DA EDUCAÇÃO DO MARANHÃO ', 'ORGÃO', NULL, 486);
INSERT INTO geral.tb_tce_unidade VALUES (97, 'SECRETARIA DE ESTADO DA EDUCAÇÃO DO MARANHÃO ', 'UNIDADE', NULL, 486);
INSERT INTO geral.tb_tce_unidade VALUES (98, 'FUNDAÇÃO NICE LOBAO ', 'UNIDADE', NULL, 464);
INSERT INTO geral.tb_tce_unidade VALUES (99, 'FUNDO ESCOLA DIGNA DO ESTADO DO MARANHÃO ', 'UNIDADE', NULL, 150019680);
INSERT INTO geral.tb_tce_unidade VALUES (100, 'PROCURADORIA GERAL DO ESTADO DO MARANHÃO ', 'ORGÃO', NULL, 540);
INSERT INTO geral.tb_tce_unidade VALUES (101, 'PROCURADORIA GERAL DO ESTADO DO MARANHÃO ', 'UNIDADE', NULL, 540);
INSERT INTO geral.tb_tce_unidade VALUES (102, 'SECRETARIA DE ESTADO DE ASSUNTOS POLÍTICOS E FEDERATIVOS DO MARANHÃO ', 'UNIDADE', NULL, 150018997);
INSERT INTO geral.tb_tce_unidade VALUES (103, 'PROCURADORIA GERAL DA JUSTIÇA DO ESTADO DO MARANHÃO ', 'ORGÃO', NULL, 548);
INSERT INTO geral.tb_tce_unidade VALUES (104, 'PROCURADORIA GERAL DA JUSTIÇA DO ESTADO DO MARANHÃO ', 'UNIDADE', NULL, 548);
INSERT INTO geral.tb_tce_unidade VALUES (105, 'FUNDO ESPECIAL DO MINISTÉRIO PÚBLICO ESTADUAL ', 'UNIDADE', NULL, 150016100);
INSERT INTO geral.tb_tce_unidade VALUES (106, 'SECRETARIA DE ESTADO DA SAÚDE DO MARANHÃO ', 'ORGÃO', NULL, 556);
INSERT INTO geral.tb_tce_unidade VALUES (107, 'SECRETARIA DE ESTADO DA SAÚDE DO MARANHÃO ', 'UNIDADE', NULL, 556);
INSERT INTO geral.tb_tce_unidade VALUES (108, 'EMPRESA MARANHENSE DE SERVIÇOS HOSPITALARES', 'UNIDADE', 'EMSERH ', 150019563);
INSERT INTO geral.tb_tce_unidade VALUES (109, 'FUNDO ESTADUAL DE SAÚDE DO MARANHÃO', 'UNIDADE', 'FES', 150019022);
INSERT INTO geral.tb_tce_unidade VALUES (111, 'FUNDO ESTADUAL DE COMBATE AO CÂNCER DO MARANHÃO ', 'UNIDADE', NULL, 150019681);
INSERT INTO geral.tb_tce_unidade VALUES (112, 'COMPANHIA MARANHENSE DE GÁS', 'ORGÃO', 'GASMAR ', 814);
INSERT INTO geral.tb_tce_unidade VALUES (113, 'COMPANHIA MARANHENSE DE GÁS', 'UNIDADE', 'GASMAR ', 814);
INSERT INTO geral.tb_tce_unidade VALUES (114, 'SECRETARIA DE ESTADO DE INFRAESTRUTURA DO MARANHÃO ', 'ORGÃO', NULL, 2252616);
INSERT INTO geral.tb_tce_unidade VALUES (115, 'SECRETARIA DE ESTADO DE INFRAESTRUTURA DO MARANHÃO ', 'UNIDADE', NULL, 2252616);
INSERT INTO geral.tb_tce_unidade VALUES (116, 'FUNDO ESTADUAL DE TRANSPORTE E MOBILIDADE URBANA', 'UNIDADE', 'FTMU ', 150020338);
INSERT INTO geral.tb_tce_unidade VALUES (117, 'SECRETARIA DE ESTADO DO DESENVOLVIMENTO SOCIAL DO MARANHÃO ', 'ORGÃO', NULL, 2252631);
INSERT INTO geral.tb_tce_unidade VALUES (118, 'SECRETARIA DE ESTADO DO DESENVOLVIMENTO SOCIAL DO MARANHÃO ', 'UNIDADE', NULL, 2252631);
INSERT INTO geral.tb_tce_unidade VALUES (119, 'GERENCIA DE INCLUSÃO SOCIOPRODUTIVA DO ESTADO DO MARANHÃO ', 'UNIDADE', NULL, 150014993);
INSERT INTO geral.tb_tce_unidade VALUES (120, 'FUNDO ESTADUAL DE ASSISTÊNCIA SOCIAL DO MARANHÃO ', 'UNIDADE', NULL, 2251845);
INSERT INTO geral.tb_tce_unidade VALUES (121, 'TRIBUNAL DE JUSTIÇA DO ESTADO DO MARANHÃO ', 'ORGÃO', NULL, 2252632);
INSERT INTO geral.tb_tce_unidade VALUES (122, 'TRIBUNAL DE JUSTIÇA DO ESTADO DO MARANHÃO ', 'UNIDADE', NULL, 2252632);
INSERT INTO geral.tb_tce_unidade VALUES (123, 'FUNDO ESPECIAL DE MODERNIZAÇÃO E REAPARELHAMENTO DO JUDICIARIO DO ESTADO DO MARANHÃO ', 'UNIDADE', NULL, 150014660);
INSERT INTO geral.tb_tce_unidade VALUES (124, 'FUNDO ESPECIAL DA ESCOLA SUPERIOR DA MAGISTRATURA DO ESTADO DO MARANHÃO ', 'UNIDADE', NULL, 150014659);
INSERT INTO geral.tb_tce_unidade VALUES (125, 'FUNDO ESPECIAL DAS SERVENTIAS DE REGISTRO CIVIL DE PESSOAS NATURAIS DO ESTADO DO MARANHÃO ', 'UNIDADE', NULL, 150014658);
INSERT INTO geral.tb_tce_unidade VALUES (126, 'FUNDO ESPECIAL DE SEGURANÇA DOS MAGISTRADOS DO MARANHÃO ', 'UNIDADE', NULL, 150019018);
INSERT INTO geral.tb_tce_unidade VALUES (127, 'ASSEMBLÉIA LEGISLATIVA DO ESTADO DO MARANHÃO ', 'ORGÃO', NULL, 2252647);
INSERT INTO geral.tb_tce_unidade VALUES (128, 'ASSEMBLÉIA LEGISLATIVA DO ESTADO DO MARANHÃO ', 'UNIDADE', NULL, 2252647);
INSERT INTO geral.tb_tce_unidade VALUES (129, 'FUNDO ESPECIAL LEGISLATIVO DO MARANHÃO ', 'UNIDADE', NULL, 150016096);
INSERT INTO geral.tb_tce_unidade VALUES (130, 'SECRETARIA DE ESTADO DA CIÊNCIA, TECNOLOGIA E INOVAÇÃO DO MARANHÃO ', 'ORGÃO', NULL, 2252654);
INSERT INTO geral.tb_tce_unidade VALUES (131, 'UNIVERSIDADE ESTADUAL DA REGIÃO TOCANTINA DO MARANHÃO', 'UNIDADE', 'UEMASUL ', 150020731);
INSERT INTO geral.tb_tce_unidade VALUES (132, 'SECRETARIA DE ESTADO DA CIÊNCIA, TECNOLOGIA E INOVAÇÃO DO MARANHÃO ', 'UNIDADE', NULL, 2252654);
INSERT INTO geral.tb_tce_unidade VALUES (133, 'UNIVERSIDADE ESTADUAL DO MARANHÃO ', 'UNIDADE', NULL, 452);
INSERT INTO geral.tb_tce_unidade VALUES (134, 'FUNDAÇÃO DE AMPARO À PESQUISA E AO DESENVOLVIMENTO CIENTIFICO E TECNOLOGICO DO MARANHÃO ', 'UNIDADE', NULL, 454);
INSERT INTO geral.tb_tce_unidade VALUES (135, 'INSTITUTO ESTADUAL DE EDUCAÇÃO, CIÊNCIA E TECNOLOGIA DO MARANHÃO', 'UNIDADE', 'IEMA ', 2252646);
INSERT INTO geral.tb_tce_unidade VALUES (136, 'SUBGERENCIA DO TESOURO ESTADUAL DO MARANHÃO ', 'UNIDADE', NULL, 150022547);
INSERT INTO geral.tb_tce_unidade VALUES (137, 'DEFENSORIA PÚBLICA DO ESTADO DO MARANHÃO ', 'ORGÃO', NULL, 2252664);
INSERT INTO geral.tb_tce_unidade VALUES (138, 'DEFENSORIA PÚBLICA DO ESTADO DO MARANHÃO ', 'UNIDADE', NULL, 2252664);
INSERT INTO geral.tb_tce_unidade VALUES (139, 'FUNDO DE APARELHAMENTO DA DEFENSORIA PUBLICA DO ESTADO DO MARANHAO ', 'UNIDADE', NULL, 150020299);
INSERT INTO geral.tb_tce_unidade VALUES (140, 'SECRETARIA DE ESTADO DO TRABALHO E DA ECONOMIA SOLIDÁRIA DO MARANHÃO ', 'ORGÃO', NULL, 2252705);
INSERT INTO geral.tb_tce_unidade VALUES (141, 'SECRETARIA DE ESTADO DO TRABALHO E DA ECONOMIA SOLIDÁRIA DO MARANHÃO ', 'UNIDADE', NULL, 2252705);
INSERT INTO geral.tb_tce_unidade VALUES (142, 'SECRETARIA DE ESTADO DE INDÚSTRIA, COMÉRCIO E ENERGIA', 'ORGÃO', 'SEINC DO MARANHÃO ', 2252706);
INSERT INTO geral.tb_tce_unidade VALUES (143, 'SECRETARIA DE ESTADO DE INDÚSTRIA, COMÉRCIO E ENERGIA', 'UNIDADE', 'SEINC DO MARANHÃO ', 2252706);
INSERT INTO geral.tb_tce_unidade VALUES (144, 'JUNTA COMERCIAL DO ESTADO DO MARANHÃO ', 'UNIDADE', NULL, 2252634);
INSERT INTO geral.tb_tce_unidade VALUES (145, 'INSTITUTO DE METROLOGIA E QUALIDADE INDUSTRIAL DO MARANHÃO ', 'UNIDADE', NULL, 2252658);
INSERT INTO geral.tb_tce_unidade VALUES (146, 'EMPRESA MARANHENSE DE ADMINISTRAÇÃO PORTUÁRIA ', 'UNIDADE', NULL, 462);
INSERT INTO geral.tb_tce_unidade VALUES (147, 'FUNDO ESTADUAL DE DESENVOLVIMENTO INDUSTRIAL DO MARANHÃO ', 'UNIDADE', NULL, 2253190);
INSERT INTO geral.tb_tce_unidade VALUES (148, 'SECRETARIA DE ESTADO DO MEIO AMBIENTE E RECURSOS NATURAIS DO MARANHÃO ', 'ORGÃO', NULL, 2252711);
INSERT INTO geral.tb_tce_unidade VALUES (149, 'SECRETARIA DE ESTADO DO MEIO AMBIENTE E RECURSOS NATURAIS DO MARANHÃO ', 'UNIDADE', NULL, 2252711);
INSERT INTO geral.tb_tce_unidade VALUES (150, 'FUNDO ESPECIAL DO MEIO AMBIENTE DO ESTADO DO MARANHÃO', 'UNIDADE', 'FEMA ', 150014342);
INSERT INTO geral.tb_tce_unidade VALUES (151, 'FUNDO ESTADUAL DE UNIDADES E CONSERVAÇÃO', 'UNIDADE', 'FEUC ', 150014341);
INSERT INTO geral.tb_tce_unidade VALUES (152, 'SECRETARIA DE ESTADO DA MULHER DO MARANHÃO ', 'ORGÃO', NULL, 2252713);
INSERT INTO geral.tb_tce_unidade VALUES (153, 'SECRETARIA DE ESTADO DA MULHER DO MARANHÃO ', 'UNIDADE', NULL, 2252713);
INSERT INTO geral.tb_tce_unidade VALUES (156, 'SECRETARIA DE ESTADO DOS DIREITOS HUMANOS E PARTICIPAÇÃO POPULAR DO MARANHÃO ', 'ORGÃO', NULL, 2253176);
INSERT INTO geral.tb_tce_unidade VALUES (157, 'SECRETARIA EXTRAORDINARIA DE ESTADO DA JUVENTUDE DO MARANHAO ', 'UNIDADE', NULL, 150017072);
INSERT INTO geral.tb_tce_unidade VALUES (158, 'SECRETARIA EXTRAORDINÁRIA DE ESTADO DA IGUALDADE RACIAL DO MARANHÃO ', 'UNIDADE', NULL, 150017457);
INSERT INTO geral.tb_tce_unidade VALUES (159, 'SECRETARIA DE ESTADO DOS DIREITOS HUMANOS E PARTICIPAÇÃO POPULAR DO MARANHÃO ', 'UNIDADE', NULL, 2253176);
INSERT INTO geral.tb_tce_unidade VALUES (155, 'CENTRO DE HEMOTERAPIA E HEMATOLOGIA DO MARANHÃO', 'UNIDADE', 'FES', 2253125);
INSERT INTO geral.tb_tce_unidade VALUES (154, 'CENTRO DE HEMOTERAPIA E HEMATOLOGIA DO MARANHÃO ', 'ORGÃO', 'FES', 2253125);
INSERT INTO geral.tb_tce_unidade VALUES (160, 'FUNDAÇÃO DA CRIANÇA E DO ADOLESCENTE DO ESTADO DO MARANHAO ', 'UNIDADE', NULL, 466);
INSERT INTO geral.tb_tce_unidade VALUES (161, 'INSTITUTO DE PROMOÇÃO E DEFESA DO CIDADÃO E CONSUMIDOR DO ESTADO DO MARANHÃO', 'UNIDADE', 'PROCON ', 150021118);
INSERT INTO geral.tb_tce_unidade VALUES (162, 'FUNDO ESTADUAL DE PROTEÇÃO E DEFESA DOS DIREITOS DO CONSUMIDOR ', 'UNIDADE', NULL, 2253187);
INSERT INTO geral.tb_tce_unidade VALUES (163, 'FUNDO ESTADUAL DOS DIREITOS DA CRIANÇA E DO ADOLESCENTE DO MARANHÃO ', 'UNIDADE', NULL, 507);
INSERT INTO geral.tb_tce_unidade VALUES (164, 'SECRETARIA DE ESTADO DAS CIDADES E DESENVOLVIMENTO URBANO DO MARANHÃO ', 'ORGÃO', NULL, 2253210);
INSERT INTO geral.tb_tce_unidade VALUES (165, 'SECRETARIA DE ESTADO DAS CIDADES E DESENVOLVIMENTO URBANO DO MARANHÃO ', 'UNIDADE', NULL, 2253210);
INSERT INTO geral.tb_tce_unidade VALUES (166, 'COMPANHIA DE SANEAMENTO AMBIENTAL DO MARANHÃO ', 'UNIDADE', NULL, 150019021);
INSERT INTO geral.tb_tce_unidade VALUES (167, 'CENTRO DE ESPECIALIDADES MÉDICAS DA CIDADE OPERÁRIA ', 'ORGÃO', NULL, 3001361);
INSERT INTO geral.tb_tce_unidade VALUES (168, 'CENTRO DE ESPECIALIDADES MÉDICAS DA CIDADE OPERÁRIA ', 'UNIDADE', NULL, 150016177);
INSERT INTO geral.tb_tce_unidade VALUES (169, 'SECRETARIA DE ESTADO DE ASSUNTOS POLITICOS ', 'ORGÃO', NULL, 3001381);
INSERT INTO geral.tb_tce_unidade VALUES (170, 'SECRETARIA DE ESTADO DE ASSUNTOS POLITICOS ', 'UNIDADE', NULL, 150016197);
INSERT INTO geral.tb_tce_unidade VALUES (171, 'GERÊNCIA DE DESENVOLVIMENTO REGIONAL DE PINHEIRO ', 'ORGÃO', NULL, 3001781);
INSERT INTO geral.tb_tce_unidade VALUES (172, 'GERÊNCIA DE DESENVOLVIMENTO REGIONAL DE PINHEIRO ', 'UNIDADE', NULL, 150016937);
INSERT INTO geral.tb_tce_unidade VALUES (173, 'SECRETARIA DE ESTADO DA AGRICULTURA FAMILIAR DO MARANHAO ', 'ORGÃO', NULL, 3001901);
INSERT INTO geral.tb_tce_unidade VALUES (174, 'SECRETARIA DE ESTADO DA AGRICULTURA FAMILIAR DO MARANHAO ', 'UNIDADE', NULL, 150017177);
INSERT INTO geral.tb_tce_unidade VALUES (175, 'INSTITUTO DE COLONIZAÇÃO E TERRAS DO MARANHÃO ', 'UNIDADE', NULL, 150019020);
INSERT INTO geral.tb_tce_unidade VALUES (176, 'AGÊNCIA ESTADUAL DE PESQUISA AGROPECUÁRIA E EXTENSÃO RURAL DO MARANHÃO ', 'UNIDADE', NULL, 2252704);
INSERT INTO geral.tb_tce_unidade VALUES (177, 'SECRETARIA DE ESTADO EXTRAORDINÁRIA DE ARTICULAÇÃO INSTITUCIONAL DO MARANHÃO ', 'ORGÃO', NULL, 3003401);
INSERT INTO geral.tb_tce_unidade VALUES (178, 'SECRETARIA DE ESTADO EXTRAORDINÁRIA DE ARTICULAÇÃO INSTITUCIONAL DO MARANHÃO ', 'UNIDADE', NULL, 150019417);
INSERT INTO geral.tb_tce_unidade VALUES (179, 'CHEFIA DE GABINETE DO GOVERNADOR DO ESTADO DO MARANHÃO ', 'ORGÃO', NULL, 3003522);
INSERT INTO geral.tb_tce_unidade VALUES (180, 'CHEFIA DE GABINETE DO GOVERNADOR DO ESTADO DO MARANHÃO ', 'UNIDADE', NULL, 150019538);
INSERT INTO geral.tb_tce_unidade VALUES (181, '6ª BATALHÃO DE BOMBEIROS MILITAR DE BACABAL', 'ORGÃO', 'MA ', 3003562);
INSERT INTO geral.tb_tce_unidade VALUES (182, '6ª BATALHÃO DE BOMBEIROS MILITAR DE BACABAL', 'UNIDADE', 'MA ', 150019578);
INSERT INTO geral.tb_tce_unidade VALUES (183, 'RESERVA DE CONTINGENCIA DO ESTADO DO MARANHÃO ', 'ORGÃO', NULL, 3003623);
INSERT INTO geral.tb_tce_unidade VALUES (184, 'RESERVA DE CONTINGENCIA DO ESTADO DO MARANHÃO ', 'UNIDADE', NULL, 150019684);
INSERT INTO geral.tb_tce_unidade VALUES (185, 'HOSPITAL ANTONIO PONTES DE AGUIAR ', 'ORGÃO', NULL, 3003922);
INSERT INTO geral.tb_tce_unidade VALUES (186, 'HOSPITAL ANTONIO PONTES DE AGUIAR ', 'UNIDADE', NULL, 150020138);
INSERT INTO geral.tb_tce_unidade VALUES (187, 'ENCARGOS ADMINISTRATIVOS ', 'ORGÃO', NULL, 3003982);
INSERT INTO geral.tb_tce_unidade VALUES (188, 'ENCARGOS ADMINISTRATIVOS ', 'UNIDADE', NULL, 150020339);
INSERT INTO geral.tb_tce_unidade VALUES (189, 'ENCARGOS FINANCEIROS', 'UNIDADE', 'SEPLAN ', 150020340);
INSERT INTO geral.tb_tce_unidade VALUES (190, 'FUNDAÇÃO DA CIDADANIA E JUSTIÇA DO MARANHÃO ', 'ORGÃO', NULL, 3004022);
INSERT INTO geral.tb_tce_unidade VALUES (191, 'FUNDAÇÃO DA CIDADANIA E JUSTIÇA DO MARANHÃO ', 'UNIDADE', NULL, 150020398);
INSERT INTO geral.tb_tce_unidade VALUES (192, 'SECRETARIA DE ESTADO DE GOVERNO DO MARANHÃO ', 'ORGÃO', NULL, 3004402);
INSERT INTO geral.tb_tce_unidade VALUES (193, 'SECRETARIA DE ESTADO DE GOVERNO DO MARANHÃO ', 'UNIDADE', NULL, 438);
INSERT INTO geral.tb_tce_unidade VALUES (194, 'SECRETARIA DE ESTADO EXTRAORDINÁRIA DE ARTICULAÇÃO POLITICAS PUBLICAS DO MARANHÃO ', 'UNIDADE', NULL, 150021120);
INSERT INTO geral.tb_tce_unidade VALUES (195, 'CASA CIVIL DO ESTADO DO MARANHÃO ', 'ORGÃO', NULL, 3004403);
INSERT INTO geral.tb_tce_unidade VALUES (196, 'CASA CIVIL DO ESTADO DO MARANHÃO ', 'UNIDADE', NULL, 2252635);
INSERT INTO geral.tb_tce_unidade VALUES (197, 'AGENCIA EXECUTIVA METROPOLITANA DO MARANHÃO ', 'UNIDADE', NULL, 150021036);
INSERT INTO geral.tb_tce_unidade VALUES (198, 'SECRETARIA EXTRAORDINÁRIA DE RELAÇÕES INSTITUCIONAIS DO ESTADO ', 'UNIDADE', NULL, 150021040);
INSERT INTO geral.tb_tce_unidade VALUES (199, 'SECRETARIA EXTRAORDINÁRIA DE PROGRAMAS ESPECIAIS DO MARANHÃO ', 'UNIDADE', NULL, 150021122);
INSERT INTO geral.tb_tce_unidade VALUES (200, 'AGENCIA ESTADUAL DE MOBILIDADE URBANA E SERVIÇOS PUBLICOS', 'UNIDADE', 'MOB DO ESTADO DO MARANHÃO ', 150021018);
INSERT INTO geral.tb_tce_unidade VALUES (201, 'AGENCIA EXECUTIVA METROPOLITANA DO SUDOESTE MARANHENSE ', 'UNIDADE', NULL, 150021572);
INSERT INTO geral.tb_tce_unidade VALUES (202, 'SECRETARIA DE ESTADO DA GESTÃO, PATRIMÔNIO E ASSISTÊNCIA DOS SERVIDORES DO MARANHÃO ', 'ORGÃO', NULL, 3004696);
INSERT INTO geral.tb_tce_unidade VALUES (203, 'ESCOLA DE GOVERNO DO MARANHÃO ', 'UNIDADE', NULL, 150015331);
INSERT INTO geral.tb_tce_unidade VALUES (204, 'FUNDO DE BENEFÍCIOS DOS SERVIDORES DO ESTADO DO MARANHÃO ', 'UNIDADE', NULL, 503);
INSERT INTO geral.tb_tce_unidade VALUES (205, 'EMPRESA MARANHENSE DE ADMINISTRAÇÃO DE RECURSOS HUMANOS E NEGÓCIO PÚBLICO', 'UNIDADE', 'EMARHP ', 461);
INSERT INTO geral.tb_tce_unidade VALUES (206, 'ENCARGOS ADMINISTRATIVOS DO ESTADO DO MARANHÃO', 'UNIDADE', 'SEGEP ', 150019683);
INSERT INTO geral.tb_tce_unidade VALUES (207, 'NÚCLEO DE ASSISTÊNCIA DOS SERVIDORES PÚBLICOS', 'UNIDADE', 'NASSP DO ESTADO DO MARANHÃO ', 150023147);
INSERT INTO geral.tb_tce_unidade VALUES (208, 'SECRETARIA DE ESTADO DA GESTÃO, PATRIMÔNIO E ASSISTÊNCIA DOS SERVIDORES DO MARANHÃO ', 'UNIDADE', NULL, 150021684);
INSERT INTO geral.tb_tce_unidade VALUES (209, 'REPRESENTAÇÃO INSTITUCIONAL NO DISTRITO FEDERAL DO MARANHÃO ', 'ORGÃO', NULL, 3005243);
INSERT INTO geral.tb_tce_unidade VALUES (210, 'REPRESENTAÇÃO INSTITUCIONAL NO DISTRITO FEDERAL DO MARANHÃO ', 'UNIDADE', NULL, 150022541);
INSERT INTO geral.tb_tce_unidade VALUES (211, 'SECRETARIA DE ESTADO DA COMUNICAÇÃO SOCIAL E ASSUNTOS POLÍTICOS DO MARANHÃO ', 'ORGÃO', NULL, 3005244);
INSERT INTO geral.tb_tce_unidade VALUES (212, 'SECRETARIA DE ESTADO DA COMUNICAÇÃO SOCIAL E ASSUNTOS POLÍTICOS DO MARANHÃO ', 'UNIDADE', NULL, 2252650);
INSERT INTO geral.tb_tce_unidade VALUES (213, 'SECRETARIA DE ESTADO DA TRANSPARÊNCIA E CONTROLE DO MARANHÃO ', 'ORGÃO', NULL, 3005246);
INSERT INTO geral.tb_tce_unidade VALUES (214, 'SECRETARIA DE ESTADO DA TRANSPARÊNCIA E CONTROLE DO MARANHÃO ', 'UNIDADE', NULL, 150017498);
INSERT INTO geral.tb_tce_unidade VALUES (215, 'COMISSÃO CENTRAL PERMANENTE DE LICITAÇÃO DO ESTADO DO MARANHÃO ', 'ORGÃO', NULL, 3005247);
INSERT INTO geral.tb_tce_unidade VALUES (216, 'COMISSÃO CENTRAL PERMANENTE DE LICITAÇÃO DO ESTADO DO MARANHÃO ', 'UNIDADE', NULL, 150012882);
INSERT INTO geral.tb_tce_unidade VALUES (217, 'INSTITUTO DE PREVIDÊNCIA DOS SERVIDORES DO ESTADO DO MARANHÃO', 'ORGÃO', 'IPREV ', 3005262);
INSERT INTO geral.tb_tce_unidade VALUES (218, 'FUNDO ESTADUAL DE PENSÃO E APOSENTADORIA DO MARANHÃO ', 'UNIDADE', NULL, 502);
INSERT INTO geral.tb_tce_unidade VALUES (219, 'INSTITUTO DE PREVIDÊNCIA DOS SERVIDORES DO ESTADO DO MARANHÃO', 'UNIDADE', 'IPREV ', 150021471);
INSERT INTO geral.tb_tce_unidade VALUES (220, 'FUNDO ESTADUAL DE RECURSOS HÍDRICOS', 'ORGÃO', 'FERH DO ESTADO DO MARANHÃO ', 3005863);
INSERT INTO geral.tb_tce_unidade VALUES (221, 'FUNDO ESTADUAL DE RECURSOS HÍDRICOS', 'UNIDADE', 'FERH DO ESTADO DO MARANHÃO ', 150023332);
INSERT INTO geral.tb_tce_unidade VALUES (222, 'SECRETARIA DE ESTADO DE ADMINISTRAÇÃO PENITENCIARIA DO MARANHÃO ', 'ORGÃO', NULL, 150012000);
INSERT INTO geral.tb_tce_unidade VALUES (223, 'SECRETARIA DE ESTADO DE ADMINISTRAÇÃO PENITENCIARIA DO MARANHÃO ', 'UNIDADE', NULL, 150012861);
INSERT INTO geral.tb_tce_unidade VALUES (224, 'FUNDO PENITENCIÁRIO ESTADUAL DO MARANHÃO ', 'UNIDADE', NULL, 701);
INSERT INTO geral.tb_tce_unidade VALUES (225, 'SECRETARIA DE ESTADO DE PESCA E AQUICULTURA DO MARANHÃO ', 'ORGÃO', NULL, 150045150);
INSERT INTO geral.tb_tce_unidade VALUES (226, 'SECRETARIA DE ESTADO DE PESCA E AQUICULTURA DO MARANHÃO ', 'UNIDADE', NULL, 150015499);
INSERT INTO geral.tb_tce_unidade VALUES (227, 'SECRETARIA DE ESTADO DE PROGRAMAS ESTRATÉGICOS DO MARANHÃO ', 'ORGÃO', NULL, 150048752);
INSERT INTO geral.tb_tce_unidade VALUES (228, 'INSTITUTO MARANHENSE DE ESTUDOS SOCIOECONÔMICOS E CARTOGRÁFICOS', 'UNIDADE', 'IMESC', 2252702);
INSERT INTO geral.tb_tce_unidade VALUES (10, 'SECRETARIA DE ESTADO DA INDÚSTRIA, COMÉRCIO E TURISMO DO MARANHÃO', 'ORGÃO', 'SINCT', 442);
INSERT INTO geral.tb_tce_unidade VALUES (110, 'HOSPITAL TARQUÍNIO LOPES FILHO ', 'UNIDADE', NULL, 2252742);


--
-- TOC entry 2960 (class 0 OID 24647)
-- Dependencies: 217
-- Data for Name: tb_unidade; Type: TABLE DATA; Schema: geral; Owner: postgres
--

INSERT INTO geral.tb_unidade VALUES (990106, 'SECRETARIA DE ESTADO DE CULTURA', 'SECMA', NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (990103, 'UNIVERSIDADE ESTADUAL DA REGIÃO TOCANTINA DO MARANHÃO', 'UEMASUL', NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (990104, 'BATALHÃO DE POLÍCIA AMBIENTAL - PMMA', 'BPAPM', '', '', '', 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (990105, 'INSTITUTO DE PREVIDENCIA DOS SERVIDORES DO ESTADO DO MARANHAO', 'IPREV', NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (990107, 'SECRETARIA DE ESTADO DE TURISMO', 'SETUR', NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (10201, 'FUNDACAO RADIO E TELEVISAO                   ', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (110107, 'ASCON                                        ', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (110110, 'GABGOV/RGCHAPADINHA                          ', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (130901, 'FUNDO DE DESENV.AGROPECUARIO AGROINDUSTRIAL  ', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (170110, 'TEATRO                                       ', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (180202, 'ARSEP                                        ', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (170203, 'FUNDACAO NICE LOBAO                          ', 'CINTRA', '', '', '', 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (110209, 'AGENCIA REGULADORA DE SERVICOS PUBLICOS      ', 'ARSEMA', '', '', '', 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (190128, 'OITAVA COMPANHIA INDEPENDENTE/ITAPECURU-MIRIM', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (190130, 'DECIMA SGUNDA COMPANHIA INDEPENDENTE/ZE DOCA ', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (190131, 'DECIMA TERCEIRA COMPANHIA INDEPENDENTE/VIANA ', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (190133, 'TERCEIRA COMPANHIA INDEPENDENTE/PORTO FRANCO ', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (190135, 'SEXTO GBM/BARREIRINHAS                       ', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (190136, 'SETIMO GRUPAMENTO BOMBEIRO MILITAR/SJ RIBAMAR', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (190158, 'DECIMO QUARTO BATALHAO POL.MILITAR/BACABEIRA ', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (190160, 'DECIMA QUARTA CIA.INDEPENDENTE/BURITICUPU    ', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (190162, 'DECIMA SEXTA COMPANHIA INDEPENDENTE/N.FREIRE ', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (210908, 'PAM/DIAMANTE                                 ', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (210933, 'FEMA                                         ', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (220903, 'FUNDO MARANHENSE D COMBATE A POBREZA         ', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (220915, 'FUMACOP/SEDES                                ', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (240901, 'FAP                                          ', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (250101, 'GR-ITAPCURU                                  ', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (320101, 'GR-BAIXADA                                   ', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (40101, 'TRIBUNAL DE JUSTICA                          ', NULL, NULL, NULL, NULL, 'true', NULL, 2252632);
INSERT INTO geral.tb_unidade VALUES (40901, 'FUNDO ESPECIAL DE MODERN.E REAPAR. JUDICIARIO', NULL, NULL, NULL, NULL, 'true', NULL, 150014660);
INSERT INTO geral.tb_unidade VALUES (40903, 'FUNDO ESPECIAL DAS SERVENTIAS REGISTRO CIVIL ', NULL, NULL, NULL, NULL, 'true', NULL, 150014658);
INSERT INTO geral.tb_unidade VALUES (70101, 'PROCURADORIA GERAL DA JUSTICA                ', NULL, NULL, NULL, NULL, 'true', NULL, 540);
INSERT INTO geral.tb_unidade VALUES (70901, 'FUNDO ESPECIAL DO MINISTERIO PUBLICO ESTADUAL', NULL, NULL, NULL, NULL, 'true', NULL, 150016100);
INSERT INTO geral.tb_unidade VALUES (150101, 'SECRETARIA ESTADO DO DESENVOLVIMENTO SOCIAL  ', 'SEDES', '', '', '', 'true', NULL, 2252631);
INSERT INTO geral.tb_unidade VALUES (150903, 'FUNDO ESTADUAL DE ASSISTENCIA SOCIAL         ', NULL, NULL, NULL, NULL, 'true', NULL, 2251845);
INSERT INTO geral.tb_unidade VALUES (160901, 'FUNDO DE FORTALECIMENTO DA ADM. TRIBUTARIA   ', NULL, NULL, NULL, NULL, 'true', NULL, 150019679);
INSERT INTO geral.tb_unidade VALUES (170901, 'FUNDO ESCOLA DIGNA                           ', NULL, NULL, NULL, NULL, 'true', NULL, 150019680);
INSERT INTO geral.tb_unidade VALUES (190102, 'POLICIA CIVIL                                ', 'PCMA', '', '', '', 'true', NULL, 2252730);
INSERT INTO geral.tb_unidade VALUES (190111, 'CORPO DE BOMBEIROS MILITAR                   ', 'CBMMA', '', '', '', 'true', NULL, 2252732);
INSERT INTO geral.tb_unidade VALUES (190112, 'SEGUNDO BATALHAO DA POLICIA MILITAR/CAXIAS   ', NULL, NULL, NULL, NULL, 'true', NULL, 2252655);
INSERT INTO geral.tb_unidade VALUES (190115, 'QUINTO BATALHAO POLICIA MILITAR/BARRA CORDA  ', NULL, NULL, NULL, NULL, 'true', NULL, 2252659);
INSERT INTO geral.tb_unidade VALUES (190116, 'DECIMO PRIMEIRO BAT.POLICIA MILITAR/TIMON    ', NULL, NULL, NULL, NULL, 'true', NULL, 2252512);
INSERT INTO geral.tb_unidade VALUES (190117, 'QUINTA COMPANHIA INDEPENDENTE/ACAILANDIA     ', NULL, NULL, NULL, NULL, 'true', NULL, 2252661);
INSERT INTO geral.tb_unidade VALUES (190119, 'DECIMO SEXTO BATALHAO POL.MILITAR/CHAPADINHA ', NULL, NULL, NULL, NULL, 'true', NULL, 2252677);
INSERT INTO geral.tb_unidade VALUES (190122, 'DECIMO OITAVO BATALHAO POL.MILITAR/PRES.DUTRA', NULL, NULL, NULL, NULL, 'true', NULL, 150020198);
INSERT INTO geral.tb_unidade VALUES (190123, 'SEXTA COMPANHIA INDEPENDENTE/S.J.DOS PATOS   ', NULL, NULL, NULL, NULL, 'true', NULL, 2252682);
INSERT INTO geral.tb_unidade VALUES (190129, 'DECIMO NONO BATALHAO POL.MILITAR/PEDREIRAS   ', NULL, NULL, NULL, NULL, 'true', NULL, 150019558);
INSERT INTO geral.tb_unidade VALUES (190132, 'PRIMEIRA COMPANHIA INDEPENDENTE/COLINAS      ', NULL, NULL, NULL, NULL, 'true', NULL, 150020318);
INSERT INTO geral.tb_unidade VALUES (190137, 'OITAVO GRUPAMENTO BOMBEIRO MILITAR/PINHEIRO  ', NULL, NULL, NULL, NULL, 'true', NULL, 150020058);
INSERT INTO geral.tb_unidade VALUES (190157, 'DECIMO SEGUNDO BATALHAO POL.MILITAR/ESTREITO ', NULL, NULL, NULL, NULL, 'true', NULL, 150012881);
INSERT INTO geral.tb_unidade VALUES (190161, 'DECIMA QUINTA COMPANHIA INDEPENDENTE/GRAJAU  ', NULL, NULL, NULL, NULL, 'true', NULL, 150020273);
INSERT INTO geral.tb_unidade VALUES (190163, 'DECIMO QUARTO BATALHAO POL.MILITAR/IMPERATRIZ', NULL, NULL, NULL, NULL, 'true', NULL, 150019237);
INSERT INTO geral.tb_unidade VALUES (190902, 'FUNDO ESPECIAL DE SEGURANCA PUBLICA          ', NULL, NULL, NULL, NULL, 'true', NULL, 150019658);
INSERT INTO geral.tb_unidade VALUES (200902, 'FUNDO ESTADUAL DE UNIDADES DE CONSERVACAO    ', NULL, NULL, NULL, NULL, 'true', NULL, 150014341);
INSERT INTO geral.tb_unidade VALUES (210946, 'FUNDO ESTADUAL DE COMBATE AO CANCER          ', NULL, NULL, NULL, NULL, 'true', NULL, 150019681);
INSERT INTO geral.tb_unidade VALUES (220101, 'SEC.DE ESTADO DO PLANEJ.E ORCAMENTO          ', 'SEPLAN', '', '', '', 'true', NULL, 482);
INSERT INTO geral.tb_unidade VALUES (220205, 'INST.MARANHENSE EST.SOCIOECON. CARTOGRAFICO  ', 'IMESC', '', '', '', 'true', NULL, 2252702);
INSERT INTO geral.tb_unidade VALUES (230901, 'FUNDO ESTADUAL DE DESENV.INDUSTRIAL DO MA    ', NULL, NULL, NULL, NULL, 'true', NULL, 2253190);
INSERT INTO geral.tb_unidade VALUES (240109, 'SUBGERENCIA DO TESOURO ESTADUAL              ', NULL, NULL, NULL, NULL, 'true', NULL, 150022547);
INSERT INTO geral.tb_unidade VALUES (10101, 'ASSEMBLEIA LEGISLATIVA                       ', NULL, NULL, NULL, NULL, 'true', NULL, 2252647);
INSERT INTO geral.tb_unidade VALUES (80101, 'DEFENSORIA PUBLICA DO ESTADO DO MARANHAO     ', NULL, NULL, NULL, NULL, 'true', NULL, 2252664);
INSERT INTO geral.tb_unidade VALUES (110103, 'PROCURADORIA GERAL DO ESTADO                 ', 'PGE', '', '', '', 'true', NULL, 540);
INSERT INTO geral.tb_unidade VALUES (110105, 'REPRESENTACAO INSTITUCIONAL NO DF            ', NULL, NULL, NULL, NULL, 'true', NULL, 150022541);
INSERT INTO geral.tb_unidade VALUES (110123, 'CHEFIA DE GABINETE DO GOVERNADOR             ', 'GABINETE', '', '', '', 'true', NULL, 150019538);
INSERT INTO geral.tb_unidade VALUES (120101, 'SEC.DAS CIDADES E DESENVOLVIMENTO URBANO     ', 'SECID', '', '', '', 'true', NULL, 2253210);
INSERT INTO geral.tb_unidade VALUES (130101, 'SEC.DE ESTADO DA AGRICULTURA E PECUARIA      ', 'SAGRIMA', '', '', '', 'true', NULL, 483);
INSERT INTO geral.tb_unidade VALUES (190159, 'DECIMO QUINTO BATALHAO POL.MILITAR/BACABAL   ', NULL, NULL, NULL, NULL, 'true', NULL, 2252676);
INSERT INTO geral.tb_unidade VALUES (10901, 'FUNDO ESPECIAL LEGISLATIVO                   ', NULL, NULL, NULL, NULL, 'true', NULL, 150016096);
INSERT INTO geral.tb_unidade VALUES (40902, 'FUNDO ESP.DA ESCOLA SUPER.DA MAGISTRATURA MA ', NULL, NULL, NULL, NULL, 'true', NULL, 150014659);
INSERT INTO geral.tb_unidade VALUES (140901, 'FUNDO DESENVOLVIMENTO DA CULTURA MARANHENSE  ', NULL, NULL, NULL, NULL, 'true', NULL, 150019678);
INSERT INTO geral.tb_unidade VALUES (170204, 'FUNDACAO DA MEMORIA REPUBLICANA BRASILEIRA   ', 'FMR', '', '', '', 'true', NULL, 150015390);
INSERT INTO geral.tb_unidade VALUES (190113, 'TERCEIRO BATALHAO POLICIA MILITAR/IMPERATRIZ ', NULL, NULL, NULL, NULL, 'true', NULL, 2252549);
INSERT INTO geral.tb_unidade VALUES (190118, 'QUARTO BATALHAO DE POLICIA MILITAR/BALSAS    ', NULL, NULL, NULL, NULL, 'true', NULL, 2252922);
INSERT INTO geral.tb_unidade VALUES (190138, 'QUINTO GRUPAMENTO BOMBEIRO MILITAR/CAXIAS    ', NULL, NULL, NULL, NULL, 'true', NULL, 2253185);
INSERT INTO geral.tb_unidade VALUES (190127, 'SETIMA COMPANHIA INDEPENDENTE/ROSARIO        ', 'SETCROS', '', '', '', 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (210202, 'EMPRESA MARANHENSE DE SERVICOS HOSPITALARES  ', 'EMSERH', '', '', '', 'true', NULL, 150019563);
INSERT INTO geral.tb_unidade VALUES (20901, 'FUNDO DE MODERNIZACAO DO TRIBUNAL DE CONTAS  ', NULL, NULL, NULL, NULL, 'true', NULL, 150016097);
INSERT INTO geral.tb_unidade VALUES (200901, 'FUNDO ESPECIAL DO MEIO AMBIENTE              ', NULL, NULL, NULL, NULL, 'true', NULL, 150014342);
INSERT INTO geral.tb_unidade VALUES (190165, 'COLEGIO MILITAR TIRADENTES III/BACABAL       ', 'CMTB', '', '', '', 'true', NULL, 150019519);
INSERT INTO geral.tb_unidade VALUES (190120, 'SEGUNDA COMPANHIA INDEPENDENTE/BACABAL       ', 'SCI', '', '', '', 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (350101, 'METROPOLITANA                                ', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (450901, 'FUNDO ESTADUAL DE ESPORTES                   ', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (470101, 'SESAE                                        ', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (500003, 'SETORIAL CONTABIL DO GOVERNO DO MARANHAO     ', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (500013, 'SETORIAL ORCAMENTARIA DO GOVERNO DO MARANHAO ', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (550110, 'SUPERINT.DO NUCLEO DE PROGRAMAS ESPECIAIS    ', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (600103, 'ENCARGOS ADMINISTRATIVOS                     ', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (600104, 'ENCARGOS FINANCEIROS                         ', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (110120, 'CORREGEDORIA GERAL DO ESTADO                 ', 'COGE', '', '', '', 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (570101, 'SECRETARIA DE ESTADO DE MINAS E ENERGIA      ', 'SEME', '', '', '', 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (980101, 'ESCOLA DE GOVERNO DO MARANHÃO', 'EGMA', NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (540110, 'VIVA CIDADAO                                 ', 'VIVA', NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (230203, 'EMPRESA MARANHENSE DE ADMINISTRACAO PORTUARIA', 'EMAP', NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (940101, 'SECRETARIA DE ESTADO DE GOVERNO', 'SEGOV ', NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (950101, 'GERENCIA DE INCLUSAO SOCIOPRODUTIVA', 'GISP', NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (960101, 'COMPANHIA MARANHENSE DE GÁS', 'GASMAR', NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (970101, 'CERIMONIAL', 'CERIMONIAL', NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (990101, 'SECRETARIA DE ESTADO EXTRAORDINÁRIA DA JUVENTUDE', 'SEEJUV', NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (990102, 'SECRETARIA DE ESTADO DA IGUALDADE RACIAL', 'SEIR', NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (240201, 'UNIVERSIDADE ESTADUAL DO MARANHAO            ', 'UEMA', '', '', '', 'true', NULL, 452);
INSERT INTO geral.tb_unidade VALUES (3636536, 'VOLUNTARIADO DE OBRAS SOCIAIS', NULL, NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (20101, 'TRIBUNAL DE CONTAS DO ESTADO                 ', NULL, NULL, NULL, NULL, 'true', NULL, 435);
INSERT INTO geral.tb_unidade VALUES (40904, 'FUNDO ESPECIAL DE SEGURANCA DOS MAGISTRADOS  ', NULL, NULL, NULL, NULL, 'true', NULL, 150019018);
INSERT INTO geral.tb_unidade VALUES (160101, 'SECRETARIA DE ESTADO DA FAZENDA              ', 'SEFAZ', '', '', '', 'true', NULL, 440);
INSERT INTO geral.tb_unidade VALUES (190114, 'SETIMO BATALHAO POLICIA MILITAR/PINDARE MIRIM', NULL, NULL, NULL, NULL, 'true', NULL, 2252639);
INSERT INTO geral.tb_unidade VALUES (190121, 'DECIMO BATALHAO DA POLICIA MILITAR/PINHEIRO  ', NULL, NULL, NULL, NULL, 'true', NULL, 2252763);
INSERT INTO geral.tb_unidade VALUES (190134, 'SEGUNDO ESQUADRAO POLICIA MILITAR/JOAO LISBOA', NULL, NULL, NULL, NULL, 'true', NULL, 2252761);
INSERT INTO geral.tb_unidade VALUES (190164, 'COLEGIO MILITAR TIRADENTES II/IMPERATRIZ     ', NULL, NULL, NULL, NULL, 'true', NULL, 150019117);
INSERT INTO geral.tb_unidade VALUES (210201, 'COMPANHIA DE SANEAMENTO AMBIENTAL DO MA      ', 'CAEMA', '', '', '', 'true', NULL, 150019021);
INSERT INTO geral.tb_unidade VALUES (80901, 'FUNDO DE APARELHAMENTO DA DEFENS. PUB. ESTADO', NULL, NULL, NULL, NULL, 'true', NULL, 150020299);
INSERT INTO geral.tb_unidade VALUES (110122, 'SEC. DE ESTADO DA TRANSPARENCIA E CONTROLE   ', 'STC', '21853640000114', '67774113304', 'Adaltina Venâncio de Queiroga', 'true', NULL, 150017498);
INSERT INTO geral.tb_unidade VALUES (190124, 'DECIMO SETIMO BATALHAO POL. MILITAR/CODO     ', NULL, NULL, NULL, NULL, 'true', NULL, 150018877);
INSERT INTO geral.tb_unidade VALUES (170101, 'SECRETARIA DE ESTADO DA EDUCACAO             ', 'SEDUC', '', '', '', 'true', NULL, 486);
INSERT INTO geral.tb_unidade VALUES (190110, 'POLICIA MILITAR DO ESTADO                    ', 'PMMA', '', '', '', 'true', NULL, 433);
INSERT INTO geral.tb_unidade VALUES (190201, 'DEPARTAMENTO ESTADUAL DE TRANSITO            ', 'DETRAN', '', '', '', 'true', NULL, 2252644);
INSERT INTO geral.tb_unidade VALUES (200101, 'SEC.DE ESTADO MEIO AMBIENTE RECURSOS NATURAIS', 'SEMA', '', '', '', 'true', NULL, 2252711);
INSERT INTO geral.tb_unidade VALUES (210101, 'SECRETARIA DE ESTADO DA SAUDE                ', 'SES', '', '', '', 'true', NULL, 556);
INSERT INTO geral.tb_unidade VALUES (230201, 'JUNTA COMERCIAL DO MARANHAO                  ', 'JUCEMA', '', '', '', 'true', NULL, 2252634);
INSERT INTO geral.tb_unidade VALUES (230202, 'INST.DE METROL. E QUALIDADE INDUSTRIAL DO MA ', 'INMEQ', '', '', '', 'true', NULL, 2252658);
INSERT INTO geral.tb_unidade VALUES (240101, 'SEC.ESTADO DA CIENCIA, TECNOLOGIA E INOVACAO ', 'SECTI', '', '', '', 'true', NULL, 2252654);
INSERT INTO geral.tb_unidade VALUES (240206, 'INSTITUTO EST.EDUC.,CIENC.E TECNOLOGIA DO MA ', 'IEMA', '', '', '', 'true', NULL, 2252646);
INSERT INTO geral.tb_unidade VALUES (450101, 'SECRETARIA DE ESTADO DO ESPORTE E LAZER      ', 'SEDEL', '', '', '', 'true', NULL, 447);
INSERT INTO geral.tb_unidade VALUES (510101, 'SEC. DE ESTADO DO TRAB. E ECON.SOLIDARIA     ', 'SETRES', '', '', '', 'true', NULL, 2252705);
INSERT INTO geral.tb_unidade VALUES (520101, 'SECRETARIA DE ESTADO DA MULHER               ', 'SEMU', '', '', '', 'true', NULL, 2252713);
INSERT INTO geral.tb_unidade VALUES (530101, 'SECRETARIA DE ESTADO DA INFRAESTRUTURA       ', 'SINFRA', '', '', '', 'true', NULL, 2252616);
INSERT INTO geral.tb_unidade VALUES (530201, 'AGENCIA EST.DE TRANSPORTE E MOBILIDADE URBANA', 'MOB', '', '', '', 'true', NULL, 150020338);
INSERT INTO geral.tb_unidade VALUES (540101, 'SEC.ESTADO DIR.HUMANOS E PARTICIPACAO POPULAR', 'SEDIHPOP', '', '', '', 'true', NULL, 2253176);
INSERT INTO geral.tb_unidade VALUES (540201, 'FUNDACAO DA CRIANCA E DO ADOLESCENTE DO MA   ', 'FUNAC', '', '', '', 'true', NULL, 466);
INSERT INTO geral.tb_unidade VALUES (540202, 'INSTITUTO DE PROMOÇÃO E DEFESA DO CIDADÃO E CONSUMIDOR DO MARANHÃO', 'PROCON', NULL, NULL, NULL, 'true', NULL, 150021118);
INSERT INTO geral.tb_unidade VALUES (540902, 'FUNDO EST.DIREITOS DA CRIANCA E ADOLESCENTE  ', NULL, NULL, NULL, NULL, 'true', NULL, 507);
INSERT INTO geral.tb_unidade VALUES (550201, 'INSTITUTO DE COLONIZACAO E TERRAS DO MARANHAO', 'ITERMA', '', '', '', 'true', NULL, 150019020);
INSERT INTO geral.tb_unidade VALUES (560101, 'SEC.DE ESTADO DE ADMINISTRACAO PENITENCIARIA ', 'SEAP', '', '', '', 'true', NULL, 150012861);
INSERT INTO geral.tb_unidade VALUES (560901, 'FUNDO PENITENCIARIO ESTADUAL                 ', NULL, NULL, NULL, NULL, 'true', NULL, 701);
INSERT INTO geral.tb_unidade VALUES (580101, 'SECRETARIA DE ESTADO DA GESTAO E PREVIDENCIA ', 'SEGEP', '', '', '', 'true', NULL, 150019683);
INSERT INTO geral.tb_unidade VALUES (110109, 'CASA CIVIL                                   ', 'CC', '', '', '', 'true', NULL, 2252635);
INSERT INTO geral.tb_unidade VALUES (110113, 'COMISSAO CENTRAL PERMANENTE DE LICITACAO     ', 'CCL', '', '', '', 'true', NULL, 150012882);
INSERT INTO geral.tb_unidade VALUES (190101, 'SECRETARIA DE ESTADO DA SEGURANCA PUBLICA    ', 'SSP', '', '', '', 'true', NULL, 485);
INSERT INTO geral.tb_unidade VALUES (230101, 'SEC.DE ESTADO DE INDUSTRIA E COMERCIO        ', 'SEINC', '', '', '', 'true', NULL, 2252706);
INSERT INTO geral.tb_unidade VALUES (540901, 'FUNDO PROTECAO DEFESA DIREITOS DO CONSUMIDOR ', NULL, NULL, NULL, NULL, 'true', NULL, 2253187);
INSERT INTO geral.tb_unidade VALUES (580201, 'FUNDO DE BENEFICIOS DOS SERVIDORES DO ESTADO ', NULL, NULL, NULL, NULL, 'true', NULL, 503);
INSERT INTO geral.tb_unidade VALUES (580202, 'FUNDO ESTADUAL DE PENSAO E APOSENTADORIA     ', NULL, NULL, NULL, NULL, 'true', NULL, 502);
INSERT INTO geral.tb_unidade VALUES (580203, 'EMPRESA MARANHENSE ADM. DE RECURSOS HUMANOS E NEGÓCIOS PUBLICOS', 'EMARHP', '', '', '', 'true', NULL, 461);
INSERT INTO geral.tb_unidade VALUES (590101, 'SECRETARIA DE ESTADO DA PESCA E AQUICULTURA  ', 'SEPAQ', '', '', '', 'true', NULL, 150015499);
INSERT INTO geral.tb_unidade VALUES (610101, 'SECRETARIA DE ESTADO DA AGRICULTURA FAMILIAR ', 'SAF', '', '', '', 'true', NULL, 150017177);
INSERT INTO geral.tb_unidade VALUES (610202, 'AGENCIA ESTADUAL PESQUISA AGROP.EXT.RURAL MA ', 'AGERP', '', '', '', 'true', NULL, 2252704);
INSERT INTO geral.tb_unidade VALUES (900101, 'RESERVA DE CONTINGENCIA                      ', NULL, NULL, NULL, NULL, 'true', NULL, 150019684);
INSERT INTO geral.tb_unidade VALUES (910101, 'Secretaria de Estado de Comunicação Social e Articulação Política', 'SECAP', NULL, NULL, NULL, 'true', NULL, 2252650);
INSERT INTO geral.tb_unidade VALUES (920101, 'Secretaria de Estado de Cultura e Turismo', 'SECTUR', NULL, NULL, NULL, 'true', NULL, 446);
INSERT INTO geral.tb_unidade VALUES (930101, 'Agência Estadual de Defesa Agropecuária', 'AGED', NULL, NULL, NULL, 'true', NULL, 943);
INSERT INTO geral.tb_unidade VALUES (240202, 'FUND.DO AMPARO A PESQ. DESENV.CIENT.TECNOL.MA', 'FAPEMA', '', '', '', 'true', 'steferson.ferreira@gmail.com', 454);


--
-- TOC entry 2961 (class 0 OID 24653)
-- Dependencies: 218
-- Data for Name: tb_usuario; Type: TABLE DATA; Schema: geral; Owner: postgres
--

INSERT INTO geral.tb_usuario VALUES (6, 'Marcos Caminha', 'marcoscaminha@stc.ma.gov.br', '', 'marcoscaminha', '$2y$10$rupW13VUDJBsUg0pfPEPNexxRvtCEjDazgVlqDUMv8KgSvSU4.LwG', true, NULL, '2015-07-06 16:47:52', '2015-07-06 16:47:52', NULL, NULL, false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (10, 'Luiz Carlos Albuquerque', 'albq@me.com', '', 'luizcarlos', '$2y$10$Cnt1C/8B8kRWkEagHkhJmeYPQSpZ4xZctSUMA6kC.gyEgFHlrQrjO', true, 'Er4qoE02iC7K4qvm3TFfrXBqhvHidUA9drAjyIp6XVAdN0NZAeELFhNTA1SD', '2015-07-22 10:27:38', '2015-07-23 11:10:41', NULL, NULL, false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (12, 'Flávia', 'flaviacoge@hotmail.com', '', 'flaviacoge@hotmail.com', '$2y$10$wRVh2jvwHQUr0i5YiYQEzehQIyLTBr.m7L/waiMYtsNAZEcVck7V2', true, NULL, '2015-09-30 11:20:53', '2015-09-30 11:20:53', NULL, NULL, false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (11, 'Gustavo', 'gustavo.mcm@hotmail.com', '982539933', 'gustavo.mcm', '$2y$10$COP4zqRr3OLPlLrVvbJ79ehev.iydlHudKb5WPzY7rtbkq7TVExyi', true, 'LJKSoByft5Tlin4f3BAoi5oQbbo603elNtF4Gk3ubX2kA5xD2uy2kciRhAkg', '2015-07-30 17:15:57', '2015-08-12 15:14:43', NULL, NULL, false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (360, 'MARGARIDA MARIA BRANDÃO TEIXEIRA BATALHA', 'magabatalha@gmail.com', '', 'margarida.batalha', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, NULL, '2019-11-06 14:51:14', '2019-11-07 10:35:26', 9449582300, '', false, NULL, '2019-11-07 10:35:26');
INSERT INTO geral.tb_usuario VALUES (8, 'Afonso Ancheita', 'afonso.anchieta@stc.ma.gov.br', '', 'afonso', '$2y$10$/pMAVESXCzhySEmlzrFjIOp9jb.bwpPYgDKCJb2/OOjok1k8KfVOK', true, 'vx86m0BxK06Hgo7OICxGQTBmU497EJjAngmGJNAB2ZzEMg3n0i8jzPXYvx4r', '2015-07-20 17:36:42', '2015-11-06 19:53:13', NULL, NULL, false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (3, 'Willian Mano Araujo', 'willianmano@stc.ma.gov.br', '', 'willianmano', '$2y$10$COP4zqRr3OLPlLrVvbJ79ehev.iydlHudKb5WPzY7rtbkq7TVExyi', true, 'RNyDo9q8ymFYCpDRvp0RlNNUZ3cHFomAASIWeaKFMPiFcMGsrDyY7FeKW434', '2015-05-20 11:30:00', '2016-01-14 11:13:39', NULL, NULL, false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (34, 'Lucinéa Jansem Silva', 'lujansem@hotmail.com', '98828-2113', 'lujansem@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 72402776315, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (35, 'Euvaldo Dias de Souza Junior', 'euvaldo.dias@hotmail.com', '98872-0230', 'euvaldo.dias@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 21537062387, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (36, 'Amanda de Mª Gomes Pinheiro', 'amandacvrd@yahoo.com.br', '98114-3450', 'amandacvrd@yahoo.com.br', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 72252200391, 'Presidente de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (37, 'Andréa Araújo Matos', 'andreamatos@bol.com.br', '98808-4150', 'andreamatos@bol.com.br', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 72167262353, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (38, 'Antonia do Espírito Santo  da S. Hortegal', 'antoniohortegal@hotmail.com', '98865-9191', 'antoniohortegal@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 48886912315, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (39, 'Suely Sousa de Moraes', 'suelymoraes5@hotmail.com', '98115-0885', 'suelymoraes5@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 41836057334, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (40, 'Sandra Rosane Costa Ferreira', 'rosanecferreira@hotmail.com', '99903-4071', 'rosanecferreira@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 43806872368, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (41, 'Maria da Natividade dos S. Rodrigues', 'natysr62@hotmail.com', '98907-2897', 'natysr62@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 26959852315, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (42, 'Thiago Melo Martins', 'tiago_martins35@hotmail.com', '99232-6694', 'tiago_martins35@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 3309456374, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (43, 'Lucinaldo Carvalho da Silva', 'lucinaldo.advocacia@gmail.com', '98165-0017', 'lucinaldo.advocacia@gmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 73642746349, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (44, 'Luiz Henrique dos Santos Castro', 'luizhscastro@bol.com.br', '98812-8599', 'luizhscastro@bol.com.br', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 29657947300, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (45, 'Nize Amorim Gonçalves', 'nize.ag68@gmail.com', '98159-3117', 'nize.ag68@gmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 33211795391, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (29, 'Pedro Cantanhede Dias', 'pedrocantanhede@stc.ma.gov.br', '', 'pedro', '$2y$10$zcgI9Xjzsn8jsYP/zB5sb.Wbd4M/WdfB5WbmBtM6n3.xd/QKS7j96', true, 'HaPevS5Sh90HBWePKD6egqmzGj4HR7NZJgYzJBqg9jOPckUDRQLDzjPo4HRu', '2016-01-19 15:45:16', '2016-01-19 16:00:26', 78177804391, 'Secretário Adjunto de Administração e Finanças', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (4, 'Rodrigo Lago', 'rpflago@gmail.com', '', 'rodrigo', '$2y$10$lgvnvod3Lu9SyBHcVFCSJOGZ8dCAWA9kAydarGLoeECerJx5Bj6T6', true, 'MFvSVSncQxul7kmAHA0eFg2q8qWzgTO7idNvpANLvrzl2ZWrk1IPpo4ssfOT', '2015-07-06 16:46:56', '2016-01-08 18:34:20', NULL, NULL, false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (46, 'Maria Raimunda dos Santos Silva', 'rayy59@hotmail.com', '98739-1354', 'rayy59@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 7462441349, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (47, 'Ana Lucia Muniz de Menezes', 'analucia1313@hotmail.com', '3962-6586', 'analucia1313@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 43165214387, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (13, 'Gabriela Freitas Maia', 'gabrielaalves@stc.ma.gov.br', '', 'gabrielaalves@stc.ma.gov.br', '$2y$10$LoRFQU6/ZLY/278xYWm.OOtANoF4dP81OZ87TjGRhIxF0h5DIrELa', true, '1xolG0ozAfhaqaGNFmSUmx30OAnsnFEJ1j8JrjNWN2dWJ2Gd8Bu9MFJ8JBnJ', '2015-09-30 11:21:46', '2018-03-02 08:40:30', NULL, NULL, false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (17, 'Ivo Salgado Neto', 'ivo.salgado@stc.ma.gov.br', '', 'ivo.salgado@stc.ma.gov.br', '$2y$10$mMeyJXS3reHW8Ra6wQy24OhJObIYzy1JBaqzFwM9.NDtpbY3Q7/8u', true, 'yZfPPVVuIvqnoQGZN9L5LSFpIhykFtZNdWYQMw8KGRuQvlcsVOYjAd6YXIuE', '2015-10-02 15:57:56', '2017-10-26 10:44:48', NULL, NULL, true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (1, 'Administrador', 'desenvolvimento@stc.ma.gov.br', '', 'admin', '$2y$10$EeyfGlwcoDEKIBOPx52uiOxcQ4RmmPmzzq58yzz29U/qcaFfXnvfe', true, NULL, '2015-05-20 11:30:00', '2015-05-20 11:30:00', NULL, NULL, false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (7, 'Adaltina Queiroga', 'adaltina@stc.ma.gov.br', '', 'adaltina', '$2y$10$SAlQ0Yzoj5LqYWCf8bFz2eXG.yjp3uEDcIl8EkAEy7TzmYYM1EUWa', true, NULL, '2015-07-06 16:48:29', '2018-05-18 15:23:51', NULL, '', false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (361, 'Carlos Magno Pires Rates Junior', 'magnorates@gmail.com', '', 'magnorates@gmail.com', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, NULL, '2019-11-06 18:53:18', '2019-11-06 18:53:18', 404410324, '', false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (32, 'Mário Silvio Costa Carvalho', 'masicoca@hotmail.com', '98865-9191', 'masicoca@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 22593411368, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (33, 'Dilson Dias Sá', 'dilson.adv@hotmail.com', '98808-2525', 'dilson.adv@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 69662380310, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (48, 'Ivângela Gomes de Oliveira', 'ivangelamaior@hotmail.com', '99207-6924', 'ivangelamaior@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 47193034391, 'Presidente de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (49, 'Maria Nazaré de Almeida Lima', 'nazadelima@yahoo.com.br', '98844-9746', 'nazadelima@yahoo.com.br', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 14917939372, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (50, 'Marivanda de Jesus Costa', 'mvanda.costa@hotmail.com', '98805-6222', 'mvanda.costa@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 58575529315, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (51, 'Layla Gonçalves Mendes de C. Barbosa', 'laylabarbosa@seinc.ma.gov.br', '98130-4963', 'laylabarbosa@seinc.ma.gov.br', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 3449570390, 'Presidente de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (52, 'Reginaldo Soares da Silva Junior', 'reginaldo_silvajr@hotmail.com', '98169-0175', 'reginaldo_silvajr@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 25117840330, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (53, 'Bruno Yuri do Nascimento Teixeira', 'brunoteixeira@seinc.ma.gov.br', '98185-2000', 'brunoteixeira@seinc.ma.gov.br', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 2079110101, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (54, 'Railda  Coutinho de Oliveira Pascoal', 'raildapascoal@hotmail.com', '98503-9191', 'raildapascoal@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 49949241391, 'Presidente de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (55, 'Eva Patrícia Sousa de Albuquerque', 'adv.patriciaalbuquerque@hotmail.com', '98110-8703', 'adv.patriciaalbuquerque@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 4037443341, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (56, 'Jair Gilberto de Almeida Barros', 'jairgilberto@hotmail.com', '98701-4471', 'jairgilberto@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 24862983391, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (60, 'Elaine Cutrim Vieira', 'assejur@sedihpop.ma.gov.br', '98170-8989', 'assejur@sedihpop.ma.gov.br', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 64405280397, 'Presidente de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (61, 'Laíza Braga Rabelo', 'laizasedihpop@hotmail.com', '99961-5301', 'laizasedihpop@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 3481894350, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (62, 'Raimundo Nonato Pires Duarte', 'rnpduarte@live.com', '98870-0138', 'rnpduarte@live.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 14980487300, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (63, 'Marília Duarte Santos', 'mariliasedihpop@gmail.com', '98417-7126', 'mariliasedihpop@gmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 2750363322, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (64, 'Jacimary Arouche Lavra', 'jacimary.lavra@secti.ma.gov.br', '99212-2304', 'jacimary.lavra@secti.ma.gov.br', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 51554992320, 'Presidente de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (65, 'Eduardo Augusto Martins Noronha', 'eduardo.noronha@secti.ma.gov.br', '99207-3478', 'eduardo.noronha@secti.ma.gov.br', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 48826308349, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (66, 'Anderson Ribeiro de Oliveira', 'anderson.oliveira@iema.ma.gov.br', '99214-1706', 'anderson.oliveira@iema.ma.gov.br', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 96212462377, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (67, 'Kátia Milena Maciel da Silva', 'kmilena@hotmail.com', '98816-5959', 'kmilena@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 70523967349, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (68, 'Gustavo Medeiros Mota Andrade', 'gustavo.andrade@iema.ma.gov.br', '99214-2740', 'gustavo.andrade@iema.ma.gov.br', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 563421363, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (69, 'Karen Karolyna Silva Rocha', 'karen.rocha@fapema.br', '99844-0066', 'karen.rocha@fapema.br', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 2878760395, 'Presidente de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (70, 'Laís de Oliveira Araújo', 'lais.araujo@fapema.br', '98130-0456', 'lais.araujo@fapema.br', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 98591533372, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (71, 'Maria Ivanilde Nassar Rocha', 'maria.ivanilde@fapema.com', '98119-1500', 'maria.ivanilde@fapema.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 15880540391, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (72, 'Sara Lopes Guimarães', 'saraguimaraes@hotmail.com', '98151-1360', 'saraguimaraes@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 981625940, 'Presidente de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (73, 'Helenilda Costa Ferre', 'ferreirahc13@hotmail.com', '98733-8810', 'ferreirahc13@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 20736690344, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (80, 'Raquel Elisa Abenante Vasconcelos', 'raquelelisa21@hotmail.com', '98758-3406', 'raquelelisa21@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 19794215368, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (81, 'Aline Maria Mendes Pereira Neto', 'alinemariamp@hotmail.com', '99603-0185', 'alinemariamp@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 62960440382, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (82, 'Katchelyne Isabelle de Carvalho Furtado', 'kisabelle_ma@hotmail.com', '98172-9131', 'kisabelle_ma@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 71077553315, 'Presidente de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (83, 'Maria Ielva Galvão Magalhães Brito', 'ielvagalvao@yahoo.com.br', '98870-7146', 'ielvagalvao@yahoo.com.br', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 14996065320, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (84, 'Nonilde Ferreira Matos', 'nonildematos@hotmail.com', '98735-6787', 'nonildematos@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:45', '2016-01-20 12:42:45', 27056309372, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (85, 'George Adriano de Oliveira Costa', 'adv_georgeadriano@hotmail.com', '98167-7899', 'adv_georgeadriano@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 645946370, 'Presidente de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (86, 'André Luis Lustosa de Oliveira', 'andrelustosa2@gmail.com', '99611-9664', 'andrelustosa2@gmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 48352446304, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (87, 'Carolina Araujo Quintanilha', 'carol_quintanilha10@hotmail.com', '99136-0659', 'carol_quintanilha10@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 465578306, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (88, 'Rogério de Araujo Lobato', 'lobroger@gmail.com', '33125-2158', 'lobroger@gmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 87843072772, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (89, 'Carlos Januário Vargas de Souza Oliveira', 'carlosjanuarioadv@gmail.com', '98406-7919', 'carlosjanuarioadv@gmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 82567786368, 'Presidente de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (90, 'Camila Amatha Cavalcanti Lima', 'camilaamatha@gmail.com', '98710-6004', 'camilaamatha@gmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 1669034348, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (91, 'Rayana Pereira Sotão Arraes', 'sotaoarraes@gmail.com', '98151-7127', 'sotaoarraes@gmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 99348969315, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (92, 'Carolina Maria Souza e Silva', 'camariaoab@gmail.com', '99993-9703', 'camariaoab@gmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 1376681390, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (93, 'Marina Marques Martins', 'marianaseme20152@outlook.com', '99116-3912', 'marianaseme20152@outlook.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 487743326, 'Presidente de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (94, 'Cláudia Cristina Cardoso Silva', 'claudiasilva.asplan@gmail.com', '98232-7383', 'claudiasilva.asplan@gmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 78527279304, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (95, 'Vinicius Lima Noleto', 'vinivius.noleto@gmail.com', '98712-4918', 'vinivius.noleto@gmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 1628571365, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (96, 'Gloria Simone Sousa Martins', 'gssmartins@hotmail.com', '99609-8066', 'gssmartins@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 44478968349, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (97, 'Belliza Mendanha Varejão de Freitas', 'bellizafreitas@hotmail.com', '98723-3153', 'bellizafreitas@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 3406352405, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (98, 'Claudia Regina Garcia Coutinho', 'claudiagcoutinho@gmai.com', '98825-0599', 'claudiagcoutinho@gmai.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 56295251315, 'Presidente de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (99, 'Guilherme Rodrigues da Silva', 'guilhermersilva@live.com', '98148-6772', 'guilhermersilva@live.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 1400954380, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (100, 'José Marcelo Assunção Soares', 'jmarceloassuncao@hotmail.com', '98303-6419', 'jmarceloassuncao@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 42844800300, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (101, 'Elaine Ascensão Raposo Leite Dias', 'nelaineraposodias@hotmail.com', '99128-9404', 'nelaineraposodias@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 22491813300, 'Presidente de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (102, 'Mariana Correia Lauande Correia Coutinho', 'mariana-lauande@hotmail.com', '99145-4582', 'mariana-lauande@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 2901955355, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (103, 'Raimunda de Arruda Machado', 'raimunda_arruda@yahoo.com.br', '99124-9238', 'raimunda_arruda@yahoo.com.br', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 15173771100, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (104, 'Nery de Jesus Maranhão Cardoso', 'nerycard@hotmail.com', '98231-9878', 'nerycard@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 46005838334, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (105, 'Elyssandra Nunes Costa', 'elyssandra@secid.ma.gov.br', '99179-5994', 'elyssandra@secid.ma.gov.br', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 75635720315, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (106, 'Albert Weyder Mousinho da Silva', 'albertwm@hotmail.com', '3214-1803', 'albertwm@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 94291268300, 'Presidente de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (108, 'Raimundo Nonato Carvalho Piorsky Junior', 'rpiorskyjr@gmai.com', '98274-8900', 'rpiorskyjr@gmai.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 4058292300, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (109, 'Waldy da Rocha Ferreira Neto', 'wrfn@hotmai.com', '98163-2469', 'wrfn@hotmai.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 1085385329, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (110, 'Marco Aurélio Silva Costa Júnior', 'marcoaureliojr17@gmail.com', '99197-0017', 'marcoaureliojr17@gmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 451744314, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (111, 'Franck Fonsêca de Mattos', 'franckmattosadv@gmail.com', '98171-4236', 'franckmattosadv@gmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 99191563372, 'Presidente de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (112, 'David José Paes Mattos', 'davivj.pmattos@gmail.com', '98822-6867', 'davivj.pmattos@gmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 3248970308, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (113, 'Bianca Maluf Vitória e Silva', 'biancamaluf@gmail.com', '98822-6867', 'biancamaluf@gmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 33235152857, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (114, 'Paulo Cesar Maia Araujo', 'pcma_araujo@yahoo.com.br', '99605-3061', 'pcma_araujo@yahoo.com.br', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 21660370334, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (115, 'Francisco Rocha Neto', 'frneto2014@hotmail.com', '98461-6556', 'frneto2014@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 75932006353, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (116, 'Jefferson Sousa Barbosa', 'jeffersonb.mig@gmail.com', '99944-8525', 'jeffersonb.mig@gmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 74313479368, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (117, 'José de Ribamar Galvão da Solidade', 'ramabigalvao@gmail.com', '98236-2126', 'ramabigalvao@gmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 49317890300, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (118, 'Alexandre Rosa de Carvalho', 'advalecarvalho@hotmail.com', '99128-7576', 'advalecarvalho@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 55857639387, 'Presidente de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (120, 'Rosangela Maia Sousa Fonseca', 'rosangela.msf@hotmail.com', '3218-8703', 'rosangela.msf@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 20624913368, 'Presidente de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (121, 'Diomedes Buceles Caminha', 'diomedescaminha@hotmail.com', '3218-8703', 'diomedescaminha@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 13710613353, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (122, 'Raimundo Santos Gomes', 'rsgomes.1999@hotmail.com', '3218-8703', 'rsgomes.1999@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 6427464353, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (123, 'Silvelene de Jesus Santos Durans', 'silvele23@bol.com.br', '3218-8703', 'silvele23@bol.com.br', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 47594578368, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (124, 'Marcos Antonio da Silva Grande', 'marcosgrande1@gmail.com', '99193-8779', 'marcosgrande1@gmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 74641816204, 'Presidente de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (125, 'Karoline Lucena Oliveira Lima', 'karolinelucena@msn.com', '99126-8555', 'karolinelucena@msn.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 2726123325, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (126, 'Saturnino Antonio Lindoso Diniz', 'saturninoantonio@bol.com.br', '98712-3120', 'saturninoantonio@bol.com.br', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 3810364304, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (130, 'Paula Coelho Bonesi Gutiez', 'paula.gutiez@hotmail.com', '98205-4640', 'paula.gutiez@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 438328302, 'Presidente de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (131, 'Andrey Salgado Moraes', 'asalgadomoraes@gmail.com', '99606-1659', 'asalgadomoraes@gmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 47126671334, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (132, 'Emanoel Penha Bastos', 'penhamb@hotmail.com', '98801-5600', 'penhamb@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 35213698387, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (133, 'Isabel Cristina de Freitas Ribeiro Moraes', 'isabelribeiromoraes@gmail.com', '98473-3927', 'isabelribeiromoraes@gmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 62247034349, 'Presidente de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (134, 'Waldomiro Bras da Silva', 'wbrasfilho@yahoo.com.;br', '99109-7537', 'wbrasfilho@yahoo.com.;br', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 11593547153, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (135, 'Nilza Maria Silva de Azevedo', 'nilza_azevedo@hotmail.com', '98285-1560', 'nilza_azevedo@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 41855000334, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (119, 'Alysson Penha de Jesus', 'engenharia.sedel@gmail.com', '98842-9103', 'engenharia.sedel@gmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-03-08 16:16:50', NULL, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (136, 'Ismael de Sousa Fonseca', 'isf70@hotmail.com', '99974-0180', 'isf70@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 45943931368, 'Presidente de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (137, 'Alindo Dias dos Santos', 'majorpmdias@hotmail.com', '99170-1300', 'majorpmdias@hotmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 40593703391, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (138, 'Carlos Fabre Matos Correa', 'fabreten@gmail.com', '98880-0269', 'fabreten@gmail.com', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-01-20 12:42:46', 81291540300, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (154, 'Alessia', 'alessia.leite@stc.ma.gov.br', '', 'alessia', '$2y$10$DF6mcy3BxGp3NOxBncm6Su1KeGowEK/0aCeapdNTzqXYkwNLwn4I6', true, 'S9x13NCiZC7Kish9GnzwpBx7axPypPinP3ur1m0avw3HKYeqIHjIHZP40Jmb', '2016-04-11 16:22:22', '2016-04-11 16:24:21', NULL, '', false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (107, 'Ambrósio Guimarães Neto', 'agneto@tce.ma.gov.br', '2108-9290', 'agneto@tce.ma.gov.br', '$2y$10$Y5Syq5SpUdDdjBd8pfhBXOgemR4dniVPBmMMm1wZ641ZeUzKgP0ke', true, NULL, '2016-01-20 12:42:46', '2016-03-08 16:08:50', 35124052304, 'Membro de comissão de TCE', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (155, 'Antonio Dino', 'antonio.dino@stc.ma.gov.br', '', 'dino', '$2y$10$o9LNVG1dihBBgXEeNBlEJ.uIWxEYkpRM9qjF8r5AIZvG/WOpSjrnm', true, '3ScbHab5BtULFAGBRKX8Xi0oGBugRXwrVq3iTppCRziVQ0EyrQ3gZpdEZJnB', '2016-04-12 16:33:54', '2016-08-05 14:37:22', NULL, '', false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (147, 'Raul', 'rauls.sdg@gmail.com', '', 'raulbarros', '$2y$10$MplaxbXlmRc7DQ7qHwuRWuNCpijGze0v9PR4Aors4EBISsndpk7S.', true, 'wgTG9ZRSdeRXOewSB5HlfnZieg01Y38nOQPZgj7BTSdMtkPqALXHa2cijHXc', '2016-02-26 17:15:05', '2016-04-14 14:20:13', NULL, 'Programador', false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (172, 'Atmos Maciel', 'atmos.mps@gmail.com', '', 'atmos.mps@gmail.com', '$2y$10$j1/n6fuI7EU3rCfDj1n5l.5/z1Uwam1Dnk7slqnzIy8TsaJOix3ja', true, 'rnKwhoB4VK7aL8jm3SEmEHJ3GKRNZVKMJeZ9ELCfHsRjSzZBndTWSfvvfe53', '2016-08-29 10:41:42', '2016-08-29 10:45:05', NULL, '', false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (169, 'Vinicius Rogério Araujo Silva', 'vinicius.ras@gmail.com', '', 'vinicius', '$2y$10$GU9h//T3eTTgIU4KCrbbBOO2/vk3Rh/UTO.DOygmS7cFqdCfyYz82', true, 'tfsFEHUWwqSHFYSnC58yJPhe2LruIJRQMEhy7OfRb4Oa4cWVdz5LEzMOxrDi', '2016-06-01 15:41:35', '2016-07-27 18:20:31', NULL, 'Assessor Sênior', false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (189, 'comum_agenda', 'steferson@stc.ma.gov.br', 'null', 'comum_agenda', '$2y$10$l7QtOsfJ3eZCsHAE8anESu/xu/L5sOhkv6VSPeNbsDvL5uwaT.NYO', true, 'WQPCdSP5ATRH4TYjdbOnQvhc6JbOJ0vVjOYKxRqx6boNPvFfD6TwoZ1m848m', '2016-11-23 18:27:27', '2018-12-12 17:25:54', NULL, '', false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (190, 'Milena Taveira ', 'milenakostaveira@gmail.com', 'null', 'milenakostaveira@gmail.com', '$2y$10$l7QtOsfJ3eZCsHAE8anESu/xu/L5sOhkv6VSPeNbsDvL5uwaT.NYO', true, 'q2puWgwJUh1rit3MnvmBOHz2unOArC1vcijmcXwCQ29SIniNK6GVfZHYUsSK', '2016-11-23 18:27:27', '2018-02-21 16:17:06', NULL, NULL, false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (187, 'Karla Brandão ', 'karla@governadoria.ma.gov.br', 'null', 'karla@governadoria.ma.gov.br', '$2y$10$l7QtOsfJ3eZCsHAE8anESu/xu/L5sOhkv6VSPeNbsDvL5uwaT.NYO', true, NULL, '2016-11-23 18:27:27', '2016-11-23 18:27:27', NULL, NULL, false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (170, 'AGENDA Cerimonial da Silva', 'steferson.ferreira@gmail.com', '', 'cerimonial', '$2y$10$W.ExBk.p4G8yQCZ6ro2wY.6qjSPVnZXk0Z3h6Lsir3GJHj9gbu142', true, 'V1Ehg4yMPzklUfnvd6oVY8sAPWYjASQCb1Gxnhia2bDjnCLhS4o2xp7TnSqF', '2016-08-02 08:17:16', '2018-12-12 17:36:34', NULL, '', false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (178, 'ALLANE SILVA', 'allane_silva@yahoo.com.br', '987705101', 'allane_silva@yahoo.com.br', '$2y$10$l7QtOsfJ3eZCsHAE8anESu/xu/L5sOhkv6VSPeNbsDvL5uwaT.NYO', true, NULL, '2016-11-23 18:27:27', '2016-11-23 18:27:27', NULL, NULL, false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (180, 'TELMA MOURA', 'telmoura@gmail.com', '988825613', 'telmoura@gmail.com', '$2y$10$l7QtOsfJ3eZCsHAE8anESu/xu/L5sOhkv6VSPeNbsDvL5uwaT.NYO', true, NULL, '2016-11-23 18:27:27', '2016-11-23 18:27:27', NULL, NULL, false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (181, 'THAGIANNE COSTA', 'thagianne@hotmail.com', '988468073', 'thagianne@hotmail.com', '$2y$10$l7QtOsfJ3eZCsHAE8anESu/xu/L5sOhkv6VSPeNbsDvL5uwaT.NYO', true, NULL, '2016-11-23 18:27:27', '2016-11-23 18:27:27', NULL, NULL, false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (183, 'CLAUDILENE MAIA', 'clauu.maia@gmail.com', '988680175', 'clauu.maia@gmail.com', '$2y$10$l7QtOsfJ3eZCsHAE8anESu/xu/L5sOhkv6VSPeNbsDvL5uwaT.NYO', true, NULL, '2016-11-23 18:27:27', '2016-11-23 18:27:27', NULL, NULL, false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (182, 'VITÓRIA NERI', 'vitorianery@yahoo.com.br', '984237010', 'vitorianery@yahoo.com.br', '$2y$10$l7QtOsfJ3eZCsHAE8anESu/xu/L5sOhkv6VSPeNbsDvL5uwaT.NYO', true, NULL, '2016-11-23 18:27:27', '2016-11-23 18:27:27', NULL, NULL, false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (184, 'PATRÍCIA RAMALHO', 'patriciarramalho@outlook.com', '981555404', 'patriciarramalho@outlook.com', '$2y$10$l7QtOsfJ3eZCsHAE8anESu/xu/L5sOhkv6VSPeNbsDvL5uwaT.NYO', true, 'H1ZY3qeoXgC9AociZVuQik1u7CHcpIWTiLIPdvI4eHv8b5EKhX0A9Swo4FcT', '2016-11-23 18:27:27', '2016-11-25 11:09:35', NULL, NULL, false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (188, 'Joseane Mendes ', 'joseane.jam@gmail.com', 'null', 'joseane.jam@gmail.com', '$2y$10$l7QtOsfJ3eZCsHAE8anESu/xu/L5sOhkv6VSPeNbsDvL5uwaT.NYO', true, 'ZmjDLKpLhn1WlUFCEiPaYf6FwSP2FyYI1yFxoEgaIRGBEK32lGGuKMZ7GEGR', '2016-11-23 18:27:27', '2016-11-28 16:17:39', NULL, NULL, false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (179, 'ROSEMERI BARROS', 'rosemeribarros.rp@gmail.com', '988242207', 'rosemeribarros.rp@gmail.com', '$2y$10$l7QtOsfJ3eZCsHAE8anESu/xu/L5sOhkv6VSPeNbsDvL5uwaT.NYO', true, 'uAXd4AdWFm9rLCHfwZBfsPAcpwWMntw9jmJIOsS7010NNwFYZYxiTpeI3OvL', '2016-11-23 18:27:27', '2017-01-12 16:39:41', NULL, NULL, false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (153, 'AGENDA Gabinete da Silva', 'usuario3@gmail.com', '', 'gabinete', '$2y$10$l7QtOsfJ3eZCsHAE8anESu/xu/L5sOhkv6VSPeNbsDvL5uwaT.NYO', true, 'AsAjs4U82qFdGyfQQc1SRfsxPhcCV6iUDWUqIJoMMLciam1WpkjuFON8r1qR', '2016-04-06 10:35:00', '2017-05-18 15:43:34', 55689896785, '', false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (2, 'Ricardo Reis', 'ricardoreis@stc.ma.gov.br', '', 'ricardoreis', '$2y$10$PonI35pujvFdNKg6QEkCKuSWdEW3GATIB8apZ6GmcI1bYYZ0N4Ff.', true, 'JLpXe8UbFB4PzrJdX6sn5ghWONP5PgJ4qPHKokHviERHH6b8KDMXzwwfKKDz', '2015-05-20 11:30:00', '2018-08-07 09:21:23', NULL, NULL, false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (171, 'Jacson Santos', 'jacsonk47@gmail.com', '991377480', 'jacson', '$2y$10$iMz3wWCSrGKIpNuaiL7/KeoMmUSP.c46Jdz1bkS6qtPUmLTl0gBae', true, 'O1VPbMsPJknExFh5uSGVQi8qibKuqSpRJ3SFSZeXLr4l3wdgyVkNn8KRSIMi', '2016-08-22 18:01:46', '2018-05-29 15:36:20', 6223170327, 'Developer', false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (185, 'Rafaela Vidigal ', 'rafaelavidigal86@gmail.com', 'null', 'rafaelavidigal86@gmail.com', '$2y$10$l7QtOsfJ3eZCsHAE8anESu/xu/L5sOhkv6VSPeNbsDvL5uwaT.NYO', true, 'dazB5tjHKPlPOPJzksBxJAUhENjfdX1cRlF698idss0QcptquECHVCx3v5Ql', '2016-11-23 18:27:27', '2017-03-13 15:37:37', NULL, NULL, false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (191, 'Anna Carolina Paiva Diniz', 'anna.carolina@stc.ma.gov.br', '', 'annacarolina', '$2y$10$Vp9/auTdXzqcdlX.vfxEs.OzwFYVJuT8xnXxY67tJ0EVbW/UV9YDG', true, 'AYVlWOcrP6b8DHqdZhozig6khNxj6vGjD2v9ity90NgifosW6nNtrwUhTcs1', '2017-01-27 16:21:04', '2017-03-30 11:53:14', 0, 'Assessora de Comunicação', false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (152, 'Usuario 2', 'usuario2@gmail.com', '', 'usuario2', '$2y$10$PonI35pujvFdNKg6QEkCKuSWdEW3GATIB8apZ6GmcI1bYYZ0N4Ff.', true, 'EhFzUtWckpENRY4bQUqcVNqKIBz55WNahf41kVpPeEuhDJv0DSGuP8566v7A', '2016-04-06 10:34:08', '2018-03-08 12:13:11', 65889089987, '', false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (18, 'Laís Barreto', 'lais.barreto@stc.ma.gov.br', '', 'lais.barreto@stc.ma.gov.br', '$2y$10$GqnGAt1mywRGUGLQqV2Lfu8LOhVO3kG5iVP.NB6BuWyxjC3q6kyUW', true, 'REneCB8uERAOQfoCJzVvWoTlFueOfsuGrucWCKKKkIXsWPYub0atxnZ6p3Id', '2015-10-02 15:58:22', '2018-03-02 15:28:58', NULL, NULL, false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (186, 'Julliene Gomes ', 'jullienegomes@gmail.com', 'null', 'jullienegomes@gmail.com', '$2y$10$l7QtOsfJ3eZCsHAE8anESu/xu/L5sOhkv6VSPeNbsDvL5uwaT.NYO', true, '8EYxudHJT20KqfS7g3m0HFEpAqYGlRViRJxFF4wSlRebtgdj7vm8xzlXRcVB', '2016-11-23 18:27:27', '2018-04-25 14:28:51', NULL, NULL, false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (148, 'Nanderson', 'nanderson.castro@stc.ma.gov.br', '', 'nanderson', '$2y$10$qjdmonwGSL7.PgqLUwLHP.YVczo8UPIc.zI9cwJl9K3RrzSC9F7kK', true, 'quProJNBsmi0SrxQR5wIyj0o0OE6OYnBlsS1uJpaKHAt9Iz8r8eUHOQ31toZ', '2016-03-04 15:13:19', '2019-07-11 15:03:47', 56465444645, 'Analista', false, NULL, '2019-07-11 15:03:47');
INSERT INTO geral.tb_usuario VALUES (192, 'Maks Saraiva Machado', 'maks_machado@hotmail.com', '', 'maks_machado@hotmail.com', '$2y$10$M9kl/qyUALwBNzM5TQS13eVRT8YYeyf1ZgHrPQe2jzWSLH6/O1UzC', true, NULL, '2017-10-26 10:46:47', '2017-10-26 10:46:47', NULL, '', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (193, 'Reinaldo Araújo Magalhães Dantas Júnior', 'reinaldo.dantas.jr@gmail.com', '', 'reinaldo.dantas.jr@gmail.com', '$2y$10$EoT/hpBuif86/WWd7rEwX.zpzXwjRMUnnSPUwutJAnxbn2ysLgmJu', true, NULL, '2017-10-26 10:48:08', '2017-10-26 10:48:08', NULL, '', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (201, 'Ronald Serra Campos', 'ronald.serra@stc.ma.gov.br', '', 'ronald', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'clIZWXbzvfwx8ywOljTjU8rZWFfu7eUval6HuLIBjkfiiHuRaQXKfh0TOPbd', '2018-02-15 19:53:15', '2019-08-14 09:36:52', NULL, '', false, '/admin/usuarios/documentos/doc_solicitacao_201_24090.pdf', '2019-08-14 09:36:52');
INSERT INTO geral.tb_usuario VALUES (202, 'Carlos André de Oliveira Silva', 'carlos.andre@stc.ma.gov.br', '', 'carlos.andre@stc.ma.gov.br', '$2y$10$QuV2mQfSJvRsDXML0fZjN.2Dz1c6aIVSuT0RURUF4zCa8XrukHj6.', true, 'f9JyFCmvIH3p7zJE5cSUzsW9XVqxvw8RWnfIEUcD9gbmZERWfGYy3uB6PLWe', '2018-02-19 12:22:29', '2019-11-07 15:14:48', 25195935807, 'Auditor do Estado', false, NULL, '2019-11-07 15:13:32');
INSERT INTO geral.tb_usuario VALUES (151, 'Usuario 1', 'usuario1@gmail.com', '', 'usuario1', '$2y$10$PonI35pujvFdNKg6QEkCKuSWdEW3GATIB8apZ6GmcI1bYYZ0N4Ff.', true, 'jADx8gQA5KIkMIIaojWB2IGuTwQXNtCqelmZnzWNMposhLjYwPtMmiD4uZaB', '2016-04-06 10:33:10', '2019-09-10 10:08:17', 23445465677, '', false, NULL, '2019-09-10 08:38:51');
INSERT INTO geral.tb_usuario VALUES (200, 'Usuário 8', 'usuario8@gmail.com', '', 'usuario8', '$2y$10$yKwns1807Yd6KBgIlYKl8OyuKp48pI77I5zI99nu9zACvbNUMQyqy', true, '64YwHj0dKFPbGAE5eoK2RFCQiGygMZpK8PdkplBD5qTJl5eJ6S4l5Kxkifm1', '2017-11-30 10:33:07', '2017-12-07 11:14:34', NULL, '', false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (212, 'Externo 01 Logari_v2', 'externo01@email.com', '', 'externo01', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'PRD393mg8LAKWCFN2qmBaZ5ToPrpUb5nRzgyYYhCo4FhiE5tqycEFpsif6BI', '2019-04-23 15:18:42', '2019-09-23 11:23:20', 56465646544, '', false, NULL, '2019-09-23 11:22:34');
INSERT INTO geral.tb_usuario VALUES (213, 'Externo 02 Logari_v2', 'externo02@email.com', '', 'externo02', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'cge0KChZjQxh85XVTkGyLfeKZ3n3MDe5SvlcoXcR5zNhwqWxbeNUUtOauMa3', '2019-04-23 16:04:30', '2019-09-26 17:54:14', 23423423423, '', false, NULL, '2019-09-26 17:54:14');
INSERT INTO geral.tb_usuario VALUES (31, 'Ana Eliza Baima dos Santos', 'anaeliza@stc.ma.gov.br', '99146-0626', 'anaeliza@stc.ma.gov.br', '$2y$10$Q/CMe3BGgsFWDpLHgZJ8WOVe8.gok8.wVVv7WDY2LrMPDbCYa.IQO', true, 'lb9n18DvjZRUjgTSZG1JLPMLOuxssWLoGp7vqP3Acbq34gZ6RiotsLxD2mlf', '2016-01-20 11:00:25', '2019-09-02 11:38:05', 64908798320, 'Assessora', false, NULL, '2019-09-02 11:26:46');
INSERT INTO geral.tb_usuario VALUES (197, 'Usuário 5', 'usuario5@gmail.com', '', 'usuario5', '$2y$10$5NfIKD5XI69k/ZM/kvZ8B.OeflEJBtCP.L6mg.YzorUW8Ie8RUJVG', true, 'aA9JJ5ZygVFXvqDJHWSHN5ner5ysa6smHvuDx3zWTk2nFTf3FTDZAmag1Cf7', '2017-11-30 10:31:58', '2017-12-11 11:24:15', NULL, '', false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (196, 'Usuário 4', 'usuario4@gmail.com', '', 'usuario4', '$2y$10$qqfVkRCjfkiysfLas6GOMufn3hyIvYBc6M48M8H/Dv/oJ6nRGMF26', true, 'mMSyx55t6909NMx8nnCePbaRRRgMrmEheRxNq6lAAg18NApYZXNUvtqv0tUG', '2017-11-30 10:31:38', '2017-12-11 11:26:05', NULL, '', false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (203, ' Edvaldo Veras Reis junior', 'edvaldo@stc.ma.gov.br', '', 'edvaldo@stc.ma.gov.br', '$2y$10$21vyNJDwztth6.rzs38yi.XoJjO02oZGYFwg6KbmieVM2EPq/JL9.', true, 'VMfUhi6sVu6xC4WhdPkBXz2gZaBfbWN40u9wtdPbL31FFvZqzjBGD2zvu8iX', '2018-02-20 11:20:21', '2019-08-21 17:06:33', 47458275391, '', false, NULL, '2019-08-21 17:05:26');
INSERT INTO geral.tb_usuario VALUES (195, 'Usuário 3', 'usuario33@gmail.com', '', 'usuario3', '$2y$10$u9jrpCdqIarycZzb9KsmQ.vuiCXf8/SADnQnb4z2eg7Wj3VgTZj12', true, 'A8s7ynB5hLPNlqJ23Bi137k4iTeNaEZmr0Cb6L8lGnFYI5RLWSmcvKdCXlvi', '2017-11-30 10:30:59', '2018-03-08 12:12:47', NULL, '', false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (214, 'Externo 03 Logari_v2', 'externo03@email.com', '', 'externo03', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'T3T9mVXTZkL6WbTVUhJ0QEdjqFpAlr4RIw7FtWuXu1ZKi8apF6OXRLKXrikr', '2019-04-23 16:18:03', '2019-09-26 17:52:23', 11111111111, '', false, NULL, '2019-09-26 17:50:13');
INSERT INTO geral.tb_usuario VALUES (198, 'Usuário 6', 'usuario6@gmail.com', '', 'usuario6', '$2y$10$HcdZyXLiLQsf6CpSrzGCNuo/e8MPZqglXRQGY2msBkAMEbfohREjW', true, '64Y5jbPzceUJPl5apQzRewtjKuBTEbDkfjFV4siQDc7jeheSbiYxARKA09kd', '2017-11-30 10:32:20', '2017-11-30 11:13:10', NULL, '', false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (199, 'Usuário 7', 'usuario7@gmail.com', '', 'usuario7', '$2y$10$jsWZiDJiDu4bYSN/Qdcc6eN2QNEXXufSYv6hgY7VaY67WoBHLP29u', true, 'L448SEJQURAWq78b793a2ouDiPLCxf5XFrb4YamOjnStyKq8Y21LmZCNDPVH', '2017-11-30 10:32:42', '2017-11-30 11:13:41', NULL, '', false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (206, 'seati', 'jrnogueiraj@gmail.com', '989898', 'seati', '$2y$10$ZQykmcxKqlUk/Y2TQCRyauDbgvsxL8KG.20S8b8TLimfFTIN49JGO', true, 'GKQaD0QPWKQtbO3Fuv4OazbPGKhs2BprfqDWaoxDgjpt61Iv6mjiLOL3JAVe', '2018-04-18 09:43:48', '2018-04-27 17:27:29', 11212121212, 'teste', false, '/admin/usuarios/documentos/doc_solicitacao_206_42474.pdf', NULL);
INSERT INTO geral.tb_usuario VALUES (16, 'Marília Medeiros', 'marilia.medeiros@stc.ma.gov.br', '', 'marilia.medeiros@stc.ma.gov.br', '$2y$10$2UfVMOU0Igyu.s5AwTHmWe1mxm5Zu3hxyKIg/CXa49R/NoZ48zvlK', true, 'cXIeKTzzvNryNBMbv3Rw1Q1DPYACehVlFPq0z6Fb5bmTYpZUnFHPd21vi6K6', '2015-10-02 15:57:09', '2018-10-03 10:42:17', NULL, NULL, false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (211, 'Luiz Evangelista Ramos Filho', 'ramosfilho03@hotmail.com', '', 'Luiz Evangelista', '$2y$10$Ive1mTC53rIxpZYrZkjNhetGzdANrVNJguabyaRAGHelAZRdjyd9a', true, NULL, '2019-01-22 14:11:32', '2019-01-28 15:21:43', NULL, 'Comissão de Recebimento', true, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (208, 'Salathiel', 'salathiel@stc.ma.gov.br', '', 'salathiel', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'D4wCnKYUcA0A0v2GorbaY2gpqlb8SV1WkdT1YLJZO5Gbm8cD0bD5v5Nk6toa', '2018-04-27 16:48:16', '2019-07-11 18:02:11', 80346146372, 'PROMOTOR DE JUSTIÇA    ', false, NULL, '2019-07-11 18:02:11');
INSERT INTO geral.tb_usuario VALUES (5, 'steferson', 'steferson1@stc.ma.gov.br', '98988998899', 'steferson', '$2y$10$be0ihORnK3qkKpEkRsMGheDKZdJ9Ul9gI1Utymz2FtckVuFU.rM3u', true, 'z0m9MK9eggp3Xz4rG7mwlGhAQQz9piXHIQkKbMkEJykTGNGmy1OiUPusSfe4', '2015-07-06 16:47:31', '2019-11-06 19:01:29', 77777777777, 'Secretário Adjunto de Transparência', false, NULL, '2019-11-06 18:57:35');
INSERT INTO geral.tb_usuario VALUES (338, 'usuario suprema 11', 'email_suprema_11@teste.com', '', 'usuario_suprema_11', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'YbQaEIu8kHI4bzfciL4WdTIpyaIb984DHv3Tmc8R7Ko9AEoyZA2yJosjAkGL', '2019-08-21 11:11:37', '2019-09-04 08:23:04', NULL, 'treinamento', false, NULL, '2019-09-04 08:23:04');
INSERT INTO geral.tb_usuario VALUES (332, 'usuario suprema 5', 'email_suprema_5@teste.com', '', 'usuario_suprema_5', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'bmmwyxZLQ5lO6JzOUoF2DEbS2q6VNCxFTHYmeRJpQzsnJDzfjmt9pnJ17HDn', '2019-08-21 11:11:37', '2019-09-04 09:49:44', NULL, 'treinamento', false, NULL, '2019-09-04 08:13:42');
INSERT INTO geral.tb_usuario VALUES (340, 'usuario suprema 13', 'email_suprema_13@teste.com', '', 'usuario_suprema_13', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'L7HJcQzlN4GwtsbXsg2vkwS2HpPqbb6G1D6OHhKu3qzik9YBmph8c7o64yRP', '2019-08-21 11:11:37', '2019-09-04 08:25:00', NULL, 'treinamento', false, NULL, '2019-09-04 08:25:00');
INSERT INTO geral.tb_usuario VALUES (341, 'usuario suprema 14', 'email_suprema_14@teste.com', '', 'usuario_suprema_14', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'yEnwIkTEAntGSZxeboOg79ityMaTfHdZJHyqhyzQqtFYzTfKmOC3xYAlpVcb', '2019-08-21 11:11:37', '2019-09-04 08:25:44', NULL, 'treinamento', false, NULL, '2019-09-04 08:25:44');
INSERT INTO geral.tb_usuario VALUES (339, 'usuario suprema 12', 'email_suprema_12@teste.com', '', 'usuario_suprema_12', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'pDljk6OEcJmrCtkzZB6RI7IQl4pcTsV7HlKJYLggD406P4qQbpfBHBMKhbys', '2019-08-21 11:11:37', '2019-09-04 09:50:01', NULL, 'treinamento', false, NULL, '2019-09-04 08:24:25');
INSERT INTO geral.tb_usuario VALUES (343, 'usuario suprema 16', 'email_suprema_16@teste.com', '', 'usuario_suprema_16', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, '1dXHnTBW6iWi0zPoehk44tk3SQS27mqk45FGFZ3Nge3bibiTjzqN5LATIHMM', '2019-08-21 11:11:37', '2019-09-04 08:29:28', NULL, 'treinamento', false, NULL, '2019-09-04 08:29:28');
INSERT INTO geral.tb_usuario VALUES (337, 'usuario suprema 10', 'email_suprema_10@teste.com', '', 'usuario_suprema_10', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'ldn8GWffzreIBGwHmqyLevLspdmpxwJFmk0EC11JISB7a1E0Ctxys7pA0SEt', '2019-08-21 11:11:37', '2019-09-04 09:49:13', NULL, 'treinamento', false, NULL, '2019-09-04 08:22:39');
INSERT INTO geral.tb_usuario VALUES (335, 'usuario suprema 8', 'email_suprema_8@teste.com', '', 'usuario_suprema_8', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'sW0eQy50meQbJwezkERAs5meRjdqaeDTPqm7OHoR7Lm57DYHXLMEyjrbZzWQ', '2019-08-21 11:11:37', '2019-09-05 08:58:09', NULL, 'treinamento', false, NULL, '2019-09-05 08:58:09');
INSERT INTO geral.tb_usuario VALUES (329, 'usuario suprema 2', 'email_suprema_2@teste.com', '', 'usuario_suprema_2', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, '9NqcQiF3IUs1V2qMk4FhxhN3uAjf6I3Bkpp0RhIfdwjFvIUG92e3P7O4eD5p', '2019-08-21 11:11:37', '2019-09-04 08:12:31', NULL, 'treinamento', false, NULL, '2019-09-04 08:12:31');
INSERT INTO geral.tb_usuario VALUES (330, 'usuario suprema 3', 'email_suprema_3@teste.com', '', 'usuario_suprema_3', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'BV0ss3BMbMytFGJNkNGPI6NcZLX8zw2wa6qlhUW9v9b313YBhLjgchWwdELk', '2019-08-21 11:11:37', '2019-09-04 08:12:49', NULL, 'treinamento', false, NULL, '2019-09-04 08:12:49');
INSERT INTO geral.tb_usuario VALUES (342, 'usuario suprema 15', 'email_suprema_15@teste.com', '', 'usuario_suprema_15', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'w1YPcXtIbUiezPsk2PTnsczBFYp2k766bXiKTXsan0lfUwQNGpsTGzqxugfi', '2019-08-21 11:11:37', '2019-09-04 09:49:39', NULL, 'treinamento', false, NULL, '2019-09-04 08:28:43');
INSERT INTO geral.tb_usuario VALUES (334, 'usuario suprema 7', 'email_suprema_7@teste.com', '', 'usuario_suprema_7', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'AwDaV00DClrhKVOMUx4dSmCW1kIg1FKIpMN3H55vkXf37tWKvQvx3ba8nZHf', '2019-08-21 11:11:37', '2019-09-04 09:49:41', NULL, 'treinamento', false, NULL, '2019-09-04 08:16:53');
INSERT INTO geral.tb_usuario VALUES (333, 'usuario suprema 6', 'email_suprema_6@teste.com', '', 'usuario_suprema_6', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, '37lq1NkwXbdqvBfdCH3Uo76yWLBoKGFskO6LULQ8L6vuI45KPcwbEgEXtnaX', '2019-08-21 11:11:37', '2019-09-04 08:14:23', NULL, 'treinamento', false, NULL, '2019-09-04 08:14:23');
INSERT INTO geral.tb_usuario VALUES (336, 'usuario suprema 9', 'email_suprema_9@teste.com', '', 'usuario_suprema_9', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'twnMrNWNpdATaXNE6KDfVWg0r1KxCdbBJpvTvIz0cTeoEGq301RhultGrzc1', '2019-08-21 11:11:37', '2019-09-04 08:21:38', NULL, 'treinamento', false, NULL, '2019-09-04 08:21:38');
INSERT INTO geral.tb_usuario VALUES (331, 'usuario suprema 4', 'email_suprema_4@teste.com', '', 'usuario_suprema_4', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'g3MRZxFwCCBwj3Kc5bYKI5b1vROobJVc6YuOl7GTbqiprSTNV2v2iYUCnBOy', '2019-08-21 11:11:37', '2019-09-04 09:49:42', NULL, 'treinamento', false, NULL, '2019-09-04 08:12:59');
INSERT INTO geral.tb_usuario VALUES (345, 'usuario suprema 18', 'email_suprema_18@teste.com', '', 'usuario_suprema_18', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, '4LdxTfwWK7UNwNSl7e3b0biKM5L6rVUVhBhj6gZbDV56VyVNDpvRkmILuFSt', '2019-08-21 11:11:37', '2019-09-04 08:33:41', NULL, 'treinamento', false, NULL, '2019-09-04 08:33:41');
INSERT INTO geral.tb_usuario VALUES (176, 'Bruno Araujo', 'bruno@stc.ma.gov.br', '(99) 9843-03437', 'bruno_araujo', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, '3800IC66HReOnDRjzoQvP1mJcaTlAPkleHsboQoty2bmX50O0LPA3GeFsqni', '2016-11-21 15:27:08', '2019-11-07 17:38:15', 15296761502, 'Develop', false, NULL, '2019-11-07 17:38:15');
INSERT INTO geral.tb_usuario VALUES (346, 'usuario suprema 19', 'email_suprema_19@teste.com', '', 'usuario_suprema_19', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'eJj8c8sHln7bltOsrI2yct7u2KougRbIbJs7Or7esLIrb1yiwsDJxuq8EkIp', '2019-08-21 11:11:37', '2019-09-04 08:34:17', NULL, 'treinamento', false, NULL, '2019-09-04 08:34:17');
INSERT INTO geral.tb_usuario VALUES (226, 'Roberto Cavalcante', 'roberto.cavalcante@stc.ma.gov.br', '', 'roberto.cavalcante@stc.ma.gov.br', '$2y$10$H/1q71MJRB5UJy8LVGm4Euxguy7NEShiISc1JbkkwE99AaRyGtmPC', true, 'IP5OwLB4J9lWYuJdJrusfzgbZCqSANqSgw5p1IM3HSOyH80ROqT2ywVlEOHP', '2019-08-21 09:54:27', '2019-08-29 10:47:27', 95889701304, 'Assessor', false, NULL, '2019-08-29 10:47:27');
INSERT INTO geral.tb_usuario VALUES (355, 'usuario suprema 28', 'email_suprema_28@teste.com', '', 'usuario_suprema_28', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, NULL, '2019-08-21 11:11:38', '2019-09-02 10:23:19', NULL, 'treinamento', false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (356, 'usuario suprema 29', 'email_suprema_29@teste.com', '', 'usuario_suprema_29', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, NULL, '2019-08-21 11:11:38', '2019-09-02 10:23:24', NULL, 'treinamento', false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (358, 'Saler Talge', 'salertalge@hotmail.com', '', 'salertalge@hotmail.com', '$2y$10$G6QtwsnIdNgke0P8RFHQ3u7qXEGuMuYDsJJHUco/44dfnH0yJMeEy', true, 'r6q4PZx3Q0lH3DMtQI9ywBMXALCBWnc9bH1cVHEkKmaakt5YQz9KdntJm2Z5', '2019-08-22 09:55:39', '2019-08-22 10:00:06', NULL, '', false, NULL, '2019-08-22 09:56:37');
INSERT INTO geral.tb_usuario VALUES (350, 'usuario suprema 23', 'email_suprema_23@teste.com', '', 'usuario_suprema_23', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, '6Dfo0JzGhMayz0hpv7JbKcGi0zHnY3EctiqEc757Dl1LkA52D5NH5tk3LFgA', '2019-08-21 11:11:38', '2019-09-03 08:36:34', NULL, 'treinamento', false, NULL, '2019-09-03 08:36:17');
INSERT INTO geral.tb_usuario VALUES (352, 'usuario suprema 25', 'email_suprema_25@teste.com', '', 'usuario_suprema_25', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'TuDrobmICn9iziA7OOqAHzsHAo80N6AEFKkUKygNdt6m1fY3olpEIFDFoJbF', '2019-08-21 11:11:38', '2019-09-02 10:29:22', NULL, 'treinamento', false, NULL, '2019-09-02 10:29:22');
INSERT INTO geral.tb_usuario VALUES (348, 'usuario suprema 21', 'email_suprema_21@teste.com', '', 'usuario_suprema_21', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'QBafwOlq6q9GJItxJ7aE7yQn11G5c9nUyFw9Q7agYYGiFqYzcWok7bKkX1By', '2019-08-21 11:11:37', '2019-09-04 09:17:05', NULL, 'treinamento', false, NULL, '2019-09-04 09:17:05');
INSERT INTO geral.tb_usuario VALUES (9, 'Ricardo Costa', 'ricardocosta@stc.ma.gov.br', '', 'ricardocosta', '$2y$10$zydxT/rbBCKzalszfK1CwOwh98k5Lw8indw3QhVnISE/XHcu4X7FS', true, 'qNpF5xo11DHiMgFRp5tpO2GZeZYloZv99bkEmbGf1qMctFW2L80uWxSzO0vE', '2015-07-21 11:01:32', '2019-08-27 14:55:18', NULL, NULL, false, NULL, '2019-08-27 14:55:18');
INSERT INTO geral.tb_usuario VALUES (353, 'usuario suprema 26', 'email_suprema_26@teste.com', '', 'usuario_suprema_26', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, NULL, '2019-08-21 11:11:38', '2019-09-02 10:33:03', NULL, 'treinamento', false, NULL, '2019-09-02 10:33:03');
INSERT INTO geral.tb_usuario VALUES (351, 'usuario suprema 24', 'email_suprema_24@teste.com', '', 'usuario_suprema_24', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'GrXEUcejj4D5s3mbEtE9hIGuHTYilGyAf6SRB8BvlmqV7aeqS7dpcwqHLTkQ', '2019-08-21 11:11:38', '2019-09-03 09:51:27', NULL, 'treinamento', false, NULL, '2019-09-03 08:41:20');
INSERT INTO geral.tb_usuario VALUES (349, 'usuario suprema 22', 'email_suprema_22@teste.com', '', 'usuario_suprema_22', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, NULL, '2019-08-21 11:11:37', '2019-09-02 10:22:38', NULL, 'treinamento', false, NULL, '2019-09-02 10:21:27');
INSERT INTO geral.tb_usuario VALUES (328, 'usuario suprema 1', 'email_suprema_1@teste.com', '', 'usuario_suprema_1', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'GaBRQ49uGRaLkcdXY0NZOFZb3sNB8w7xfPMHbmvXeqxchn6YnWnQGy9jvcuK', '2019-08-21 11:11:37', '2019-09-16 09:00:37', NULL, 'treinamento', false, NULL, '2019-09-16 09:00:37');
INSERT INTO geral.tb_usuario VALUES (347, 'usuario suprema 20', 'email_suprema_20@teste.com', '', 'usuario_suprema_20', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'w8vgMdmDitJ8bR5EHs5PXhrEV6SQFeys78lJIwAPf47hDptv3Bj9G8CRgtFh', '2019-08-21 11:11:37', '2019-09-04 09:49:46', NULL, 'treinamento', false, NULL, '2019-09-04 08:50:29');
INSERT INTO geral.tb_usuario VALUES (357, 'usuario suprema 30', 'email_suprema_30@teste.com', '', 'usuario_suprema_30', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'de3pwjGxFh0uX5rseR6ECeREpG7IxWnFD2tjMHpfG1RpL59liTeOZcaChlPy', '2019-08-21 11:11:38', '2019-09-09 16:48:36', NULL, 'treinamento', false, NULL, '2019-09-09 16:48:36');
INSERT INTO geral.tb_usuario VALUES (354, 'usuario suprema 27', 'email_suprema_27@teste.com', '', 'usuario_suprema_27', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'Jka3MRnSzFBb12RKYDwMgnXZW2cYSdFSvQoRbq6ev2wQ7qC2sD18mIzXUX4s', '2019-08-21 11:11:38', '2019-09-02 11:28:56', NULL, 'treinamento', false, NULL, '2019-09-02 11:28:56');
INSERT INTO geral.tb_usuario VALUES (359, 'usuario_suprema_00', 'usuario_suprema_00@teste.com', '', 'usuario_suprema_00', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'nWNzO1QMW2dSH0GFjSZIqHR6OShF2chCzxEHVe8QRchq7EzwouNcb5W291sn', '2019-08-27 14:59:07', '2019-09-12 09:16:55', NULL, '', false, NULL, '2019-09-12 09:09:04');
INSERT INTO geral.tb_usuario VALUES (344, 'usuario suprema 17', 'email_suprema_17@teste.com', '', 'usuario_suprema_17', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'JCW1s7vzZBGFGxU9rLzZvxJZtU5zRZ66Cgq8TUpplBSCqKDy2WtK6P6sDhRw', '2019-08-21 11:11:37', '2019-09-04 08:33:22', NULL, 'treinamento', false, NULL, '2019-09-04 08:33:05');
INSERT INTO geral.tb_usuario VALUES (369, 'jesonilton', 'jesonilton@gmail.com', '991448646', 'nilton', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, NULL, '2020-01-17 00:08:03', '2020-01-17 00:08:03', 23423432432, NULL, false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (210, 'Jesonilton', 'jesonilton@stc.ma.gov.br', '98999989999999', 'jesonilton', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'mSoWlpNoyzbKDs5izR2kQ4IQMnk5BXr01ZmNIWoJ0KQaxmt7cE3fNMUmSE5j', '2018-06-19 13:35:19', '2020-01-21 02:27:15', 60621194301, 'Analista', false, NULL, '2020-01-21 02:27:15');


--
-- TOC entry 2962 (class 0 OID 24661)
-- Dependencies: 219
-- Data for Name: tb_usuario_anexo; Type: TABLE DATA; Schema: geral; Owner: postgres
--

INSERT INTO geral.tb_usuario_anexo VALUES (176, 1);
INSERT INTO geral.tb_usuario_anexo VALUES (176, 2);


--
-- TOC entry 2964 (class 0 OID 24666)
-- Dependencies: 221
-- Data for Name: tb_usuario_mensagem; Type: TABLE DATA; Schema: geral; Owner: postgres
--

INSERT INTO geral.tb_usuario_mensagem VALUES (148, 6, 1, true, '2016-05-09 18:43:23', '2016-05-09 18:43:23', 1);
INSERT INTO geral.tb_usuario_mensagem VALUES (148, 4, 1, true, '2016-05-09 18:56:01', '2016-05-09 18:56:01', 4);
INSERT INTO geral.tb_usuario_mensagem VALUES (148, 5, 1, true, '2016-05-10 11:14:56', '2016-05-10 11:14:56', 6);
INSERT INTO geral.tb_usuario_mensagem VALUES (147, 6, 1, true, '2016-05-11 16:19:59', '2016-05-11 16:19:59', 7);
INSERT INTO geral.tb_usuario_mensagem VALUES (147, 5, 1, true, '2016-05-11 16:20:01', '2016-05-11 16:20:01', 8);
INSERT INTO geral.tb_usuario_mensagem VALUES (147, 4, 1, true, '2016-05-11 16:20:30', '2016-05-11 16:20:30', 9);
INSERT INTO geral.tb_usuario_mensagem VALUES (148, 7, 1, true, '2016-05-12 16:29:48', '2016-05-12 16:29:48', 10);
INSERT INTO geral.tb_usuario_mensagem VALUES (5, 7, 1, true, '2016-05-12 17:03:19', '2016-05-12 17:03:19', 11);
INSERT INTO geral.tb_usuario_mensagem VALUES (148, 11, 1, true, '2016-05-13 15:30:43', '2016-05-13 15:30:43', 12);
INSERT INTO geral.tb_usuario_mensagem VALUES (148, 10, 1, true, '2016-05-13 15:30:44', '2016-05-13 15:30:44', 13);
INSERT INTO geral.tb_usuario_mensagem VALUES (148, 9, 1, true, '2016-05-13 15:30:45', '2016-05-13 15:30:45', 14);
INSERT INTO geral.tb_usuario_mensagem VALUES (148, 8, 1, true, '2016-05-13 15:30:46', '2016-05-13 15:30:46', 15);
INSERT INTO geral.tb_usuario_mensagem VALUES (5, 10, 1, true, '2016-05-13 15:18:34', '2016-05-13 15:18:34', 16);
INSERT INTO geral.tb_usuario_mensagem VALUES (148, 15, 1, true, '2016-05-16 11:23:57', '2016-05-16 11:23:57', 17);
INSERT INTO geral.tb_usuario_mensagem VALUES (5, 9, 1, true, '2016-05-16 11:49:59', '2016-05-16 11:49:59', 18);
INSERT INTO geral.tb_usuario_mensagem VALUES (5, 16, 1, true, '2016-05-16 15:27:16', '2016-05-16 15:27:16', 19);
INSERT INTO geral.tb_usuario_mensagem VALUES (5, 17, 1, true, '2016-05-16 15:27:21', '2016-05-16 15:27:21', 20);
INSERT INTO geral.tb_usuario_mensagem VALUES (5, 18, 1, true, '2016-05-16 16:12:53', '2016-05-16 16:12:53', 21);
INSERT INTO geral.tb_usuario_mensagem VALUES (148, 17, 1, true, '2016-05-16 17:29:52', '2016-05-16 17:29:52', 22);
INSERT INTO geral.tb_usuario_mensagem VALUES (148, 18, 1, true, '2016-05-16 17:36:56', '2016-05-16 17:36:56', 23);
INSERT INTO geral.tb_usuario_mensagem VALUES (5, 15, 1, true, '2016-05-19 16:40:15', '2016-05-19 16:40:15', 25);
INSERT INTO geral.tb_usuario_mensagem VALUES (148, 16, 1, true, '2016-05-19 17:15:58', '2016-05-19 17:15:58', 27);
INSERT INTO geral.tb_usuario_mensagem VALUES (5, 8, 1, true, '2016-05-19 17:03:47', '2016-05-19 17:03:47', 28);
INSERT INTO geral.tb_usuario_mensagem VALUES (148, 19, 1, true, '2016-05-19 18:50:49', '2016-05-19 18:50:49', 29);
INSERT INTO geral.tb_usuario_mensagem VALUES (148, 20, 1, true, '2016-05-20 14:22:48', '2016-05-20 14:22:48', 30);
INSERT INTO geral.tb_usuario_mensagem VALUES (5, 20, 1, true, '2016-05-23 11:33:02', '2016-05-23 11:33:02', 31);
INSERT INTO geral.tb_usuario_mensagem VALUES (2, 20, 1, true, '2016-05-25 17:58:52', '2016-05-25 17:58:52', 32);
INSERT INTO geral.tb_usuario_mensagem VALUES (2, 16, 1, true, '2016-05-25 17:58:53', '2016-05-25 17:58:53', 33);
INSERT INTO geral.tb_usuario_mensagem VALUES (2, 10, 1, true, '2016-05-25 17:58:53', '2016-05-25 17:58:53', 34);
INSERT INTO geral.tb_usuario_mensagem VALUES (2, 8, 1, true, '2016-05-25 17:58:54', '2016-05-25 17:58:54', 35);
INSERT INTO geral.tb_usuario_mensagem VALUES (2, 17, 1, true, '2016-05-25 17:58:54', '2016-05-25 17:58:54', 36);
INSERT INTO geral.tb_usuario_mensagem VALUES (155, 17, 1, true, '2016-05-31 17:29:06', '2016-05-31 17:29:06', 37);
INSERT INTO geral.tb_usuario_mensagem VALUES (169, 17, 1, true, '2016-07-14 15:41:46', '2016-07-14 15:41:46', 38);
INSERT INTO geral.tb_usuario_mensagem VALUES (171, 20, 1, true, '2016-08-22 18:06:26', '2016-08-22 18:06:26', 39);
INSERT INTO geral.tb_usuario_mensagem VALUES (171, 15, 1, true, '2016-08-22 18:06:28', '2016-08-22 18:06:28', 40);
INSERT INTO geral.tb_usuario_mensagem VALUES (171, 18, 1, true, '2018-05-29 15:38:47', '2018-05-29 15:38:47', 41);
INSERT INTO geral.tb_usuario_mensagem VALUES (171, 16, 1, true, '2018-05-29 15:38:48', '2018-05-29 15:38:48', 42);
INSERT INTO geral.tb_usuario_mensagem VALUES (171, 10, 1, true, '2018-05-29 15:38:49', '2018-05-29 15:38:49', 43);
INSERT INTO geral.tb_usuario_mensagem VALUES (171, 8, 1, true, '2018-05-29 15:38:50', '2018-05-29 15:38:50', 44);
INSERT INTO geral.tb_usuario_mensagem VALUES (148, 21, 1, true, '2019-04-24 16:15:11', '2019-04-24 16:15:11', 45);
INSERT INTO geral.tb_usuario_mensagem VALUES (148, 22, 1, true, '2019-04-24 16:15:13', '2019-04-24 16:15:13', 46);
INSERT INTO geral.tb_usuario_mensagem VALUES (5, 23, 1, true, '2019-09-02 09:33:27', '2019-09-02 09:33:27', 47);
INSERT INTO geral.tb_usuario_mensagem VALUES (5, 22, 1, true, '2019-09-02 09:33:29', '2019-09-02 09:33:29', 48);
INSERT INTO geral.tb_usuario_mensagem VALUES (5, 21, 1, true, '2019-09-02 09:33:30', '2019-09-02 09:33:30', 49);
INSERT INTO geral.tb_usuario_mensagem VALUES (5, 19, 1, true, '2019-09-02 09:33:32', '2019-09-02 09:33:32', 50);


--
-- TOC entry 2966 (class 0 OID 24671)
-- Dependencies: 223
-- Data for Name: tb_usuario_unidade; Type: TABLE DATA; Schema: geral; Owner: postgres
--

INSERT INTO geral.tb_usuario_unidade VALUES (3, 110122);
INSERT INTO geral.tb_usuario_unidade VALUES (2, 110122);
INSERT INTO geral.tb_usuario_unidade VALUES (29, 110122);
INSERT INTO geral.tb_usuario_unidade VALUES (32, 170101);
INSERT INTO geral.tb_usuario_unidade VALUES (33, 170101);
INSERT INTO geral.tb_usuario_unidade VALUES (34, 170101);
INSERT INTO geral.tb_usuario_unidade VALUES (35, 170101);
INSERT INTO geral.tb_usuario_unidade VALUES (36, 170101);
INSERT INTO geral.tb_usuario_unidade VALUES (37, 170101);
INSERT INTO geral.tb_usuario_unidade VALUES (38, 170101);
INSERT INTO geral.tb_usuario_unidade VALUES (39, 170101);
INSERT INTO geral.tb_usuario_unidade VALUES (40, 170101);
INSERT INTO geral.tb_usuario_unidade VALUES (41, 170101);
INSERT INTO geral.tb_usuario_unidade VALUES (42, 170101);
INSERT INTO geral.tb_usuario_unidade VALUES (43, 170101);
INSERT INTO geral.tb_usuario_unidade VALUES (44, 170101);
INSERT INTO geral.tb_usuario_unidade VALUES (45, 170101);
INSERT INTO geral.tb_usuario_unidade VALUES (46, 170101);
INSERT INTO geral.tb_usuario_unidade VALUES (47, 170101);
INSERT INTO geral.tb_usuario_unidade VALUES (48, 610202);
INSERT INTO geral.tb_usuario_unidade VALUES (49, 610202);
INSERT INTO geral.tb_usuario_unidade VALUES (50, 610202);
INSERT INTO geral.tb_usuario_unidade VALUES (51, 230101);
INSERT INTO geral.tb_usuario_unidade VALUES (52, 230101);
INSERT INTO geral.tb_usuario_unidade VALUES (53, 230101);
INSERT INTO geral.tb_usuario_unidade VALUES (54, 610101);
INSERT INTO geral.tb_usuario_unidade VALUES (55, 610101);
INSERT INTO geral.tb_usuario_unidade VALUES (56, 610101);
INSERT INTO geral.tb_usuario_unidade VALUES (60, 540101);
INSERT INTO geral.tb_usuario_unidade VALUES (61, 540101);
INSERT INTO geral.tb_usuario_unidade VALUES (62, 540101);
INSERT INTO geral.tb_usuario_unidade VALUES (63, 540101);
INSERT INTO geral.tb_usuario_unidade VALUES (64, 240101);
INSERT INTO geral.tb_usuario_unidade VALUES (65, 240101);
INSERT INTO geral.tb_usuario_unidade VALUES (66, 240101);
INSERT INTO geral.tb_usuario_unidade VALUES (67, 240101);
INSERT INTO geral.tb_usuario_unidade VALUES (68, 240101);
INSERT INTO geral.tb_usuario_unidade VALUES (69, 240202);
INSERT INTO geral.tb_usuario_unidade VALUES (70, 240202);
INSERT INTO geral.tb_usuario_unidade VALUES (71, 240202);
INSERT INTO geral.tb_usuario_unidade VALUES (72, 510101);
INSERT INTO geral.tb_usuario_unidade VALUES (73, 510101);
INSERT INTO geral.tb_usuario_unidade VALUES (80, 540201);
INSERT INTO geral.tb_usuario_unidade VALUES (81, 540201);
INSERT INTO geral.tb_usuario_unidade VALUES (82, 130101);
INSERT INTO geral.tb_usuario_unidade VALUES (83, 130101);
INSERT INTO geral.tb_usuario_unidade VALUES (84, 130101);
INSERT INTO geral.tb_usuario_unidade VALUES (85, 220205);
INSERT INTO geral.tb_usuario_unidade VALUES (86, 220205);
INSERT INTO geral.tb_usuario_unidade VALUES (87, 220205);
INSERT INTO geral.tb_usuario_unidade VALUES (88, 220205);
INSERT INTO geral.tb_usuario_unidade VALUES (89, 220101);
INSERT INTO geral.tb_usuario_unidade VALUES (90, 220101);
INSERT INTO geral.tb_usuario_unidade VALUES (91, 220101);
INSERT INTO geral.tb_usuario_unidade VALUES (92, 220101);
INSERT INTO geral.tb_usuario_unidade VALUES (93, 570101);
INSERT INTO geral.tb_usuario_unidade VALUES (94, 570101);
INSERT INTO geral.tb_usuario_unidade VALUES (95, 570101);
INSERT INTO geral.tb_usuario_unidade VALUES (96, 570101);
INSERT INTO geral.tb_usuario_unidade VALUES (97, 590101);
INSERT INTO geral.tb_usuario_unidade VALUES (98, 590101);
INSERT INTO geral.tb_usuario_unidade VALUES (99, 590101);
INSERT INTO geral.tb_usuario_unidade VALUES (100, 590101);
INSERT INTO geral.tb_usuario_unidade VALUES (101, 120101);
INSERT INTO geral.tb_usuario_unidade VALUES (102, 120101);
INSERT INTO geral.tb_usuario_unidade VALUES (103, 120101);
INSERT INTO geral.tb_usuario_unidade VALUES (104, 120101);
INSERT INTO geral.tb_usuario_unidade VALUES (105, 120101);
INSERT INTO geral.tb_usuario_unidade VALUES (106, 110109);
INSERT INTO geral.tb_usuario_unidade VALUES (107, 110109);
INSERT INTO geral.tb_usuario_unidade VALUES (108, 110109);
INSERT INTO geral.tb_usuario_unidade VALUES (109, 110109);
INSERT INTO geral.tb_usuario_unidade VALUES (110, 110109);
INSERT INTO geral.tb_usuario_unidade VALUES (111, 530201);
INSERT INTO geral.tb_usuario_unidade VALUES (112, 530201);
INSERT INTO geral.tb_usuario_unidade VALUES (113, 530201);
INSERT INTO geral.tb_usuario_unidade VALUES (114, 450101);
INSERT INTO geral.tb_usuario_unidade VALUES (115, 450101);
INSERT INTO geral.tb_usuario_unidade VALUES (116, 450101);
INSERT INTO geral.tb_usuario_unidade VALUES (117, 450101);
INSERT INTO geral.tb_usuario_unidade VALUES (118, 450101);
INSERT INTO geral.tb_usuario_unidade VALUES (119, 450101);
INSERT INTO geral.tb_usuario_unidade VALUES (120, 210101);
INSERT INTO geral.tb_usuario_unidade VALUES (121, 210101);
INSERT INTO geral.tb_usuario_unidade VALUES (122, 210101);
INSERT INTO geral.tb_usuario_unidade VALUES (123, 210101);
INSERT INTO geral.tb_usuario_unidade VALUES (124, 530101);
INSERT INTO geral.tb_usuario_unidade VALUES (125, 530101);
INSERT INTO geral.tb_usuario_unidade VALUES (126, 530101);
INSERT INTO geral.tb_usuario_unidade VALUES (130, 580101);
INSERT INTO geral.tb_usuario_unidade VALUES (131, 580101);
INSERT INTO geral.tb_usuario_unidade VALUES (132, 580101);
INSERT INTO geral.tb_usuario_unidade VALUES (133, 190101);
INSERT INTO geral.tb_usuario_unidade VALUES (134, 190101);
INSERT INTO geral.tb_usuario_unidade VALUES (135, 190101);
INSERT INTO geral.tb_usuario_unidade VALUES (136, 190110);
INSERT INTO geral.tb_usuario_unidade VALUES (137, 190110);
INSERT INTO geral.tb_usuario_unidade VALUES (138, 190110);
INSERT INTO geral.tb_usuario_unidade VALUES (148, 110122);
INSERT INTO geral.tb_usuario_unidade VALUES (147, 110122);
INSERT INTO geral.tb_usuario_unidade VALUES (2, 110120);
INSERT INTO geral.tb_usuario_unidade VALUES (151, 110122);
INSERT INTO geral.tb_usuario_unidade VALUES (152, 110122);
INSERT INTO geral.tb_usuario_unidade VALUES (154, 110122);
INSERT INTO geral.tb_usuario_unidade VALUES (31, 110120);
INSERT INTO geral.tb_usuario_unidade VALUES (155, 110122);
INSERT INTO geral.tb_usuario_unidade VALUES (5, 930101);
INSERT INTO geral.tb_usuario_unidade VALUES (169, 110122);
INSERT INTO geral.tb_usuario_unidade VALUES (172, 110122);
INSERT INTO geral.tb_usuario_unidade VALUES (170, 110109);
INSERT INTO geral.tb_usuario_unidade VALUES (153, 110123);
INSERT INTO geral.tb_usuario_unidade VALUES (171, 110122);
INSERT INTO geral.tb_usuario_unidade VALUES (178, 110109);
INSERT INTO geral.tb_usuario_unidade VALUES (179, 110109);
INSERT INTO geral.tb_usuario_unidade VALUES (180, 110109);
INSERT INTO geral.tb_usuario_unidade VALUES (181, 110109);
INSERT INTO geral.tb_usuario_unidade VALUES (182, 110109);
INSERT INTO geral.tb_usuario_unidade VALUES (183, 610101);
INSERT INTO geral.tb_usuario_unidade VALUES (184, 610101);
INSERT INTO geral.tb_usuario_unidade VALUES (185, 110123);
INSERT INTO geral.tb_usuario_unidade VALUES (186, 110123);
INSERT INTO geral.tb_usuario_unidade VALUES (187, 110123);
INSERT INTO geral.tb_usuario_unidade VALUES (188, 110123);
INSERT INTO geral.tb_usuario_unidade VALUES (7, 10201);
INSERT INTO geral.tb_usuario_unidade VALUES (190, 110123);
INSERT INTO geral.tb_usuario_unidade VALUES (191, 110122);
INSERT INTO geral.tb_usuario_unidade VALUES (18, 110120);
INSERT INTO geral.tb_usuario_unidade VALUES (16, 110120);
INSERT INTO geral.tb_usuario_unidade VALUES (13, 110120);
INSERT INTO geral.tb_usuario_unidade VALUES (17, 110120);
INSERT INTO geral.tb_usuario_unidade VALUES (192, 110120);
INSERT INTO geral.tb_usuario_unidade VALUES (193, 110120);
INSERT INTO geral.tb_usuario_unidade VALUES (200, 110122);
INSERT INTO geral.tb_usuario_unidade VALUES (196, 110122);
INSERT INTO geral.tb_usuario_unidade VALUES (198, 110122);
INSERT INTO geral.tb_usuario_unidade VALUES (195, 110122);
INSERT INTO geral.tb_usuario_unidade VALUES (197, 110122);
INSERT INTO geral.tb_usuario_unidade VALUES (199, 110122);
INSERT INTO geral.tb_usuario_unidade VALUES (201, 110122);
INSERT INTO geral.tb_usuario_unidade VALUES (208, 920101);
INSERT INTO geral.tb_usuario_unidade VALUES (208, 222222);
INSERT INTO geral.tb_usuario_unidade VALUES (7, 10901);
INSERT INTO geral.tb_usuario_unidade VALUES (7, 20101);
INSERT INTO geral.tb_usuario_unidade VALUES (208, 930101);
INSERT INTO geral.tb_usuario_unidade VALUES (201, 930101);
INSERT INTO geral.tb_usuario_unidade VALUES (208, 110120);
INSERT INTO geral.tb_usuario_unidade VALUES (208, 110122);
INSERT INTO geral.tb_usuario_unidade VALUES (210, 110122);
INSERT INTO geral.tb_usuario_unidade VALUES (176, 110122);
INSERT INTO geral.tb_usuario_unidade VALUES (210, 110109);
INSERT INTO geral.tb_usuario_unidade VALUES (202, 930101);
INSERT INTO geral.tb_usuario_unidade VALUES (210, 590101);
INSERT INTO geral.tb_usuario_unidade VALUES (202, 590101);
INSERT INTO geral.tb_usuario_unidade VALUES (210, 580203);
INSERT INTO geral.tb_usuario_unidade VALUES (202, 580203);
INSERT INTO geral.tb_usuario_unidade VALUES (210, 610201);
INSERT INTO geral.tb_usuario_unidade VALUES (202, 610201);
INSERT INTO geral.tb_usuario_unidade VALUES (210, 580201);
INSERT INTO geral.tb_usuario_unidade VALUES (202, 580201);
INSERT INTO geral.tb_usuario_unidade VALUES (210, 580101);
INSERT INTO geral.tb_usuario_unidade VALUES (202, 580101);
INSERT INTO geral.tb_usuario_unidade VALUES (210, 210291);
INSERT INTO geral.tb_usuario_unidade VALUES (202, 210291);
INSERT INTO geral.tb_usuario_unidade VALUES (210, 570101);
INSERT INTO geral.tb_usuario_unidade VALUES (202, 570101);
INSERT INTO geral.tb_usuario_unidade VALUES (210, 230201);
INSERT INTO geral.tb_usuario_unidade VALUES (202, 230201);
INSERT INTO geral.tb_usuario_unidade VALUES (210, 220917);
INSERT INTO geral.tb_usuario_unidade VALUES (202, 220917);
INSERT INTO geral.tb_usuario_unidade VALUES (210, 220205);
INSERT INTO geral.tb_usuario_unidade VALUES (202, 220205);
INSERT INTO geral.tb_usuario_unidade VALUES (210, 220202);
INSERT INTO geral.tb_usuario_unidade VALUES (202, 220202);
INSERT INTO geral.tb_usuario_unidade VALUES (9, 110122);
INSERT INTO geral.tb_usuario_unidade VALUES (5, 920101);
INSERT INTO geral.tb_usuario_unidade VALUES (189, 540101);
INSERT INTO geral.tb_usuario_unidade VALUES (170, 110122);
INSERT INTO geral.tb_usuario_unidade VALUES (148, 610202);
INSERT INTO geral.tb_usuario_unidade VALUES (148, 110107);
INSERT INTO geral.tb_usuario_unidade VALUES (202, 520101);
INSERT INTO geral.tb_usuario_unidade VALUES (202, 190201);
INSERT INTO geral.tb_usuario_unidade VALUES (202, 210201);
INSERT INTO geral.tb_usuario_unidade VALUES (202, 220903);
INSERT INTO geral.tb_usuario_unidade VALUES (202, 560901);
INSERT INTO geral.tb_usuario_unidade VALUES (202, 110103);
INSERT INTO geral.tb_usuario_unidade VALUES (202, 80101);
INSERT INTO geral.tb_usuario_unidade VALUES (202, 110104);
INSERT INTO geral.tb_usuario_unidade VALUES (202, 530101);
INSERT INTO geral.tb_usuario_unidade VALUES (202, 160101);
INSERT INTO geral.tb_usuario_unidade VALUES (202, 150101);
INSERT INTO geral.tb_usuario_unidade VALUES (202, 170101);
INSERT INTO geral.tb_usuario_unidade VALUES (202, 190101);
INSERT INTO geral.tb_usuario_unidade VALUES (202, 610202);
INSERT INTO geral.tb_usuario_unidade VALUES (202, 910101);
INSERT INTO geral.tb_usuario_unidade VALUES (202, 580111);
INSERT INTO geral.tb_usuario_unidade VALUES (202, 190134);
INSERT INTO geral.tb_usuario_unidade VALUES (203, 10101);
INSERT INTO geral.tb_usuario_unidade VALUES (203, 10201);
INSERT INTO geral.tb_usuario_unidade VALUES (203, 10901);
INSERT INTO geral.tb_usuario_unidade VALUES (203, 20101);
INSERT INTO geral.tb_usuario_unidade VALUES (203, 20901);
INSERT INTO geral.tb_usuario_unidade VALUES (203, 40101);
INSERT INTO geral.tb_usuario_unidade VALUES (203, 40102);
INSERT INTO geral.tb_usuario_unidade VALUES (203, 40901);
INSERT INTO geral.tb_usuario_unidade VALUES (203, 40902);
INSERT INTO geral.tb_usuario_unidade VALUES (203, 40903);
INSERT INTO geral.tb_usuario_unidade VALUES (203, 40904);
INSERT INTO geral.tb_usuario_unidade VALUES (203, 70101);
INSERT INTO geral.tb_usuario_unidade VALUES (203, 70901);
INSERT INTO geral.tb_usuario_unidade VALUES (203, 80101);
INSERT INTO geral.tb_usuario_unidade VALUES (203, 80901);
INSERT INTO geral.tb_usuario_unidade VALUES (203, 110104);
INSERT INTO geral.tb_usuario_unidade VALUES (203, 110105);
INSERT INTO geral.tb_usuario_unidade VALUES (203, 110107);
INSERT INTO geral.tb_usuario_unidade VALUES (203, 110110);
INSERT INTO geral.tb_usuario_unidade VALUES (203, 110116);
INSERT INTO geral.tb_usuario_unidade VALUES (203, 110117);
INSERT INTO geral.tb_usuario_unidade VALUES (203, 110119);
INSERT INTO geral.tb_usuario_unidade VALUES (203, 110123);
INSERT INTO geral.tb_usuario_unidade VALUES (203, 120205);
INSERT INTO geral.tb_usuario_unidade VALUES (203, 130126);
INSERT INTO geral.tb_usuario_unidade VALUES (203, 130129);
INSERT INTO geral.tb_usuario_unidade VALUES (211, 40903);
INSERT INTO geral.tb_usuario_unidade VALUES (211, 140901);
INSERT INTO geral.tb_usuario_unidade VALUES (211, 190112);
INSERT INTO geral.tb_usuario_unidade VALUES (211, 190101);
INSERT INTO geral.tb_usuario_unidade VALUES (211, 570101);
INSERT INTO geral.tb_usuario_unidade VALUES (211, 560101);
INSERT INTO geral.tb_usuario_unidade VALUES (211, 610202);
INSERT INTO geral.tb_usuario_unidade VALUES (211, 120205);
INSERT INTO geral.tb_usuario_unidade VALUES (211, 910101);
INSERT INTO geral.tb_usuario_unidade VALUES (148, 190110);
INSERT INTO geral.tb_usuario_unidade VALUES (212, 110113);
INSERT INTO geral.tb_usuario_unidade VALUES (212, 110109);
INSERT INTO geral.tb_usuario_unidade VALUES (212, 600103);
INSERT INTO geral.tb_usuario_unidade VALUES (212, 110209);
INSERT INTO geral.tb_usuario_unidade VALUES (212, 120101);
INSERT INTO geral.tb_usuario_unidade VALUES (212, 160901);
INSERT INTO geral.tb_usuario_unidade VALUES (212, 220205);
INSERT INTO geral.tb_usuario_unidade VALUES (212, 220101);
INSERT INTO geral.tb_usuario_unidade VALUES (212, 530101);
INSERT INTO geral.tb_usuario_unidade VALUES (212, 530201);
INSERT INTO geral.tb_usuario_unidade VALUES (212, 220903);
INSERT INTO geral.tb_usuario_unidade VALUES (212, 220901);
INSERT INTO geral.tb_usuario_unidade VALUES (212, 160101);
INSERT INTO geral.tb_usuario_unidade VALUES (212, 600104);
INSERT INTO geral.tb_usuario_unidade VALUES (212, 580101);
INSERT INTO geral.tb_usuario_unidade VALUES (212, 110105);
INSERT INTO geral.tb_usuario_unidade VALUES (212, 220202);
INSERT INTO geral.tb_usuario_unidade VALUES (176, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (213, 170101);
INSERT INTO geral.tb_usuario_unidade VALUES (213, 140201);
INSERT INTO geral.tb_usuario_unidade VALUES (213, 140901);
INSERT INTO geral.tb_usuario_unidade VALUES (213, 150101);
INSERT INTO geral.tb_usuario_unidade VALUES (213, 150903);
INSERT INTO geral.tb_usuario_unidade VALUES (213, 170203);
INSERT INTO geral.tb_usuario_unidade VALUES (213, 170901);
INSERT INTO geral.tb_usuario_unidade VALUES (213, 230201);
INSERT INTO geral.tb_usuario_unidade VALUES (213, 230202);
INSERT INTO geral.tb_usuario_unidade VALUES (213, 120206);
INSERT INTO geral.tb_usuario_unidade VALUES (213, 230901);
INSERT INTO geral.tb_usuario_unidade VALUES (213, 240101);
INSERT INTO geral.tb_usuario_unidade VALUES (213, 240206);
INSERT INTO geral.tb_usuario_unidade VALUES (213, 230101);
INSERT INTO geral.tb_usuario_unidade VALUES (213, 240202);
INSERT INTO geral.tb_usuario_unidade VALUES (213, 580111);
INSERT INTO geral.tb_usuario_unidade VALUES (213, 240201);
INSERT INTO geral.tb_usuario_unidade VALUES (213, 150112);
INSERT INTO geral.tb_usuario_unidade VALUES (214, 10201);
INSERT INTO geral.tb_usuario_unidade VALUES (214, 580203);
INSERT INTO geral.tb_usuario_unidade VALUES (176, 240202);
INSERT INTO geral.tb_usuario_unidade VALUES (226, 110120);
INSERT INTO geral.tb_usuario_unidade VALUES (5, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (336, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (332, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (342, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (341, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (339, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (334, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (329, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (338, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (337, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (331, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (330, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (343, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (335, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (340, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (333, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (349, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (350, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (351, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (353, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (354, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (355, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (356, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (348, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (347, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (352, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (345, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (346, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (357, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (344, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (328, 980101);
INSERT INTO geral.tb_usuario_unidade VALUES (359, 110120);
INSERT INTO geral.tb_usuario_unidade VALUES (176, 110120);
INSERT INTO geral.tb_usuario_unidade VALUES (5, 990106);
INSERT INTO geral.tb_usuario_unidade VALUES (5, 130901);
INSERT INTO geral.tb_usuario_unidade VALUES (5, 150101);
INSERT INTO geral.tb_usuario_unidade VALUES (358, 110120);
INSERT INTO geral.tb_usuario_unidade VALUES (176, 990106);
INSERT INTO geral.tb_usuario_unidade VALUES (176, 990107);
INSERT INTO geral.tb_usuario_unidade VALUES (176, 610202);
INSERT INTO geral.tb_usuario_unidade VALUES (176, 910101);
INSERT INTO geral.tb_usuario_unidade VALUES (5, 240202);
INSERT INTO geral.tb_usuario_unidade VALUES (176, 940101);
INSERT INTO geral.tb_usuario_unidade VALUES (176, 210101);


--
-- TOC entry 2986 (class 0 OID 0)
-- Dependencies: 198
-- Name: tb_anexo_int_anexo_id_seq; Type: SEQUENCE SET; Schema: geral; Owner: postgres
--

SELECT pg_catalog.setval('geral.tb_anexo_int_anexo_id_seq', 2, true);


--
-- TOC entry 2987 (class 0 OID 0)
-- Dependencies: 200
-- Name: tb_categoria_recurso_int_categoria_recurso_id_seq; Type: SEQUENCE SET; Schema: geral; Owner: postgres
--

SELECT pg_catalog.setval('geral.tb_categoria_recurso_int_categoria_recurso_id_seq', 11, true);


--
-- TOC entry 2988 (class 0 OID 0)
-- Dependencies: 202
-- Name: tb_feriados_int_feriado_id_seq; Type: SEQUENCE SET; Schema: geral; Owner: postgres
--

SELECT pg_catalog.setval('geral.tb_feriados_int_feriado_id_seq', 1, false);


--
-- TOC entry 2989 (class 0 OID 0)
-- Dependencies: 204
-- Name: tb_mensagens_int_mensagem_id_seq; Type: SEQUENCE SET; Schema: geral; Owner: postgres
--

SELECT pg_catalog.setval('geral.tb_mensagens_int_mensagem_id_seq', 24, true);


--
-- TOC entry 2990 (class 0 OID 0)
-- Dependencies: 206
-- Name: tb_modulo_int_modulo_id_seq; Type: SEQUENCE SET; Schema: geral; Owner: postgres
--

SELECT pg_catalog.setval('geral.tb_modulo_int_modulo_id_seq', 17, true);


--
-- TOC entry 2991 (class 0 OID 0)
-- Dependencies: 208
-- Name: tb_perfil_int_perfil_id_seq; Type: SEQUENCE SET; Schema: geral; Owner: postgres
--

SELECT pg_catalog.setval('geral.tb_perfil_int_perfil_id_seq', 43, true);


--
-- TOC entry 2992 (class 0 OID 0)
-- Dependencies: 212
-- Name: tb_permissao_int_permissao_id_seq; Type: SEQUENCE SET; Schema: geral; Owner: postgres
--

SELECT pg_catalog.setval('geral.tb_permissao_int_permissao_id_seq', 585, true);


--
-- TOC entry 2993 (class 0 OID 0)
-- Dependencies: 214
-- Name: tb_recurso_int_recurso_id_seq; Type: SEQUENCE SET; Schema: geral; Owner: postgres
--

SELECT pg_catalog.setval('geral.tb_recurso_int_recurso_id_seq', 114, true);


--
-- TOC entry 2994 (class 0 OID 0)
-- Dependencies: 216
-- Name: tb_tce_unidade_int_unidade_tce_id_seq; Type: SEQUENCE SET; Schema: geral; Owner: postgres
--

SELECT pg_catalog.setval('geral.tb_tce_unidade_int_unidade_tce_id_seq', 228, true);


--
-- TOC entry 2995 (class 0 OID 0)
-- Dependencies: 220
-- Name: tb_usuario_int_usuario_id_seq; Type: SEQUENCE SET; Schema: geral; Owner: postgres
--

SELECT pg_catalog.setval('geral.tb_usuario_int_usuario_id_seq', 369, true);


--
-- TOC entry 2996 (class 0 OID 0)
-- Dependencies: 222
-- Name: tb_usuario_mensagem_int_usuario_mensagem_id_seq; Type: SEQUENCE SET; Schema: geral; Owner: postgres
--

SELECT pg_catalog.setval('geral.tb_usuario_mensagem_int_usuario_mensagem_id_seq', 50, true);


--
-- TOC entry 2795 (class 2606 OID 24686)
-- Name: tb_usuario geral_tb_usuario_int_cpf_unique; Type: CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_usuario
    ADD CONSTRAINT geral_tb_usuario_int_cpf_unique UNIQUE (int_cpf);


--
-- TOC entry 2797 (class 2606 OID 24688)
-- Name: tb_usuario geral_tb_usuario_str_email_unique; Type: CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_usuario
    ADD CONSTRAINT geral_tb_usuario_str_email_unique UNIQUE (str_email);


--
-- TOC entry 2799 (class 2606 OID 24690)
-- Name: tb_usuario geral_tb_usuario_str_usuario_unique; Type: CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_usuario
    ADD CONSTRAINT geral_tb_usuario_str_usuario_unique UNIQUE (str_usuario);


--
-- TOC entry 2790 (class 2606 OID 24692)
-- Name: tb_tce_unidade int_unidade_tce_id_key; Type: CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_tce_unidade
    ADD CONSTRAINT int_unidade_tce_id_key PRIMARY KEY (int_unidade_tce_id);


--
-- TOC entry 2776 (class 2606 OID 24694)
-- Name: tb_anexo pk_anexo; Type: CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_anexo
    ADD CONSTRAINT pk_anexo PRIMARY KEY (int_anexo_id);


--
-- TOC entry 2778 (class 2606 OID 24696)
-- Name: tb_categoria_recurso tb_categoria_recurso_pkey; Type: CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_categoria_recurso
    ADD CONSTRAINT tb_categoria_recurso_pkey PRIMARY KEY (int_categoria_recurso_id);


--
-- TOC entry 2780 (class 2606 OID 24698)
-- Name: tb_mensagens tb_mensagens_pkey; Type: CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_mensagens
    ADD CONSTRAINT tb_mensagens_pkey PRIMARY KEY (int_mensagem_id);


--
-- TOC entry 2782 (class 2606 OID 24700)
-- Name: tb_modulo tb_modulo_pkey; Type: CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_modulo
    ADD CONSTRAINT tb_modulo_pkey PRIMARY KEY (int_modulo_id);


--
-- TOC entry 2784 (class 2606 OID 24702)
-- Name: tb_perfil tb_perfil_pkey; Type: CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_perfil
    ADD CONSTRAINT tb_perfil_pkey PRIMARY KEY (int_perfil_id);


--
-- TOC entry 2786 (class 2606 OID 24704)
-- Name: tb_permissao tb_permissao_pkey; Type: CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_permissao
    ADD CONSTRAINT tb_permissao_pkey PRIMARY KEY (int_permissao_id);


--
-- TOC entry 2788 (class 2606 OID 24706)
-- Name: tb_recurso tb_recurso_pkey; Type: CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_recurso
    ADD CONSTRAINT tb_recurso_pkey PRIMARY KEY (int_recurso_id);


--
-- TOC entry 2793 (class 2606 OID 24708)
-- Name: tb_unidade tb_unidade_pkey; Type: CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_unidade
    ADD CONSTRAINT tb_unidade_pkey PRIMARY KEY (int_unidade_id);


--
-- TOC entry 2803 (class 2606 OID 24710)
-- Name: tb_usuario_anexo tb_usuario_anexo_pkey; Type: CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_usuario_anexo
    ADD CONSTRAINT tb_usuario_anexo_pkey PRIMARY KEY (int_usuario_id, int_anexo_id);


--
-- TOC entry 2805 (class 2606 OID 24712)
-- Name: tb_usuario_mensagem tb_usuario_mensagem_pkey; Type: CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_usuario_mensagem
    ADD CONSTRAINT tb_usuario_mensagem_pkey PRIMARY KEY (int_usuario_mensagem_id);


--
-- TOC entry 2801 (class 2606 OID 24714)
-- Name: tb_usuario tb_usuario_pkey; Type: CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_usuario
    ADD CONSTRAINT tb_usuario_pkey PRIMARY KEY (int_usuario_id);


--
-- TOC entry 2807 (class 2606 OID 24716)
-- Name: tb_usuario_unidade tb_usuario_unidade_pkey; Type: CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_usuario_unidade
    ADD CONSTRAINT tb_usuario_unidade_pkey PRIMARY KEY (int_usuario_id, int_unidade_id);


--
-- TOC entry 2791 (class 1259 OID 24717)
-- Name: geral_tb_unidade_int_unidade_id_index; Type: INDEX; Schema: geral; Owner: postgres
--

CREATE INDEX geral_tb_unidade_int_unidade_id_index ON geral.tb_unidade USING btree (int_unidade_id);


--
-- TOC entry 2808 (class 2606 OID 24718)
-- Name: tb_perfil geral_tb_perfil_int_perfil_modulo_id_foreign; Type: FK CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_perfil
    ADD CONSTRAINT geral_tb_perfil_int_perfil_modulo_id_foreign FOREIGN KEY (int_perfil_modulo_id) REFERENCES geral.tb_modulo(int_modulo_id);


--
-- TOC entry 2809 (class 2606 OID 24723)
-- Name: tb_perfil_permissao geral_tb_perfil_permissao_int_perfil_permissao_perfil_id_foreig; Type: FK CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_perfil_permissao
    ADD CONSTRAINT geral_tb_perfil_permissao_int_perfil_permissao_perfil_id_foreig FOREIGN KEY (int_perfil_permissao_perfil_id) REFERENCES geral.tb_perfil(int_perfil_id);


--
-- TOC entry 2810 (class 2606 OID 24728)
-- Name: tb_perfil_permissao geral_tb_perfil_permissao_int_perfil_permissao_permissao_id_for; Type: FK CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_perfil_permissao
    ADD CONSTRAINT geral_tb_perfil_permissao_int_perfil_permissao_permissao_id_for FOREIGN KEY (int_perfil_permissao_permissao_id) REFERENCES geral.tb_permissao(int_permissao_id);


--
-- TOC entry 2811 (class 2606 OID 24733)
-- Name: tb_perfil_usuario geral_tb_perfil_usuario_int_perfil_usuario_perfil_id_foreign; Type: FK CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_perfil_usuario
    ADD CONSTRAINT geral_tb_perfil_usuario_int_perfil_usuario_perfil_id_foreign FOREIGN KEY (int_perfil_usuario_perfil_id) REFERENCES geral.tb_perfil(int_perfil_id);


--
-- TOC entry 2812 (class 2606 OID 24738)
-- Name: tb_perfil_usuario geral_tb_perfil_usuario_int_perfil_usuario_usuario_id_foreign; Type: FK CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_perfil_usuario
    ADD CONSTRAINT geral_tb_perfil_usuario_int_perfil_usuario_usuario_id_foreign FOREIGN KEY (int_perfil_usuario_usuario_id) REFERENCES geral.tb_usuario(int_usuario_id);


--
-- TOC entry 2813 (class 2606 OID 24743)
-- Name: tb_permissao geral_tb_permissao_int_permissao_recurso_id_foreign; Type: FK CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_permissao
    ADD CONSTRAINT geral_tb_permissao_int_permissao_recurso_id_foreign FOREIGN KEY (int_permissao_recurso_id) REFERENCES geral.tb_recurso(int_recurso_id);


--
-- TOC entry 2814 (class 2606 OID 24748)
-- Name: tb_recurso geral_tb_recurso_int_categoria_recurso_id_foreign; Type: FK CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_recurso
    ADD CONSTRAINT geral_tb_recurso_int_categoria_recurso_id_foreign FOREIGN KEY (int_categoria_recurso_id) REFERENCES geral.tb_categoria_recurso(int_categoria_recurso_id);


--
-- TOC entry 2815 (class 2606 OID 24753)
-- Name: tb_recurso geral_tb_recurso_int_modulo_id_foreign; Type: FK CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_recurso
    ADD CONSTRAINT geral_tb_recurso_int_modulo_id_foreign FOREIGN KEY (int_modulo_id) REFERENCES geral.tb_modulo(int_modulo_id);


--
-- TOC entry 2816 (class 2606 OID 24758)
-- Name: tb_usuario_anexo geral_tb_usuario_anexo_int_usuario_id_foreign; Type: FK CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_usuario_anexo
    ADD CONSTRAINT geral_tb_usuario_anexo_int_usuario_id_foreign FOREIGN KEY (int_usuario_id) REFERENCES geral.tb_usuario(int_usuario_id);


--
-- TOC entry 2817 (class 2606 OID 24763)
-- Name: tb_usuario_anexo geral_tb_usuario_unidade_int_anexo_id_foreign; Type: FK CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_usuario_anexo
    ADD CONSTRAINT geral_tb_usuario_unidade_int_anexo_id_foreign FOREIGN KEY (int_anexo_id) REFERENCES geral.tb_anexo(int_anexo_id);


--
-- TOC entry 2818 (class 2606 OID 24768)
-- Name: tb_usuario_unidade geral_tb_usuario_unidade_int_usuario_id_foreign; Type: FK CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.tb_usuario_unidade
    ADD CONSTRAINT geral_tb_usuario_unidade_int_usuario_id_foreign FOREIGN KEY (int_usuario_id) REFERENCES geral.tb_usuario(int_usuario_id);


-- Completed on 2020-01-20 23:39:55

--
-- PostgreSQL database dump complete
--

