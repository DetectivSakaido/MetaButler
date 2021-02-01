--
-- PostgreSQL database dump
--

-- Dumped from database version 12.5 (Ubuntu 12.5-0ubuntu0.20.10.1)
-- Dumped by pg_dump version 12.5 (Ubuntu 12.5-0ubuntu0.20.10.1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: access_connection; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.access_connection (
    chat_id character varying(14) NOT NULL,
    allow_connect_to_chat boolean
);


ALTER TABLE public.access_connection OWNER TO destroyer;

--
-- Name: afk_users; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.afk_users (
    user_id integer NOT NULL,
    is_afk boolean,
    reason text
);


ALTER TABLE public.afk_users OWNER TO destroyer;

--
-- Name: afk_users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: destroyer
--

CREATE SEQUENCE public.afk_users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.afk_users_user_id_seq OWNER TO destroyer;

--
-- Name: afk_users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: destroyer
--

ALTER SEQUENCE public.afk_users_user_id_seq OWNED BY public.afk_users.user_id;


--
-- Name: antiflood; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.antiflood (
    chat_id character varying(14) NOT NULL,
    user_id integer,
    count integer,
    "limit" integer
);


ALTER TABLE public.antiflood OWNER TO destroyer;

--
-- Name: antispam_settings; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.antispam_settings (
    chat_id character varying(14) NOT NULL,
    setting boolean NOT NULL
);


ALTER TABLE public.antispam_settings OWNER TO destroyer;

--
-- Name: bans_feds; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.bans_feds (
    fed_id text NOT NULL,
    user_id character varying(14) NOT NULL,
    first_name text NOT NULL,
    last_name text,
    user_name text,
    reason text
);


ALTER TABLE public.bans_feds OWNER TO destroyer;

--
-- Name: blacklist; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.blacklist (
    chat_id character varying(14) NOT NULL,
    trigger text NOT NULL
);


ALTER TABLE public.blacklist OWNER TO destroyer;

--
-- Name: chat_feds; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.chat_feds (
    chat_id character varying(14) NOT NULL,
    fed_id text
);


ALTER TABLE public.chat_feds OWNER TO destroyer;

--
-- Name: chat_members; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.chat_members (
    priv_chat_id integer NOT NULL,
    chat character varying(14) NOT NULL,
    "user" integer NOT NULL
);


ALTER TABLE public.chat_members OWNER TO destroyer;

--
-- Name: chat_members_priv_chat_id_seq; Type: SEQUENCE; Schema: public; Owner: destroyer
--

CREATE SEQUENCE public.chat_members_priv_chat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chat_members_priv_chat_id_seq OWNER TO destroyer;

--
-- Name: chat_members_priv_chat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: destroyer
--

ALTER SEQUENCE public.chat_members_priv_chat_id_seq OWNED BY public.chat_members.priv_chat_id;


--
-- Name: chat_report_settings; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.chat_report_settings (
    chat_id character varying(14) NOT NULL,
    should_report boolean
);


ALTER TABLE public.chat_report_settings OWNER TO destroyer;

--
-- Name: chats; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.chats (
    chat_id character varying(14) NOT NULL,
    chat_name text NOT NULL
);


ALTER TABLE public.chats OWNER TO destroyer;

--
-- Name: clean_service; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.clean_service (
    chat_id character varying(14) NOT NULL,
    clean_service boolean
);


ALTER TABLE public.clean_service OWNER TO destroyer;

--
-- Name: comm_react_setting; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.comm_react_setting (
    chat_id character varying(14) NOT NULL,
    comm_reaction boolean
);


ALTER TABLE public.comm_react_setting OWNER TO destroyer;

--
-- Name: connection; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.connection (
    user_id integer NOT NULL,
    chat_id character varying(14)
);


ALTER TABLE public.connection OWNER TO destroyer;

--
-- Name: connection_history5; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.connection_history5 (
    user_id integer NOT NULL,
    chat_id1 character varying(14),
    chat_id2 character varying(14),
    chat_id3 character varying(14),
    updated integer
);


ALTER TABLE public.connection_history5 OWNER TO destroyer;

--
-- Name: connection_history5_user_id_seq; Type: SEQUENCE; Schema: public; Owner: destroyer
--

CREATE SEQUENCE public.connection_history5_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.connection_history5_user_id_seq OWNER TO destroyer;

--
-- Name: connection_history5_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: destroyer
--

ALTER SEQUENCE public.connection_history5_user_id_seq OWNED BY public.connection_history5.user_id;


--
-- Name: connection_user_id_seq; Type: SEQUENCE; Schema: public; Owner: destroyer
--

CREATE SEQUENCE public.connection_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.connection_user_id_seq OWNER TO destroyer;

--
-- Name: connection_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: destroyer
--

ALTER SEQUENCE public.connection_user_id_seq OWNED BY public.connection.user_id;


--
-- Name: cust_filter_urls; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.cust_filter_urls (
    id integer NOT NULL,
    chat_id character varying(14) NOT NULL,
    keyword text NOT NULL,
    name text NOT NULL,
    url text NOT NULL,
    same_line boolean
);


ALTER TABLE public.cust_filter_urls OWNER TO destroyer;

--
-- Name: cust_filter_urls_id_seq; Type: SEQUENCE; Schema: public; Owner: destroyer
--

CREATE SEQUENCE public.cust_filter_urls_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cust_filter_urls_id_seq OWNER TO destroyer;

--
-- Name: cust_filter_urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: destroyer
--

ALTER SEQUENCE public.cust_filter_urls_id_seq OWNED BY public.cust_filter_urls.id;


--
-- Name: cust_filters; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.cust_filters (
    chat_id character varying(14) NOT NULL,
    keyword text NOT NULL,
    reply text NOT NULL,
    is_sticker boolean NOT NULL,
    is_document boolean NOT NULL,
    is_image boolean NOT NULL,
    is_audio boolean NOT NULL,
    is_voice boolean NOT NULL,
    is_video boolean NOT NULL,
    has_buttons boolean NOT NULL,
    has_markdown boolean NOT NULL
);


ALTER TABLE public.cust_filters OWNER TO destroyer;

--
-- Name: disabled_commands; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.disabled_commands (
    chat_id character varying(14) NOT NULL,
    command text NOT NULL
);


ALTER TABLE public.disabled_commands OWNER TO destroyer;

--
-- Name: feds; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.feds (
    owner_id character varying(14),
    fed_name text,
    fed_id text NOT NULL,
    fed_rules text,
    fed_users text
);


ALTER TABLE public.feds OWNER TO destroyer;

--
-- Name: feds_settings; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.feds_settings (
    user_id integer NOT NULL,
    should_report boolean
);


ALTER TABLE public.feds_settings OWNER TO destroyer;

--
-- Name: feds_settings_user_id_seq; Type: SEQUENCE; Schema: public; Owner: destroyer
--

CREATE SEQUENCE public.feds_settings_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feds_settings_user_id_seq OWNER TO destroyer;

--
-- Name: feds_settings_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: destroyer
--

ALTER SEQUENCE public.feds_settings_user_id_seq OWNED BY public.feds_settings.user_id;


--
-- Name: leave_urls; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.leave_urls (
    id integer NOT NULL,
    chat_id character varying(14) NOT NULL,
    name text NOT NULL,
    url text NOT NULL,
    same_line boolean
);


ALTER TABLE public.leave_urls OWNER TO destroyer;

--
-- Name: leave_urls_id_seq; Type: SEQUENCE; Schema: public; Owner: destroyer
--

CREATE SEQUENCE public.leave_urls_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.leave_urls_id_seq OWNER TO destroyer;

--
-- Name: leave_urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: destroyer
--

ALTER SEQUENCE public.leave_urls_id_seq OWNED BY public.leave_urls.id;


--
-- Name: locales; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.locales (
    chat_id character varying(14) NOT NULL,
    locale_name text
);


ALTER TABLE public.locales OWNER TO destroyer;

--
-- Name: log_channels; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.log_channels (
    chat_id character varying(14) NOT NULL,
    log_channel character varying(14) NOT NULL
);


ALTER TABLE public.log_channels OWNER TO destroyer;

--
-- Name: note_urls; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.note_urls (
    id integer NOT NULL,
    chat_id character varying(14) NOT NULL,
    note_name text NOT NULL,
    name text NOT NULL,
    url text NOT NULL,
    same_line boolean
);


ALTER TABLE public.note_urls OWNER TO destroyer;

--
-- Name: note_urls_id_seq; Type: SEQUENCE; Schema: public; Owner: destroyer
--

CREATE SEQUENCE public.note_urls_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.note_urls_id_seq OWNER TO destroyer;

--
-- Name: note_urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: destroyer
--

ALTER SEQUENCE public.note_urls_id_seq OWNED BY public.note_urls.id;


--
-- Name: notes; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.notes (
    chat_id character varying(14) NOT NULL,
    name text NOT NULL,
    value text NOT NULL,
    file text,
    is_reply boolean,
    has_buttons boolean,
    msgtype integer
);


ALTER TABLE public.notes OWNER TO destroyer;

--
-- Name: permissions; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.permissions (
    chat_id character varying(14) NOT NULL,
    audio boolean,
    voice boolean,
    contact boolean,
    video boolean,
    videonote boolean,
    document boolean,
    photo boolean,
    sticker boolean,
    gif boolean,
    url boolean,
    bots boolean,
    forward boolean,
    game boolean,
    location boolean
);


ALTER TABLE public.permissions OWNER TO destroyer;

--
-- Name: restrictions; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.restrictions (
    chat_id character varying(14) NOT NULL,
    messages boolean,
    media boolean,
    other boolean,
    preview boolean
);


ALTER TABLE public.restrictions OWNER TO destroyer;

--
-- Name: rules; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.rules (
    chat_id character varying(14) NOT NULL,
    rules text
);


ALTER TABLE public.rules OWNER TO destroyer;

--
-- Name: url_blacklist; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.url_blacklist (
    chat_id character varying(14) NOT NULL,
    domain text NOT NULL
);


ALTER TABLE public.url_blacklist OWNER TO destroyer;

--
-- Name: user_report_settings; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.user_report_settings (
    user_id integer NOT NULL,
    should_report boolean
);


ALTER TABLE public.user_report_settings OWNER TO destroyer;

--
-- Name: user_report_settings_user_id_seq; Type: SEQUENCE; Schema: public; Owner: destroyer
--

CREATE SEQUENCE public.user_report_settings_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_report_settings_user_id_seq OWNER TO destroyer;

--
-- Name: user_report_settings_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: destroyer
--

ALTER SEQUENCE public.user_report_settings_user_id_seq OWNED BY public.user_report_settings.user_id;


--
-- Name: userbio; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.userbio (
    user_id integer NOT NULL,
    bio text
);


ALTER TABLE public.userbio OWNER TO destroyer;

--
-- Name: userbio_user_id_seq; Type: SEQUENCE; Schema: public; Owner: destroyer
--

CREATE SEQUENCE public.userbio_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.userbio_user_id_seq OWNER TO destroyer;

--
-- Name: userbio_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: destroyer
--

ALTER SEQUENCE public.userbio_user_id_seq OWNED BY public.userbio.user_id;


--
-- Name: userinfo; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.userinfo (
    user_id integer NOT NULL,
    info text
);


ALTER TABLE public.userinfo OWNER TO destroyer;

--
-- Name: userinfo_user_id_seq; Type: SEQUENCE; Schema: public; Owner: destroyer
--

CREATE SEQUENCE public.userinfo_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.userinfo_user_id_seq OWNER TO destroyer;

--
-- Name: userinfo_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: destroyer
--

ALTER SEQUENCE public.userinfo_user_id_seq OWNED BY public.userinfo.user_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username text
);


