--
-- PostgreSQL database dump
--

CREATE SCHEMA geral;


ALTER SCHEMA geral OWNER TO postgres;

--
-- TOC entry 2972 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA geral; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA geral IS 'Schema das tabelas gerais do sistema admin';


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

COMMENT ON COLUMN geral.tb_feriados.int_cod_municipio IS ' --se estadual ou federal ?? nulo';


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

INSERT INTO geral.tb_anexo VALUES (1, '201810031538588674.pdf', 'application/pdf', '2018-10-03 14:44:34', '2018-10-03 14:44:34', '8?? F??rum de Profissionais PHP do Estado do Maranh??o.pdf');
INSERT INTO geral.tb_anexo VALUES (2, '201810031538588779.pdf', 'application/pdf', '2018-10-03 14:46:19', '2018-10-03 14:46:19', '3Contrato-Cria????o-de-logotipo.pdf');


--
-- TOC entry 2942 (class 0 OID 24586)
-- Dependencies: 199
-- Data for Name: tb_categoria_recurso; Type: TABLE DATA; Schema: geral; Owner: postgres
--

INSERT INTO geral.tb_categoria_recurso VALUES (1, 'Cadastros', 'fa-cog', 1, true, '2015-05-20 11:30:00', '2015-05-20 11:30:00');
INSERT INTO geral.tb_categoria_recurso VALUES (2, 'Relat??rios', 'fa-cog ipsum', 2, true, '2015-05-20 11:30:00', '2015-05-20 11:30:00');
INSERT INTO geral.tb_categoria_recurso VALUES (3, 'Consultas', 'fa-eye', 3, true, '2015-07-07 16:59:45', '2015-07-07 16:59:45');
INSERT INTO geral.tb_categoria_recurso VALUES (4, 'Dashboard', 'fa-home', 0, true, '2015-07-08 14:40:00', '2015-07-08 14:40:00');
INSERT INTO geral.tb_categoria_recurso VALUES (5, 'Categoria Invis??vel', 'fa-hidden', 100, false, '2015-07-30 12:49:23', '2015-07-30 12:49:23');
INSERT INTO geral.tb_categoria_recurso VALUES (6, 'Manual', 'fa-file-pdf-o', 4, true, '2016-01-28 10:26:49', '2016-01-28 10:26:49');
INSERT INTO geral.tb_categoria_recurso VALUES (7, 'Atividade', 'fa-exchange', 1, true, '2018-09-21 14:49:16', '2018-09-21 14:49:16');
INSERT INTO geral.tb_categoria_recurso VALUES (12, 'Configura????es', 'gear', 20, true, '2020-01-31 17:45:59', '2020-01-31 17:45:59');
INSERT INTO geral.tb_categoria_recurso VALUES (13, 'Movimenta????es', 'home', 5, true, '2020-01-31 19:11:17', '2020-01-31 19:11:17');


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



--
-- TOC entry 2948 (class 0 OID 24605)
-- Dependencies: 205
-- Data for Name: tb_modulo; Type: TABLE DATA; Schema: geral; Owner: postgres
--

INSERT INTO geral.tb_modulo VALUES (1, 'admin', 'Admin', 'fa-cog', true, '2015-05-20 11:30:00', '2015-05-20 11:30:00', 'Admin');
INSERT INTO geral.tb_modulo VALUES (15, 'log-viewer', 'Logs do App', 'fa-archive', true, '2019-06-05 14:55:25', '2019-06-05 14:55:25', 'AppLogs');
INSERT INTO geral.tb_modulo VALUES (18, 'pnae', 'Controle de alimenta????o escolar', 'home', true, '2020-01-31 17:30:21', '2020-01-31 17:30:21', 'Pnae');


--
-- TOC entry 2950 (class 0 OID 24614)
-- Dependencies: 207
-- Data for Name: tb_perfil; Type: TABLE DATA; Schema: geral; Owner: postgres
--

INSERT INTO geral.tb_perfil VALUES (1, 'Administrador', 'Administrador do m??dulo ADMIN.', '2015-07-07 18:34:55', '2015-07-07 18:34:55', 1);
INSERT INTO geral.tb_perfil VALUES (35, 'Administrador', 'Administrador de Logs', '2019-06-05 14:59:28', '2019-06-05 14:59:28', 15);
INSERT INTO geral.tb_perfil VALUES (44, 'Administrador', 'Administrador do Pnae', '2020-01-31 21:12:29', '2020-01-31 21:12:29', 18);


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
INSERT INTO geral.tb_perfil_permissao VALUES (44, 586);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 587);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 588);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 589);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 590);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 591);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 592);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 593);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 594);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 595);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 633);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 634);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 635);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 636);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 637);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 638);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 639);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 640);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 682);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 683);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 684);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 685);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 686);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 687);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 688);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 689);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 724);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 725);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 596);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 597);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 641);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 642);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 643);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 644);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 645);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 646);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 647);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 648);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 690);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 691);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 692);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 693);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 694);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 695);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 696);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 697);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 726);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 727);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 728);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 598);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 599);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 600);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 601);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 602);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 603);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 604);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 605);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 606);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 698);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 699);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 700);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 701);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 702);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 703);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 704);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 705);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 649);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 650);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 651);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 652);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 653);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 654);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 655);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 656);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 729);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 730);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 731);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 657);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 658);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 92);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 659);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 660);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 661);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 662);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 663);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 664);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 665);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 706);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 707);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 708);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 709);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 710);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 711);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 712);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 713);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 617);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 618);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 619);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 620);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 621);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 622);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 623);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 624);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 666);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 667);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 668);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 669);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 116);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 670);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 119);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 121);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 122);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 123);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 124);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 125);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 671);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 672);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 673);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 714);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 715);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 716);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 717);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 718);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 719);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 720);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 721);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 674);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 675);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 676);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 677);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 678);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 679);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 680);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 681);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 722);
INSERT INTO geral.tb_perfil_permissao VALUES (44, 723);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 384);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 385);
INSERT INTO geral.tb_perfil_permissao VALUES (1, 383);
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

INSERT INTO geral.tb_perfil_usuario VALUES (357, 1, '2020-01-31 21:35:42', '2020-01-31 21:35:42');
INSERT INTO geral.tb_perfil_usuario VALUES (369, 1, '2020-01-31 21:35:58', '2020-01-31 21:35:58');
INSERT INTO geral.tb_perfil_usuario VALUES (357, 35, '2020-01-31 21:35:48', '2020-01-31 21:35:48');
INSERT INTO geral.tb_perfil_usuario VALUES (369, 35, '2020-01-31 21:36:05', '2020-01-31 21:36:05');
INSERT INTO geral.tb_perfil_usuario VALUES (208, 1, '2018-04-30 14:12:46', '2018-04-30 14:12:46');
INSERT INTO geral.tb_perfil_usuario VALUES (210, 1, '2020-01-19 08:51:02', '2020-01-19 08:51:02');
INSERT INTO geral.tb_perfil_usuario VALUES (357, 44, '2020-01-31 21:35:53', '2020-01-31 21:35:53');
INSERT INTO geral.tb_perfil_usuario VALUES (369, 44, '2020-01-31 21:36:11', '2020-01-31 21:36:11');
INSERT INTO geral.tb_perfil_usuario VALUES (210, 35, '2019-06-05 15:00:43', '2019-06-05 15:00:43');


--
-- TOC entry 2954 (class 0 OID 24625)
-- Dependencies: 211
-- Data for Name: tb_permissao; Type: TABLE DATA; Schema: geral; Owner: postgres
--