ALTER TABLE public.users OWNER TO destroyer;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: destroyer
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO destroyer;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: destroyer
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: warn_filters; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.warn_filters (
    chat_id character varying(14) NOT NULL,
    keyword text NOT NULL,
    reply text NOT NULL
);


ALTER TABLE public.warn_filters OWNER TO destroyer;

--
-- Name: warn_settings; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.warn_settings (
    chat_id character varying(14) NOT NULL,
    warn_limit integer,
    soft_warn boolean
);


ALTER TABLE public.warn_settings OWNER TO destroyer;

--
-- Name: warns; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.warns (
    user_id integer NOT NULL,
    chat_id character varying(14) NOT NULL,
    num_warns integer,
    reasons text[]
);


ALTER TABLE public.warns OWNER TO destroyer;

--
-- Name: welcome_pref; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.welcome_pref (
    chat_id character varying(14) NOT NULL,
    should_welcome boolean,
    should_goodbye boolean,
    custom_content text,
    custom_welcome text,
    welcome_type integer,
    custom_content_leave text,
    custom_leave text,
    leave_type integer,
    clean_welcome bigint
);


ALTER TABLE public.welcome_pref OWNER TO destroyer;

--
-- Name: welcome_restirectlist; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.welcome_restirectlist (
    chat_id character varying(14) NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.welcome_restirectlist OWNER TO destroyer;

--
-- Name: welcome_security; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.welcome_security (
    chat_id character varying(14) NOT NULL,
    security boolean,
    mute_time text,
    custom_text text
);


ALTER TABLE public.welcome_security OWNER TO destroyer;

--
-- Name: welcome_urls; Type: TABLE; Schema: public; Owner: destroyer
--

CREATE TABLE public.welcome_urls (
    id integer NOT NULL,
    chat_id character varying(14) NOT NULL,
    name text NOT NULL,
    url text NOT NULL,
    same_line boolean
);


ALTER TABLE public.welcome_urls OWNER TO destroyer;

--
-- Name: welcome_urls_id_seq; Type: SEQUENCE; Schema: public; Owner: destroyer
--

CREATE SEQUENCE public.welcome_urls_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.welcome_urls_id_seq OWNER TO destroyer;

--
-- Name: welcome_urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: destroyer
--

ALTER SEQUENCE public.welcome_urls_id_seq OWNED BY public.welcome_urls.id;


--
-- Name: afk_users user_id; Type: DEFAULT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.afk_users ALTER COLUMN user_id SET DEFAULT nextval('public.afk_users_user_id_seq'::regclass);


--
-- Name: chat_members priv_chat_id; Type: DEFAULT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.chat_members ALTER COLUMN priv_chat_id SET DEFAULT nextval('public.chat_members_priv_chat_id_seq'::regclass);


--
-- Name: connection user_id; Type: DEFAULT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.connection ALTER COLUMN user_id SET DEFAULT nextval('public.connection_user_id_seq'::regclass);


--
-- Name: connection_history5 user_id; Type: DEFAULT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.connection_history5 ALTER COLUMN user_id SET DEFAULT nextval('public.connection_history5_user_id_seq'::regclass);


--
-- Name: cust_filter_urls id; Type: DEFAULT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.cust_filter_urls ALTER COLUMN id SET DEFAULT nextval('public.cust_filter_urls_id_seq'::regclass);


--
-- Name: feds_settings user_id; Type: DEFAULT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.feds_settings ALTER COLUMN user_id SET DEFAULT nextval('public.feds_settings_user_id_seq'::regclass);


--
-- Name: leave_urls id; Type: DEFAULT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.leave_urls ALTER COLUMN id SET DEFAULT nextval('public.leave_urls_id_seq'::regclass);


--
-- Name: note_urls id; Type: DEFAULT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.note_urls ALTER COLUMN id SET DEFAULT nextval('public.note_urls_id_seq'::regclass);


--
-- Name: user_report_settings user_id; Type: DEFAULT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.user_report_settings ALTER COLUMN user_id SET DEFAULT nextval('public.user_report_settings_user_id_seq'::regclass);


--
-- Name: userbio user_id; Type: DEFAULT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.userbio ALTER COLUMN user_id SET DEFAULT nextval('public.userbio_user_id_seq'::regclass);


--
-- Name: userinfo user_id; Type: DEFAULT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.userinfo ALTER COLUMN user_id SET DEFAULT nextval('public.userinfo_user_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Name: welcome_urls id; Type: DEFAULT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.welcome_urls ALTER COLUMN id SET DEFAULT nextval('public.welcome_urls_id_seq'::regclass);


--
-- Data for Name: access_connection; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.access_connection (chat_id, allow_connect_to_chat) FROM stdin;
\.


--
-- Data for Name: afk_users; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.afk_users (user_id, is_afk, reason) FROM stdin;
\.


--
-- Data for Name: antiflood; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.antiflood (chat_id, user_id, count, "limit") FROM stdin;
\.


--
-- Data for Name: antispam_settings; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.antispam_settings (chat_id, setting) FROM stdin;
\.


--
-- Data for Name: bans_feds; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.bans_feds (fed_id, user_id, first_name, last_name, user_name, reason) FROM stdin;
\.


--
-- Data for Name: blacklist; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.blacklist (chat_id, trigger) FROM stdin;
\.


--
-- Data for Name: chat_feds; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.chat_feds (chat_id, fed_id) FROM stdin;
\.


--
-- Data for Name: chat_members; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.chat_members (priv_chat_id, chat, "user") FROM stdin;
1	-1001472918769	329095176
2	-1001472918769	1394048062
3	-1001472918769	628215130
4	-1001472918769	411860733
5	-1001394706846	329095176
6	-1001472918769	1226634960
7	-1001472918769	1215589105
8	-1001472918769	596701090
\.


--
-- Data for Name: chat_report_settings; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.chat_report_settings (chat_id, should_report) FROM stdin;
\.


--
-- Data for Name: chats; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.chats (chat_id, chat_name) FROM stdin;
-1001472918769	Mirror Discussion | OT
-1001394706846	metabutler test
\.


--
-- Data for Name: clean_service; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.clean_service (chat_id, clean_service) FROM stdin;
\.


--
-- Data for Name: comm_react_setting; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.comm_react_setting (chat_id, comm_reaction) FROM stdin;
\.


--
-- Data for Name: connection; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.connection (user_id, chat_id) FROM stdin;
\.


--
-- Data for Name: connection_history5; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.connection_history5 (user_id, chat_id1, chat_id2, chat_id3, updated) FROM stdin;
\.


--
-- Data for Name: cust_filter_urls; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.cust_filter_urls (id, chat_id, keyword, name, url, same_line) FROM stdin;
\.


--
-- Data for Name: cust_filters; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.cust_filters (chat_id, keyword, reply, is_sticker, is_document, is_image, is_audio, is_voice, is_video, has_buttons, has_markdown) FROM stdin;
-1001394706846	hi	gg	f	f	f	f	f	f	f	t
\.


--
-- Data for Name: disabled_commands; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.disabled_commands (chat_id, command) FROM stdin;
\.


--
-- Data for Name: feds; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.feds (owner_id, fed_name, fed_id, fed_rules, fed_users) FROM stdin;
\.


--
-- Data for Name: feds_settings; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.feds_settings (user_id, should_report) FROM stdin;
\.


--
-- Data for Name: leave_urls; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.leave_urls (id, chat_id, name, url, same_line) FROM stdin;
\.


--
-- Data for Name: locales; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.locales (chat_id, locale_name) FROM stdin;
\.


--
-- Data for Name: log_channels; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.log_channels (chat_id, log_channel) FROM stdin;
\.


--
-- Data for Name: note_urls; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.note_urls (id, chat_id, note_name, name, url, same_line) FROM stdin;
\.


--
-- Data for Name: notes; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.notes (chat_id, name, value, file, is_reply, has_buttons, msgtype) FROM stdin;
-1001394706846	why	why this bot replies as soon as filter is added	\N	f	f	0
-1001472918769	mirrorbot	List Of Mirror Bot Groups 🔥\n\n- @TorrentMirror\n- @MetaPublicLeech\n- @SammyTorrents\n- @NJTorrent\n- @TroyMods\n\nFor XXX Content 🔥\n- @PornMirror\n- @MetaXPublicLeech	\N	f	f	0
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.permissions (chat_id, audio, voice, contact, video, videonote, document, photo, sticker, gif, url, bots, forward, game, location) FROM stdin;
\.


--
-- Data for Name: restrictions; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.restrictions (chat_id, messages, media, other, preview) FROM stdin;
\.


--
-- Data for Name: rules; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.rules (chat_id, rules) FROM stdin;
\.


--
-- Data for Name: url_blacklist; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.url_blacklist (chat_id, domain) FROM stdin;
\.


--
-- Data for Name: user_report_settings; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.user_report_settings (user_id, should_report) FROM stdin;
\.


--
-- Data for Name: userbio; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.userbio (user_id, bio) FROM stdin;
\.


--
-- Data for Name: userinfo; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.userinfo (user_id, info) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.users (user_id, username) FROM stdin;
1215589105	Metabutlertestbot
329095176	Destroyer32
1394048062	LuciferTheFallen
628215130	troy007
411860733	CoolDude69_420
1226634960	stevenbin
750715841	Celebi898
596701090	Zero_cool7870
\.


--
-- Data for Name: warn_filters; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.warn_filters (chat_id, keyword, reply) FROM stdin;
\.


--
-- Data for Name: warn_settings; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.warn_settings (chat_id, warn_limit, soft_warn) FROM stdin;
\.


--
-- Data for Name: warns; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.warns (user_id, chat_id, num_warns, reasons) FROM stdin;
\.


--
-- Data for Name: welcome_pref; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.welcome_pref (chat_id, should_welcome, should_goodbye, custom_content, custom_welcome, welcome_type, custom_content_leave, custom_leave, leave_type, clean_welcome) FROM stdin;
\.


--
-- Data for Name: welcome_restirectlist; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.welcome_restirectlist (chat_id, user_id) FROM stdin;
\.


--
-- Data for Name: welcome_security; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.welcome_security (chat_id, security, mute_time, custom_text) FROM stdin;
\.


--
-- Data for Name: welcome_urls; Type: TABLE DATA; Schema: public; Owner: destroyer
--

COPY public.welcome_urls (id, chat_id, name, url, same_line) FROM stdin;
\.


--
-- Name: afk_users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: destroyer
--

SELECT pg_catalog.setval('public.afk_users_user_id_seq', 1, false);


--
-- Name: chat_members_priv_chat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: destroyer
--

SELECT pg_catalog.setval('public.chat_members_priv_chat_id_seq', 8, true);


--
-- Name: connection_history5_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: destroyer
--

SELECT pg_catalog.setval('public.connection_history5_user_id_seq', 1, false);


--
-- Name: connection_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: destroyer
--

SELECT pg_catalog.setval('public.connection_user_id_seq', 1, false);


--
-- Name: cust_filter_urls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: destroyer
--

SELECT pg_catalog.setval('public.cust_filter_urls_id_seq', 1, false);


--
-- Name: feds_settings_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: destroyer
--

SELECT pg_catalog.setval('public.feds_settings_user_id_seq', 1, false);


--
-- Name: leave_urls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: destroyer
--

SELECT pg_catalog.setval('public.leave_urls_id_seq', 1, false);


--
-- Name: note_urls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: destroyer
--

SELECT pg_catalog.setval('public.note_urls_id_seq', 1, false);


--
-- Name: user_report_settings_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: destroyer
--

SELECT pg_catalog.setval('public.user_report_settings_user_id_seq', 1, false);


--
-- Name: userbio_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: destroyer
--

SELECT pg_catalog.setval('public.userbio_user_id_seq', 1, false);


--
-- Name: userinfo_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: destroyer
--

SELECT pg_catalog.setval('public.userinfo_user_id_seq', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: destroyer
--

SELECT pg_catalog.setval('public.users_user_id_seq', 1, false);


--
-- Name: welcome_urls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: destroyer
--

SELECT pg_catalog.setval('public.welcome_urls_id_seq', 1, false);


--
-- Name: chat_members _chat_members_uc; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.chat_members
    ADD CONSTRAINT _chat_members_uc UNIQUE (chat, "user");


--
-- Name: access_connection access_connection_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.access_connection
    ADD CONSTRAINT access_connection_pkey PRIMARY KEY (chat_id);


--
-- Name: afk_users afk_users_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.afk_users
    ADD CONSTRAINT afk_users_pkey PRIMARY KEY (user_id);


--
-- Name: antiflood antiflood_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.antiflood
    ADD CONSTRAINT antiflood_pkey PRIMARY KEY (chat_id);


--
-- Name: antispam_settings antispam_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.antispam_settings
    ADD CONSTRAINT antispam_settings_pkey PRIMARY KEY (chat_id);


--
-- Name: bans_feds bans_feds_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.bans_feds
    ADD CONSTRAINT bans_feds_pkey PRIMARY KEY (fed_id, user_id);


--
-- Name: blacklist blacklist_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.blacklist
    ADD CONSTRAINT blacklist_pkey PRIMARY KEY (chat_id, trigger);


--
-- Name: chat_feds chat_feds_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.chat_feds
    ADD CONSTRAINT chat_feds_pkey PRIMARY KEY (chat_id);


--
-- Name: chat_members chat_members_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.chat_members
    ADD CONSTRAINT chat_members_pkey PRIMARY KEY (priv_chat_id);


--
-- Name: chat_report_settings chat_report_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.chat_report_settings
    ADD CONSTRAINT chat_report_settings_pkey PRIMARY KEY (chat_id);


--
-- Name: chats chats_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.chats
    ADD CONSTRAINT chats_pkey PRIMARY KEY (chat_id);


--
-- Name: clean_service clean_service_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.clean_service
    ADD CONSTRAINT clean_service_pkey PRIMARY KEY (chat_id);


--
-- Name: comm_react_setting comm_react_setting_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.comm_react_setting
    ADD CONSTRAINT comm_react_setting_pkey PRIMARY KEY (chat_id);


--
-- Name: connection_history5 connection_history5_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.connection_history5
    ADD CONSTRAINT connection_history5_pkey PRIMARY KEY (user_id);


--
-- Name: connection connection_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.connection
    ADD CONSTRAINT connection_pkey PRIMARY KEY (user_id);


--
-- Name: cust_filter_urls cust_filter_urls_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.cust_filter_urls
    ADD CONSTRAINT cust_filter_urls_pkey PRIMARY KEY (id, chat_id, keyword);


--
-- Name: cust_filters cust_filters_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.cust_filters
    ADD CONSTRAINT cust_filters_pkey PRIMARY KEY (chat_id, keyword);


--
-- Name: disabled_commands disabled_commands_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.disabled_commands
    ADD CONSTRAINT disabled_commands_pkey PRIMARY KEY (chat_id, command);


--
-- Name: feds feds_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.feds
    ADD CONSTRAINT feds_pkey PRIMARY KEY (fed_id);


--
-- Name: feds_settings feds_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.feds_settings
    ADD CONSTRAINT feds_settings_pkey PRIMARY KEY (user_id);


--
-- Name: leave_urls leave_urls_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.leave_urls
    ADD CONSTRAINT leave_urls_pkey PRIMARY KEY (id, chat_id);


--
-- Name: locales locales_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.locales
    ADD CONSTRAINT locales_pkey PRIMARY KEY (chat_id);


--
-- Name: log_channels log_channels_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.log_channels
    ADD CONSTRAINT log_channels_pkey PRIMARY KEY (chat_id);


--
-- Name: note_urls note_urls_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.note_urls
    ADD CONSTRAINT note_urls_pkey PRIMARY KEY (id, chat_id, note_name);


--
-- Name: notes notes_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (chat_id, name);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (chat_id);


--
-- Name: restrictions restrictions_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.restrictions
    ADD CONSTRAINT restrictions_pkey PRIMARY KEY (chat_id);


--
-- Name: rules rules_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.rules
    ADD CONSTRAINT rules_pkey PRIMARY KEY (chat_id);


--
-- Name: url_blacklist url_blacklist_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.url_blacklist
    ADD CONSTRAINT url_blacklist_pkey PRIMARY KEY (chat_id, domain);


--
-- Name: user_report_settings user_report_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.user_report_settings
    ADD CONSTRAINT user_report_settings_pkey PRIMARY KEY (user_id);


--
-- Name: userbio userbio_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.userbio
    ADD CONSTRAINT userbio_pkey PRIMARY KEY (user_id);


--
-- Name: userinfo userinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.userinfo
    ADD CONSTRAINT userinfo_pkey PRIMARY KEY (user_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: warn_filters warn_filters_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.warn_filters
    ADD CONSTRAINT warn_filters_pkey PRIMARY KEY (chat_id, keyword);


--
-- Name: warn_settings warn_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.warn_settings
    ADD CONSTRAINT warn_settings_pkey PRIMARY KEY (chat_id);


--
-- Name: warns warns_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.warns
    ADD CONSTRAINT warns_pkey PRIMARY KEY (user_id, chat_id);


--
-- Name: welcome_pref welcome_pref_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.welcome_pref
    ADD CONSTRAINT welcome_pref_pkey PRIMARY KEY (chat_id);


--
-- Name: welcome_restirectlist welcome_restirectlist_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.welcome_restirectlist
    ADD CONSTRAINT welcome_restirectlist_pkey PRIMARY KEY (chat_id, user_id);


--
-- Name: welcome_security welcome_security_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.welcome_security
    ADD CONSTRAINT welcome_security_pkey PRIMARY KEY (chat_id);


--
-- Name: welcome_urls welcome_urls_pkey; Type: CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.welcome_urls
    ADD CONSTRAINT welcome_urls_pkey PRIMARY KEY (id, chat_id);


--
-- Name: chat_members chat_members_chat_fkey; Type: FK CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.chat_members
    ADD CONSTRAINT chat_members_chat_fkey FOREIGN KEY (chat) REFERENCES public.chats(chat_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: chat_members chat_members_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: destroyer
--

ALTER TABLE ONLY public.chat_members
    ADD CONSTRAINT chat_members_user_fkey FOREIGN KEY ("user") REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