INSERT INTO geral.tb_permissao VALUES (1, 'index', 'P??gina inicial de m??dulos.', '2015-07-07 15:23:47', '2015-07-07 15:23:47', 1);
INSERT INTO geral.tb_permissao VALUES (2, 'create', 'Cria????o de novo m??dulo.', '2015-07-07 15:24:36', '2015-07-07 15:24:36', 1);
INSERT INTO geral.tb_permissao VALUES (3, 'delete', 'Deletar m??dulo.', '2015-07-07 15:24:53', '2015-07-07 15:24:53', 1);
INSERT INTO geral.tb_permissao VALUES (4, 'index', 'P??gina inicial de usu??rios.', '2015-07-07 15:37:16', '2015-07-07 15:37:16', 2);
INSERT INTO geral.tb_permissao VALUES (5, 'create', 'P??gina de cadastro de usu??rios.', '2015-07-07 15:37:54', '2015-07-07 15:37:54', 2);
INSERT INTO geral.tb_permissao VALUES (6, 'edit', 'P??gina para editar usu??rios.', '2015-07-07 15:38:40', '2015-07-07 15:38:40', 2);
INSERT INTO geral.tb_permissao VALUES (7, 'delete', 'Deletar usu??rio.', '2015-07-07 15:39:12', '2015-07-07 15:39:12', 2);
INSERT INTO geral.tb_permissao VALUES (8, 'index', 'P??gina inicial de categorias recursos.', '2015-07-07 15:47:18', '2015-07-07 15:47:18', 3);
INSERT INTO geral.tb_permissao VALUES (9, 'create', 'Cria????o de nova categoria recurso.', '2015-07-07 15:48:18', '2015-07-07 15:48:18', 3);
INSERT INTO geral.tb_permissao VALUES (10, 'delete', 'Deletar categoria.', '2015-07-07 15:48:41', '2015-07-07 15:48:41', 3);
INSERT INTO geral.tb_permissao VALUES (11, 'index', 'P??gina inicial de recursos.', '2015-07-07 16:03:14', '2015-07-07 16:03:14', 4);
INSERT INTO geral.tb_permissao VALUES (12, 'create', 'Cria????o de novo recurso.', '2015-07-07 16:03:39', '2015-07-07 16:03:39', 4);
INSERT INTO geral.tb_permissao VALUES (13, 'delete', 'Deletar recurso.', '2015-07-07 16:04:12', '2015-07-07 16:04:12', 4);
INSERT INTO geral.tb_permissao VALUES (14, 'index', 'P??gina inicial de permiss??es.', '2015-07-07 16:09:25', '2015-07-07 16:09:25', 5);
INSERT INTO geral.tb_permissao VALUES (16, 'create', 'Cria????o de nova permiss??o.', '2015-07-07 16:10:13', '2015-07-07 16:10:13', 5);
INSERT INTO geral.tb_permissao VALUES (17, 'delete', 'Deletar permiss??o.', '2015-07-07 16:10:32', '2015-07-07 16:10:32', 5);
INSERT INTO geral.tb_permissao VALUES (18, 'index', 'P??gina inicial de perfis.', '2015-07-07 16:22:45', '2015-07-07 16:22:45', 6);
INSERT INTO geral.tb_permissao VALUES (19, 'create', 'Cria????o de novo perfil.', '2015-07-07 16:23:14', '2015-07-07 16:23:14', 6);
INSERT INTO geral.tb_permissao VALUES (20, 'delete', 'Deletar perfil.', '2015-07-07 16:23:36', '2015-07-07 16:23:36', 6);
INSERT INTO geral.tb_permissao VALUES (21, 'index', 'P??gina inicial de perfis permiss??es.', '2015-07-07 16:31:01', '2015-07-07 16:31:01', 7);
INSERT INTO geral.tb_permissao VALUES (22, 'atribuirpermissoes', 'P??gina para atribuir permiss??es a um perfil.', '2015-07-07 16:32:01', '2015-07-07 16:32:01', 7);
INSERT INTO geral.tb_permissao VALUES (23, 'index', 'P??gina inicial de perfis usu??rios.', '2015-07-07 16:39:47', '2015-07-07 16:39:47', 8);
INSERT INTO geral.tb_permissao VALUES (24, 'atribuirperfis', 'P??gina para atribuir perfis a um usu??rio.', '2015-07-07 16:40:56', '2015-07-07 16:40:56', 8);
INSERT INTO geral.tb_permissao VALUES (26, 'desvincularperfil', 'Deletar um perfil de um usu??rio.', '2015-07-07 16:42:30', '2015-07-07 16:42:30', 8);
INSERT INTO geral.tb_permissao VALUES (27, 'atribuir', 'Atribuir um perfil a um usu??rio', '2015-07-07 16:43:28', '2015-07-07 16:43:28', 8);
INSERT INTO geral.tb_permissao VALUES (28, 'index', 'P??gina inicial de admin.', '2015-07-07 16:52:21', '2015-07-07 16:52:21', 9);
INSERT INTO geral.tb_permissao VALUES (586, 'index', 'p??gina inicial', '2020-01-31 19:01:11', '2020-01-31 19:01:11', 115);
INSERT INTO geral.tb_permissao VALUES (587, 'recuperar-projeto-produtos', 'recupera projetos por produtos', '2020-01-31 19:01:12', '2020-01-31 19:01:12', 115);
INSERT INTO geral.tb_permissao VALUES (588, 'recuperar-todos', 'recupera todos os projetos', '2020-01-31 19:01:12', '2020-01-31 19:01:12', 115);
INSERT INTO geral.tb_permissao VALUES (589, 'recuperar-paginado', 'recupera paginado', '2020-01-31 19:01:12', '2020-01-31 19:01:12', 115);
INSERT INTO geral.tb_permissao VALUES (590, 'cadastrar', 'p??gina de cadastro do projeto', '2020-01-31 19:01:12', '2020-01-31 19:01:12', 115);
INSERT INTO geral.tb_permissao VALUES (591, 'editar', 'edita projeto', '2020-01-31 19:01:12', '2020-01-31 19:01:12', 115);
INSERT INTO geral.tb_permissao VALUES (592, 'salvar', 'salva projeto', '2020-01-31 19:01:12', '2020-01-31 19:01:12', 115);
INSERT INTO geral.tb_permissao VALUES (593, 'deletar', 'deleta o projeto', '2020-01-31 19:01:12', '2020-01-31 19:01:12', 115);
INSERT INTO geral.tb_permissao VALUES (594, 'imprimir', 'imprime o projeto', '2020-01-31 19:01:12', '2020-01-31 19:01:12', 115);
INSERT INTO geral.tb_permissao VALUES (595, 'levantamento', 'levantamento do projeto', '2020-01-31 19:01:12', '2020-01-31 19:01:12', 115);
INSERT INTO geral.tb_permissao VALUES (633, 'index', 'p??gina inicial', '2020-01-31 19:35:37', '2020-01-31 19:35:37', 123);
INSERT INTO geral.tb_permissao VALUES (634, 'recuperar', 'recupera um', '2020-01-31 19:35:37', '2020-01-31 19:35:37', 123);
INSERT INTO geral.tb_permissao VALUES (635, 'recuperar-todos', 'recupera todos', '2020-01-31 19:35:37', '2020-01-31 19:35:37', 123);
INSERT INTO geral.tb_permissao VALUES (636, 'recuperar-paginado', 'recupera paginado', '2020-01-31 19:35:37', '2020-01-31 19:35:37', 123);
INSERT INTO geral.tb_permissao VALUES (637, 'cadastrar', 'p??gina de cadastro', '2020-01-31 19:35:37', '2020-01-31 19:35:37', 123);
INSERT INTO geral.tb_permissao VALUES (638, 'editar', 'edita o registro', '2020-01-31 19:35:37', '2020-01-31 19:35:37', 123);
INSERT INTO geral.tb_permissao VALUES (639, 'salvar', 'salva o registro', '2020-01-31 19:35:37', '2020-01-31 19:35:37', 123);
INSERT INTO geral.tb_permissao VALUES (640, 'deletar', 'deleta o registro', '2020-01-31 19:35:37', '2020-01-31 19:35:37', 123);
INSERT INTO geral.tb_permissao VALUES (682, 'index', 'p??gina inicial', '2020-01-31 19:41:01', '2020-01-31 19:41:01', 125);
INSERT INTO geral.tb_permissao VALUES (683, 'recuperar', 'recupera um', '2020-01-31 19:41:01', '2020-01-31 19:41:01', 125);
INSERT INTO geral.tb_permissao VALUES (684, 'recuperar-todos', 'recupera todos', '2020-01-31 19:41:01', '2020-01-31 19:41:01', 125);
INSERT INTO geral.tb_permissao VALUES (685, 'recuperar-paginado', 'recupera paginado', '2020-01-31 19:41:01', '2020-01-31 19:41:01', 125);
INSERT INTO geral.tb_permissao VALUES (686, 'cadastrar', 'p??gina de cadastro', '2020-01-31 19:41:01', '2020-01-31 19:41:01', 125);
INSERT INTO geral.tb_permissao VALUES (687, 'editar', 'edita o registro', '2020-01-31 19:41:01', '2020-01-31 19:41:01', 125);
INSERT INTO geral.tb_permissao VALUES (688, 'salvar', 'salva o registro', '2020-01-31 19:41:01', '2020-01-31 19:41:01', 125);
INSERT INTO geral.tb_permissao VALUES (689, 'deletar', 'deleta o registro', '2020-01-31 19:41:01', '2020-01-31 19:41:01', 125);
INSERT INTO geral.tb_permissao VALUES (724, 'index', 'p??gina inicial do relat??rio', '2020-01-31 21:00:20', '2020-01-31 21:00:20', 121);
INSERT INTO geral.tb_permissao VALUES (725, 'filtrar', 'filtro', '2020-01-31 21:00:20', '2020-01-31 21:00:20', 121);
INSERT INTO geral.tb_permissao VALUES (92, 'perfis', 'Atribuir perfis ao usuario', '2015-11-04 14:55:20', '2015-11-04 14:55:20', 8);
INSERT INTO geral.tb_permissao VALUES (102, 'index', 'Index', '2015-11-16 18:44:11', '2015-11-16 18:44:11', 28);
INSERT INTO geral.tb_permissao VALUES (103, 'atribuirusuarios', 'Vincular usu??rio a uma unidade', '2015-11-16 18:44:37', '2015-11-16 18:44:37', 28);
INSERT INTO geral.tb_permissao VALUES (104, 'edit', 'Editar Unidade', '2015-11-26 10:44:11', '2015-11-26 10:44:11', 28);
INSERT INTO geral.tb_permissao VALUES (116, 'generatenewpassword', 'Gerador de nova senha automatica.', '2016-03-08 17:40:28', '2016-03-08 17:40:28', 2);
INSERT INTO geral.tb_permissao VALUES (117, 'import', 'Importe de usu??rios', '2016-03-15 11:45:29', '2016-03-15 11:45:29', 1);
INSERT INTO geral.tb_permissao VALUES (596, 'salvar', 'Salva vinculo', '2020-01-31 19:05:28', '2020-01-31 19:05:28', 131);
INSERT INTO geral.tb_permissao VALUES (119, 'messagereaded', 'Realiza processo de marcar mensagem de  notifica????es de altera????o do sistema como lido pelo usu??rio', '2016-05-09 17:06:09', '2016-05-09 17:06:09', 2);
INSERT INTO geral.tb_permissao VALUES (120, 'notification', 'Area de listagem das notifica????es de altera????es realizadas no sistema.', '2016-05-10 16:47:32', '2016-05-10 16:47:32', 1);
INSERT INTO geral.tb_permissao VALUES (121, 'create', 'Cria????o de Mensagens de Notifica????es de Altera????es no Sistema.', '2016-05-13 10:47:18', '2016-05-13 10:47:18', 32);
INSERT INTO geral.tb_permissao VALUES (122, 'index', 'Listagem das mensagens de Notifica????es do Sistema', '2016-05-13 12:17:19', '2016-05-13 12:17:19', 32);
INSERT INTO geral.tb_permissao VALUES (123, 'edit', 'Edi????o de Mensagens de Notifica????o', '2016-05-13 15:17:04', '2016-05-13 15:17:04', 32);
INSERT INTO geral.tb_permissao VALUES (124, 'view', 'Visualiza????o de Mensagens de Notifica????o', '2016-05-13 15:17:26', '2016-05-13 15:17:26', 32);
INSERT INTO geral.tb_permissao VALUES (125, 'delete', 'Remove uma notifica????o ', '2016-05-13 17:28:10', '2016-05-13 17:28:10', 32);
INSERT INTO geral.tb_permissao VALUES (597, 'deletar', 'deleta vinculo', '2020-01-31 19:05:28', '2020-01-31 19:05:28', 131);
INSERT INTO geral.tb_permissao VALUES (641, 'index', 'p??gina inicial', '2020-01-31 19:36:30', '2020-01-31 19:36:30', 133);
INSERT INTO geral.tb_permissao VALUES (642, 'recuperar', 'recupera um', '2020-01-31 19:36:30', '2020-01-31 19:36:30', 133);
INSERT INTO geral.tb_permissao VALUES (643, 'recuperar-todos', 'recupera todos', '2020-01-31 19:36:30', '2020-01-31 19:36:30', 133);
INSERT INTO geral.tb_permissao VALUES (644, 'recuperar-paginado', 'recupera paginado', '2020-01-31 19:36:30', '2020-01-31 19:36:30', 133);
INSERT INTO geral.tb_permissao VALUES (645, 'cadastrar', 'p??gina de cadastro', '2020-01-31 19:36:30', '2020-01-31 19:36:30', 133);
INSERT INTO geral.tb_permissao VALUES (646, 'editar', 'edita o registro', '2020-01-31 19:36:30', '2020-01-31 19:36:30', 133);
INSERT INTO geral.tb_permissao VALUES (647, 'salvar', 'salva o registro', '2020-01-31 19:36:30', '2020-01-31 19:36:30', 133);
INSERT INTO geral.tb_permissao VALUES (648, 'deletar', 'deleta o registro', '2020-01-31 19:36:30', '2020-01-31 19:36:30', 133);
INSERT INTO geral.tb_permissao VALUES (690, 'index', 'p??gina inicial', '2020-01-31 19:41:37', '2020-01-31 19:41:37', 127);
INSERT INTO geral.tb_permissao VALUES (691, 'recuperar', 'recupera um', '2020-01-31 19:41:37', '2020-01-31 19:41:37', 127);
INSERT INTO geral.tb_permissao VALUES (692, 'recuperar-todos', 'recupera todos', '2020-01-31 19:41:37', '2020-01-31 19:41:37', 127);
INSERT INTO geral.tb_permissao VALUES (693, 'recuperar-paginado', 'recupera paginado', '2020-01-31 19:41:37', '2020-01-31 19:41:37', 127);
INSERT INTO geral.tb_permissao VALUES (694, 'cadastrar', 'p??gina de cadastro', '2020-01-31 19:41:37', '2020-01-31 19:41:37', 127);
INSERT INTO geral.tb_permissao VALUES (695, 'editar', 'edita o registro', '2020-01-31 19:41:37', '2020-01-31 19:41:37', 127);
INSERT INTO geral.tb_permissao VALUES (696, 'salvar', 'salva o registro', '2020-01-31 19:41:37', '2020-01-31 19:41:37', 127);
INSERT INTO geral.tb_permissao VALUES (697, 'deletar', 'deleta o registro', '2020-01-31 19:41:37', '2020-01-31 19:41:37', 127);
INSERT INTO geral.tb_permissao VALUES (726, 'recuperar', 'recuperar um', '2020-01-31 21:04:55', '2020-01-31 21:04:55', 134);
INSERT INTO geral.tb_permissao VALUES (727, 'recuperar-por-cidade', 'recuperar por cidade', '2020-01-31 21:04:55', '2020-01-31 21:04:55', 134);
INSERT INTO geral.tb_permissao VALUES (728, 'recuperar-todos', 'recuperar-todos', '2020-01-31 21:04:55', '2020-01-31 21:04:55', 134);
INSERT INTO geral.tb_permissao VALUES (598, 'index', 'p??gina inicial', '2020-01-31 19:20:20', '2020-01-31 19:20:20', 132);
INSERT INTO geral.tb_permissao VALUES (599, 'recuperar', 'recupera entrada', '2020-01-31 19:20:20', '2020-01-31 19:20:20', 132);
INSERT INTO geral.tb_permissao VALUES (600, 'recuperar-todos', 'recupera todas as entradas', '2020-01-31 19:20:20', '2020-01-31 19:20:20', 132);
INSERT INTO geral.tb_permissao VALUES (601, 'recuperar-paginado', 'recupera paginado', '2020-01-31 19:20:20', '2020-01-31 19:20:20', 132);
INSERT INTO geral.tb_permissao VALUES (602, 'cadastrar', 'p??gina de registro', '2020-01-31 19:20:20', '2020-01-31 19:20:20', 132);
INSERT INTO geral.tb_permissao VALUES (603, 'editar', 'edita o registro', '2020-01-31 19:20:20', '2020-01-31 19:20:20', 132);
INSERT INTO geral.tb_permissao VALUES (604, 'salvar', 'salva o registro', '2020-01-31 19:20:20', '2020-01-31 19:20:20', 132);
INSERT INTO geral.tb_permissao VALUES (605, 'deletar', 'imprime o recibo', '2020-01-31 19:20:20', '2020-01-31 19:20:20', 132);
INSERT INTO geral.tb_permissao VALUES (606, 'imprimir-recibo', 'checa a quantidade de mercadoria entregue', '2020-01-31 19:20:20', '2020-01-31 19:20:20', 132);
INSERT INTO geral.tb_permissao VALUES (649, 'index', 'p??gina inicial', '2020-01-31 19:37:22', '2020-01-31 19:37:22', 117);
INSERT INTO geral.tb_permissao VALUES (650, 'recuperar', 'recupera um', '2020-01-31 19:37:22', '2020-01-31 19:37:22', 117);
INSERT INTO geral.tb_permissao VALUES (651, 'recuperar-todos', 'recupera todos', '2020-01-31 19:37:22', '2020-01-31 19:37:22', 117);
INSERT INTO geral.tb_permissao VALUES (652, 'recuperar-paginado', 'recupera paginado', '2020-01-31 19:37:22', '2020-01-31 19:37:22', 117);
INSERT INTO geral.tb_permissao VALUES (653, 'cadastrar', 'p??gina de cadastro', '2020-01-31 19:37:22', '2020-01-31 19:37:22', 117);
INSERT INTO geral.tb_permissao VALUES (654, 'editar', 'edita o registro', '2020-01-31 19:37:22', '2020-01-31 19:37:22', 117);
INSERT INTO geral.tb_permissao VALUES (655, 'salvar', 'salva o registro', '2020-01-31 19:37:22', '2020-01-31 19:37:22', 117);
INSERT INTO geral.tb_permissao VALUES (656, 'deletar', 'deleta o registro', '2020-01-31 19:37:22', '2020-01-31 19:37:22', 117);
INSERT INTO geral.tb_permissao VALUES (698, 'index', 'p??gina inicial', '2020-01-31 19:41:54', '2020-01-31 19:41:54', 129);
INSERT INTO geral.tb_permissao VALUES (699, 'recuperar', 'recupera um', '2020-01-31 19:41:54', '2020-01-31 19:41:54', 129);
INSERT INTO geral.tb_permissao VALUES (700, 'recuperar-todos', 'recupera todos', '2020-01-31 19:41:54', '2020-01-31 19:41:54', 129);
INSERT INTO geral.tb_permissao VALUES (701, 'recuperar-paginado', 'recupera paginado', '2020-01-31 19:41:54', '2020-01-31 19:41:54', 129);
INSERT INTO geral.tb_permissao VALUES (702, 'cadastrar', 'p??gina de cadastro', '2020-01-31 19:41:54', '2020-01-31 19:41:54', 129);
INSERT INTO geral.tb_permissao VALUES (703, 'editar', 'edita o registro', '2020-01-31 19:41:54', '2020-01-31 19:41:54', 129);
INSERT INTO geral.tb_permissao VALUES (704, 'salvar', 'salva o registro', '2020-01-31 19:41:54', '2020-01-31 19:41:54', 129);
INSERT INTO geral.tb_permissao VALUES (705, 'deletar', 'deleta o registro', '2020-01-31 19:41:54', '2020-01-31 19:41:54', 129);
INSERT INTO geral.tb_permissao VALUES (729, 'recuperar', 'recuperar um', '2020-01-31 21:05:58', '2020-01-31 21:05:58', 135);
INSERT INTO geral.tb_permissao VALUES (730, 'recuperar-por-estado', 'recuperar por estado', '2020-01-31 21:05:58', '2020-01-31 21:05:58', 135);
INSERT INTO geral.tb_permissao VALUES (731, 'recuperar-todos', 'recuperar-todos', '2020-01-31 21:05:58', '2020-01-31 21:05:58', 135);
INSERT INTO geral.tb_permissao VALUES (615, 'imprimir-recibo', 'imprime o recibo', '2020-01-31 19:22:49', '2020-01-31 19:22:49', 32);
INSERT INTO geral.tb_permissao VALUES (616, 'check-qtd-entrada-mercadoria', 'checa a quantidade de mercadoria entregue', '2020-01-31 19:22:49', '2020-01-31 19:22:49', 32);
INSERT INTO geral.tb_permissao VALUES (657, 'index', 'p??gina inicial', '2020-01-31 19:38:30', '2020-01-31 19:38:30', 119);
INSERT INTO geral.tb_permissao VALUES (658, 'recuperar', 'recupera um', '2020-01-31 19:38:30', '2020-01-31 19:38:30', 119);
INSERT INTO geral.tb_permissao VALUES (659, 'recuperar-todos', 'recupera todos', '2020-01-31 19:38:30', '2020-01-31 19:38:30', 119);
INSERT INTO geral.tb_permissao VALUES (660, 'recuperar-paginado', 'recupera paginado', '2020-01-31 19:38:30', '2020-01-31 19:38:30', 119);
INSERT INTO geral.tb_permissao VALUES (661, 'cadastrar', 'p??gina de cadastro', '2020-01-31 19:38:30', '2020-01-31 19:38:30', 119);
INSERT INTO geral.tb_permissao VALUES (662, 'editar', 'edita o registro', '2020-01-31 19:38:30', '2020-01-31 19:38:30', 119);
INSERT INTO geral.tb_permissao VALUES (663, 'salvar', 'salva o registro', '2020-01-31 19:38:30', '2020-01-31 19:38:30', 119);
INSERT INTO geral.tb_permissao VALUES (664, 'deletar', 'deleta o registro', '2020-01-31 19:38:30', '2020-01-31 19:38:30', 119);
INSERT INTO geral.tb_permissao VALUES (665, 'check-qtd-produto-fornecido', 'checa a quantidade de produtos fornecidos', '2020-01-31 19:38:30', '2020-01-31 19:38:30', 119);
INSERT INTO geral.tb_permissao VALUES (706, 'index', 'p??gina inicial', '2020-01-31 19:44:42', '2020-01-31 19:44:42', 126);
INSERT INTO geral.tb_permissao VALUES (707, 'recuperar', 'recupera um', '2020-01-31 19:44:42', '2020-01-31 19:44:42', 126);
INSERT INTO geral.tb_permissao VALUES (708, 'recuperar-todos', 'recupera todos', '2020-01-31 19:44:42', '2020-01-31 19:44:42', 126);
INSERT INTO geral.tb_permissao VALUES (709, 'recuperar-paginado', 'recupera paginado', '2020-01-31 19:44:42', '2020-01-31 19:44:42', 126);
INSERT INTO geral.tb_permissao VALUES (710, 'cadastrar', 'p??gina de cadastro', '2020-01-31 19:44:42', '2020-01-31 19:44:42', 126);
INSERT INTO geral.tb_permissao VALUES (711, 'editar', 'edita o registro', '2020-01-31 19:44:42', '2020-01-31 19:44:42', 126);
INSERT INTO geral.tb_permissao VALUES (712, 'salvar', 'salva o registro', '2020-01-31 19:44:42', '2020-01-31 19:44:42', 126);
INSERT INTO geral.tb_permissao VALUES (713, 'deletar', 'deleta o registro', '2020-01-31 19:44:42', '2020-01-31 19:44:42', 126);
INSERT INTO geral.tb_permissao VALUES (384, 'atribuir', 'Atribuir Perfil', '2018-10-03 14:22:41', '2018-10-03 14:22:41', 2);
INSERT INTO geral.tb_permissao VALUES (385, 'desvincularperfil', 'Desvincular Perfil de usuario', '2018-10-03 14:23:08', '2018-10-03 14:23:08', 2);
INSERT INTO geral.tb_permissao VALUES (383, 'atribuirperfis', 'Atribuir Perfis ao Usuario', '2018-10-03 14:21:55', '2018-10-03 14:21:55', 2);
INSERT INTO geral.tb_permissao VALUES (499, 'index', 'p??gina inicial de logs', '2019-06-05 14:58:10', '2019-06-05 14:58:10', 101);
INSERT INTO geral.tb_permissao VALUES (617, 'index', 'p??gina inicial', '2020-01-31 19:28:27', '2020-01-31 19:28:27', 118);
INSERT INTO geral.tb_permissao VALUES (618, 'recuperar', 'recupera um', '2020-01-31 19:28:27', '2020-01-31 19:28:27', 118);
INSERT INTO geral.tb_permissao VALUES (619, 'recuperar-todos', 'recupera todos', '2020-01-31 19:28:27', '2020-01-31 19:28:27', 118);
INSERT INTO geral.tb_permissao VALUES (620, 'recuperar-paginado', 'recupera paginado', '2020-01-31 19:28:27', '2020-01-31 19:28:27', 118);
INSERT INTO geral.tb_permissao VALUES (621, 'cadastrar', 'p??gina de cadastro', '2020-01-31 19:28:27', '2020-01-31 19:28:27', 118);
INSERT INTO geral.tb_permissao VALUES (622, 'editar', 'edita o registro', '2020-01-31 19:28:27', '2020-01-31 19:28:27', 118);
INSERT INTO geral.tb_permissao VALUES (623, 'salvar', 'salva o registro', '2020-01-31 19:28:27', '2020-01-31 19:28:27', 118);
INSERT INTO geral.tb_permissao VALUES (624, 'deletar', 'deleta o registro', '2020-01-31 19:28:27', '2020-01-31 19:28:27', 118);
INSERT INTO geral.tb_permissao VALUES (666, 'index', 'p??gina inicial', '2020-01-31 19:39:21', '2020-01-31 19:39:21', 130);
INSERT INTO geral.tb_permissao VALUES (667, 'recuperar', 'recupera um', '2020-01-31 19:39:21', '2020-01-31 19:39:21', 130);
INSERT INTO geral.tb_permissao VALUES (668, 'recuperar-todos', 'recupera todos', '2020-01-31 19:39:21', '2020-01-31 19:39:21', 130);
INSERT INTO geral.tb_permissao VALUES (669, 'recuperar-paginado', 'recupera paginado', '2020-01-31 19:39:22', '2020-01-31 19:39:22', 130);
INSERT INTO geral.tb_permissao VALUES (670, 'cadastrar', 'p??gina de cadastro', '2020-01-31 19:39:22', '2020-01-31 19:39:22', 130);
INSERT INTO geral.tb_permissao VALUES (671, 'editar', 'edita o registro', '2020-01-31 19:39:22', '2020-01-31 19:39:22', 130);
INSERT INTO geral.tb_permissao VALUES (672, 'salvar', 'salva o registro', '2020-01-31 19:39:22', '2020-01-31 19:39:22', 130);
INSERT INTO geral.tb_permissao VALUES (673, 'deletar', 'deleta o registro', '2020-01-31 19:39:22', '2020-01-31 19:39:22', 130);
INSERT INTO geral.tb_permissao VALUES (714, 'index', 'p??gina inicial', '2020-01-31 19:45:33', '2020-01-31 19:45:33', 128);
INSERT INTO geral.tb_permissao VALUES (715, 'recuperar', 'recupera um', '2020-01-31 19:45:33', '2020-01-31 19:45:33', 128);
INSERT INTO geral.tb_permissao VALUES (716, 'recuperar-todos', 'recupera todos', '2020-01-31 19:45:33', '2020-01-31 19:45:33', 128);
INSERT INTO geral.tb_permissao VALUES (717, 'recuperar-paginado', 'recupera paginado', '2020-01-31 19:45:33', '2020-01-31 19:45:33', 128);
INSERT INTO geral.tb_permissao VALUES (718, 'cadastrar', 'p??gina de cadastro', '2020-01-31 19:45:33', '2020-01-31 19:45:33', 128);
INSERT INTO geral.tb_permissao VALUES (719, 'editar', 'edita o registro', '2020-01-31 19:45:33', '2020-01-31 19:45:33', 128);
INSERT INTO geral.tb_permissao VALUES (720, 'salvar', 'salva o registro', '2020-01-31 19:45:33', '2020-01-31 19:45:33', 128);
INSERT INTO geral.tb_permissao VALUES (721, 'deletar', 'deleta o registro', '2020-01-31 19:45:33', '2020-01-31 19:45:33', 128);
INSERT INTO geral.tb_permissao VALUES (479, 'index', 'p??gina inicial de migra????o', '2019-01-28 15:37:46', '2019-01-28 15:37:46', 93);
INSERT INTO geral.tb_permissao VALUES (480, 'migrar-modulo', 'Faz a migra????o de todas as permiss??es do m??dulo para outro banco', '2019-01-28 16:42:27', '2019-01-28 16:42:27', 93);
INSERT INTO geral.tb_permissao VALUES (496, 'index', 'p??gina inicial do sistema', '2019-05-24 15:55:46', '2019-05-24 15:55:46', 1);
INSERT INTO geral.tb_permissao VALUES (498, 'index', 'p??gina inicial de logs', '2019-06-05 14:57:34', '2019-06-05 14:57:34', 100);
INSERT INTO geral.tb_permissao VALUES (500, 'data', 'filtros de logs', '2019-06-05 14:58:51', '2019-06-05 14:58:51', 101);
INSERT INTO geral.tb_permissao VALUES (501, 'delete', 'Deletar Logs', '2019-06-05 14:59:07', '2019-06-05 14:59:07', 101);
INSERT INTO geral.tb_permissao VALUES (625, 'index', 'p??gina inicial', '2020-01-31 19:31:56', '2020-01-31 19:31:56', 32);
INSERT INTO geral.tb_permissao VALUES (626, 'recuperar', 'recupera um', '2020-01-31 19:31:56', '2020-01-31 19:31:56', 32);
INSERT INTO geral.tb_permissao VALUES (627, 'recuperar-todos', 'recupera todos', '2020-01-31 19:31:56', '2020-01-31 19:31:56', 32);
INSERT INTO geral.tb_permissao VALUES (628, 'recuperar-paginado', 'recupera paginado', '2020-01-31 19:31:56', '2020-01-31 19:31:56', 32);
INSERT INTO geral.tb_permissao VALUES (629, 'cadastrar', 'p??gina de cadastro', '2020-01-31 19:31:56', '2020-01-31 19:31:56', 32);
INSERT INTO geral.tb_permissao VALUES (630, 'editar', 'edita o registro', '2020-01-31 19:31:56', '2020-01-31 19:31:56', 32);
INSERT INTO geral.tb_permissao VALUES (631, 'salvar', 'salva o registro', '2020-01-31 19:31:57', '2020-01-31 19:31:57', 32);
INSERT INTO geral.tb_permissao VALUES (632, 'deletar', 'deleta o registro', '2020-01-31 19:31:57', '2020-01-31 19:31:57', 32);
INSERT INTO geral.tb_permissao VALUES (674, 'index', 'p??gina inicial', '2020-01-31 19:40:26', '2020-01-31 19:40:26', 124);
INSERT INTO geral.tb_permissao VALUES (675, 'recuperar', 'recupera um', '2020-01-31 19:40:26', '2020-01-31 19:40:26', 124);
INSERT INTO geral.tb_permissao VALUES (676, 'recuperar-todos', 'recupera todos', '2020-01-31 19:40:26', '2020-01-31 19:40:26', 124);
INSERT INTO geral.tb_permissao VALUES (677, 'recuperar-paginado', 'recupera paginado', '2020-01-31 19:40:26', '2020-01-31 19:40:26', 124);
INSERT INTO geral.tb_permissao VALUES (678, 'cadastrar', 'p??gina de cadastro', '2020-01-31 19:40:26', '2020-01-31 19:40:26', 124);
INSERT INTO geral.tb_permissao VALUES (679, 'editar', 'edita o registro', '2020-01-31 19:40:26', '2020-01-31 19:40:26', 124);
INSERT INTO geral.tb_permissao VALUES (680, 'salvar', 'salva o registro', '2020-01-31 19:40:26', '2020-01-31 19:40:26', 124);
INSERT INTO geral.tb_permissao VALUES (681, 'deletar', 'deleta o registro', '2020-01-31 19:40:26', '2020-01-31 19:40:26', 124);
INSERT INTO geral.tb_permissao VALUES (722, 'index', 'p??gina inicial do relat??rio', '2020-01-31 20:59:42', '2020-01-31 20:59:42', 120);
INSERT INTO geral.tb_permissao VALUES (723, 'filtrar', 'filtro', '2020-01-31 20:59:42', '2020-01-31 20:59:42', 120);


--
-- TOC entry 2956 (class 0 OID 24630)
-- Dependencies: 213
-- Data for Name: tb_recurso; Type: TABLE DATA; Schema: geral; Owner: postgres
--

INSERT INTO geral.tb_recurso VALUES (1, 1, 1, 'modulos', 'M??dulos', 'fa-cog', true, 1, '2015-07-07 15:23:03', '2015-07-07 15:23:03');
INSERT INTO geral.tb_recurso VALUES (2, 1, 1, 'usuarios', 'Usu??rios', 'fa-user', true, 2, '2015-07-07 15:36:26', '2015-07-07 15:36:26');
INSERT INTO geral.tb_recurso VALUES (3, 1, 1, 'categoriasrecursos', 'Categorias de Recursos', 'fa-navicon', true, 3, '2015-07-07 15:46:34', '2015-07-07 15:46:34');
INSERT INTO geral.tb_recurso VALUES (4, 1, 1, 'recursos', 'Recursos', 'fa-share-alt', true, 4, '2015-07-07 16:00:27', '2015-07-07 16:00:27');
INSERT INTO geral.tb_recurso VALUES (5, 1, 1, 'permissoes', 'Permiss??es', 'fa-lock', true, 5, '2015-07-07 16:08:47', '2015-07-07 16:08:47');
INSERT INTO geral.tb_recurso VALUES (6, 1, 1, 'perfis', 'Perfis', 'fa-users', true, 6, '2015-07-07 16:21:10', '2015-07-07 16:21:10');
INSERT INTO geral.tb_recurso VALUES (7, 1, 1, 'perfispermissoes', 'Perfis Permiss??es', 'fa-exchange', true, 7, '2015-07-07 16:29:51', '2015-07-07 16:29:51');
INSERT INTO geral.tb_recurso VALUES (8, 1, 1, 'perfisusuarios', 'Perfis Usu??rios', 'fa-exchange', true, 8, '2015-07-07 16:38:47', '2015-07-07 16:38:47');
INSERT INTO geral.tb_recurso VALUES (9, 1, 4, 'index', 'Home', 'fa-home', true, 0, '2015-07-07 16:51:57', '2015-07-07 16:51:57');
INSERT INTO geral.tb_recurso VALUES (115, 18, 1, 'projetos', 'Projetos', 'asd', true, 4, '2020-01-31 17:32:17', '2020-01-31 17:32:17');
INSERT INTO geral.tb_recurso VALUES (117, 18, 1, 'produtos', 'Produtos', 'asd', true, 1, '2020-01-31 17:33:36', '2020-01-31 17:33:36');
INSERT INTO geral.tb_recurso VALUES (119, 18, 1, 'editais', 'Editais', 'asd', true, 3, '2020-01-31 17:37:56', '2020-01-31 17:37:56');
INSERT INTO geral.tb_recurso VALUES (121, 18, 2, 'produtos-contratados', 'Produtos Contratados', 'teste', true, 2, '2020-01-31 17:41:36', '2020-01-31 17:41:36');
INSERT INTO geral.tb_recurso VALUES (123, 18, 12, 'bancos', 'Bancos', 'teste', true, 1, '2020-01-31 17:46:57', '2020-01-31 17:46:57');
INSERT INTO geral.tb_recurso VALUES (125, 18, 12, 'entidades', 'Entidades', 'gear', true, 3, '2020-01-31 17:48:18', '2020-01-31 17:48:18');
INSERT INTO geral.tb_recurso VALUES (127, 18, 12, 'representantes-legais', 'Representantes Legais', 'kdsafs', true, 5, '2020-01-31 17:49:39', '2020-01-31 17:49:39');
INSERT INTO geral.tb_recurso VALUES (129, 18, 12, 'tipos-de-contato', 'Tipos de Contato', 'asd', true, 7, '2020-01-31 17:51:12', '2020-01-31 17:51:12');
INSERT INTO geral.tb_recurso VALUES (131, 18, 5, 'projeto-produto', 'Projeto Produtos', 'teste', true, 1, '2020-01-31 19:03:02', '2020-01-31 19:03:02');
INSERT INTO geral.tb_recurso VALUES (135, 18, 5, 'cidades', 'Cidades', 'asd', true, 4, '2020-01-31 21:02:34', '2020-01-31 21:02:34');
INSERT INTO geral.tb_recurso VALUES (28, 1, 1, 'unidades', 'Unidades', 'fa-cog', true, 9, '2015-11-16 18:43:59', '2015-11-16 18:43:59');
INSERT INTO geral.tb_recurso VALUES (133, 18, 5, 'contas', 'Conta do fornecedor', 'gear', true, 2, '2020-01-31 19:29:59', '2020-01-31 19:29:59');
INSERT INTO geral.tb_recurso VALUES (32, 1, 1, 'notificacoes', 'Notifica????es', 'fa-bell-o', true, 10, '2016-05-13 10:01:55', '2016-05-13 10:01:55');
INSERT INTO geral.tb_recurso VALUES (118, 18, 1, 'fornecedores', 'Fornecedores', 'asd', true, 2, '2020-01-31 17:34:15', '2020-01-31 17:34:15');
INSERT INTO geral.tb_recurso VALUES (120, 18, 2, 'entrada-de-produtos', 'Entrada de produtos', 'home', true, 1, '2020-01-31 17:40:48', '2020-01-31 17:40:48');
INSERT INTO geral.tb_recurso VALUES (122, 18, 3, 'links-uteis', 'Links ??teis', 'teste', true, 1, '2020-01-31 17:42:43', '2020-01-31 17:42:43');
INSERT INTO geral.tb_recurso VALUES (124, 18, 12, 'agencias', 'Ag??ncias', 'teste', true, 2, '2020-01-31 17:47:30', '2020-01-31 17:47:30');
INSERT INTO geral.tb_recurso VALUES (93, 1, 7, 'migracao', 'Migra????o', 'fa-archive', true, 2, '2019-01-28 15:37:17', '2019-01-28 15:37:17');
INSERT INTO geral.tb_recurso VALUES (128, 18, 12, 'usuarios', 'Usu??rios', 'gear', true, 6, '2020-01-31 17:50:08', '2020-01-31 17:50:08');
INSERT INTO geral.tb_recurso VALUES (130, 18, 12, 'unidades-de-medidas', 'Unidades de Medidas', 'asd', true, 8, '2020-01-31 17:51:54', '2020-01-31 17:51:54');
INSERT INTO geral.tb_recurso VALUES (132, 18, 13, 'entradas', 'Entradas', 'asd', true, 1, '2020-01-31 19:15:29', '2020-01-31 19:15:29');
INSERT INTO geral.tb_recurso VALUES (126, 18, 12, 'cronogramas-de-entrega', 'Cronogramas de Entrega', 'home', true, 4, '2020-01-31 17:48:50', '2020-01-31 17:48:50');
INSERT INTO geral.tb_recurso VALUES (100, 15, 4, 'index', 'P??gina de inicial de logs', 'fa-archive', true, 1, '2019-06-05 14:56:07', '2019-06-05 14:56:07');
INSERT INTO geral.tb_recurso VALUES (101, 15, 5, 'logs', 'Logs do App', 'fa-archive', true, 1, '2019-06-05 14:57:07', '2019-06-05 14:57:07');
INSERT INTO geral.tb_recurso VALUES (134, 18, 5, 'estados', 'Estado', 'home', true, 4, '2020-01-31 21:02:00', '2020-01-31 21:02:00');


--
-- TOC entry 2958 (class 0 OID 24639)
-- Dependencies: 215
-- Data for Name: tb_tce_unidade; Type: TABLE DATA; Schema: geral; Owner: postgres
--

INSERT INTO geral.tb_tce_unidade VALUES (1, 'POL??CIA MILITAR DO MARANH??O ', 'ORG??O', NULL, 433);
INSERT INTO geral.tb_tce_unidade VALUES (2, 'COL??GIO MILITAR TIRADENTES IV', 'UNIDADE', 'CAXIAS ', 150023438);
INSERT INTO geral.tb_tce_unidade VALUES (3, 'TRIBUNAL DE CONTAS DO ESTADO DO MARANH??O ', 'ORG??O', NULL, 435);
INSERT INTO geral.tb_tce_unidade VALUES (4, 'TRIBUNAL DE CONTAS DO ESTADO DO MARANH??O ', 'UNIDADE', NULL, 435);
INSERT INTO geral.tb_tce_unidade VALUES (5, 'FUNDO DE MODERNIZA????O DO TRIBUNAL DE CONTAS DO ESTADO DO MARANH??O ', 'UNIDADE', NULL, 150016097);
INSERT INTO geral.tb_tce_unidade VALUES (6, 'N??O INFORMADO ', 'UNIDADE', NULL, 0);
INSERT INTO geral.tb_tce_unidade VALUES (7, 'SECRETARIA DE ESTADO DA FAZENDA DO MARANH??O ', 'ORG??O', NULL, 440);
INSERT INTO geral.tb_tce_unidade VALUES (8, 'SECRETARIA DE ESTADO DA FAZENDA DO MARANH??O ', 'UNIDADE', NULL, 440);
INSERT INTO geral.tb_tce_unidade VALUES (9, 'FUNDO DE FORTALECIMENTO DA ADMINISTRA????O TRIBUT??RIA DO MARANH??O ', 'UNIDADE', NULL, 150019679);
INSERT INTO geral.tb_tce_unidade VALUES (11, 'FUNDO ESTADUAL DE DESENVOLVIMENTO INDUSTRIAL DO MARANH??O ', 'UNIDADE', NULL, 150014807);
INSERT INTO geral.tb_tce_unidade VALUES (12, 'SECRETARIA DE ESTADO DA CULTURA E TURISMO DO MARANH??O ', 'ORG??O', NULL, 446);
INSERT INTO geral.tb_tce_unidade VALUES (13, 'SECRETARIA DE ESTADO DA CULTURA E TURISMO DO MARANH??O ', 'UNIDADE', NULL, 446);
INSERT INTO geral.tb_tce_unidade VALUES (14, 'FUNDA????O DA MEM??RIA REPUBLICANA BRASILEIRA ', 'UNIDADE', NULL, 150015390);
INSERT INTO geral.tb_tce_unidade VALUES (15, 'FUNDO DE DESENVOLVIMENTO DA CULTURA MARANHENSE ', 'UNIDADE', NULL, 150019678);
INSERT INTO geral.tb_tce_unidade VALUES (16, 'SECRETARIA DE ESTADO DO ESPORTE E LAZER DO MARANH??O ', 'ORG??O', NULL, 447);
INSERT INTO geral.tb_tce_unidade VALUES (17, 'SECRETARIA DE ESTADO DO ESPORTE E LAZER DO MARANH??O ', 'UNIDADE', NULL, 447);
INSERT INTO geral.tb_tce_unidade VALUES (18, 'SECRETARIA DE ESTADO DE PLANEJAMENTO E OR??AMENTO DO MARANH??O ', 'ORG??O', NULL, 482);
INSERT INTO geral.tb_tce_unidade VALUES (19, 'ENCARGOS GERAIS DO ESTADO', 'UNIDADE', 'SEPLAN ', 150019057);
INSERT INTO geral.tb_tce_unidade VALUES (20, 'SECRETARIA DE ESTADO DE PLANEJAMENTO E OR??AMENTO DO MARANH??O ', 'UNIDADE', NULL, 482);
INSERT INTO geral.tb_tce_unidade VALUES (21, 'ENCARGOS FINANCEIROS DO ESTADO DO MARANH??O', 'UNIDADE', 'SEPLAN ', 150019058);
INSERT INTO geral.tb_tce_unidade VALUES (22, 'SECRETARIA DE ESTADO DA AGRICULTURA, PECU??RIA E PESCA DO MARANH??O ', 'ORG??O', NULL, 483);
INSERT INTO geral.tb_tce_unidade VALUES (23, 'SECRETARIA DE ESTADO DA AGRICULTURA, PECU??RIA E PESCA DO MARANH??O ', 'UNIDADE', NULL, 483);
INSERT INTO geral.tb_tce_unidade VALUES (24, 'AG??NCIA ESTADUAL DE DEFESA AGROPEC??ARIA DO MARANH??O ', 'UNIDADE', NULL, 943);
INSERT INTO geral.tb_tce_unidade VALUES (25, 'SECRETARIA DE ESTADO DA SEGURAN??A P??BLICA DO MARANH??O ', 'ORG??O', NULL, 485);
INSERT INTO geral.tb_tce_unidade VALUES (26, 'SECRETARIA DE ESTADO DE SEGURAN??A P??BLICA DO MARANH??O ', 'UNIDADE', NULL, 485);
INSERT INTO geral.tb_tce_unidade VALUES (27, 'POL??CIA CIVIL DO ESTADO DO MARANH??O ', 'UNIDADE', NULL, 2252730);
INSERT INTO geral.tb_tce_unidade VALUES (28, 'POL??CIA MILITAR DO MARANH??O', 'UNIDADE', 'PM/MA ', 433);
INSERT INTO geral.tb_tce_unidade VALUES (29, 'CORPO DE BOMBEIROS MILITAR DO ESTADO DO MARANH??O ', 'UNIDADE', NULL, 2252732);
INSERT INTO geral.tb_tce_unidade VALUES (30, 'SEGUNDO BATALHAO DE POLICIA MILITAR/CAXIAS ', 'UNIDADE', NULL, 2252655);
INSERT INTO geral.tb_tce_unidade VALUES (31, 'TERCEIRO BATALH??O DE POL??CIA MILITAR/IMPERATRIZ ', 'UNIDADE', NULL, 2252549);
INSERT INTO geral.tb_tce_unidade VALUES (32, 'S??TIMO BATALHAO DE POLICIA MILITAR/PINDARE', 'UNIDADE', 'MIRIM ', 2252639);
INSERT INTO geral.tb_tce_unidade VALUES (33, 'QUINTO BATALHAO DE POLICIA MILITAR/BARRA DO CORDA ', 'UNIDADE', NULL, 2252659);
INSERT INTO geral.tb_tce_unidade VALUES (34, 'D??CIMO PRIMEIRO BATALH??O DE POL??CIA MILITAR/TIMON ', 'UNIDADE', NULL, 2252512);
INSERT INTO geral.tb_tce_unidade VALUES (35, 'QUINTA COMPANHIA INDEPENDENTE DE POL??CIA MILITAR/A??AIL??NDIA ', 'UNIDADE', NULL, 2252661);
INSERT INTO geral.tb_tce_unidade VALUES (36, 'QUARTO BATALH??O DA POL??CIA MILITAR/BALSAS ', 'UNIDADE', NULL, 2252922);
INSERT INTO geral.tb_tce_unidade VALUES (37, 'D??CIMO SEXTO BATALH??O DE POL??CIA MILITAR DE CHAPADINHA ', 'UNIDADE', NULL, 2252677);
INSERT INTO geral.tb_tce_unidade VALUES (38, 'D??CIMO BATALH??O DE POL??CIA MILITAR/PINHEIRO ', 'UNIDADE', NULL, 2252763);
INSERT INTO geral.tb_tce_unidade VALUES (39, 'D??CIMO OITAVO BATALH??O DE POLICIA MILITAR DE PRESIDENTE DUTRA ', 'UNIDADE', NULL, 150020198);
INSERT INTO geral.tb_tce_unidade VALUES (40, 'D??CIMO S??TIMO BATALH??O DE POLICIA MILITAR/COD?? ', 'UNIDADE', NULL, 150018877);
INSERT INTO geral.tb_tce_unidade VALUES (41, '4?? GRUPAMENTO DE BOMBEIROS MILITAR/BALSAS ', 'UNIDADE', NULL, 2252926);
INSERT INTO geral.tb_tce_unidade VALUES (42, 'TERCEIRO GRUPAMENTO DE BOMBEIROS MILITAR/IMPERATRIZ ', 'UNIDADE', NULL, 2253184);
INSERT INTO geral.tb_tce_unidade VALUES (43, 'D??CIMO NONO BATALH??O DE POLICIA MILITAR', 'UNIDADE', 'PEDREIRAS ', 150019558);
INSERT INTO geral.tb_tce_unidade VALUES (44, 'D??CIMA TERCEIRA COMPANHIA MILITAR INDEPENDENTE ', 'UNIDADE', NULL, 2252700);
INSERT INTO geral.tb_tce_unidade VALUES (45, 'PRIMEIRA COMPANHIA INDEPENDENTE/COLINAS ', 'UNIDADE', NULL, 150020318);
INSERT INTO geral.tb_tce_unidade VALUES (46, '2?? ESQUADR??O DE POL??CIA MONTADA DE JO??O LISBOA ', 'UNIDADE', NULL, 2252761);
INSERT INTO geral.tb_tce_unidade VALUES (47, 'OITAVO BATALH??O DE BOMBEIROS MILITAR 8?? BBM', 'UNIDADE', 'PINHEIRO ', 150020058);
INSERT INTO geral.tb_tce_unidade VALUES (48, 'QUINTO BATALH??O DE BOMBEIROS MILITAR DE CAXIAS ', 'UNIDADE', NULL, 2253185);
INSERT INTO geral.tb_tce_unidade VALUES (49, '12?? BATALH??O DE POLICIA MILITAR DE ESTREITO ', 'UNIDADE', NULL, 150012881);
INSERT INTO geral.tb_tce_unidade VALUES (50, 'D??CIMO QUINTO BATALH??O DE POLICIA MILITAR DE BACABAL ', 'UNIDADE', NULL, 2252676);
INSERT INTO geral.tb_tce_unidade VALUES (51, '15?? COMPANHIA INDEPENDENTE DE GRAJA?? ', 'UNIDADE', NULL, 150020273);
INSERT INTO geral.tb_tce_unidade VALUES (52, '14?? BATALHAO DE POLICIA MILITAR DE IMPERATRIZ ', 'UNIDADE', NULL, 150019237);
INSERT INTO geral.tb_tce_unidade VALUES (53, 'COLEGIO MILITAR TIRADENTES II', 'UNIDADE', 'IMPERATRIZ ', 150019117);
INSERT INTO geral.tb_tce_unidade VALUES (54, 'COLEGIO MILITAR TIRADENTES III', 'UNIDADE', 'BACABAL ', 150019519);
INSERT INTO geral.tb_tce_unidade VALUES (55, 'CENTRO DE FORMA????O E APERFEI??OAMENTO DE PRA??AS ', 'UNIDADE', NULL, 150020269);
INSERT INTO geral.tb_tce_unidade VALUES (56, 'ACADEMIA DE POLICIA MILITAR GON??ALVES DIAS ', 'UNIDADE', NULL, 150020267);
INSERT INTO geral.tb_tce_unidade VALUES (57, 'BATALH??O DE POLICIA DE CHOQUE ', 'UNIDADE', NULL, 150020268);
INSERT INTO geral.tb_tce_unidade VALUES (58, 'BATALH??O DE POLICIA AMBIENTAL ', 'UNIDADE', NULL, 150020270);
INSERT INTO geral.tb_tce_unidade VALUES (59, 'COMPANHIA DE POLICIA RODOVI??RIA INDEPENDENTE DO ESTADO DO MARANH??O ', 'UNIDADE', NULL, 150020298);
INSERT INTO geral.tb_tce_unidade VALUES (60, 'SEGUNDA COMPANHIA INDEPENDENTE/MIRINZAL ', 'UNIDADE', NULL, 150020320);
INSERT INTO geral.tb_tce_unidade VALUES (61, 'TERCEIRA CIA INDEPENDENTE/AMARANTE ', 'UNIDADE', NULL, 150020321);
INSERT INTO geral.tb_tce_unidade VALUES (62, 'COORDENADORIA ESTADUAL DE PROTE????O E DEFESA CIVIL DO ESTADO DO MARANH??O ', 'UNIDADE', NULL, 150020272);
INSERT INTO geral.tb_tce_unidade VALUES (63, 'TERCEIRA COMPANHIA INDEPENDENTE DE BOMBEIROS MILITAR EM ITAPECURU', 'UNIDADE', 'MIRIM ', 150019477);
INSERT INTO geral.tb_tce_unidade VALUES (64, 'QUARTA CIA INDEPENDENTE DE BOMBEIROS MILITAR/BARREIRINHAS ', 'UNIDADE', NULL, 150020323);
INSERT INTO geral.tb_tce_unidade VALUES (65, 'SETIMO BATALHAO DE BOMBEIROS MILITAR/TIMON ', 'UNIDADE', NULL, 150020324);
INSERT INTO geral.tb_tce_unidade VALUES (66, 'SEXTA COMPANHIA INDEPENDENTE DE BOMBEIROS MILITAR DE A??AIL??NDIA ', 'UNIDADE', NULL, 150020098);
INSERT INTO geral.tb_tce_unidade VALUES (67, 'NONO BATALHAO DE BOMBEIROS MILITAR/ESTREITO ', 'UNIDADE', NULL, 150020325);
INSERT INTO geral.tb_tce_unidade VALUES (68, '1?? COMPANHIA INDEPENDENTE DE BOMBEIROS MILITAR DE S??O JOS?? DE RIBAMAR ', 'UNIDADE', NULL, 150020159);
INSERT INTO geral.tb_tce_unidade VALUES (69, 'DEPARTAMENTO ESTADUAL DE TR??NSITO DO ESTADO DO MARANH??O ', 'UNIDADE', NULL, 2252644);
INSERT INTO geral.tb_tce_unidade VALUES (70, 'SEXTA COMPANHIA INDEPENDENTE/S.J. DOS PATOS ', 'UNIDADE', NULL, 2252682);
INSERT INTO geral.tb_tce_unidade VALUES (71, '7?? BATALHAO DE BOMBEIROS MILITAR DE TIMON ', 'UNIDADE', NULL, 150019598);
INSERT INTO geral.tb_tce_unidade VALUES (72, 'FUNDO ESPECIAL DE SEGURAN??A PUBLICA DO MARANH??O ', 'UNIDADE', NULL, 150019658);
INSERT INTO geral.tb_tce_unidade VALUES (73, 'FUNDO ESTADUAL DE POLITICAS SOBRE DROGAS DO MARANHAO', 'UNIDADE', 'FEPOD ', 150019659);
INSERT INTO geral.tb_tce_unidade VALUES (74, 'SEGUNDA COMPANHIA DE POLICIA MILITAR INDEPENDENTE DE BACABAL ', 'UNIDADE', NULL, 150015517);
INSERT INTO geral.tb_tce_unidade VALUES (75, 'D??CIMO BATALH??O DE BOMBEIROS MILITAR/ S??O JOS?? DE RIBAMAR ', 'UNIDADE', NULL, 150024072);
INSERT INTO geral.tb_tce_unidade VALUES (76, 'VIG??SIMO NONO BATALH??O DE POLICIA MILITAR / Z?? DOCA ', 'UNIDADE', NULL, 150024041);
INSERT INTO geral.tb_tce_unidade VALUES (77, 'VIG??SIMO OITAVO BATALH??O DE POLICIA MILITAR/ ITAPECURU MIRIM ', 'UNIDADE', NULL, 150024040);
INSERT INTO geral.tb_tce_unidade VALUES (78, 'D??CIMA SEXTA COMPANHIA INDEPENDENTE DE BOMBEIROS MILITAR/ S??O LU??S ', 'UNIDADE', NULL, 150024085);
INSERT INTO geral.tb_tce_unidade VALUES (79, 'D??CIMA QUINTA COMPANHIA INDEPENDENTE DE BOMBEIROS MILITAR/ COD?? ', 'UNIDADE', NULL, 150024084);
INSERT INTO geral.tb_tce_unidade VALUES (80, 'D??CIMA QUARTA COMPANHIA INDEPENDENTE DE BOMBEIROS MILITAR/ CAROLINA ', 'UNIDADE', NULL, 150024083);
INSERT INTO geral.tb_tce_unidade VALUES (81, 'D??CIMA TERCEIRA COMPANHIA INDEPENDENTE DE BOMBEIROS MILITAR/ TRIZIDELA DO VALE ', 'UNIDADE', NULL, 150024082);
INSERT INTO geral.tb_tce_unidade VALUES (82, 'D??CIMO SEGUNDO BATALH??O DE BOMBEIROS MILITAR/ A??AIL??NDIA ', 'UNIDADE', NULL, 150024081);
INSERT INTO geral.tb_tce_unidade VALUES (83, 'PRIMEIRO REGIMENTO DE POLICIA MONTADA/ S??O LU??S ', 'UNIDADE', NULL, 150024080);
INSERT INTO geral.tb_tce_unidade VALUES (84, 'TRIG??SIMO S??TIMO BATALH??O DE POLICIA MILITAR/ GRAJA?? ', 'UNIDADE', NULL, 150024079);
INSERT INTO geral.tb_tce_unidade VALUES (85, 'TRIG??SIMO QUINTO BATALH??O DE POLICIA MILITAR/ S??O JO??O DOS PATOS ', 'UNIDADE', NULL, 150024078);
INSERT INTO geral.tb_tce_unidade VALUES (86, 'TRIG??SIMO QUARTO BATALH??O DE POLICIA MILITAR/ AMARANTE ', 'UNIDADE', NULL, 150024077);
INSERT INTO geral.tb_tce_unidade VALUES (87, 'BATALH??O DE POLICIA MILITAR DE TURISMO ', 'UNIDADE', NULL, 150023578);
INSERT INTO geral.tb_tce_unidade VALUES (88, 'TRIG??SIMO TERCEIRO BATALH??O DE POLICIA MILITAR/ COLINAS ', 'UNIDADE', NULL, 150024076);
INSERT INTO geral.tb_tce_unidade VALUES (89, 'COL??GIO MILITAR TIRADENTES V', 'UNIDADE', 'TIMON ', 150023879);
INSERT INTO geral.tb_tce_unidade VALUES (90, 'VIG??SIMO S??TIMO BATALH??O DA POLICIA MILITAR/ ROS??RIO 27?? BPM ', 'UNIDADE', NULL, 150022905);
INSERT INTO geral.tb_tce_unidade VALUES (91, 'TRIG??SIMO SEGUNDO BATALH??O DE POLICIA MILITAR/ CIDEL??NDIA ', 'UNIDADE', NULL, 150024075);
INSERT INTO geral.tb_tce_unidade VALUES (92, 'TRIG??SIMO SEXTO BATALH??O DE POLICIA MILITAR/ VIANA ', 'UNIDADE', NULL, 150024074);
INSERT INTO geral.tb_tce_unidade VALUES (93, 'TRIG??SIMO BATALH??O DE POLICIA MILITAR/ BURITICUPU ', 'UNIDADE', NULL, 150024042);
INSERT INTO geral.tb_tce_unidade VALUES (94, 'TRIG??SIMO PRIMEIRO BATALH??O DE POLICIA MILITAR/ GOVERNADOR NUNES FREIRE ', 'UNIDADE', NULL, 150024043);
INSERT INTO geral.tb_tce_unidade VALUES (95, 'D??CIMO PRIMEIRO BATALH??O DE BOMBEIROS/ ITAPECURU MIRIM ', 'UNIDADE', NULL, 150024000);
INSERT INTO geral.tb_tce_unidade VALUES (96, 'SECRETARIA DE ESTADO DA EDUCA????O DO MARANH??O ', 'ORG??O', NULL, 486);
INSERT INTO geral.tb_tce_unidade VALUES (97, 'SECRETARIA DE ESTADO DA EDUCA????O DO MARANH??O ', 'UNIDADE', NULL, 486);
INSERT INTO geral.tb_tce_unidade VALUES (98, 'FUNDA????O NICE LOBAO ', 'UNIDADE', NULL, 464);
INSERT INTO geral.tb_tce_unidade VALUES (99, 'FUNDO ESCOLA DIGNA DO ESTADO DO MARANH??O ', 'UNIDADE', NULL, 150019680);
INSERT INTO geral.tb_tce_unidade VALUES (100, 'PROCURADORIA GERAL DO ESTADO DO MARANH??O ', 'ORG??O', NULL, 540);
INSERT INTO geral.tb_tce_unidade VALUES (101, 'PROCURADORIA GERAL DO ESTADO DO MARANH??O ', 'UNIDADE', NULL, 540);
INSERT INTO geral.tb_tce_unidade VALUES (102, 'SECRETARIA DE ESTADO DE ASSUNTOS POL??TICOS E FEDERATIVOS DO MARANH??O ', 'UNIDADE', NULL, 150018997);
INSERT INTO geral.tb_tce_unidade VALUES (103, 'PROCURADORIA GERAL DA JUSTI??A DO ESTADO DO MARANH??O ', 'ORG??O', NULL, 548);
INSERT INTO geral.tb_tce_unidade VALUES (104, 'PROCURADORIA GERAL DA JUSTI??A DO ESTADO DO MARANH??O ', 'UNIDADE', NULL, 548);
INSERT INTO geral.tb_tce_unidade VALUES (105, 'FUNDO ESPECIAL DO MINIST??RIO P??BLICO ESTADUAL ', 'UNIDADE', NULL, 150016100);
INSERT INTO geral.tb_tce_unidade VALUES (106, 'SECRETARIA DE ESTADO DA SA??DE DO MARANH??O ', 'ORG??O', NULL, 556);
INSERT INTO geral.tb_tce_unidade VALUES (107, 'SECRETARIA DE ESTADO DA SA??DE DO MARANH??O ', 'UNIDADE', NULL, 556);
INSERT INTO geral.tb_tce_unidade VALUES (108, 'EMPRESA MARANHENSE DE SERVI??OS HOSPITALARES', 'UNIDADE', 'EMSERH ', 150019563);
INSERT INTO geral.tb_tce_unidade VALUES (109, 'FUNDO ESTADUAL DE SA??DE DO MARANH??O', 'UNIDADE', 'FES', 150019022);
INSERT INTO geral.tb_tce_unidade VALUES (111, 'FUNDO ESTADUAL DE COMBATE AO C??NCER DO MARANH??O ', 'UNIDADE', NULL, 150019681);
INSERT INTO geral.tb_tce_unidade VALUES (112, 'COMPANHIA MARANHENSE DE G??S', 'ORG??O', 'GASMAR ', 814);
INSERT INTO geral.tb_tce_unidade VALUES (113, 'COMPANHIA MARANHENSE DE G??S', 'UNIDADE', 'GASMAR ', 814);
INSERT INTO geral.tb_tce_unidade VALUES (114, 'SECRETARIA DE ESTADO DE INFRAESTRUTURA DO MARANH??O ', 'ORG??O', NULL, 2252616);
INSERT INTO geral.tb_tce_unidade VALUES (115, 'SECRETARIA DE ESTADO DE INFRAESTRUTURA DO MARANH??O ', 'UNIDADE', NULL, 2252616);
INSERT INTO geral.tb_tce_unidade VALUES (116, 'FUNDO ESTADUAL DE TRANSPORTE E MOBILIDADE URBANA', 'UNIDADE', 'FTMU ', 150020338);
INSERT INTO geral.tb_tce_unidade VALUES (117, 'SECRETARIA DE ESTADO DO DESENVOLVIMENTO SOCIAL DO MARANH??O ', 'ORG??O', NULL, 2252631);
INSERT INTO geral.tb_tce_unidade VALUES (118, 'SECRETARIA DE ESTADO DO DESENVOLVIMENTO SOCIAL DO MARANH??O ', 'UNIDADE', NULL, 2252631);
INSERT INTO geral.tb_tce_unidade VALUES (119, 'GERENCIA DE INCLUS??O SOCIOPRODUTIVA DO ESTADO DO MARANH??O ', 'UNIDADE', NULL, 150014993);
INSERT INTO geral.tb_tce_unidade VALUES (120, 'FUNDO ESTADUAL DE ASSIST??NCIA SOCIAL DO MARANH??O ', 'UNIDADE', NULL, 2251845);
INSERT INTO geral.tb_tce_unidade VALUES (121, 'TRIBUNAL DE JUSTI??A DO ESTADO DO MARANH??O ', 'ORG??O', NULL, 2252632);
INSERT INTO geral.tb_tce_unidade VALUES (122, 'TRIBUNAL DE JUSTI??A DO ESTADO DO MARANH??O ', 'UNIDADE', NULL, 2252632);
INSERT INTO geral.tb_tce_unidade VALUES (123, 'FUNDO ESPECIAL DE MODERNIZA????O E REAPARELHAMENTO DO JUDICIARIO DO ESTADO DO MARANH??O ', 'UNIDADE', NULL, 150014660);
INSERT INTO geral.tb_tce_unidade VALUES (124, 'FUNDO ESPECIAL DA ESCOLA SUPERIOR DA MAGISTRATURA DO ESTADO DO MARANH??O ', 'UNIDADE', NULL, 150014659);
INSERT INTO geral.tb_tce_unidade VALUES (125, 'FUNDO ESPECIAL DAS SERVENTIAS DE REGISTRO CIVIL DE PESSOAS NATURAIS DO ESTADO DO MARANH??O ', 'UNIDADE', NULL, 150014658);
INSERT INTO geral.tb_tce_unidade VALUES (126, 'FUNDO ESPECIAL DE SEGURAN??A DOS MAGISTRADOS DO MARANH??O ', 'UNIDADE', NULL, 150019018);
INSERT INTO geral.tb_tce_unidade VALUES (127, 'ASSEMBL??IA LEGISLATIVA DO ESTADO DO MARANH??O ', 'ORG??O', NULL, 2252647);
INSERT INTO geral.tb_tce_unidade VALUES (128, 'ASSEMBL??IA LEGISLATIVA DO ESTADO DO MARANH??O ', 'UNIDADE', NULL, 2252647);
INSERT INTO geral.tb_tce_unidade VALUES (129, 'FUNDO ESPECIAL LEGISLATIVO DO MARANH??O ', 'UNIDADE', NULL, 150016096);
INSERT INTO geral.tb_tce_unidade VALUES (130, 'SECRETARIA DE ESTADO DA CI??NCIA, TECNOLOGIA E INOVA????O DO MARANH??O ', 'ORG??O', NULL, 2252654);
INSERT INTO geral.tb_tce_unidade VALUES (131, 'UNIVERSIDADE ESTADUAL DA REGI??O TOCANTINA DO MARANH??O', 'UNIDADE', 'UEMASUL ', 150020731);
INSERT INTO geral.tb_tce_unidade VALUES (132, 'SECRETARIA DE ESTADO DA CI??NCIA, TECNOLOGIA E INOVA????O DO MARANH??O ', 'UNIDADE', NULL, 2252654);
INSERT INTO geral.tb_tce_unidade VALUES (133, 'UNIVERSIDADE ESTADUAL DO MARANH??O ', 'UNIDADE', NULL, 452);
INSERT INTO geral.tb_tce_unidade VALUES (134, 'FUNDA????O DE AMPARO ?? PESQUISA E AO DESENVOLVIMENTO CIENTIFICO E TECNOLOGICO DO MARANH??O ', 'UNIDADE', NULL, 454);
INSERT INTO geral.tb_tce_unidade VALUES (135, 'INSTITUTO ESTADUAL DE EDUCA????O, CI??NCIA E TECNOLOGIA DO MARANH??O', 'UNIDADE', 'IEMA ', 2252646);
INSERT INTO geral.tb_tce_unidade VALUES (136, 'SUBGERENCIA DO TESOURO ESTADUAL DO MARANH??O ', 'UNIDADE', NULL, 150022547);
INSERT INTO geral.tb_tce_unidade VALUES (137, 'DEFENSORIA P??BLICA DO ESTADO DO MARANH??O ', 'ORG??O', NULL, 2252664);
INSERT INTO geral.tb_tce_unidade VALUES (138, 'DEFENSORIA P??BLICA DO ESTADO DO MARANH??O ', 'UNIDADE', NULL, 2252664);
INSERT INTO geral.tb_tce_unidade VALUES (139, 'FUNDO DE APARELHAMENTO DA DEFENSORIA PUBLICA DO ESTADO DO MARANHAO ', 'UNIDADE', NULL, 150020299);
INSERT INTO geral.tb_tce_unidade VALUES (140, 'SECRETARIA DE ESTADO DO TRABALHO E DA ECONOMIA SOLID??RIA DO MARANH??O ', 'ORG??O', NULL, 2252705);
INSERT INTO geral.tb_tce_unidade VALUES (141, 'SECRETARIA DE ESTADO DO TRABALHO E DA ECONOMIA SOLID??RIA DO MARANH??O ', 'UNIDADE', NULL, 2252705);
INSERT INTO geral.tb_tce_unidade VALUES (142, 'SECRETARIA DE ESTADO DE IND??STRIA, COM??RCIO E ENERGIA', 'ORG??O', 'SEINC DO MARANH??O ', 2252706);
INSERT INTO geral.tb_tce_unidade VALUES (143, 'SECRETARIA DE ESTADO DE IND??STRIA, COM??RCIO E ENERGIA', 'UNIDADE', 'SEINC DO MARANH??O ', 2252706);
INSERT INTO geral.tb_tce_unidade VALUES (144, 'JUNTA COMERCIAL DO ESTADO DO MARANH??O ', 'UNIDADE', NULL, 2252634);
INSERT INTO geral.tb_tce_unidade VALUES (145, 'INSTITUTO DE METROLOGIA E QUALIDADE INDUSTRIAL DO MARANH??O ', 'UNIDADE', NULL, 2252658);
INSERT INTO geral.tb_tce_unidade VALUES (146, 'EMPRESA MARANHENSE DE ADMINISTRA????O PORTU??RIA ', 'UNIDADE', NULL, 462);
INSERT INTO geral.tb_tce_unidade VALUES (147, 'FUNDO ESTADUAL DE DESENVOLVIMENTO INDUSTRIAL DO MARANH??O ', 'UNIDADE', NULL, 2253190);
INSERT INTO geral.tb_tce_unidade VALUES (148, 'SECRETARIA DE ESTADO DO MEIO AMBIENTE E RECURSOS NATURAIS DO MARANH??O ', 'ORG??O', NULL, 2252711);
INSERT INTO geral.tb_tce_unidade VALUES (149, 'SECRETARIA DE ESTADO DO MEIO AMBIENTE E RECURSOS NATURAIS DO MARANH??O ', 'UNIDADE', NULL, 2252711);
INSERT INTO geral.tb_tce_unidade VALUES (150, 'FUNDO ESPECIAL DO MEIO AMBIENTE DO ESTADO DO MARANH??O', 'UNIDADE', 'FEMA ', 150014342);
INSERT INTO geral.tb_tce_unidade VALUES (151, 'FUNDO ESTADUAL DE UNIDADES E CONSERVA????O', 'UNIDADE', 'FEUC ', 150014341);
INSERT INTO geral.tb_tce_unidade VALUES (152, 'SECRETARIA DE ESTADO DA MULHER DO MARANH??O ', 'ORG??O', NULL, 2252713);
INSERT INTO geral.tb_tce_unidade VALUES (153, 'SECRETARIA DE ESTADO DA MULHER DO MARANH??O ', 'UNIDADE', NULL, 2252713);
INSERT INTO geral.tb_tce_unidade VALUES (156, 'SECRETARIA DE ESTADO DOS DIREITOS HUMANOS E PARTICIPA????O POPULAR DO MARANH??O ', 'ORG??O', NULL, 2253176);
INSERT INTO geral.tb_tce_unidade VALUES (157, 'SECRETARIA EXTRAORDINARIA DE ESTADO DA JUVENTUDE DO MARANHAO ', 'UNIDADE', NULL, 150017072);
INSERT INTO geral.tb_tce_unidade VALUES (158, 'SECRETARIA EXTRAORDIN??RIA DE ESTADO DA IGUALDADE RACIAL DO MARANH??O ', 'UNIDADE', NULL, 150017457);
INSERT INTO geral.tb_tce_unidade VALUES (159, 'SECRETARIA DE ESTADO DOS DIREITOS HUMANOS E PARTICIPA????O POPULAR DO MARANH??O ', 'UNIDADE', NULL, 2253176);
INSERT INTO geral.tb_tce_unidade VALUES (155, 'CENTRO DE HEMOTERAPIA E HEMATOLOGIA DO MARANH??O', 'UNIDADE', 'FES', 2253125);
INSERT INTO geral.tb_tce_unidade VALUES (154, 'CENTRO DE HEMOTERAPIA E HEMATOLOGIA DO MARANH??O ', 'ORG??O', 'FES', 2253125);
INSERT INTO geral.tb_tce_unidade VALUES (160, 'FUNDA????O DA CRIAN??A E DO ADOLESCENTE DO ESTADO DO MARANHAO ', 'UNIDADE', NULL, 466);
INSERT INTO geral.tb_tce_unidade VALUES (161, 'INSTITUTO DE PROMO????O E DEFESA DO CIDAD??O E CONSUMIDOR DO ESTADO DO MARANH??O', 'UNIDADE', 'PROCON ', 150021118);
INSERT INTO geral.tb_tce_unidade VALUES (162, 'FUNDO ESTADUAL DE PROTE????O E DEFESA DOS DIREITOS DO CONSUMIDOR ', 'UNIDADE', NULL, 2253187);
INSERT INTO geral.tb_tce_unidade VALUES (163, 'FUNDO ESTADUAL DOS DIREITOS DA CRIAN??A E DO ADOLESCENTE DO MARANH??O ', 'UNIDADE', NULL, 507);
INSERT INTO geral.tb_tce_unidade VALUES (164, 'SECRETARIA DE ESTADO DAS CIDADES E DESENVOLVIMENTO URBANO DO MARANH??O ', 'ORG??O', NULL, 2253210);
INSERT INTO geral.tb_tce_unidade VALUES (165, 'SECRETARIA DE ESTADO DAS CIDADES E DESENVOLVIMENTO URBANO DO MARANH??O ', 'UNIDADE', NULL, 2253210);
INSERT INTO geral.tb_tce_unidade VALUES (166, 'COMPANHIA DE SANEAMENTO AMBIENTAL DO MARANH??O ', 'UNIDADE', NULL, 150019021);
INSERT INTO geral.tb_tce_unidade VALUES (167, 'CENTRO DE ESPECIALIDADES M??DICAS DA CIDADE OPER??RIA ', 'ORG??O', NULL, 3001361);
INSERT INTO geral.tb_tce_unidade VALUES (168, 'CENTRO DE ESPECIALIDADES M??DICAS DA CIDADE OPER??RIA ', 'UNIDADE', NULL, 150016177);
INSERT INTO geral.tb_tce_unidade VALUES (169, 'SECRETARIA DE ESTADO DE ASSUNTOS POLITICOS ', 'ORG??O', NULL, 3001381);
INSERT INTO geral.tb_tce_unidade VALUES (170, 'SECRETARIA DE ESTADO DE ASSUNTOS POLITICOS ', 'UNIDADE', NULL, 150016197);
INSERT INTO geral.tb_tce_unidade VALUES (171, 'GER??NCIA DE DESENVOLVIMENTO REGIONAL DE PINHEIRO ', 'ORG??O', NULL, 3001781);
INSERT INTO geral.tb_tce_unidade VALUES (172, 'GER??NCIA DE DESENVOLVIMENTO REGIONAL DE PINHEIRO ', 'UNIDADE', NULL, 150016937);
INSERT INTO geral.tb_tce_unidade VALUES (173, 'SECRETARIA DE ESTADO DA AGRICULTURA FAMILIAR DO MARANHAO ', 'ORG??O', NULL, 3001901);
INSERT INTO geral.tb_tce_unidade VALUES (174, 'SECRETARIA DE ESTADO DA AGRICULTURA FAMILIAR DO MARANHAO ', 'UNIDADE', NULL, 150017177);
INSERT INTO geral.tb_tce_unidade VALUES (175, 'INSTITUTO DE COLONIZA????O E TERRAS DO MARANH??O ', 'UNIDADE', NULL, 150019020);
INSERT INTO geral.tb_tce_unidade VALUES (176, 'AG??NCIA ESTADUAL DE PESQUISA AGROPECU??RIA E EXTENS??O RURAL DO MARANH??O ', 'UNIDADE', NULL, 2252704);
INSERT INTO geral.tb_tce_unidade VALUES (177, 'SECRETARIA DE ESTADO EXTRAORDIN??RIA DE ARTICULA????O INSTITUCIONAL DO MARANH??O ', 'ORG??O', NULL, 3003401);
INSERT INTO geral.tb_tce_unidade VALUES (178, 'SECRETARIA DE ESTADO EXTRAORDIN??RIA DE ARTICULA????O INSTITUCIONAL DO MARANH??O ', 'UNIDADE', NULL, 150019417);
INSERT INTO geral.tb_tce_unidade VALUES (179, 'CHEFIA DE GABINETE DO GOVERNADOR DO ESTADO DO MARANH??O ', 'ORG??O', NULL, 3003522);
INSERT INTO geral.tb_tce_unidade VALUES (180, 'CHEFIA DE GABINETE DO GOVERNADOR DO ESTADO DO MARANH??O ', 'UNIDADE', NULL, 150019538);
INSERT INTO geral.tb_tce_unidade VALUES (181, '6?? BATALH??O DE BOMBEIROS MILITAR DE BACABAL', 'ORG??O', 'MA ', 3003562);
INSERT INTO geral.tb_tce_unidade VALUES (182, '6?? BATALH??O DE BOMBEIROS MILITAR DE BACABAL', 'UNIDADE', 'MA ', 150019578);
INSERT INTO geral.tb_tce_unidade VALUES (183, 'RESERVA DE CONTINGENCIA DO ESTADO DO MARANH??O ', 'ORG??O', NULL, 3003623);
INSERT INTO geral.tb_tce_unidade VALUES (184, 'RESERVA DE CONTINGENCIA DO ESTADO DO MARANH??O ', 'UNIDADE', NULL, 150019684);
INSERT INTO geral.tb_tce_unidade VALUES (185, 'HOSPITAL ANTONIO PONTES DE AGUIAR ', 'ORG??O', NULL, 3003922);
INSERT INTO geral.tb_tce_unidade VALUES (186, 'HOSPITAL ANTONIO PONTES DE AGUIAR ', 'UNIDADE', NULL, 150020138);
INSERT INTO geral.tb_tce_unidade VALUES (187, 'ENCARGOS ADMINISTRATIVOS ', 'ORG??O', NULL, 3003982);
INSERT INTO geral.tb_tce_unidade VALUES (188, 'ENCARGOS ADMINISTRATIVOS ', 'UNIDADE', NULL, 150020339);
INSERT INTO geral.tb_tce_unidade VALUES (189, 'ENCARGOS FINANCEIROS', 'UNIDADE', 'SEPLAN ', 150020340);
INSERT INTO geral.tb_tce_unidade VALUES (190, 'FUNDA????O DA CIDADANIA E JUSTI??A DO MARANH??O ', 'ORG??O', NULL, 3004022);
INSERT INTO geral.tb_tce_unidade VALUES (191, 'FUNDA????O DA CIDADANIA E JUSTI??A DO MARANH??O ', 'UNIDADE', NULL, 150020398);
INSERT INTO geral.tb_tce_unidade VALUES (192, 'SECRETARIA DE ESTADO DE GOVERNO DO MARANH??O ', 'ORG??O', NULL, 3004402);
INSERT INTO geral.tb_tce_unidade VALUES (193, 'SECRETARIA DE ESTADO DE GOVERNO DO MARANH??O ', 'UNIDADE', NULL, 438);
INSERT INTO geral.tb_tce_unidade VALUES (194, 'SECRETARIA DE ESTADO EXTRAORDIN??RIA DE ARTICULA????O POLITICAS PUBLICAS DO MARANH??O ', 'UNIDADE', NULL, 150021120);
INSERT INTO geral.tb_tce_unidade VALUES (195, 'CASA CIVIL DO ESTADO DO MARANH??O ', 'ORG??O', NULL, 3004403);
INSERT INTO geral.tb_tce_unidade VALUES (196, 'CASA CIVIL DO ESTADO DO MARANH??O ', 'UNIDADE', NULL, 2252635);
INSERT INTO geral.tb_tce_unidade VALUES (197, 'AGENCIA EXECUTIVA METROPOLITANA DO MARANH??O ', 'UNIDADE', NULL, 150021036);
INSERT INTO geral.tb_tce_unidade VALUES (198, 'SECRETARIA EXTRAORDIN??RIA DE RELA????ES INSTITUCIONAIS DO ESTADO ', 'UNIDADE', NULL, 150021040);
INSERT INTO geral.tb_tce_unidade VALUES (199, 'SECRETARIA EXTRAORDIN??RIA DE PROGRAMAS ESPECIAIS DO MARANH??O ', 'UNIDADE', NULL, 150021122);
INSERT INTO geral.tb_tce_unidade VALUES (200, 'AGENCIA ESTADUAL DE MOBILIDADE URBANA E SERVI??OS PUBLICOS', 'UNIDADE', 'MOB DO ESTADO DO MARANH??O ', 150021018);
INSERT INTO geral.tb_tce_unidade VALUES (201, 'AGENCIA EXECUTIVA METROPOLITANA DO SUDOESTE MARANHENSE ', 'UNIDADE', NULL, 150021572);
INSERT INTO geral.tb_tce_unidade VALUES (202, 'SECRETARIA DE ESTADO DA GEST??O, PATRIM??NIO E ASSIST??NCIA DOS SERVIDORES DO MARANH??O ', 'ORG??O', NULL, 3004696);
INSERT INTO geral.tb_tce_unidade VALUES (203, 'ESCOLA DE GOVERNO DO MARANH??O ', 'UNIDADE', NULL, 150015331);
INSERT INTO geral.tb_tce_unidade VALUES (204, 'FUNDO DE BENEF??CIOS DOS SERVIDORES DO ESTADO DO MARANH??O ', 'UNIDADE', NULL, 503);
INSERT INTO geral.tb_tce_unidade VALUES (205, 'EMPRESA MARANHENSE DE ADMINISTRA????O DE RECURSOS HUMANOS E NEG??CIO P??BLICO', 'UNIDADE', 'EMARHP ', 461);
INSERT INTO geral.tb_tce_unidade VALUES (206, 'ENCARGOS ADMINISTRATIVOS DO ESTADO DO MARANH??O', 'UNIDADE', 'SEGEP ', 150019683);
INSERT INTO geral.tb_tce_unidade VALUES (207, 'N??CLEO DE ASSIST??NCIA DOS SERVIDORES P??BLICOS', 'UNIDADE', 'NASSP DO ESTADO DO MARANH??O ', 150023147);
INSERT INTO geral.tb_tce_unidade VALUES (208, 'SECRETARIA DE ESTADO DA GEST??O, PATRIM??NIO E ASSIST??NCIA DOS SERVIDORES DO MARANH??O ', 'UNIDADE', NULL, 150021684);
INSERT INTO geral.tb_tce_unidade VALUES (209, 'REPRESENTA????O INSTITUCIONAL NO DISTRITO FEDERAL DO MARANH??O ', 'ORG??O', NULL, 3005243);
INSERT INTO geral.tb_tce_unidade VALUES (210, 'REPRESENTA????O INSTITUCIONAL NO DISTRITO FEDERAL DO MARANH??O ', 'UNIDADE', NULL, 150022541);
INSERT INTO geral.tb_tce_unidade VALUES (211, 'SECRETARIA DE ESTADO DA COMUNICA????O SOCIAL E ASSUNTOS POL??TICOS DO MARANH??O ', 'ORG??O', NULL, 3005244);
INSERT INTO geral.tb_tce_unidade VALUES (212, 'SECRETARIA DE ESTADO DA COMUNICA????O SOCIAL E ASSUNTOS POL??TICOS DO MARANH??O ', 'UNIDADE', NULL, 2252650);
INSERT INTO geral.tb_tce_unidade VALUES (213, 'SECRETARIA DE ESTADO DA TRANSPAR??NCIA E CONTROLE DO MARANH??O ', 'ORG??O', NULL, 3005246);
INSERT INTO geral.tb_tce_unidade VALUES (214, 'SECRETARIA DE ESTADO DA TRANSPAR??NCIA E CONTROLE DO MARANH??O ', 'UNIDADE', NULL, 150017498);
INSERT INTO geral.tb_tce_unidade VALUES (215, 'COMISS??O CENTRAL PERMANENTE DE LICITA????O DO ESTADO DO MARANH??O ', 'ORG??O', NULL, 3005247);
INSERT INTO geral.tb_tce_unidade VALUES (216, 'COMISS??O CENTRAL PERMANENTE DE LICITA????O DO ESTADO DO MARANH??O ', 'UNIDADE', NULL, 150012882);
INSERT INTO geral.tb_tce_unidade VALUES (217, 'INSTITUTO DE PREVID??NCIA DOS SERVIDORES DO ESTADO DO MARANH??O', 'ORG??O', 'IPREV ', 3005262);
INSERT INTO geral.tb_tce_unidade VALUES (218, 'FUNDO ESTADUAL DE PENS??O E APOSENTADORIA DO MARANH??O ', 'UNIDADE', NULL, 502);
INSERT INTO geral.tb_tce_unidade VALUES (219, 'INSTITUTO DE PREVID??NCIA DOS SERVIDORES DO ESTADO DO MARANH??O', 'UNIDADE', 'IPREV ', 150021471);
INSERT INTO geral.tb_tce_unidade VALUES (220, 'FUNDO ESTADUAL DE RECURSOS H??DRICOS', 'ORG??O', 'FERH DO ESTADO DO MARANH??O ', 3005863);
INSERT INTO geral.tb_tce_unidade VALUES (221, 'FUNDO ESTADUAL DE RECURSOS H??DRICOS', 'UNIDADE', 'FERH DO ESTADO DO MARANH??O ', 150023332);
INSERT INTO geral.tb_tce_unidade VALUES (222, 'SECRETARIA DE ESTADO DE ADMINISTRA????O PENITENCIARIA DO MARANH??O ', 'ORG??O', NULL, 150012000);
INSERT INTO geral.tb_tce_unidade VALUES (223, 'SECRETARIA DE ESTADO DE ADMINISTRA????O PENITENCIARIA DO MARANH??O ', 'UNIDADE', NULL, 150012861);
INSERT INTO geral.tb_tce_unidade VALUES (224, 'FUNDO PENITENCI??RIO ESTADUAL DO MARANH??O ', 'UNIDADE', NULL, 701);
INSERT INTO geral.tb_tce_unidade VALUES (225, 'SECRETARIA DE ESTADO DE PESCA E AQUICULTURA DO MARANH??O ', 'ORG??O', NULL, 150045150);
INSERT INTO geral.tb_tce_unidade VALUES (226, 'SECRETARIA DE ESTADO DE PESCA E AQUICULTURA DO MARANH??O ', 'UNIDADE', NULL, 150015499);
INSERT INTO geral.tb_tce_unidade VALUES (227, 'SECRETARIA DE ESTADO DE PROGRAMAS ESTRAT??GICOS DO MARANH??O ', 'ORG??O', NULL, 150048752);
INSERT INTO geral.tb_tce_unidade VALUES (228, 'INSTITUTO MARANHENSE DE ESTUDOS SOCIOECON??MICOS E CARTOGR??FICOS', 'UNIDADE', 'IMESC', 2252702);
INSERT INTO geral.tb_tce_unidade VALUES (10, 'SECRETARIA DE ESTADO DA IND??STRIA, COM??RCIO E TURISMO DO MARANH??O', 'ORG??O', 'SINCT', 442);
INSERT INTO geral.tb_tce_unidade VALUES (110, 'HOSPITAL TARQU??NIO LOPES FILHO ', 'UNIDADE', NULL, 2252742);


--
-- TOC entry 2960 (class 0 OID 24647)
-- Dependencies: 217
-- Data for Name: tb_unidade; Type: TABLE DATA; Schema: geral; Owner: postgres
--

INSERT INTO geral.tb_unidade VALUES (990106, 'SECRETARIA DE ESTADO DE CULTURA', 'SECMA', NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (990103, 'UNIVERSIDADE ESTADUAL DA REGI??O TOCANTINA DO MARANH??O', 'UEMASUL', NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (990104, 'BATALH??O DE POL??CIA AMBIENTAL - PMMA', 'BPAPM', '', '', '', 'true', NULL, NULL);
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
INSERT INTO geral.tb_unidade VALUES (980101, 'ESCOLA DE GOVERNO DO MARANH??O', 'EGMA', NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (540110, 'VIVA CIDADAO                                 ', 'VIVA', NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (230203, 'EMPRESA MARANHENSE DE ADMINISTRACAO PORTUARIA', 'EMAP', NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (940101, 'SECRETARIA DE ESTADO DE GOVERNO', 'SEGOV ', NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (950101, 'GERENCIA DE INCLUSAO SOCIOPRODUTIVA', 'GISP', NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (960101, 'COMPANHIA MARANHENSE DE G??S', 'GASMAR', NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (970101, 'CERIMONIAL', 'CERIMONIAL', NULL, NULL, NULL, 'true', NULL, NULL);
INSERT INTO geral.tb_unidade VALUES (990101, 'SECRETARIA DE ESTADO EXTRAORDIN??RIA DA JUVENTUDE', 'SEEJUV', NULL, NULL, NULL, 'true', NULL, NULL);
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
INSERT INTO geral.tb_unidade VALUES (110122, 'SEC. DE ESTADO DA TRANSPARENCIA E CONTROLE   ', 'STC', '21853640000114', '67774113304', 'Adaltina Ven??ncio de Queiroga', 'true', NULL, 150017498);
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
INSERT INTO geral.tb_unidade VALUES (540202, 'INSTITUTO DE PROMO????O E DEFESA DO CIDAD??O E CONSUMIDOR DO MARANH??O', 'PROCON', NULL, NULL, NULL, 'true', NULL, 150021118);
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
INSERT INTO geral.tb_unidade VALUES (580203, 'EMPRESA MARANHENSE ADM. DE RECURSOS HUMANOS E NEG??CIOS PUBLICOS', 'EMARHP', '', '', '', 'true', NULL, 461);
INSERT INTO geral.tb_unidade VALUES (590101, 'SECRETARIA DE ESTADO DA PESCA E AQUICULTURA  ', 'SEPAQ', '', '', '', 'true', NULL, 150015499);
INSERT INTO geral.tb_unidade VALUES (610101, 'SECRETARIA DE ESTADO DA AGRICULTURA FAMILIAR ', 'SAF', '', '', '', 'true', NULL, 150017177);
INSERT INTO geral.tb_unidade VALUES (610202, 'AGENCIA ESTADUAL PESQUISA AGROP.EXT.RURAL MA ', 'AGERP', '', '', '', 'true', NULL, 2252704);
INSERT INTO geral.tb_unidade VALUES (900101, 'RESERVA DE CONTINGENCIA                      ', NULL, NULL, NULL, NULL, 'true', NULL, 150019684);
INSERT INTO geral.tb_unidade VALUES (910101, 'Secretaria de Estado de Comunica????o Social e Articula????o Pol??tica', 'SECAP', NULL, NULL, NULL, 'true', NULL, 2252650);
INSERT INTO geral.tb_unidade VALUES (920101, 'Secretaria de Estado de Cultura e Turismo', 'SECTUR', NULL, NULL, NULL, 'true', NULL, 446);
INSERT INTO geral.tb_unidade VALUES (930101, 'Ag??ncia Estadual de Defesa Agropecu??ria', 'AGED', NULL, NULL, NULL, 'true', NULL, 943);
INSERT INTO geral.tb_unidade VALUES (240202, 'FUND.DO AMPARO A PESQ. DESENV.CIENT.TECNOL.MA', 'FAPEMA', '', '', '', 'true', 'steferson.ferreira@gmail.com', 454);


--
-- TOC entry 2961 (class 0 OID 24653)
-- Dependencies: 218
-- Data for Name: tb_usuario; Type: TABLE DATA; Schema: geral; Owner: postgres
--

INSERT INTO geral.tb_usuario VALUES (208, 'Salathiel', 'salathiel@stc.ma.gov.br', '', 'salathiel', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'D4wCnKYUcA0A0v2GorbaY2gpqlb8SV1WkdT1YLJZO5Gbm8cD0bD5v5Nk6toa', '2018-04-27 16:48:16', '2019-07-11 18:02:11', 80346146372, 'PROMOTOR DE JUSTI??A    ', false, NULL, '2019-07-11 18:02:11');
INSERT INTO geral.tb_usuario VALUES (357, 'Antonio Carlos', 'antoniocarlos@mail.com', '', 'carlos', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'de3pwjGxFh0uX5rseR6ECeREpG7IxWnFD2tjMHpfG1RpL59liTeOZcaChlPy', '2019-08-21 11:11:38', '2019-09-09 16:48:36', NULL, 'treinamento', false, NULL, '2019-09-09 16:48:36');
INSERT INTO geral.tb_usuario VALUES (369, 'Josivan Sousa', 'josivan@mail.com', '', 'josivan', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, NULL, '2020-01-17 00:08:03', '2020-01-17 00:08:03', 23423432432, NULL, false, NULL, NULL);
INSERT INTO geral.tb_usuario VALUES (210, 'Jesonilton', 'jesonilton@stc.ma.gov.br', '98999989999999', 'jesonilton', '$2y$10$mEIawoT69JJuHj./gI6swubY14z1Z1jtQ9pwFQVisRs/5euLR5xza', true, 'mSoWlpNoyzbKDs5izR2kQ4IQMnk5BXr01ZmNIWoJ0KQaxmt7cE3fNMUmSE5j', '2018-06-19 13:35:19', '2020-01-31 15:17:16', 60621194301, 'Analista', false, NULL, '2020-01-31 15:17:16');


--
-- TOC entry 2962 (class 0 OID 24661)
-- Dependencies: 219
-- Data for Name: tb_usuario_anexo; Type: TABLE DATA; Schema: geral; Owner: postgres
--



--
-- TOC entry 2964 (class 0 OID 24666)
-- Dependencies: 221
-- Data for Name: tb_usuario_mensagem; Type: TABLE DATA; Schema: geral; Owner: postgres
--



--
-- TOC entry 2966 (class 0 OID 24671)
-- Dependencies: 223
-- Data for Name: tb_usuario_unidade; Type: TABLE DATA; Schema: geral; Owner: postgres
--



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

SELECT pg_catalog.setval('geral.tb_categoria_recurso_int_categoria_recurso_id_seq', 13, true);


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

SELECT pg_catalog.setval('geral.tb_modulo_int_modulo_id_seq', 18, true);


--
-- TOC entry 2991 (class 0 OID 0)
-- Dependencies: 208
-- Name: tb_perfil_int_perfil_id_seq; Type: SEQUENCE SET; Schema: geral; Owner: postgres
--

SELECT pg_catalog.setval('geral.tb_perfil_int_perfil_id_seq', 44, true);


--
-- TOC entry 2992 (class 0 OID 0)
-- Dependencies: 212
-- Name: tb_permissao_int_permissao_id_seq; Type: SEQUENCE SET; Schema: geral; Owner: postgres
--

SELECT pg_catalog.setval('geral.tb_permissao_int_permissao_id_seq', 731, true);


--
-- TOC entry 2993 (class 0 OID 0)
-- Dependencies: 214
-- Name: tb_recurso_int_recurso_id_seq; Type: SEQUENCE SET; Schema: geral; Owner: postgres
--

SELECT pg_catalog.setval('geral.tb_recurso_int_recurso_id_seq', 135, true);


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


-- Completed on 2020-01-31 18:42:25

--
-- PostgreSQL database dump complete
--

