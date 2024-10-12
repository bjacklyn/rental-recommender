--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0 (Debian 17.0-1.pgdg120+1)
-- Dumped by pg_dump version 17.0 (Debian 17.0-1.pgdg120+1)

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

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
d954e40a-95eb-4c8d-bbe6-a1de520c31a8	60	300	300	\N	\N	\N	t	f	0	\N	houseproject	0	\N	t	t	t	f	EXTERNAL	1800	36000	f	f	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	2fc6be72-9b7a-4c0c-a7cf-e57c395d7d60	cda2f3b5-7631-4f6f-a35d-45eb6be3d5cf	921ad445-fa6a-49a1-ae44-459d424b3a1e	c27cbc96-3cc6-485a-816f-bf493f51c252	4743939c-ee3d-4323-9e15-77aa168c815c	2592000	f	900	t	f	775a1abb-8edb-440e-b121-fd49d66fa1ff	0	f	0	0	538419ab-6282-4178-8ca3-3ed943c4de09
3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	2610030b-00c5-4f55-aaf5-c19053e277eb	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	d3c96e7f-7bfc-44bd-a30a-12e380558ca3	57c16665-3935-409c-93de-ffcde5b9840e	6504ae30-1efb-4dbd-afbd-80c298defa1c	07f9ff80-11fb-4338-9a8e-c3d0416bee55	8cdd92f2-d4c0-4619-8f71-3f918bd8ce61	2592000	f	900	t	f	e2fbaa18-d4d4-48a2-9fdb-4f21f9224745	0	f	0	0	3edc0499-ea4d-423d-a6a1-179788bf8222
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
d3c96e7f-7bfc-44bd-a30a-12e380558ca3	browser	browser based authentication	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	basic-flow	t	t
61b1f702-5bca-4735-9fc1-6506039a9528	forms	Username, password, otp and other auth forms.	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	basic-flow	f	t
9aaebe5d-5aa6-4413-bbc5-43072b52eb46	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	basic-flow	f	t
6504ae30-1efb-4dbd-afbd-80c298defa1c	direct grant	OpenID Connect Resource Owner Grant	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	basic-flow	t	t
ef928ba6-ecf7-4cdb-8585-aaeae324753d	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	basic-flow	f	t
57c16665-3935-409c-93de-ffcde5b9840e	registration	registration flow	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	basic-flow	t	t
22a2f5b7-6c9a-413d-8713-51f36a18170a	registration form	registration form	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	form-flow	f	t
07f9ff80-11fb-4338-9a8e-c3d0416bee55	reset credentials	Reset credentials for a user if they forgot their password or something	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	basic-flow	t	t
dc28376a-fe4b-429a-8ec5-a45c2962531a	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	basic-flow	f	t
8cdd92f2-d4c0-4619-8f71-3f918bd8ce61	clients	Base authentication for clients	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	client-flow	t	t
7f93ff67-ccc7-401d-ab29-c412eeb9b4e0	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	basic-flow	t	t
51adebc8-b350-49d5-b548-18ad882c3689	User creation or linking	Flow for the existing/non-existing user alternatives	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	basic-flow	f	t
0143d0ac-774e-4742-b7a7-908abc61dd99	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	basic-flow	f	t
639f1961-ec79-4e95-baf5-b22719490732	Account verification options	Method with which to verity the existing account	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	basic-flow	f	t
0df224b0-50d0-407d-acf0-3e9d81e9f350	Verify Existing Account by Re-authentication	Reauthentication of existing account	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	basic-flow	f	t
f7cb6a10-d104-48e7-bc04-8ca6f36db02f	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	basic-flow	f	t
e177928b-6e09-4baa-a989-ee4c2d654afc	saml ecp	SAML ECP Profile Authentication Flow	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	basic-flow	t	t
e2fbaa18-d4d4-48a2-9fdb-4f21f9224745	docker auth	Used by Docker clients to authenticate against the IDP	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	basic-flow	t	t
2fc6be72-9b7a-4c0c-a7cf-e57c395d7d60	browser	browser based authentication	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	basic-flow	t	t
107af0f4-73ab-4168-a664-0dbce85e6a3e	forms	Username, password, otp and other auth forms.	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	basic-flow	f	t
250abe42-eb93-4cf5-9aa0-fdc05acefe58	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	basic-flow	f	t
921ad445-fa6a-49a1-ae44-459d424b3a1e	direct grant	OpenID Connect Resource Owner Grant	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	basic-flow	t	t
391c034e-983e-487f-8573-42eb39154ea1	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	basic-flow	f	t
cda2f3b5-7631-4f6f-a35d-45eb6be3d5cf	registration	registration flow	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	basic-flow	t	t
a6d63518-54ea-408c-817b-942d0917ae54	registration form	registration form	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	form-flow	f	t
c27cbc96-3cc6-485a-816f-bf493f51c252	reset credentials	Reset credentials for a user if they forgot their password or something	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	basic-flow	t	t
14770064-c3cd-4196-a122-de36f90585b2	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	basic-flow	f	t
4743939c-ee3d-4323-9e15-77aa168c815c	clients	Base authentication for clients	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	client-flow	t	t
0827ef01-b057-4727-98d5-a9a2a954720b	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	basic-flow	t	t
01ba149e-2fa2-4a92-85e7-67fa72db9041	User creation or linking	Flow for the existing/non-existing user alternatives	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	basic-flow	f	t
9063bdfa-acdf-4202-881c-a214b8be8c36	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	basic-flow	f	t
73d0e948-e34b-4dbb-9e01-ed6182cda813	Account verification options	Method with which to verity the existing account	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	basic-flow	f	t
f0bc1547-4e52-45f7-aa73-6bea84fe6ea0	Verify Existing Account by Re-authentication	Reauthentication of existing account	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	basic-flow	f	t
c3060eb4-483a-4547-b602-45ffe5beeec3	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	basic-flow	f	t
12051288-9059-49db-8ea4-53ce16253abe	saml ecp	SAML ECP Profile Authentication Flow	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	basic-flow	t	t
775a1abb-8edb-440e-b121-fd49d66fa1ff	docker auth	Used by Docker clients to authenticate against the IDP	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	basic-flow	t	t
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
4909e02a-74e1-4c7b-b9fd-e86aec41a695	\N	auth-cookie	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	d3c96e7f-7bfc-44bd-a30a-12e380558ca3	2	10	f	\N	\N
3bbe305f-8e24-40b8-9d68-e2c9378068dd	\N	auth-spnego	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	d3c96e7f-7bfc-44bd-a30a-12e380558ca3	3	20	f	\N	\N
902b841a-bac9-43dd-b8ef-5393f84a0f32	\N	identity-provider-redirector	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	d3c96e7f-7bfc-44bd-a30a-12e380558ca3	2	25	f	\N	\N
37503a72-c507-41b1-a002-332523538a2d	\N	\N	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	d3c96e7f-7bfc-44bd-a30a-12e380558ca3	2	30	t	61b1f702-5bca-4735-9fc1-6506039a9528	\N
e9df2e7d-64f5-4689-baed-13cbdfac20ca	\N	auth-username-password-form	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	61b1f702-5bca-4735-9fc1-6506039a9528	0	10	f	\N	\N
700e3a90-6db7-4972-ad18-7ef9bb18c556	\N	\N	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	61b1f702-5bca-4735-9fc1-6506039a9528	1	20	t	9aaebe5d-5aa6-4413-bbc5-43072b52eb46	\N
cf4abcda-052c-442c-9f4f-0b5a71324e9f	\N	conditional-user-configured	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	9aaebe5d-5aa6-4413-bbc5-43072b52eb46	0	10	f	\N	\N
03f82378-f9ea-4c89-9e99-b1c36bcbbc21	\N	auth-otp-form	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	9aaebe5d-5aa6-4413-bbc5-43072b52eb46	0	20	f	\N	\N
b99592d1-077e-49c7-b485-0d8de936745e	\N	direct-grant-validate-username	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	6504ae30-1efb-4dbd-afbd-80c298defa1c	0	10	f	\N	\N
24fa32e7-33f1-4aa4-b559-0a09af101a8f	\N	direct-grant-validate-password	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	6504ae30-1efb-4dbd-afbd-80c298defa1c	0	20	f	\N	\N
219f0348-83a5-44e3-956d-4b327db21ab0	\N	\N	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	6504ae30-1efb-4dbd-afbd-80c298defa1c	1	30	t	ef928ba6-ecf7-4cdb-8585-aaeae324753d	\N
09f20146-0a32-437f-b357-aa455cfe159e	\N	conditional-user-configured	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	ef928ba6-ecf7-4cdb-8585-aaeae324753d	0	10	f	\N	\N
a6141fb1-1dcc-484d-868d-df23950e6c35	\N	direct-grant-validate-otp	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	ef928ba6-ecf7-4cdb-8585-aaeae324753d	0	20	f	\N	\N
7f74daa5-7b7c-4ad2-82e7-0988d0c4d123	\N	registration-page-form	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	57c16665-3935-409c-93de-ffcde5b9840e	0	10	t	22a2f5b7-6c9a-413d-8713-51f36a18170a	\N
6eb64221-eb5b-4290-aa42-625438050684	\N	registration-user-creation	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	22a2f5b7-6c9a-413d-8713-51f36a18170a	0	20	f	\N	\N
526017da-617b-46d8-82af-ee8dac0ef373	\N	registration-password-action	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	22a2f5b7-6c9a-413d-8713-51f36a18170a	0	50	f	\N	\N
0e7714bf-72a0-497a-ba86-09c731f43ff3	\N	registration-recaptcha-action	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	22a2f5b7-6c9a-413d-8713-51f36a18170a	3	60	f	\N	\N
ee5855dc-ab66-4be8-a9d6-39d10b5dc4c2	\N	registration-terms-and-conditions	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	22a2f5b7-6c9a-413d-8713-51f36a18170a	3	70	f	\N	\N
386e1178-5c2a-418f-b066-7c8e570c648a	\N	reset-credentials-choose-user	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	07f9ff80-11fb-4338-9a8e-c3d0416bee55	0	10	f	\N	\N
aba2148f-c656-4f3c-8bad-48d1e5815e52	\N	reset-credential-email	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	07f9ff80-11fb-4338-9a8e-c3d0416bee55	0	20	f	\N	\N
743c3676-e225-4918-838c-a25d63aa53d1	\N	reset-password	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	07f9ff80-11fb-4338-9a8e-c3d0416bee55	0	30	f	\N	\N
206d1571-be5a-4824-945c-fc2c977c5dc1	\N	\N	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	07f9ff80-11fb-4338-9a8e-c3d0416bee55	1	40	t	dc28376a-fe4b-429a-8ec5-a45c2962531a	\N
2b8b2cf1-9197-4a23-b862-e25f52519ecf	\N	conditional-user-configured	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	dc28376a-fe4b-429a-8ec5-a45c2962531a	0	10	f	\N	\N
5b9d4296-7959-4b61-bd17-f71f100570e6	\N	reset-otp	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	dc28376a-fe4b-429a-8ec5-a45c2962531a	0	20	f	\N	\N
d416672a-b2dc-40c8-82fa-c5a25bf5c78e	\N	client-secret	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	8cdd92f2-d4c0-4619-8f71-3f918bd8ce61	2	10	f	\N	\N
09de92e1-f1e3-49f1-93ed-eea3ab3c76de	\N	client-jwt	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	8cdd92f2-d4c0-4619-8f71-3f918bd8ce61	2	20	f	\N	\N
2dea01bc-a2ac-4233-8c25-cbf75d6d509b	\N	client-secret-jwt	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	8cdd92f2-d4c0-4619-8f71-3f918bd8ce61	2	30	f	\N	\N
5d403b2d-90bd-4cc2-8a81-c56e86f75fb2	\N	client-x509	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	8cdd92f2-d4c0-4619-8f71-3f918bd8ce61	2	40	f	\N	\N
6a31d912-a7d7-41de-9a7e-aff387f2d96b	\N	idp-review-profile	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	7f93ff67-ccc7-401d-ab29-c412eeb9b4e0	0	10	f	\N	b66b9528-028f-48a1-b067-59f0d896bf1e
8ee656c2-5c60-498a-8a00-67ab95825008	\N	\N	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	7f93ff67-ccc7-401d-ab29-c412eeb9b4e0	0	20	t	51adebc8-b350-49d5-b548-18ad882c3689	\N
1a2fde96-2034-4fde-9783-12a6761c8250	\N	idp-create-user-if-unique	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	51adebc8-b350-49d5-b548-18ad882c3689	2	10	f	\N	144550c1-5da4-4456-93a5-5af491bddf1e
71eeabf9-ec12-463f-bbe0-915889c7b1f2	\N	\N	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	51adebc8-b350-49d5-b548-18ad882c3689	2	20	t	0143d0ac-774e-4742-b7a7-908abc61dd99	\N
a679df22-4b7d-463b-9a22-d723a1077f87	\N	idp-confirm-link	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	0143d0ac-774e-4742-b7a7-908abc61dd99	0	10	f	\N	\N
4f943e5e-fc63-4753-b675-b110d62fa701	\N	\N	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	0143d0ac-774e-4742-b7a7-908abc61dd99	0	20	t	639f1961-ec79-4e95-baf5-b22719490732	\N
10daa675-7338-40cc-9d96-33ed07513a02	\N	idp-email-verification	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	639f1961-ec79-4e95-baf5-b22719490732	2	10	f	\N	\N
86cbda68-4713-4497-98cf-3df1bc2b71c5	\N	\N	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	639f1961-ec79-4e95-baf5-b22719490732	2	20	t	0df224b0-50d0-407d-acf0-3e9d81e9f350	\N
080aec0a-358f-4bfc-83bb-64b6a5f03af3	\N	idp-username-password-form	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	0df224b0-50d0-407d-acf0-3e9d81e9f350	0	10	f	\N	\N
4595fc80-812a-42a6-a17a-43dfe98a295d	\N	\N	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	0df224b0-50d0-407d-acf0-3e9d81e9f350	1	20	t	f7cb6a10-d104-48e7-bc04-8ca6f36db02f	\N
d96a444d-0f4e-4671-ac5c-6d21b5089585	\N	conditional-user-configured	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	f7cb6a10-d104-48e7-bc04-8ca6f36db02f	0	10	f	\N	\N
68c20ced-afe1-4e22-b46c-61fb4cfa463d	\N	auth-otp-form	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	f7cb6a10-d104-48e7-bc04-8ca6f36db02f	0	20	f	\N	\N
b3f9186f-da3f-4fbc-97c4-8b00c46ac63f	\N	http-basic-authenticator	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	e177928b-6e09-4baa-a989-ee4c2d654afc	0	10	f	\N	\N
08805f24-04fa-443a-b08b-7be77b990259	\N	docker-http-basic-authenticator	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	e2fbaa18-d4d4-48a2-9fdb-4f21f9224745	0	10	f	\N	\N
89365c18-bd36-41e9-8a54-6ff5d19ad334	\N	auth-cookie	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	2fc6be72-9b7a-4c0c-a7cf-e57c395d7d60	2	10	f	\N	\N
bc59a71b-1bed-4a72-bb9b-638ce58bbf49	\N	auth-spnego	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	2fc6be72-9b7a-4c0c-a7cf-e57c395d7d60	3	20	f	\N	\N
0b788f3a-0244-4e75-8178-dcb0396d49cf	\N	identity-provider-redirector	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	2fc6be72-9b7a-4c0c-a7cf-e57c395d7d60	2	25	f	\N	\N
d74c10a8-c852-420c-8dae-f476365209bd	\N	\N	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	2fc6be72-9b7a-4c0c-a7cf-e57c395d7d60	2	30	t	107af0f4-73ab-4168-a664-0dbce85e6a3e	\N
e7dea1a3-8b33-4da1-a473-577d477010de	\N	auth-username-password-form	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	107af0f4-73ab-4168-a664-0dbce85e6a3e	0	10	f	\N	\N
37cbd28e-d274-473c-9f62-bcad030957f2	\N	\N	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	107af0f4-73ab-4168-a664-0dbce85e6a3e	1	20	t	250abe42-eb93-4cf5-9aa0-fdc05acefe58	\N
9fd71b33-739d-4058-8bc2-f4b8cfb22579	\N	conditional-user-configured	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	250abe42-eb93-4cf5-9aa0-fdc05acefe58	0	10	f	\N	\N
fa4183cf-a436-45cd-a654-4c32caf8e1f8	\N	auth-otp-form	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	250abe42-eb93-4cf5-9aa0-fdc05acefe58	0	20	f	\N	\N
357865d8-6432-49a8-b4fe-fb5ea6b0543e	\N	direct-grant-validate-username	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	921ad445-fa6a-49a1-ae44-459d424b3a1e	0	10	f	\N	\N
3b776609-9d01-4b26-98e2-dbb759c36f1d	\N	direct-grant-validate-password	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	921ad445-fa6a-49a1-ae44-459d424b3a1e	0	20	f	\N	\N
85654ba8-6259-4878-a818-40dd6c951272	\N	\N	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	921ad445-fa6a-49a1-ae44-459d424b3a1e	1	30	t	391c034e-983e-487f-8573-42eb39154ea1	\N
db870be9-fedd-4896-8ec2-51ec37277b44	\N	conditional-user-configured	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	391c034e-983e-487f-8573-42eb39154ea1	0	10	f	\N	\N
30e3c2fd-eb1a-4116-a23d-a7c84205ba4c	\N	direct-grant-validate-otp	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	391c034e-983e-487f-8573-42eb39154ea1	0	20	f	\N	\N
2e4cc394-0200-4234-8240-b3e52f600ad3	\N	registration-page-form	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	cda2f3b5-7631-4f6f-a35d-45eb6be3d5cf	0	10	t	a6d63518-54ea-408c-817b-942d0917ae54	\N
46f5cd00-6cb3-42d8-838b-aa6ef3031b6e	\N	registration-user-creation	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	a6d63518-54ea-408c-817b-942d0917ae54	0	20	f	\N	\N
10deb589-6a82-4544-a9d5-905498d754fd	\N	registration-password-action	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	a6d63518-54ea-408c-817b-942d0917ae54	0	50	f	\N	\N
42abac8b-d207-4b77-be83-f8752bd5ceda	\N	registration-recaptcha-action	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	a6d63518-54ea-408c-817b-942d0917ae54	3	60	f	\N	\N
712598fd-b46a-43ac-a4f8-b3be175a0c3a	\N	registration-terms-and-conditions	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	a6d63518-54ea-408c-817b-942d0917ae54	3	70	f	\N	\N
eb9aa50d-f00e-4bee-b336-928ec4cf1bc8	\N	reset-credentials-choose-user	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	c27cbc96-3cc6-485a-816f-bf493f51c252	0	10	f	\N	\N
103409f4-7bef-48ae-97e3-a2c9901d2fcc	\N	reset-credential-email	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	c27cbc96-3cc6-485a-816f-bf493f51c252	0	20	f	\N	\N
9fb25f7b-6c9c-4220-aa3b-5801daa55307	\N	reset-password	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	c27cbc96-3cc6-485a-816f-bf493f51c252	0	30	f	\N	\N
7052ec25-def2-4c44-a03d-e91aa55c07ad	\N	\N	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	c27cbc96-3cc6-485a-816f-bf493f51c252	1	40	t	14770064-c3cd-4196-a122-de36f90585b2	\N
63d40b51-38c3-47e6-8d71-5794530cf91f	\N	conditional-user-configured	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	14770064-c3cd-4196-a122-de36f90585b2	0	10	f	\N	\N
211da447-91f5-42fa-a02a-b7dc19f691ef	\N	reset-otp	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	14770064-c3cd-4196-a122-de36f90585b2	0	20	f	\N	\N
8b3d3af0-0a85-45cf-b60c-47d9f844c0b5	\N	client-secret	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	4743939c-ee3d-4323-9e15-77aa168c815c	2	10	f	\N	\N
bfaeb9f9-75fb-4aa1-b545-e681860fbf2d	\N	client-jwt	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	4743939c-ee3d-4323-9e15-77aa168c815c	2	20	f	\N	\N
2df70a14-4d03-450e-91b8-2078ecdc55fd	\N	client-secret-jwt	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	4743939c-ee3d-4323-9e15-77aa168c815c	2	30	f	\N	\N
9db0fec8-b9cb-4bce-8fbe-28f1a2e2fc32	\N	client-x509	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	4743939c-ee3d-4323-9e15-77aa168c815c	2	40	f	\N	\N
df882873-b7a5-4ee0-89d9-04d14a26f43c	\N	idp-review-profile	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	0827ef01-b057-4727-98d5-a9a2a954720b	0	10	f	\N	d399ca7f-2672-4eef-b42e-728b4e3e5f93
1b48c5d6-17f3-43f3-b7f0-2fb5a269bdfe	\N	\N	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	0827ef01-b057-4727-98d5-a9a2a954720b	0	20	t	01ba149e-2fa2-4a92-85e7-67fa72db9041	\N
c1e66924-549a-4c63-a6cf-8472092c143a	\N	idp-create-user-if-unique	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	01ba149e-2fa2-4a92-85e7-67fa72db9041	2	10	f	\N	a6e26960-fcb3-4cc0-8573-4dc192238a5e
cbad48d9-d3f1-4fc6-a842-c08100c3dab1	\N	\N	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	01ba149e-2fa2-4a92-85e7-67fa72db9041	2	20	t	9063bdfa-acdf-4202-881c-a214b8be8c36	\N
d1c955ab-997f-4bee-962d-6978671b9886	\N	idp-confirm-link	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	9063bdfa-acdf-4202-881c-a214b8be8c36	0	10	f	\N	\N
b303124b-39af-482f-bbe7-661de4d328ac	\N	\N	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	9063bdfa-acdf-4202-881c-a214b8be8c36	0	20	t	73d0e948-e34b-4dbb-9e01-ed6182cda813	\N
411cbd3f-ef00-49d3-a9c8-62baf05abb81	\N	idp-email-verification	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	73d0e948-e34b-4dbb-9e01-ed6182cda813	2	10	f	\N	\N
a1de0fdf-c4fc-4cc5-bd54-0c057ef3f635	\N	\N	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	73d0e948-e34b-4dbb-9e01-ed6182cda813	2	20	t	f0bc1547-4e52-45f7-aa73-6bea84fe6ea0	\N
9b022246-afb6-445e-bb10-058030da9395	\N	idp-username-password-form	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	f0bc1547-4e52-45f7-aa73-6bea84fe6ea0	0	10	f	\N	\N
ff5b2451-1e76-4691-80bd-9d1fbb13efcd	\N	\N	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	f0bc1547-4e52-45f7-aa73-6bea84fe6ea0	1	20	t	c3060eb4-483a-4547-b602-45ffe5beeec3	\N
e157ed60-f3ac-495c-bd44-afaaf43389d5	\N	conditional-user-configured	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	c3060eb4-483a-4547-b602-45ffe5beeec3	0	10	f	\N	\N
2d1c058a-b887-45ae-a4f2-424a4c5912cc	\N	auth-otp-form	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	c3060eb4-483a-4547-b602-45ffe5beeec3	0	20	f	\N	\N
5a1a0b6f-958a-4b74-822e-d65ec610afd8	\N	http-basic-authenticator	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	12051288-9059-49db-8ea4-53ce16253abe	0	10	f	\N	\N
d0b1e029-0e4d-433d-a646-cef924ebfe88	\N	docker-http-basic-authenticator	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	775a1abb-8edb-440e-b121-fd49d66fa1ff	0	10	f	\N	\N
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
b66b9528-028f-48a1-b067-59f0d896bf1e	review profile config	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3
144550c1-5da4-4456-93a5-5af491bddf1e	create unique user config	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3
d399ca7f-2672-4eef-b42e-728b4e3e5f93	review profile config	d954e40a-95eb-4c8d-bbe6-a1de520c31a8
a6e26960-fcb3-4cc0-8573-4dc192238a5e	create unique user config	d954e40a-95eb-4c8d-bbe6-a1de520c31a8
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
144550c1-5da4-4456-93a5-5af491bddf1e	false	require.password.update.after.registration
b66b9528-028f-48a1-b067-59f0d896bf1e	missing	update.profile.on.first.login
a6e26960-fcb3-4cc0-8573-4dc192238a5e	false	require.password.update.after.registration
d399ca7f-2672-4eef-b42e-728b4e3e5f93	missing	update.profile.on.first.login
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
2610030b-00c5-4f55-aaf5-c19053e277eb	t	f	master-realm	0	f	\N	\N	t	\N	f	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
56ee7430-711e-4931-a812-bed36a17be94	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
e8fe6ba7-81c0-48c6-b3e5-6dc17c8c77fe	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
a9cd39a8-054f-4724-a771-614f3e9a47d2	t	f	broker	0	f	\N	\N	t	\N	f	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
121db436-e63f-49ba-a93a-7a6951e5315e	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
b1cef7ff-1915-4c0c-8272-a7effe9ed538	t	f	admin-cli	0	t	\N	\N	f	\N	f	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
8b4a4b34-f1da-419c-aa6f-62ec476a77e2	t	f	houseproject-realm	0	f	\N	\N	t	\N	f	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	\N	0	f	f	houseproject Realm	f	client-secret	\N	\N	\N	t	f	f	f
3a859b28-422a-4b13-ace1-abf51967a3f6	t	f	realm-management	0	f	\N	\N	t	\N	f	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
eba96f4c-fc01-4e8b-b3af-e9f5a042f2b4	t	f	account	0	t	\N	/realms/houseproject/account/	f	\N	f	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
a8298116-778e-4155-8ed9-9454d57106ff	t	f	account-console	0	t	\N	/realms/houseproject/account/	f	\N	f	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
a0ff463d-23cc-4126-bd41-c01fddc9129e	t	f	broker	0	f	\N	\N	t	\N	f	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
c6697c1f-2ead-4af7-b8cd-195dd0332614	t	f	security-admin-console	0	t	\N	/admin/houseproject/console/	f	\N	f	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
9cf19a67-eaa1-46a5-bd75-7ba1ff4bf3e3	t	f	admin-cli	0	t	\N	\N	f	\N	f	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
51abee6f-2294-4cea-a78a-fbfd60c8fc07	t	t	oauth-proxy-client	0	f	KmyqCo9TuczActT9HI09HpJ30Ruw4JsN		f		f	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	openid-connect	-1	t	f		f	client-secret			\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
56ee7430-711e-4931-a812-bed36a17be94	post.logout.redirect.uris	+
e8fe6ba7-81c0-48c6-b3e5-6dc17c8c77fe	post.logout.redirect.uris	+
e8fe6ba7-81c0-48c6-b3e5-6dc17c8c77fe	pkce.code.challenge.method	S256
121db436-e63f-49ba-a93a-7a6951e5315e	post.logout.redirect.uris	+
121db436-e63f-49ba-a93a-7a6951e5315e	pkce.code.challenge.method	S256
eba96f4c-fc01-4e8b-b3af-e9f5a042f2b4	post.logout.redirect.uris	+
a8298116-778e-4155-8ed9-9454d57106ff	post.logout.redirect.uris	+
a8298116-778e-4155-8ed9-9454d57106ff	pkce.code.challenge.method	S256
c6697c1f-2ead-4af7-b8cd-195dd0332614	post.logout.redirect.uris	+
c6697c1f-2ead-4af7-b8cd-195dd0332614	pkce.code.challenge.method	S256
51abee6f-2294-4cea-a78a-fbfd60c8fc07	client.secret.creation.time	1728681269
51abee6f-2294-4cea-a78a-fbfd60c8fc07	oauth2.device.authorization.grant.enabled	false
51abee6f-2294-4cea-a78a-fbfd60c8fc07	oidc.ciba.grant.enabled	false
51abee6f-2294-4cea-a78a-fbfd60c8fc07	backchannel.logout.session.required	true
51abee6f-2294-4cea-a78a-fbfd60c8fc07	backchannel.logout.revoke.offline.tokens	false
51abee6f-2294-4cea-a78a-fbfd60c8fc07	display.on.consent.screen	false
51abee6f-2294-4cea-a78a-fbfd60c8fc07	post.logout.redirect.uris	http://houseproject.internal/*
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
870cda08-b62f-4572-ad45-e8f105aef2cc	offline_access	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	OpenID Connect built-in scope: offline_access	openid-connect
00a59f91-955b-4bd6-8a50-04ef48d3eb77	role_list	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	SAML role list	saml
ddc7c8a2-5096-44f3-945e-47d1c59057c2	profile	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	OpenID Connect built-in scope: profile	openid-connect
367e4646-da88-4a9e-b064-ea4875de785a	email	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	OpenID Connect built-in scope: email	openid-connect
df600c68-8316-4bfe-a0bf-6a2569c3ee85	address	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	OpenID Connect built-in scope: address	openid-connect
e7c17ef3-6940-42d2-9ea4-740ba4786c73	phone	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	OpenID Connect built-in scope: phone	openid-connect
2560dbea-6828-434c-a09f-3e0a6175ddca	roles	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	OpenID Connect scope for add user roles to the access token	openid-connect
29fff4ec-d1cb-4105-9203-dd2661ff910d	web-origins	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	OpenID Connect scope for add allowed web origins to the access token	openid-connect
bcdfb684-445f-4109-89ed-3e3a1421ab78	microprofile-jwt	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	Microprofile - JWT built-in scope	openid-connect
12be406b-33e7-4186-aa12-0d196f650f9f	acr	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
eb8159fe-8bb4-4184-af19-9ab02a0be00c	basic	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	OpenID Connect scope for add all basic claims to the token	openid-connect
6e19494c-632c-436d-8fca-f7e243ba70de	offline_access	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	OpenID Connect built-in scope: offline_access	openid-connect
0bb5c221-8de7-4f23-ae3d-b5144e138e96	role_list	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	SAML role list	saml
d2093271-2662-4829-8ecb-79fb23eb9bd9	profile	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	OpenID Connect built-in scope: profile	openid-connect
e69de729-aeb1-4853-bc52-fe7ceb05376d	email	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	OpenID Connect built-in scope: email	openid-connect
8db8f53c-46af-49d7-a339-cd093a0d316d	address	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	OpenID Connect built-in scope: address	openid-connect
847e2b44-2b44-4588-ba5d-60e8f64921e7	phone	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	OpenID Connect built-in scope: phone	openid-connect
a0697fdd-acb1-4b25-9c70-a38d704072d1	roles	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	OpenID Connect scope for add user roles to the access token	openid-connect
e03ed03f-90d7-4029-86bd-ff0cf87d8591	web-origins	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	OpenID Connect scope for add allowed web origins to the access token	openid-connect
6f779370-cb02-4849-8a63-bce28a6da83c	microprofile-jwt	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	Microprofile - JWT built-in scope	openid-connect
3f964c38-1350-4181-b7b4-86ea2e7d3350	acr	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
597c1f45-6b30-424b-ac29-9f6c636d856e	basic	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	OpenID Connect scope for add all basic claims to the token	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
870cda08-b62f-4572-ad45-e8f105aef2cc	true	display.on.consent.screen
870cda08-b62f-4572-ad45-e8f105aef2cc	${offlineAccessScopeConsentText}	consent.screen.text
00a59f91-955b-4bd6-8a50-04ef48d3eb77	true	display.on.consent.screen
00a59f91-955b-4bd6-8a50-04ef48d3eb77	${samlRoleListScopeConsentText}	consent.screen.text
ddc7c8a2-5096-44f3-945e-47d1c59057c2	true	display.on.consent.screen
ddc7c8a2-5096-44f3-945e-47d1c59057c2	${profileScopeConsentText}	consent.screen.text
ddc7c8a2-5096-44f3-945e-47d1c59057c2	true	include.in.token.scope
367e4646-da88-4a9e-b064-ea4875de785a	true	display.on.consent.screen
367e4646-da88-4a9e-b064-ea4875de785a	${emailScopeConsentText}	consent.screen.text
367e4646-da88-4a9e-b064-ea4875de785a	true	include.in.token.scope
df600c68-8316-4bfe-a0bf-6a2569c3ee85	true	display.on.consent.screen
df600c68-8316-4bfe-a0bf-6a2569c3ee85	${addressScopeConsentText}	consent.screen.text
df600c68-8316-4bfe-a0bf-6a2569c3ee85	true	include.in.token.scope
e7c17ef3-6940-42d2-9ea4-740ba4786c73	true	display.on.consent.screen
e7c17ef3-6940-42d2-9ea4-740ba4786c73	${phoneScopeConsentText}	consent.screen.text
e7c17ef3-6940-42d2-9ea4-740ba4786c73	true	include.in.token.scope
2560dbea-6828-434c-a09f-3e0a6175ddca	true	display.on.consent.screen
2560dbea-6828-434c-a09f-3e0a6175ddca	${rolesScopeConsentText}	consent.screen.text
2560dbea-6828-434c-a09f-3e0a6175ddca	false	include.in.token.scope
29fff4ec-d1cb-4105-9203-dd2661ff910d	false	display.on.consent.screen
29fff4ec-d1cb-4105-9203-dd2661ff910d		consent.screen.text
29fff4ec-d1cb-4105-9203-dd2661ff910d	false	include.in.token.scope
bcdfb684-445f-4109-89ed-3e3a1421ab78	false	display.on.consent.screen
bcdfb684-445f-4109-89ed-3e3a1421ab78	true	include.in.token.scope
12be406b-33e7-4186-aa12-0d196f650f9f	false	display.on.consent.screen
12be406b-33e7-4186-aa12-0d196f650f9f	false	include.in.token.scope
eb8159fe-8bb4-4184-af19-9ab02a0be00c	false	display.on.consent.screen
eb8159fe-8bb4-4184-af19-9ab02a0be00c	false	include.in.token.scope
6e19494c-632c-436d-8fca-f7e243ba70de	true	display.on.consent.screen
6e19494c-632c-436d-8fca-f7e243ba70de	${offlineAccessScopeConsentText}	consent.screen.text
0bb5c221-8de7-4f23-ae3d-b5144e138e96	true	display.on.consent.screen
0bb5c221-8de7-4f23-ae3d-b5144e138e96	${samlRoleListScopeConsentText}	consent.screen.text
d2093271-2662-4829-8ecb-79fb23eb9bd9	true	display.on.consent.screen
d2093271-2662-4829-8ecb-79fb23eb9bd9	${profileScopeConsentText}	consent.screen.text
d2093271-2662-4829-8ecb-79fb23eb9bd9	true	include.in.token.scope
e69de729-aeb1-4853-bc52-fe7ceb05376d	true	display.on.consent.screen
e69de729-aeb1-4853-bc52-fe7ceb05376d	${emailScopeConsentText}	consent.screen.text
e69de729-aeb1-4853-bc52-fe7ceb05376d	true	include.in.token.scope
8db8f53c-46af-49d7-a339-cd093a0d316d	true	display.on.consent.screen
8db8f53c-46af-49d7-a339-cd093a0d316d	${addressScopeConsentText}	consent.screen.text
8db8f53c-46af-49d7-a339-cd093a0d316d	true	include.in.token.scope
847e2b44-2b44-4588-ba5d-60e8f64921e7	true	display.on.consent.screen
847e2b44-2b44-4588-ba5d-60e8f64921e7	${phoneScopeConsentText}	consent.screen.text
847e2b44-2b44-4588-ba5d-60e8f64921e7	true	include.in.token.scope
a0697fdd-acb1-4b25-9c70-a38d704072d1	true	display.on.consent.screen
a0697fdd-acb1-4b25-9c70-a38d704072d1	${rolesScopeConsentText}	consent.screen.text
a0697fdd-acb1-4b25-9c70-a38d704072d1	false	include.in.token.scope
e03ed03f-90d7-4029-86bd-ff0cf87d8591	false	display.on.consent.screen
e03ed03f-90d7-4029-86bd-ff0cf87d8591		consent.screen.text
e03ed03f-90d7-4029-86bd-ff0cf87d8591	false	include.in.token.scope
6f779370-cb02-4849-8a63-bce28a6da83c	false	display.on.consent.screen
6f779370-cb02-4849-8a63-bce28a6da83c	true	include.in.token.scope
3f964c38-1350-4181-b7b4-86ea2e7d3350	false	display.on.consent.screen
3f964c38-1350-4181-b7b4-86ea2e7d3350	false	include.in.token.scope
597c1f45-6b30-424b-ac29-9f6c636d856e	false	display.on.consent.screen
597c1f45-6b30-424b-ac29-9f6c636d856e	false	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
56ee7430-711e-4931-a812-bed36a17be94	29fff4ec-d1cb-4105-9203-dd2661ff910d	t
56ee7430-711e-4931-a812-bed36a17be94	367e4646-da88-4a9e-b064-ea4875de785a	t
56ee7430-711e-4931-a812-bed36a17be94	12be406b-33e7-4186-aa12-0d196f650f9f	t
56ee7430-711e-4931-a812-bed36a17be94	eb8159fe-8bb4-4184-af19-9ab02a0be00c	t
56ee7430-711e-4931-a812-bed36a17be94	ddc7c8a2-5096-44f3-945e-47d1c59057c2	t
56ee7430-711e-4931-a812-bed36a17be94	2560dbea-6828-434c-a09f-3e0a6175ddca	t
56ee7430-711e-4931-a812-bed36a17be94	df600c68-8316-4bfe-a0bf-6a2569c3ee85	f
56ee7430-711e-4931-a812-bed36a17be94	bcdfb684-445f-4109-89ed-3e3a1421ab78	f
56ee7430-711e-4931-a812-bed36a17be94	870cda08-b62f-4572-ad45-e8f105aef2cc	f
56ee7430-711e-4931-a812-bed36a17be94	e7c17ef3-6940-42d2-9ea4-740ba4786c73	f
e8fe6ba7-81c0-48c6-b3e5-6dc17c8c77fe	29fff4ec-d1cb-4105-9203-dd2661ff910d	t
e8fe6ba7-81c0-48c6-b3e5-6dc17c8c77fe	367e4646-da88-4a9e-b064-ea4875de785a	t
e8fe6ba7-81c0-48c6-b3e5-6dc17c8c77fe	12be406b-33e7-4186-aa12-0d196f650f9f	t
e8fe6ba7-81c0-48c6-b3e5-6dc17c8c77fe	eb8159fe-8bb4-4184-af19-9ab02a0be00c	t
e8fe6ba7-81c0-48c6-b3e5-6dc17c8c77fe	ddc7c8a2-5096-44f3-945e-47d1c59057c2	t
e8fe6ba7-81c0-48c6-b3e5-6dc17c8c77fe	2560dbea-6828-434c-a09f-3e0a6175ddca	t
e8fe6ba7-81c0-48c6-b3e5-6dc17c8c77fe	df600c68-8316-4bfe-a0bf-6a2569c3ee85	f
e8fe6ba7-81c0-48c6-b3e5-6dc17c8c77fe	bcdfb684-445f-4109-89ed-3e3a1421ab78	f
e8fe6ba7-81c0-48c6-b3e5-6dc17c8c77fe	870cda08-b62f-4572-ad45-e8f105aef2cc	f
e8fe6ba7-81c0-48c6-b3e5-6dc17c8c77fe	e7c17ef3-6940-42d2-9ea4-740ba4786c73	f
b1cef7ff-1915-4c0c-8272-a7effe9ed538	29fff4ec-d1cb-4105-9203-dd2661ff910d	t
b1cef7ff-1915-4c0c-8272-a7effe9ed538	367e4646-da88-4a9e-b064-ea4875de785a	t
b1cef7ff-1915-4c0c-8272-a7effe9ed538	12be406b-33e7-4186-aa12-0d196f650f9f	t
b1cef7ff-1915-4c0c-8272-a7effe9ed538	eb8159fe-8bb4-4184-af19-9ab02a0be00c	t
b1cef7ff-1915-4c0c-8272-a7effe9ed538	ddc7c8a2-5096-44f3-945e-47d1c59057c2	t
b1cef7ff-1915-4c0c-8272-a7effe9ed538	2560dbea-6828-434c-a09f-3e0a6175ddca	t
b1cef7ff-1915-4c0c-8272-a7effe9ed538	df600c68-8316-4bfe-a0bf-6a2569c3ee85	f
b1cef7ff-1915-4c0c-8272-a7effe9ed538	bcdfb684-445f-4109-89ed-3e3a1421ab78	f
b1cef7ff-1915-4c0c-8272-a7effe9ed538	870cda08-b62f-4572-ad45-e8f105aef2cc	f
b1cef7ff-1915-4c0c-8272-a7effe9ed538	e7c17ef3-6940-42d2-9ea4-740ba4786c73	f
a9cd39a8-054f-4724-a771-614f3e9a47d2	29fff4ec-d1cb-4105-9203-dd2661ff910d	t
a9cd39a8-054f-4724-a771-614f3e9a47d2	367e4646-da88-4a9e-b064-ea4875de785a	t
a9cd39a8-054f-4724-a771-614f3e9a47d2	12be406b-33e7-4186-aa12-0d196f650f9f	t
a9cd39a8-054f-4724-a771-614f3e9a47d2	eb8159fe-8bb4-4184-af19-9ab02a0be00c	t
a9cd39a8-054f-4724-a771-614f3e9a47d2	ddc7c8a2-5096-44f3-945e-47d1c59057c2	t
a9cd39a8-054f-4724-a771-614f3e9a47d2	2560dbea-6828-434c-a09f-3e0a6175ddca	t
a9cd39a8-054f-4724-a771-614f3e9a47d2	df600c68-8316-4bfe-a0bf-6a2569c3ee85	f
a9cd39a8-054f-4724-a771-614f3e9a47d2	bcdfb684-445f-4109-89ed-3e3a1421ab78	f
a9cd39a8-054f-4724-a771-614f3e9a47d2	870cda08-b62f-4572-ad45-e8f105aef2cc	f
a9cd39a8-054f-4724-a771-614f3e9a47d2	e7c17ef3-6940-42d2-9ea4-740ba4786c73	f
2610030b-00c5-4f55-aaf5-c19053e277eb	29fff4ec-d1cb-4105-9203-dd2661ff910d	t
2610030b-00c5-4f55-aaf5-c19053e277eb	367e4646-da88-4a9e-b064-ea4875de785a	t
2610030b-00c5-4f55-aaf5-c19053e277eb	12be406b-33e7-4186-aa12-0d196f650f9f	t
2610030b-00c5-4f55-aaf5-c19053e277eb	eb8159fe-8bb4-4184-af19-9ab02a0be00c	t
2610030b-00c5-4f55-aaf5-c19053e277eb	ddc7c8a2-5096-44f3-945e-47d1c59057c2	t
2610030b-00c5-4f55-aaf5-c19053e277eb	2560dbea-6828-434c-a09f-3e0a6175ddca	t
2610030b-00c5-4f55-aaf5-c19053e277eb	df600c68-8316-4bfe-a0bf-6a2569c3ee85	f
2610030b-00c5-4f55-aaf5-c19053e277eb	bcdfb684-445f-4109-89ed-3e3a1421ab78	f
2610030b-00c5-4f55-aaf5-c19053e277eb	870cda08-b62f-4572-ad45-e8f105aef2cc	f
2610030b-00c5-4f55-aaf5-c19053e277eb	e7c17ef3-6940-42d2-9ea4-740ba4786c73	f
121db436-e63f-49ba-a93a-7a6951e5315e	29fff4ec-d1cb-4105-9203-dd2661ff910d	t
121db436-e63f-49ba-a93a-7a6951e5315e	367e4646-da88-4a9e-b064-ea4875de785a	t
121db436-e63f-49ba-a93a-7a6951e5315e	12be406b-33e7-4186-aa12-0d196f650f9f	t
121db436-e63f-49ba-a93a-7a6951e5315e	eb8159fe-8bb4-4184-af19-9ab02a0be00c	t
121db436-e63f-49ba-a93a-7a6951e5315e	ddc7c8a2-5096-44f3-945e-47d1c59057c2	t
121db436-e63f-49ba-a93a-7a6951e5315e	2560dbea-6828-434c-a09f-3e0a6175ddca	t
121db436-e63f-49ba-a93a-7a6951e5315e	df600c68-8316-4bfe-a0bf-6a2569c3ee85	f
121db436-e63f-49ba-a93a-7a6951e5315e	bcdfb684-445f-4109-89ed-3e3a1421ab78	f
121db436-e63f-49ba-a93a-7a6951e5315e	870cda08-b62f-4572-ad45-e8f105aef2cc	f
121db436-e63f-49ba-a93a-7a6951e5315e	e7c17ef3-6940-42d2-9ea4-740ba4786c73	f
eba96f4c-fc01-4e8b-b3af-e9f5a042f2b4	a0697fdd-acb1-4b25-9c70-a38d704072d1	t
eba96f4c-fc01-4e8b-b3af-e9f5a042f2b4	597c1f45-6b30-424b-ac29-9f6c636d856e	t
eba96f4c-fc01-4e8b-b3af-e9f5a042f2b4	d2093271-2662-4829-8ecb-79fb23eb9bd9	t
eba96f4c-fc01-4e8b-b3af-e9f5a042f2b4	3f964c38-1350-4181-b7b4-86ea2e7d3350	t
eba96f4c-fc01-4e8b-b3af-e9f5a042f2b4	e69de729-aeb1-4853-bc52-fe7ceb05376d	t
eba96f4c-fc01-4e8b-b3af-e9f5a042f2b4	e03ed03f-90d7-4029-86bd-ff0cf87d8591	t
eba96f4c-fc01-4e8b-b3af-e9f5a042f2b4	8db8f53c-46af-49d7-a339-cd093a0d316d	f
eba96f4c-fc01-4e8b-b3af-e9f5a042f2b4	847e2b44-2b44-4588-ba5d-60e8f64921e7	f
eba96f4c-fc01-4e8b-b3af-e9f5a042f2b4	6f779370-cb02-4849-8a63-bce28a6da83c	f
eba96f4c-fc01-4e8b-b3af-e9f5a042f2b4	6e19494c-632c-436d-8fca-f7e243ba70de	f
a8298116-778e-4155-8ed9-9454d57106ff	a0697fdd-acb1-4b25-9c70-a38d704072d1	t
a8298116-778e-4155-8ed9-9454d57106ff	597c1f45-6b30-424b-ac29-9f6c636d856e	t
a8298116-778e-4155-8ed9-9454d57106ff	d2093271-2662-4829-8ecb-79fb23eb9bd9	t
a8298116-778e-4155-8ed9-9454d57106ff	3f964c38-1350-4181-b7b4-86ea2e7d3350	t
a8298116-778e-4155-8ed9-9454d57106ff	e69de729-aeb1-4853-bc52-fe7ceb05376d	t
a8298116-778e-4155-8ed9-9454d57106ff	e03ed03f-90d7-4029-86bd-ff0cf87d8591	t
a8298116-778e-4155-8ed9-9454d57106ff	8db8f53c-46af-49d7-a339-cd093a0d316d	f
a8298116-778e-4155-8ed9-9454d57106ff	847e2b44-2b44-4588-ba5d-60e8f64921e7	f
a8298116-778e-4155-8ed9-9454d57106ff	6f779370-cb02-4849-8a63-bce28a6da83c	f
a8298116-778e-4155-8ed9-9454d57106ff	6e19494c-632c-436d-8fca-f7e243ba70de	f
9cf19a67-eaa1-46a5-bd75-7ba1ff4bf3e3	a0697fdd-acb1-4b25-9c70-a38d704072d1	t
9cf19a67-eaa1-46a5-bd75-7ba1ff4bf3e3	597c1f45-6b30-424b-ac29-9f6c636d856e	t
9cf19a67-eaa1-46a5-bd75-7ba1ff4bf3e3	d2093271-2662-4829-8ecb-79fb23eb9bd9	t
9cf19a67-eaa1-46a5-bd75-7ba1ff4bf3e3	3f964c38-1350-4181-b7b4-86ea2e7d3350	t
9cf19a67-eaa1-46a5-bd75-7ba1ff4bf3e3	e69de729-aeb1-4853-bc52-fe7ceb05376d	t
9cf19a67-eaa1-46a5-bd75-7ba1ff4bf3e3	e03ed03f-90d7-4029-86bd-ff0cf87d8591	t
9cf19a67-eaa1-46a5-bd75-7ba1ff4bf3e3	8db8f53c-46af-49d7-a339-cd093a0d316d	f
9cf19a67-eaa1-46a5-bd75-7ba1ff4bf3e3	847e2b44-2b44-4588-ba5d-60e8f64921e7	f
9cf19a67-eaa1-46a5-bd75-7ba1ff4bf3e3	6f779370-cb02-4849-8a63-bce28a6da83c	f
9cf19a67-eaa1-46a5-bd75-7ba1ff4bf3e3	6e19494c-632c-436d-8fca-f7e243ba70de	f
a0ff463d-23cc-4126-bd41-c01fddc9129e	a0697fdd-acb1-4b25-9c70-a38d704072d1	t
a0ff463d-23cc-4126-bd41-c01fddc9129e	597c1f45-6b30-424b-ac29-9f6c636d856e	t
a0ff463d-23cc-4126-bd41-c01fddc9129e	d2093271-2662-4829-8ecb-79fb23eb9bd9	t
a0ff463d-23cc-4126-bd41-c01fddc9129e	3f964c38-1350-4181-b7b4-86ea2e7d3350	t
a0ff463d-23cc-4126-bd41-c01fddc9129e	e69de729-aeb1-4853-bc52-fe7ceb05376d	t
a0ff463d-23cc-4126-bd41-c01fddc9129e	e03ed03f-90d7-4029-86bd-ff0cf87d8591	t
a0ff463d-23cc-4126-bd41-c01fddc9129e	8db8f53c-46af-49d7-a339-cd093a0d316d	f
a0ff463d-23cc-4126-bd41-c01fddc9129e	847e2b44-2b44-4588-ba5d-60e8f64921e7	f
a0ff463d-23cc-4126-bd41-c01fddc9129e	6f779370-cb02-4849-8a63-bce28a6da83c	f
a0ff463d-23cc-4126-bd41-c01fddc9129e	6e19494c-632c-436d-8fca-f7e243ba70de	f
3a859b28-422a-4b13-ace1-abf51967a3f6	a0697fdd-acb1-4b25-9c70-a38d704072d1	t
3a859b28-422a-4b13-ace1-abf51967a3f6	597c1f45-6b30-424b-ac29-9f6c636d856e	t
3a859b28-422a-4b13-ace1-abf51967a3f6	d2093271-2662-4829-8ecb-79fb23eb9bd9	t
3a859b28-422a-4b13-ace1-abf51967a3f6	3f964c38-1350-4181-b7b4-86ea2e7d3350	t
3a859b28-422a-4b13-ace1-abf51967a3f6	e69de729-aeb1-4853-bc52-fe7ceb05376d	t
3a859b28-422a-4b13-ace1-abf51967a3f6	e03ed03f-90d7-4029-86bd-ff0cf87d8591	t
3a859b28-422a-4b13-ace1-abf51967a3f6	8db8f53c-46af-49d7-a339-cd093a0d316d	f
3a859b28-422a-4b13-ace1-abf51967a3f6	847e2b44-2b44-4588-ba5d-60e8f64921e7	f
3a859b28-422a-4b13-ace1-abf51967a3f6	6f779370-cb02-4849-8a63-bce28a6da83c	f
3a859b28-422a-4b13-ace1-abf51967a3f6	6e19494c-632c-436d-8fca-f7e243ba70de	f
c6697c1f-2ead-4af7-b8cd-195dd0332614	a0697fdd-acb1-4b25-9c70-a38d704072d1	t
c6697c1f-2ead-4af7-b8cd-195dd0332614	597c1f45-6b30-424b-ac29-9f6c636d856e	t
c6697c1f-2ead-4af7-b8cd-195dd0332614	d2093271-2662-4829-8ecb-79fb23eb9bd9	t
c6697c1f-2ead-4af7-b8cd-195dd0332614	3f964c38-1350-4181-b7b4-86ea2e7d3350	t
c6697c1f-2ead-4af7-b8cd-195dd0332614	e69de729-aeb1-4853-bc52-fe7ceb05376d	t
c6697c1f-2ead-4af7-b8cd-195dd0332614	e03ed03f-90d7-4029-86bd-ff0cf87d8591	t
c6697c1f-2ead-4af7-b8cd-195dd0332614	8db8f53c-46af-49d7-a339-cd093a0d316d	f
c6697c1f-2ead-4af7-b8cd-195dd0332614	847e2b44-2b44-4588-ba5d-60e8f64921e7	f
c6697c1f-2ead-4af7-b8cd-195dd0332614	6f779370-cb02-4849-8a63-bce28a6da83c	f
c6697c1f-2ead-4af7-b8cd-195dd0332614	6e19494c-632c-436d-8fca-f7e243ba70de	f
51abee6f-2294-4cea-a78a-fbfd60c8fc07	a0697fdd-acb1-4b25-9c70-a38d704072d1	t
51abee6f-2294-4cea-a78a-fbfd60c8fc07	597c1f45-6b30-424b-ac29-9f6c636d856e	t
51abee6f-2294-4cea-a78a-fbfd60c8fc07	d2093271-2662-4829-8ecb-79fb23eb9bd9	t
51abee6f-2294-4cea-a78a-fbfd60c8fc07	3f964c38-1350-4181-b7b4-86ea2e7d3350	t
51abee6f-2294-4cea-a78a-fbfd60c8fc07	e69de729-aeb1-4853-bc52-fe7ceb05376d	t
51abee6f-2294-4cea-a78a-fbfd60c8fc07	e03ed03f-90d7-4029-86bd-ff0cf87d8591	t
51abee6f-2294-4cea-a78a-fbfd60c8fc07	8db8f53c-46af-49d7-a339-cd093a0d316d	f
51abee6f-2294-4cea-a78a-fbfd60c8fc07	847e2b44-2b44-4588-ba5d-60e8f64921e7	f
51abee6f-2294-4cea-a78a-fbfd60c8fc07	6f779370-cb02-4849-8a63-bce28a6da83c	f
51abee6f-2294-4cea-a78a-fbfd60c8fc07	6e19494c-632c-436d-8fca-f7e243ba70de	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
870cda08-b62f-4572-ad45-e8f105aef2cc	defcfd6e-fe85-4026-bd95-b4532f16254e
6e19494c-632c-436d-8fca-f7e243ba70de	05732f5c-1a13-463b-a1c3-5ad62753772c
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
9bfdc63a-1714-432e-aaf9-7b9f4abfc806	Trusted Hosts	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	anonymous
90f52781-3947-4608-9534-e367d9356ad4	Consent Required	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	anonymous
c8e2c9ec-c53e-41f0-bb72-dff75eb296ec	Full Scope Disabled	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	anonymous
10d0221d-5874-49f0-89e6-bd5317b697e9	Max Clients Limit	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	anonymous
8f176089-39b8-4aa1-bda0-6840a65c7f55	Allowed Protocol Mapper Types	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	anonymous
24499a47-4edf-41a7-bd75-eebd2aaeae90	Allowed Client Scopes	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	anonymous
2b5ff4c8-9a82-4668-b098-a29d73d98b00	Allowed Protocol Mapper Types	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	authenticated
a807b018-f73c-4269-bc71-7739c6f604b9	Allowed Client Scopes	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	authenticated
8ce0c91a-8c65-448d-a94d-4b48408c860b	rsa-generated	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	rsa-generated	org.keycloak.keys.KeyProvider	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	\N
3901e719-9651-466e-bf6a-10df643d82d2	rsa-enc-generated	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	rsa-enc-generated	org.keycloak.keys.KeyProvider	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	\N
e58eb1ca-4487-4e57-aa76-a1d3b49db15b	hmac-generated-hs512	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	hmac-generated	org.keycloak.keys.KeyProvider	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	\N
597e6ca3-3328-48cf-8d4d-1c201993d5e3	aes-generated	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	aes-generated	org.keycloak.keys.KeyProvider	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	\N
0d7292c0-fe79-40ce-86e6-b8369f77462b	\N	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	\N
e79b9306-3afb-4cbd-9997-da382e1b5e8f	rsa-generated	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	rsa-generated	org.keycloak.keys.KeyProvider	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	\N
7c3cf599-7c55-416c-9859-1254009bebf9	rsa-enc-generated	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	rsa-enc-generated	org.keycloak.keys.KeyProvider	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	\N
e70235be-c33f-4465-8267-998ce1853931	hmac-generated-hs512	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	hmac-generated	org.keycloak.keys.KeyProvider	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	\N
cf388641-17fd-461b-ae42-6298d2c7e6c7	aes-generated	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	aes-generated	org.keycloak.keys.KeyProvider	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	\N
585ccb68-7ae6-4af6-b72c-9fb2c790507f	Trusted Hosts	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	anonymous
f585d42e-5243-48fb-9989-ae886eb66f20	Consent Required	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	anonymous
f6276fe2-811f-4510-bcff-d2aad7293337	Full Scope Disabled	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	anonymous
4f3811db-56fc-426e-af8e-dc0909e3ff56	Max Clients Limit	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	anonymous
a1b267b6-ee9a-4d11-85d3-d9f13890b258	Allowed Protocol Mapper Types	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	anonymous
3e6c2ce8-c5a6-4934-9501-29e400db5b98	Allowed Client Scopes	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	anonymous
e32d34e1-5059-49f1-99f2-3e93a013f674	Allowed Protocol Mapper Types	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	authenticated
a7cf9ef1-6266-4faf-82a4-8030f2260fd4	Allowed Client Scopes	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
d8d4e263-7aae-4349-9266-037e8e2e4662	24499a47-4edf-41a7-bd75-eebd2aaeae90	allow-default-scopes	true
92d5c18c-ec08-4cd8-9d44-5bef01bc042c	10d0221d-5874-49f0-89e6-bd5317b697e9	max-clients	200
b43372a5-e1eb-48e3-a975-65e8a423ec59	a807b018-f73c-4269-bc71-7739c6f604b9	allow-default-scopes	true
50d8851e-ec54-4d77-872a-ae12860de61c	8f176089-39b8-4aa1-bda0-6840a65c7f55	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
f67236a4-8875-46d5-bb7b-a599f9f915b9	8f176089-39b8-4aa1-bda0-6840a65c7f55	allowed-protocol-mapper-types	saml-user-property-mapper
a76dcf2b-5a2d-40e6-a556-2f7662b49e31	8f176089-39b8-4aa1-bda0-6840a65c7f55	allowed-protocol-mapper-types	oidc-address-mapper
0c9de979-95c0-48bf-9f41-9cfd474b3402	8f176089-39b8-4aa1-bda0-6840a65c7f55	allowed-protocol-mapper-types	saml-user-attribute-mapper
292551ce-f810-4e75-8379-6fa0fed9b177	8f176089-39b8-4aa1-bda0-6840a65c7f55	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
e1f89137-c1c5-4c96-9638-3ea6477370c6	8f176089-39b8-4aa1-bda0-6840a65c7f55	allowed-protocol-mapper-types	oidc-full-name-mapper
9ad5fc2a-8fcd-49ed-9d92-6d9516a54832	8f176089-39b8-4aa1-bda0-6840a65c7f55	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
975badd0-35c0-4fb6-ab9f-9f6b7fd86c48	8f176089-39b8-4aa1-bda0-6840a65c7f55	allowed-protocol-mapper-types	saml-role-list-mapper
4ceb20f9-0bfd-42f3-92fa-83997e4cad49	2b5ff4c8-9a82-4668-b098-a29d73d98b00	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
4856e9d4-25a1-45d1-a168-55c72edbad92	2b5ff4c8-9a82-4668-b098-a29d73d98b00	allowed-protocol-mapper-types	saml-user-attribute-mapper
3f12cfb4-f4a6-4a34-9156-6dfb5a704097	2b5ff4c8-9a82-4668-b098-a29d73d98b00	allowed-protocol-mapper-types	saml-user-property-mapper
3c8cb058-1435-46b1-bbe7-0f760911171f	2b5ff4c8-9a82-4668-b098-a29d73d98b00	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
d838ec0e-c2a6-4ee3-a359-2d2a33ac9b5f	2b5ff4c8-9a82-4668-b098-a29d73d98b00	allowed-protocol-mapper-types	oidc-full-name-mapper
ce717f6f-3b60-49cd-b4c7-c8a7fa6a7cb6	2b5ff4c8-9a82-4668-b098-a29d73d98b00	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
86802377-65d7-49b7-a312-5eba6b3a8520	2b5ff4c8-9a82-4668-b098-a29d73d98b00	allowed-protocol-mapper-types	oidc-address-mapper
4ec2430f-aa29-415c-afdf-1f8fcc64fd67	2b5ff4c8-9a82-4668-b098-a29d73d98b00	allowed-protocol-mapper-types	saml-role-list-mapper
a6ea2926-5774-4f98-a495-ee5e972d5bed	9bfdc63a-1714-432e-aaf9-7b9f4abfc806	client-uris-must-match	true
7fd8c2d5-4105-4ab5-9dd4-d4837759948f	9bfdc63a-1714-432e-aaf9-7b9f4abfc806	host-sending-registration-request-must-match	true
4dbc64d0-667b-4520-aa79-c420803103f0	0d7292c0-fe79-40ce-86e6-b8369f77462b	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
dfb06fb0-4d04-4e0e-9a32-2004b4484bbb	3901e719-9651-466e-bf6a-10df643d82d2	priority	100
b8e89270-5e97-46af-8d14-3ab306a0fb43	3901e719-9651-466e-bf6a-10df643d82d2	keyUse	ENC
f9131303-af46-44dd-92b7-52d1482c7d46	3901e719-9651-466e-bf6a-10df643d82d2	privateKey	MIIEowIBAAKCAQEAynSql7s3E2TTpZ5OoISrAC/D0JWn4GpllYnZrwMSPecNcssQBek4krVKKVEDnx5mN8Y6NYxIn4HlKZZ/jUeONCPDq2MuA4sRoLskcSsSvZu5CMZfBaizeOVef2YZsifN/dYHDnN9Ya/lqUP28s2L/5JJNTKMsUZZEvPlql6dBNWNk4B8Ev0NpDPLNrpahK66b7Y6gLGjCGkaafUVxw3TKQD1v/qRVtEy/GOWNo5OwDYu3qQw//Ty9opFDGR9fRBz8p9AzOsGnkv1I+TtVV2/mNmqLK1CJN3eeKvw/HmyL9RRXsZzCU3ZSSu0sYQWDwdJ3a9RgZlfDsZ1hQocs8sGzQIDAQABAoIBAEfdF7zaQJeKv7HXOrOxw/1B9zDwHnIDcmGdV/7OiUgd3uEzgVGH0oQJA/Ucg7uUj9YWcA0X6aNs+UpE2KvujWSmmUsZ3nh1geFa7HmbP4C8aPbba1lX47TzPhLczBw4Et+afFC93/Cv/kaSEHNpUNt8Mq5Gbjhy7yVSG+DYysWu4jNe6kfs4tL/2rkHv2OTXdPUQH2pi3edL6T7TXwq98uQPCROPOFNUQavcWFAS7oM8bQilaTj2JiW7OD3Yt0XHiy0ax1obbA3saNtTOIbdVpnET1PGqKE1sWzSDOvrOKf1NlzuYHDowGHs9T1l2JUKEjXYRm0Vvt92tdD/OO1ncUCgYEA8cDEi0+aBu0aOYGB9O12ZAZiKTl700NiwVtcYTeS7RkxbcLjBgUWQn+HvyEGPNoQhHBp4+odjfAsuFwmGn7hsZzay3/bdK7+8nxINshHWY9S9FfJRYq1Uw+7P/87m2c/KQ3wpEVrRMPsEQpDItb8qJSlshv2lBILTCCjF/cctKcCgYEA1mMJQzvDqQ5sxytkvaKL5uvzvZ9Ew/LtxZJPptJRKJyaak2kNsam5XutFLaWYEq+aYvtDR8RoCimZ+a5fGtWZQ/e5Kti4oOr8AibfPh3dD7k1iiypIlZYTkt/PF9sHWfQSZn+KHeR6bLN7aDLte7/AHaP5yv5E+IEEzmAodH82sCgYA4Ck+FW7aA1IW3vuW5OTKwjSpEFCc4Ge7Sk7MedhuBCs4Ce6LUymkWkSmOjME9ae9aRBTH2IVxWbOEKRhMHA2Fdq7hbYoZylcfLuAuks63XBoGujLWBAl0b7kgZLIUnCJwCeM2sUDkd+ZJLO/TK7L2AT9HwmOuf2BPDWHBNG9bEQKBgQDK2jy6dENHpFGDB2k0EiikYKBpzNjpO+SFrFJXu+t1LPDjIwH9nmvu+d4kmjuhczfGcNLlNn+b9rq111etBXdi+uhhoFVZlVNMNSjCz+tff99RUILwMtHyr4L3Mp1GKZV9tNRuKuNDEux4k+Z+nTzPUAVtaVn5AtPw8II25EBNbwKBgBCn9VnyrPkNFzXUGKX1pNPUb/aCkcnOs9ZrGrt3PwcTdSWfRHwe9KAY+Sn68tabFm0oJX2eOYKrhNhtzf9L48UcHIWSwq9wPJ5KU8h8yH9McjZ0EyrZZIBjlKfoHN1M8Ti42I9xGmM3vdhBBuOOPjmQBwGXCydmR86rgkv+MdS7
758ab547-d392-4e7a-8aaf-e8c92838b3e4	3901e719-9651-466e-bf6a-10df643d82d2	certificate	MIICmzCCAYMCBgGSfVIOjTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQxMDExMjA0MTIyWhcNMzQxMDExMjA0MzAyWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDKdKqXuzcTZNOlnk6ghKsAL8PQlafgamWVidmvAxI95w1yyxAF6TiStUopUQOfHmY3xjo1jEifgeUpln+NR440I8OrYy4DixGguyRxKxK9m7kIxl8FqLN45V5/ZhmyJ8391gcOc31hr+WpQ/byzYv/kkk1MoyxRlkS8+WqXp0E1Y2TgHwS/Q2kM8s2ulqErrpvtjqAsaMIaRpp9RXHDdMpAPW/+pFW0TL8Y5Y2jk7ANi7epDD/9PL2ikUMZH19EHPyn0DM6waeS/Uj5O1VXb+Y2aosrUIk3d54q/D8ebIv1FFexnMJTdlJK7SxhBYPB0ndr1GBmV8OxnWFChyzywbNAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAHHr94ZF1tguOsVUiGoKwwh+oULYhgfrMN7Ts2ImAzpIPheMZNLxcMOSbyHFz+4gEmvUXHT3ZqMFnxr64Vcc44mSp4gBtwqDWh7/YdhRghOcne+k3msrTvG0zfFalk3KIHuZ3fOPnY3hBbHDao4xqU/mqqgoJl95udlplxtxQWc84SPaj/k+IbX4i09ULYixRDJmhmzOASlqKLrrDAtdXOHaTQ8TByo7FVUBak71pJMNgOfFyW2jHsKmKUhRPXS7+PDddlHK2Dp7x2tOCuDKP/rqqF95NhHk2jvvEX3s6AWSDZSUBU/hkIJm2lTCT+vHZisFunTRXfIMCd5fhGA+slA=
d4dd36d6-f2bd-4afb-9eb7-2f6ee57bafc7	3901e719-9651-466e-bf6a-10df643d82d2	algorithm	RSA-OAEP
654e5964-9e3c-429e-ad1c-c1de03b6bc8e	e58eb1ca-4487-4e57-aa76-a1d3b49db15b	algorithm	HS512
1fa016bd-4e08-414c-9254-db13726b0a2f	e58eb1ca-4487-4e57-aa76-a1d3b49db15b	kid	a12b2151-fdd9-4d4c-bc98-5b53268d76ac
5e242b33-769c-498b-804d-fdc90558bc50	e58eb1ca-4487-4e57-aa76-a1d3b49db15b	priority	100
92f094a1-74f3-48de-80e7-dc3c1cec137c	e58eb1ca-4487-4e57-aa76-a1d3b49db15b	secret	w2XsO5TGnRj-WTpF4jmXJfOOvnL_0_eYjmEh9Vv-how200VLK_yhwqzfTfgemNMtrQyqnPmNRN8D0MeaqVOqivR_ZqZyXyYpOdVXHmkdywBjzlJJfYwuoPXi03mcfa7Le_z07wDk1pMjCCmi9Wr3Dzb6MzA5v0ji6ry51bqnoyk
35a81dcb-bf40-4d53-9186-89009bad6913	8ce0c91a-8c65-448d-a94d-4b48408c860b	privateKey	MIIEowIBAAKCAQEAmgCrgYSi5nxZ0q52klfUf3TVkupj4P+xN+wcnZp3udz2PZDe51RhTibhk4PMNypArVusKVNoUrGNfAotWi6VrPlb2i32Za3GxftsG9VN0dmMFrZQKqau7m+mV3Qqm2J2iZxaxL5kZutkzbQgtyaXqIXK+dgegFHk5djgHJ3OxYIwJJczQ04PR2+P1TZ/COx9IsVhxs0l318M4DkAwsqlT8gwKL4hkZEkhooTp1cKdt0agRwgmdPVi9SWsBOPw6U1bFYR17Oq9S28a6qIFOcZj1IuvAbHyKU87oGix9LDHaNiixtqNjkEsP7SlajZb4NEcLFq3vqyt4KUO4zUu5/G2QIDAQABAoIBAACJpg+lnS3O1YVzm8KOIq0pys+magjcEvTINc4YJ7MKVo0HkaQH2pJkdrlXw6R+wYs8UPnWgeUxePYr0Rtyf9PUU2qXgZTR2McvRf8VbUyVofRmWI43v60ncV48njtIeP96jABm8WkpfWtttx5vfoOEBkDDbToEjy5On/7IINDHiNT5hmY1QZGbikrkA5YAAjgN5vzCRDxFjtDhzUYP6vjAh+i8aNOK3Oyx3tZm6B/sAZBWS5YdZMHWkncGAYIjUHiV1JbsdzL9igI5fhs5Kr7kHs0fCQX66khrI8nkF8un+ki2LGDxoOv2ptwdcwHkjPf/WvT6U5HmHF4q3rKqNJ0CgYEA1MDyCghp+EbvcMKDY4mFibsYi3/5RxlE06jxOL/tfvYwksrGJVQnsJtVadog5EG1jwq+3VgANfMKk6JOKaNXeA9WdQ2MJjGrm3GxERNaOuVOEPYsVNNui1Knhywxbep2XdVzJpcDjFA/beouPZU3tIPGke6IZ29DqYNPRrYWPEMCgYEAuU5/UGGe32sSFTvai6qSvtpeRYSV76pdJrismn8J9x6mO6HBwYGZV+9m0foLwgNf2zl/N5xEj6ypIEoq604RQPwJyodFLoNrcummGcCO1kJSXn6JBbSyleA8VG2wVFyfGbQ67aYd7Cvt+E5gBxPZF3/uJy/mi09Q0wPzW0f1jLMCgYEAo4bOQyHmebvkLLKFlMtORef13Lt3mct1WI7hIjJ7VHvcJ+gN1wFRJHCwfRT49RkAeTrUK4OJXe46MfGtzFlNUO3REVVhZLYG5grEA5DxaJV5pJXiyyxcKmBUfhRcxdRSOJtoz7+BLac8qbo24oS/9VLYHLDQTVh7FF7mXz5z5ssCgYAlO5B5JiQ1392SRqRyy6MQle+7KBi4PxLYZOLJaB0oehAMi0PTDacx8/hE2GjkYqkv8y2Mjul3tMmGo2BcRyNQW1PcTbGo1t8QB8JIClio1EqYkfQWIWiAlL2KeT+ks7eEAqKUfXwlp+34pkbFJUfJYPsJBKbd9uHWhESxYpQD4QKBgCsiFwcUxBi3FMFckYpS9c5HdEpwVLO6VDVtNHnh60DT3/fwQ8xa/J2Xvb4YH8Q7W1hXTTR9U7fCKv4IrkIG/cjRaD9SzTcjVtKI7ctFXgT/ypMOTLxdeIB7YHzh9AFkuZjiOijJKyXsHBQyV/vLBQNMwV6Y6si1BkhbkXFQ9JN2
0fbe19e7-a3e9-48ed-9ec0-44084c63606b	8ce0c91a-8c65-448d-a94d-4b48408c860b	priority	100
8d74cdf4-2f2c-4bce-a384-d2f61d9392a7	8ce0c91a-8c65-448d-a94d-4b48408c860b	certificate	MIICmzCCAYMCBgGSfVILmTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQxMDExMjA0MTIxWhcNMzQxMDExMjA0MzAxWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCaAKuBhKLmfFnSrnaSV9R/dNWS6mPg/7E37Bydmne53PY9kN7nVGFOJuGTg8w3KkCtW6wpU2hSsY18Ci1aLpWs+VvaLfZlrcbF+2wb1U3R2YwWtlAqpq7ub6ZXdCqbYnaJnFrEvmRm62TNtCC3Jpeohcr52B6AUeTl2OAcnc7FgjAklzNDTg9Hb4/VNn8I7H0ixWHGzSXfXwzgOQDCyqVPyDAoviGRkSSGihOnVwp23RqBHCCZ09WL1JawE4/DpTVsVhHXs6r1LbxrqogU5xmPUi68BsfIpTzugaLH0sMdo2KLG2o2OQSw/tKVqNlvg0RwsWre+rK3gpQ7jNS7n8bZAgMBAAEwDQYJKoZIhvcNAQELBQADggEBACnhUidIqmuKKEB5Wwl3RD7oIR33e26n6oYDapwNaZNrfaOEklg74+/dOSu2eV1Q51Sz7dLxutNfbP0dYgGNVHoAq/B5WxdGQGOxelDPcJDRf8ai+w/X/Cori0SWj6DzqgYzFYKHwpmroZ7C6LFexrPkP1zRYWNOhMxFZhNJI7vr42nCMdb2mTLVmTcqrsa0gNVR4Ux04QL6gvaMEYquV+AAERFFawbjUJJnQOvfAo1ZxlkWDmHdyZead/eM0RYNOOnwLIgNU1DH1S2tiuiSHvRTw/C6e+jdo0Kcb4bLGMrEq6lcBcT4K+pmP9gqifOK/+qxNq8cs82YgSEEarOMIUo=
8a77bf22-334f-471f-9942-a3bdde1cd089	8ce0c91a-8c65-448d-a94d-4b48408c860b	keyUse	SIG
58f5bd6a-9f7b-49d2-84e8-5ba74f87d904	597e6ca3-3328-48cf-8d4d-1c201993d5e3	kid	1c58730c-b352-4923-b94b-14b0ea20e966
2c614029-b23c-4037-97ca-65f23985007a	597e6ca3-3328-48cf-8d4d-1c201993d5e3	priority	100
04f48d8b-db9b-4aa5-8cdf-6e85a0882c5b	597e6ca3-3328-48cf-8d4d-1c201993d5e3	secret	R0n9GfwUqCK0tEaym3Djvg
15e1dedf-ab06-4d99-a1f6-b08c54b50ed5	7c3cf599-7c55-416c-9859-1254009bebf9	priority	100
e3e5c7fa-3616-4177-a495-4246fe4409bd	7c3cf599-7c55-416c-9859-1254009bebf9	algorithm	RSA-OAEP
da963410-cf94-4a03-8335-8fa176d48f6a	7c3cf599-7c55-416c-9859-1254009bebf9	keyUse	ENC
ba9bddc4-f2af-4ed4-92ab-4a7e99ba70fa	7c3cf599-7c55-416c-9859-1254009bebf9	certificate	MIICpzCCAY8CBgGSfW5JoTANBgkqhkiG9w0BAQsFADAXMRUwEwYDVQQDDAxob3VzZXByb2plY3QwHhcNMjQxMDExMjExMjEyWhcNMzQxMDExMjExMzUyWjAXMRUwEwYDVQQDDAxob3VzZXByb2plY3QwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC/BlBdu/29LBw2k/xtN4OU4cy4TDBRmt0cF9AhLYZ+j6qchFH0aNhUyxZiL+YmPuaKNYeZlldTmUG56347l5FRBVMmv7vkMO2br9ehnCQWcCq0m3XwkjOmCCmbTl1o7V9uODwajMvKKGYyrrghFxl2cY6CIxrk4Xmd4KOB3g/RWumtOCaG+znH+KjxLF6O3JB+Cf8Yn8ua23eKRbxs5HiZxghh2VUlgn7MFhMFzEYMF8BZI2Ge05xULi9crhH/8RdCsu4oT685Fe+54VBGWJ3o6D+qCBUuglvYtoDZ0oGzFs560POxkAgN92STVEXO+xKtMbdLdZGi32PIOBCY8rnFAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAAizINKacQFid7cCirda9xcERBZPo9lrdi86x6gCF3b0STyPXhdfLYfHCcFWo9ywAf1ZrCdZ35s/vYrwMfW37KnqoZ2fH2855FPdq/a1TRbxA9nuogG3Ab/sNCSxs9L+5Trx/LCXUUswffhq4eqguWs9QmKOPX2CsT5958RL/sOjzMfQ5qaCynA/+B7SdZVSkdl1XlXdZfQdAFuyvxmp7JybyOxVDQz2Hd9eylGcxeqTzd9yrcM7SO+Jz4jtbFQb1Vj0Ug3jUnAmxshHo1szFtk/jfiZXBdGGjU+NYZCQHEM1cYCxG7rjE3iLcQKhOqvhWukEsguk2dEYn77A6Bhce8=
84ca47f9-cb3e-4291-bb9f-e0f64370a8c7	7c3cf599-7c55-416c-9859-1254009bebf9	privateKey	MIIEpAIBAAKCAQEAvwZQXbv9vSwcNpP8bTeDlOHMuEwwUZrdHBfQIS2Gfo+qnIRR9GjYVMsWYi/mJj7mijWHmZZXU5lBuet+O5eRUQVTJr+75DDtm6/XoZwkFnAqtJt18JIzpggpm05daO1fbjg8GozLyihmMq64IRcZdnGOgiMa5OF5neCjgd4P0VrprTgmhvs5x/io8SxejtyQfgn/GJ/Lmtt3ikW8bOR4mcYIYdlVJYJ+zBYTBcxGDBfAWSNhntOcVC4vXK4R//EXQrLuKE+vORXvueFQRlid6Og/qggVLoJb2LaA2dKBsxbOetDzsZAIDfdkk1RFzvsSrTG3S3WRot9jyDgQmPK5xQIDAQABAoIBAFCmw8uvkYQLWaYZeRxLsfxsEVlGoafysKQp0bAQXpaU5b3LiCafFadHT54JByzipcd4rlXESf572Go86UETz0Db9K2JijTgC5IN/ga3u+zVUtKKSJNXxwK0s4xk279vaTlJ+OZkx64EvJFtf0RJUnDVpQuA8tvr7sMfkylDrn3/H5V6My+Rve/hgZmLbwWVPWDLKRPyLvYtxwVKSi6sm5A/Vx2Kf/h58z8exn+DIt0OLMSxH4mpjw1qAgLs7nUnHhakgmjzwz1l7U4m01wh06plJosjk0hCSP1F6/E7wHSLRnHI1ggzhpqcOkJ7FH2jZpG8N5YqLK0iwrk2EIlJ2UkCgYEA47na/Cx8ra3I6YQ7SIYp+si41bnhV8wP06dDDnsAsU7gGIXoRHsThCzPGVNMNT6F/xOxVE6gmylgnND6RdvfF9Se4Nk3F06Gjfc90ysh0LfwAUV87pYbk/IhAH9dsBc2mz63u44nOVzKCOEjOOKd1GsSwkfKrLVRNbeEPTNs5PMCgYEA1r3tTcpXV6EHYJV5V8ADJDSnuToThkCyr5u4wv5HraNuNG0SCxsHo0r5SA7koVpWLKQJtPzGI98OoxkUw1USgSAUTSIvjgsBRCdMTadZ0AUzX4fGEB1frq8jYJJXMnR7049yPiR33K4BXdq9UZpNCC4AAarZ/0PmOOiiaoEp9GcCgYEAq0SXbrrilhiylvWNRJEqt2MIqC0hTk+5w3vzUcuujKt+nNLxCbfqyKiOpURhd1XrnxincHmmDqwC7k25PJsNYTXWu9KBvXSge9rr04qH5xq/VaV2PVYFrbIXofEofAwpVH7J3jQeSeUAScdRHzJIc36H4DfwNQ404op/2St5BYMCgYAW+dM+E3ws4AnOB7An919erFOVueUE5D86Ess98b7xkR7ldRYNIiM7EXaCgzVrHiNCO3reZn08sUz7nl9eVufX8Pq7FgFIjVzhUeMUG+e8HhJVEk3aw4nNQufiGUZDG7tz81Eh3P0GG4gB5rmC1aOQUHunsgQJD9a+GAXop1E52QKBgQCXWm4LAAVOqtEFsRUXHa2HaN71819/JCJ81R92HvRZPdrrNvaAcHc2Csx62StCGCho+SciNhHykGxeyJvXyR0CeAe77TdUT4aYyytGPvr7B3orODS1hWf5X3y61AV5UFvE86EVV9sTJoWkPmEXgf6dmNaFCwDb1kQ6IWg9yYPRBg==
63789cd5-af88-41fa-9b4b-e9ceb267dc45	e70235be-c33f-4465-8267-998ce1853931	priority	100
bb68e4f0-726a-424f-8085-a2159e503559	e70235be-c33f-4465-8267-998ce1853931	algorithm	HS512
950abf45-6e1b-41e4-a2a1-45433dcb27cc	e70235be-c33f-4465-8267-998ce1853931	secret	9D5m_F5pwOT6CQ3Chi7tcLMxCDkILtrs44xS4AKE-YOzChu4zdj-Lu72qlkSPkiGeldanXwZEVFbXGWfzLw0M1Qt5TzxCxtWcWuRNRqSVeWLRqKKYnxZJuzbIYI421InMRAkFcQJMePUSJMhMRypfoOic1b75DPJA_pYhDukIZc
a4dafa5e-9ffa-46a1-8a13-86dd9cdb0abe	e70235be-c33f-4465-8267-998ce1853931	kid	53ec71f4-44f5-4c00-8770-6e69f1673d9c
162a6d89-b5c8-46e1-ae2c-cbc77d08cca7	cf388641-17fd-461b-ae42-6298d2c7e6c7	priority	100
4a96d1c0-e609-4922-843b-ca42bae8e993	cf388641-17fd-461b-ae42-6298d2c7e6c7	kid	9f5673cf-8146-45bb-a302-ab27b4c81383
45fee32a-ee22-4dec-becf-5dd943127baf	cf388641-17fd-461b-ae42-6298d2c7e6c7	secret	GUjSQGAEE-qnUrdNXyjhWg
9af33f92-9073-4af2-883c-d0b03944d601	e79b9306-3afb-4cbd-9997-da382e1b5e8f	certificate	MIICpzCCAY8CBgGSfW5I/zANBgkqhkiG9w0BAQsFADAXMRUwEwYDVQQDDAxob3VzZXByb2plY3QwHhcNMjQxMDExMjExMjEyWhcNMzQxMDExMjExMzUyWjAXMRUwEwYDVQQDDAxob3VzZXByb2plY3QwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC7HoOo1QwoPLtxD1IRI0aH65tImwZPk7Cyt+fc6f2tMdOfZTeF39eY2BVxfzbLLK4BF/ykEx0us+WiEV/dFeoicvfzAF6AWsF/+1brLGIfUJNAVAqpRdhXIG9b6+u0ufR7Fl0BSgjPSkJH3aVasyaE4EVKVkEVBvv8lKFN0iHhrKXKm9zk5gHEpe5qStBZfDurzgRhKTWu7FsM2Zbb6a14r8UJdZnEypz7w3LGHOHxEmzGzLyugjYedOckhitQ0BsoUNqyXN9iU9+QUlu+WFu17TZUUSGSLXvtj/Wf2/5B1ORIEAn7S4tfDrecT8Y5l/t8XOht9lbqZkUj+lTe3x9xAgMBAAEwDQYJKoZIhvcNAQELBQADggEBACKROSdVKI6BTqRvT/thFEC9HQjV9Q+B2JvhZ6Cy3JreeQa4lHIJ4ZbVbJSgQkJQ7oFiXMSonyYVnJjnjAi976gM1d0AzvmKLhk0kGxBi6VaWhImaBdUMhyBdBm6uwnuZ79DiHGT+wJU6dBoWIVr19X9bGcAULWyH3UwgoIs1/wc8m8aVQFXH2BrwrtOKXSYqQh/SEgO3frqmhLeO35AffusGWMpeQyabYFULTE0ryxD8eudANOQF1Pmg8GImKbbmiXk1VDXhsKGMlupCVwaAR/ZovlcnXWV6LUFNe8rTBljknaj5WM5iaTqm98r2RBAa3AKkLsRp6lW0rAwU2+RHz8=
be4c9b0d-40b1-4826-b5e5-1a400ab81fef	e79b9306-3afb-4cbd-9997-da382e1b5e8f	priority	100
0ce39c99-43c3-43fa-969f-a5198b386bb6	e79b9306-3afb-4cbd-9997-da382e1b5e8f	keyUse	SIG
4cef0301-bb8a-4bdb-a408-dacf21ff1987	e79b9306-3afb-4cbd-9997-da382e1b5e8f	privateKey	MIIEpQIBAAKCAQEAux6DqNUMKDy7cQ9SESNGh+ubSJsGT5Owsrfn3On9rTHTn2U3hd/XmNgVcX82yyyuARf8pBMdLrPlohFf3RXqInL38wBegFrBf/tW6yxiH1CTQFQKqUXYVyBvW+vrtLn0exZdAUoIz0pCR92lWrMmhOBFSlZBFQb7/JShTdIh4aylypvc5OYBxKXuakrQWXw7q84EYSk1ruxbDNmW2+mteK/FCXWZxMqc+8Nyxhzh8RJsxsy8roI2HnTnJIYrUNAbKFDaslzfYlPfkFJbvlhbte02VFEhki177Y/1n9v+QdTkSBAJ+0uLXw63nE/GOZf7fFzobfZW6mZFI/pU3t8fcQIDAQABAoIBAA1yCgmHKYT4puAJtvQWofpL9+VV3Qm5yzrEU+EACqONJC+Ha9/ERQSCvmO16D+ILzFSl8DzGKfi8wSxapSDKcbzlj/RTnkQTGgrAhoK9JAFz6w8fbmfvwW1BcYdToYMI0uhlemXosjBBWs5kNNSx9lIw4yDDyZ40Swwl+NKI/dzEJziDlzxEyc/IwhBT7mH7RZTJ1z2Buuwqb0jLCqEUS4wtVJBaFaQsJXqvqr5OXssSR+pcleUW62F40wwG6QcPg+UGCMt1r5+cV5Z1eArfJ5TWOVit4lH/ZaxAT/fRByhvTdT0/Jfma7pvnLXpN0rOgxbATSXgs+EuGuXuxym75kCgYEA9RjgS+gJo3ORw0+PeDxmpjUydhM+J6AhW+52iWqJaKSPD21FZfmQ6hJypdHBUd13P8MaVA8ojCFkCaRUdhl/u06yFOwngoXjchggsWe6svtDGJKfHiZ3TRghMwxnUUJlGFLNIDNUdQi65DFcMuujNKNra122C3vdD+MMhvECvNUCgYEAw3FlIqtLPmXUThL8EoeZO7dNsv4Vm9TPr0M7KVRSCIy9Aj6VHtIVIdcmWSkYPzWj8sAOwGEogbjGRanU4oh5Smn6sjUJLfufr03aXZ/Gy6YbxCVvPi1bXn/VomjO0WhmWuPx1d1WAmdbFOa4Q6WnxShhq56M2c3uPkUPsCLTNi0CgYEA0cJwc4YqeZC29whoKObIkwaEITlmwFLzOdJj8EcVQlFTfkhuVE+6DhmrtO5HHOEE5bT8G2S9tu/8xaO2BTzdbFh1YCKbzcD4XvT3Rd0Yk4UmbylMtGkHQRudjirXYVwJWT/D/gLwDRljmVgFKC8yhiI2FLUmz705/Ba86d/qD+ECgYEAocuH/BFuMvO9s/yHbReQRR1UV298mAqu+9peabKCTs2j0u3YKTGliORBvOIGTp2rYdSY4a4NCIbcrOMRd4+fSXk+rrS1Krn50fhTY9pXilOy/Mg4tXJ7B1owk0jMnhMdWPUHSRL4lvjVMBJoTKggoVjysk6JL+4I4sftWtUZoOkCgYEAivExPUQ1pt4/AKNQzHGuHZPbdYgzhVFjuf/0alzNqd7QAFrXvkC5M0eMmIIrI9nf0HV4pUwfsojPLc9NFFKfW1ARFnlqx3RJL5V36XNNlC1XX3v62/VvwIoRNkqeQ93AktgrN8QR9EjlPrJeeYZq39Y062Jjud/lItaziiW43nQ=
c359f037-bea7-4ba2-ab16-cf3726583faa	a1b267b6-ee9a-4d11-85d3-d9f13890b258	allowed-protocol-mapper-types	saml-user-attribute-mapper
71a46a46-514d-4401-af40-bc85cb45db1f	a1b267b6-ee9a-4d11-85d3-d9f13890b258	allowed-protocol-mapper-types	saml-user-property-mapper
45dc08a6-1d40-414f-b3f7-f79aec210f69	a1b267b6-ee9a-4d11-85d3-d9f13890b258	allowed-protocol-mapper-types	saml-role-list-mapper
9c634a68-eb0a-4c2f-b975-9e01f76c5e11	a1b267b6-ee9a-4d11-85d3-d9f13890b258	allowed-protocol-mapper-types	oidc-address-mapper
ada410a6-1212-4d14-bdb8-628426ccf2c7	a1b267b6-ee9a-4d11-85d3-d9f13890b258	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
1ffe979f-fcda-4456-9d83-c07f0ed20db9	a1b267b6-ee9a-4d11-85d3-d9f13890b258	allowed-protocol-mapper-types	oidc-full-name-mapper
4f2c7737-c21e-4a43-9962-7456e970ffb0	a1b267b6-ee9a-4d11-85d3-d9f13890b258	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
5c284d34-031d-47dc-a1ec-44484fbf4d25	a1b267b6-ee9a-4d11-85d3-d9f13890b258	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
e9e6eb94-b518-4731-9850-56bfbd9a3d86	585ccb68-7ae6-4af6-b72c-9fb2c790507f	host-sending-registration-request-must-match	true
40eee126-106d-4d91-92c7-eb72649da4c0	585ccb68-7ae6-4af6-b72c-9fb2c790507f	client-uris-must-match	true
bbefee91-4d32-48e3-b268-f56e33459427	4f3811db-56fc-426e-af8e-dc0909e3ff56	max-clients	200
4d7c8691-f0ff-4919-83e2-0b67dcb82f31	e32d34e1-5059-49f1-99f2-3e93a013f674	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
6b1af07e-0772-46c6-aa3b-cc99840d0cac	e32d34e1-5059-49f1-99f2-3e93a013f674	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
b5d04e23-5095-4be4-a0af-d3ce25814e30	e32d34e1-5059-49f1-99f2-3e93a013f674	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
3c0ffb1d-cd32-4814-822d-e41d0192f355	e32d34e1-5059-49f1-99f2-3e93a013f674	allowed-protocol-mapper-types	saml-role-list-mapper
b50ca7d5-0746-4035-9840-02b864270005	e32d34e1-5059-49f1-99f2-3e93a013f674	allowed-protocol-mapper-types	saml-user-property-mapper
c2cc1ca8-2cb3-4b01-9ca1-283f3d0901ec	e32d34e1-5059-49f1-99f2-3e93a013f674	allowed-protocol-mapper-types	saml-user-attribute-mapper
0fe9a10e-bd98-4200-b526-09ef665b9699	e32d34e1-5059-49f1-99f2-3e93a013f674	allowed-protocol-mapper-types	oidc-full-name-mapper
fd3afdcc-c99e-47a4-b47d-c40c449e7563	e32d34e1-5059-49f1-99f2-3e93a013f674	allowed-protocol-mapper-types	oidc-address-mapper
953d9af3-f2a7-4a1b-a2e8-81a18325d58a	a7cf9ef1-6266-4faf-82a4-8030f2260fd4	allow-default-scopes	true
6ed01dc4-005b-434f-9911-a8de0168e1d2	3e6c2ce8-c5a6-4934-9501-29e400db5b98	allow-default-scopes	true
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
3edc0499-ea4d-423d-a6a1-179788bf8222	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	f	${role_default-roles}	default-roles-master	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	\N	\N
28652c93-3773-4132-86d8-4e94076d5598	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	f	${role_admin}	admin	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	\N	\N
bdd0e543-4aa0-4462-89e9-e5b171144a16	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	f	${role_create-realm}	create-realm	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	\N	\N
b7222d10-2d9e-444b-948b-1d127945fe71	2610030b-00c5-4f55-aaf5-c19053e277eb	t	${role_create-client}	create-client	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	2610030b-00c5-4f55-aaf5-c19053e277eb	\N
80ef6a24-4cdd-47c6-9a50-e4365e272fb7	2610030b-00c5-4f55-aaf5-c19053e277eb	t	${role_view-realm}	view-realm	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	2610030b-00c5-4f55-aaf5-c19053e277eb	\N
3f6a6102-83a5-4453-ac0c-c269f88c27a6	2610030b-00c5-4f55-aaf5-c19053e277eb	t	${role_view-users}	view-users	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	2610030b-00c5-4f55-aaf5-c19053e277eb	\N
def8c6b4-daa1-479b-aa96-24fa84a2aeea	2610030b-00c5-4f55-aaf5-c19053e277eb	t	${role_view-clients}	view-clients	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	2610030b-00c5-4f55-aaf5-c19053e277eb	\N
ef262dcd-7366-44ae-b4a8-699f1e946c1c	2610030b-00c5-4f55-aaf5-c19053e277eb	t	${role_view-events}	view-events	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	2610030b-00c5-4f55-aaf5-c19053e277eb	\N
450483de-bf9a-4bdf-b1d7-ee3560b1c71e	2610030b-00c5-4f55-aaf5-c19053e277eb	t	${role_view-identity-providers}	view-identity-providers	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	2610030b-00c5-4f55-aaf5-c19053e277eb	\N
4cda110b-ab87-4104-86c3-66aead55fafd	2610030b-00c5-4f55-aaf5-c19053e277eb	t	${role_view-authorization}	view-authorization	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	2610030b-00c5-4f55-aaf5-c19053e277eb	\N
b1102e99-88dc-44e8-a859-fb2246c1566d	2610030b-00c5-4f55-aaf5-c19053e277eb	t	${role_manage-realm}	manage-realm	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	2610030b-00c5-4f55-aaf5-c19053e277eb	\N
1f4a0287-6591-4479-b191-e7b53975cf29	2610030b-00c5-4f55-aaf5-c19053e277eb	t	${role_manage-users}	manage-users	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	2610030b-00c5-4f55-aaf5-c19053e277eb	\N
e8905044-bc24-45d6-b0e1-02917a91466a	2610030b-00c5-4f55-aaf5-c19053e277eb	t	${role_manage-clients}	manage-clients	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	2610030b-00c5-4f55-aaf5-c19053e277eb	\N
be93fbcd-0ce0-48dd-8cfd-e41741854144	2610030b-00c5-4f55-aaf5-c19053e277eb	t	${role_manage-events}	manage-events	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	2610030b-00c5-4f55-aaf5-c19053e277eb	\N
2d56d5db-4943-461e-b2dd-a1d384f8bfb4	2610030b-00c5-4f55-aaf5-c19053e277eb	t	${role_manage-identity-providers}	manage-identity-providers	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	2610030b-00c5-4f55-aaf5-c19053e277eb	\N
8b2b039a-4b3d-44b3-8aaa-c1b83247968c	2610030b-00c5-4f55-aaf5-c19053e277eb	t	${role_manage-authorization}	manage-authorization	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	2610030b-00c5-4f55-aaf5-c19053e277eb	\N
1b273dec-84ca-4bdf-a800-1392c8f12a6f	2610030b-00c5-4f55-aaf5-c19053e277eb	t	${role_query-users}	query-users	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	2610030b-00c5-4f55-aaf5-c19053e277eb	\N
23c9ea38-7622-4775-a5bb-cb2925d5bba2	2610030b-00c5-4f55-aaf5-c19053e277eb	t	${role_query-clients}	query-clients	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	2610030b-00c5-4f55-aaf5-c19053e277eb	\N
d14d5b39-0b39-4cfa-b949-89118736fd9f	2610030b-00c5-4f55-aaf5-c19053e277eb	t	${role_query-realms}	query-realms	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	2610030b-00c5-4f55-aaf5-c19053e277eb	\N
2ff8b3e3-f75b-47fb-956c-e3f757406ac3	2610030b-00c5-4f55-aaf5-c19053e277eb	t	${role_query-groups}	query-groups	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	2610030b-00c5-4f55-aaf5-c19053e277eb	\N
4f87527a-3d22-4d34-a91b-8fce37ea3223	56ee7430-711e-4931-a812-bed36a17be94	t	${role_view-profile}	view-profile	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	56ee7430-711e-4931-a812-bed36a17be94	\N
8be99f82-d9a2-41c6-adb8-7f78824995b2	56ee7430-711e-4931-a812-bed36a17be94	t	${role_manage-account}	manage-account	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	56ee7430-711e-4931-a812-bed36a17be94	\N
0efbe808-0a55-4acc-91b9-c92da1c91893	56ee7430-711e-4931-a812-bed36a17be94	t	${role_manage-account-links}	manage-account-links	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	56ee7430-711e-4931-a812-bed36a17be94	\N
234bcf24-fc6b-462b-a9e3-f95cdde49e10	56ee7430-711e-4931-a812-bed36a17be94	t	${role_view-applications}	view-applications	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	56ee7430-711e-4931-a812-bed36a17be94	\N
da5266bb-17fd-4370-a38e-349a3d19d3be	56ee7430-711e-4931-a812-bed36a17be94	t	${role_view-consent}	view-consent	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	56ee7430-711e-4931-a812-bed36a17be94	\N
75265bf7-57ac-40fc-b397-7b3202812591	56ee7430-711e-4931-a812-bed36a17be94	t	${role_manage-consent}	manage-consent	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	56ee7430-711e-4931-a812-bed36a17be94	\N
6b89af9f-cf76-4f08-86af-6954ed36fa1d	56ee7430-711e-4931-a812-bed36a17be94	t	${role_view-groups}	view-groups	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	56ee7430-711e-4931-a812-bed36a17be94	\N
5274bd50-aacf-4bc7-bc0a-3868e351e6b3	56ee7430-711e-4931-a812-bed36a17be94	t	${role_delete-account}	delete-account	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	56ee7430-711e-4931-a812-bed36a17be94	\N
a4bb15bc-a576-4329-a626-ac6debfa7d59	a9cd39a8-054f-4724-a771-614f3e9a47d2	t	${role_read-token}	read-token	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	a9cd39a8-054f-4724-a771-614f3e9a47d2	\N
4728896c-2b47-4c53-83c2-4480063884c8	2610030b-00c5-4f55-aaf5-c19053e277eb	t	${role_impersonation}	impersonation	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	2610030b-00c5-4f55-aaf5-c19053e277eb	\N
defcfd6e-fe85-4026-bd95-b4532f16254e	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	f	${role_offline-access}	offline_access	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	\N	\N
934dbd76-8d1c-4209-99cf-d4e70d6dab61	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	f	${role_uma_authorization}	uma_authorization	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	\N	\N
538419ab-6282-4178-8ca3-3ed943c4de09	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	f	${role_default-roles}	default-roles-houseproject	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	\N	\N
55db5432-6457-4455-8286-806d230c8b0f	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	t	${role_create-client}	create-client	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	\N
2c463bfb-3872-4994-bb00-6f09464f41ab	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	t	${role_view-realm}	view-realm	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	\N
f1311b47-ffb7-4a13-9c46-7ed7af031b12	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	t	${role_view-users}	view-users	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	\N
b7d5cd9e-a368-48b3-9243-1712006c5057	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	t	${role_view-clients}	view-clients	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	\N
9cf9d8d7-51b1-4bcd-9ab4-3a0c153c225c	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	t	${role_view-events}	view-events	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	\N
bf8400c4-dbef-4c65-bdfb-9baad734bc29	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	t	${role_view-identity-providers}	view-identity-providers	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	\N
25449408-f9b9-425d-ac1a-b34296ae75db	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	t	${role_view-authorization}	view-authorization	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	\N
9375b0d3-d30b-4559-a53f-eccf62938da8	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	t	${role_manage-realm}	manage-realm	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	\N
f7291743-b0eb-497f-b6a8-c0064197ed57	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	t	${role_manage-users}	manage-users	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	\N
2c212b3d-003d-47cd-8000-2253525c11db	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	t	${role_manage-clients}	manage-clients	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	\N
841dd101-63ae-49fb-a69f-1910656c331f	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	t	${role_manage-events}	manage-events	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	\N
ee059424-b879-4ca7-8c4e-f33d71d9fdc3	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	t	${role_manage-identity-providers}	manage-identity-providers	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	\N
7cd6689a-ca85-4c05-ad79-5d33173f0a02	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	t	${role_manage-authorization}	manage-authorization	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	\N
74dcf624-6ff9-4ff2-babb-91f6c6fe626b	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	t	${role_query-users}	query-users	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	\N
fb746287-5bc7-4a2f-86c3-a60bb85040ac	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	t	${role_query-clients}	query-clients	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	\N
e6d6e616-bc16-4c74-b86a-9ef1156c0c0e	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	t	${role_query-realms}	query-realms	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	\N
921c9903-bd7b-4bcf-a9bf-cdf612df72f8	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	t	${role_query-groups}	query-groups	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	\N
8cb80a40-28ca-4f70-bb4c-3b3d23fc0068	3a859b28-422a-4b13-ace1-abf51967a3f6	t	${role_realm-admin}	realm-admin	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	3a859b28-422a-4b13-ace1-abf51967a3f6	\N
3da5c134-77fd-48ae-aa56-a718ea127630	3a859b28-422a-4b13-ace1-abf51967a3f6	t	${role_create-client}	create-client	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	3a859b28-422a-4b13-ace1-abf51967a3f6	\N
3cf90624-5447-4aa7-9bd9-187f6e27475b	3a859b28-422a-4b13-ace1-abf51967a3f6	t	${role_view-realm}	view-realm	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	3a859b28-422a-4b13-ace1-abf51967a3f6	\N
001eb388-5e0a-4aa7-9220-9d8b253e5617	3a859b28-422a-4b13-ace1-abf51967a3f6	t	${role_view-users}	view-users	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	3a859b28-422a-4b13-ace1-abf51967a3f6	\N
ea140d8f-5509-42b1-9d97-dfbef663ce49	3a859b28-422a-4b13-ace1-abf51967a3f6	t	${role_view-clients}	view-clients	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	3a859b28-422a-4b13-ace1-abf51967a3f6	\N
843e48cd-d379-480f-9b7d-d2a7e255bf42	3a859b28-422a-4b13-ace1-abf51967a3f6	t	${role_view-events}	view-events	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	3a859b28-422a-4b13-ace1-abf51967a3f6	\N
fcd6095e-f039-427a-b31f-461caded4045	3a859b28-422a-4b13-ace1-abf51967a3f6	t	${role_view-identity-providers}	view-identity-providers	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	3a859b28-422a-4b13-ace1-abf51967a3f6	\N
3aaa0f7b-5798-48bc-a20f-3434d679093e	3a859b28-422a-4b13-ace1-abf51967a3f6	t	${role_view-authorization}	view-authorization	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	3a859b28-422a-4b13-ace1-abf51967a3f6	\N
8e8518de-c026-417d-baf0-05495ee1fbd5	3a859b28-422a-4b13-ace1-abf51967a3f6	t	${role_manage-realm}	manage-realm	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	3a859b28-422a-4b13-ace1-abf51967a3f6	\N
45a30da0-44fc-4e28-b79a-e31c38a75636	3a859b28-422a-4b13-ace1-abf51967a3f6	t	${role_manage-users}	manage-users	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	3a859b28-422a-4b13-ace1-abf51967a3f6	\N
b4fd12d2-c1cf-4a38-9847-6882e36fdfd3	3a859b28-422a-4b13-ace1-abf51967a3f6	t	${role_manage-clients}	manage-clients	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	3a859b28-422a-4b13-ace1-abf51967a3f6	\N
3bf268e6-6da0-4fa7-b547-d94ab337ce13	3a859b28-422a-4b13-ace1-abf51967a3f6	t	${role_manage-events}	manage-events	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	3a859b28-422a-4b13-ace1-abf51967a3f6	\N
71a4c6a7-066c-490e-b940-19d314875c01	3a859b28-422a-4b13-ace1-abf51967a3f6	t	${role_manage-identity-providers}	manage-identity-providers	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	3a859b28-422a-4b13-ace1-abf51967a3f6	\N
1a266800-dd22-4c63-8a74-28c5f8e5b507	3a859b28-422a-4b13-ace1-abf51967a3f6	t	${role_manage-authorization}	manage-authorization	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	3a859b28-422a-4b13-ace1-abf51967a3f6	\N
c19a5f44-7001-4b1c-876b-c9b40e844ec8	3a859b28-422a-4b13-ace1-abf51967a3f6	t	${role_query-users}	query-users	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	3a859b28-422a-4b13-ace1-abf51967a3f6	\N
90d66a07-36d6-4ec3-824b-39dc6ca85809	3a859b28-422a-4b13-ace1-abf51967a3f6	t	${role_query-clients}	query-clients	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	3a859b28-422a-4b13-ace1-abf51967a3f6	\N
ac017606-25ca-41c5-bdeb-6d5c1a260649	3a859b28-422a-4b13-ace1-abf51967a3f6	t	${role_query-realms}	query-realms	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	3a859b28-422a-4b13-ace1-abf51967a3f6	\N
89ee27d0-b4b6-4f44-b643-a91be650251d	3a859b28-422a-4b13-ace1-abf51967a3f6	t	${role_query-groups}	query-groups	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	3a859b28-422a-4b13-ace1-abf51967a3f6	\N
68f5eac4-5cf2-4052-85b2-8073209efb4d	eba96f4c-fc01-4e8b-b3af-e9f5a042f2b4	t	${role_view-profile}	view-profile	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	eba96f4c-fc01-4e8b-b3af-e9f5a042f2b4	\N
8dd2f017-b0ba-4d63-bad5-4af3a2e4a663	eba96f4c-fc01-4e8b-b3af-e9f5a042f2b4	t	${role_manage-account}	manage-account	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	eba96f4c-fc01-4e8b-b3af-e9f5a042f2b4	\N
096e2383-fb7d-46db-b8e4-d5c5fb9e8090	eba96f4c-fc01-4e8b-b3af-e9f5a042f2b4	t	${role_manage-account-links}	manage-account-links	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	eba96f4c-fc01-4e8b-b3af-e9f5a042f2b4	\N
5aef7c3b-9f98-47f1-8216-bbd8eb972216	eba96f4c-fc01-4e8b-b3af-e9f5a042f2b4	t	${role_view-applications}	view-applications	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	eba96f4c-fc01-4e8b-b3af-e9f5a042f2b4	\N
9eb8596e-e7da-4278-b1e6-eea8e3567f5e	eba96f4c-fc01-4e8b-b3af-e9f5a042f2b4	t	${role_view-consent}	view-consent	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	eba96f4c-fc01-4e8b-b3af-e9f5a042f2b4	\N
980285be-de6e-4a9e-a122-03481b461a7f	eba96f4c-fc01-4e8b-b3af-e9f5a042f2b4	t	${role_manage-consent}	manage-consent	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	eba96f4c-fc01-4e8b-b3af-e9f5a042f2b4	\N
376545ba-50c4-4da3-9122-9421779f6437	eba96f4c-fc01-4e8b-b3af-e9f5a042f2b4	t	${role_view-groups}	view-groups	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	eba96f4c-fc01-4e8b-b3af-e9f5a042f2b4	\N
15ad1e08-09d1-47a9-a024-c9e368544488	eba96f4c-fc01-4e8b-b3af-e9f5a042f2b4	t	${role_delete-account}	delete-account	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	eba96f4c-fc01-4e8b-b3af-e9f5a042f2b4	\N
911db872-d15d-4e81-bd80-dd3caaea5ced	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	t	${role_impersonation}	impersonation	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	8b4a4b34-f1da-419c-aa6f-62ec476a77e2	\N
8717b5d9-edab-4a4c-9ed4-ef49614a69a1	3a859b28-422a-4b13-ace1-abf51967a3f6	t	${role_impersonation}	impersonation	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	3a859b28-422a-4b13-ace1-abf51967a3f6	\N
f1d801bf-4707-42c2-8ec5-f9ba780c71f6	a0ff463d-23cc-4126-bd41-c01fddc9129e	t	${role_read-token}	read-token	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	a0ff463d-23cc-4126-bd41-c01fddc9129e	\N
05732f5c-1a13-463b-a1c3-5ad62753772c	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	f	${role_offline-access}	offline_access	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	\N	\N
87c7df8f-b33c-46ef-aa3b-a35042d9e526	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	f	${role_uma_authorization}	uma_authorization	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	\N	\N
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.composite_role (composite, child_role) FROM stdin;
28652c93-3773-4132-86d8-4e94076d5598	bdd0e543-4aa0-4462-89e9-e5b171144a16
28652c93-3773-4132-86d8-4e94076d5598	b7222d10-2d9e-444b-948b-1d127945fe71
28652c93-3773-4132-86d8-4e94076d5598	80ef6a24-4cdd-47c6-9a50-e4365e272fb7
28652c93-3773-4132-86d8-4e94076d5598	3f6a6102-83a5-4453-ac0c-c269f88c27a6
28652c93-3773-4132-86d8-4e94076d5598	def8c6b4-daa1-479b-aa96-24fa84a2aeea
28652c93-3773-4132-86d8-4e94076d5598	ef262dcd-7366-44ae-b4a8-699f1e946c1c
28652c93-3773-4132-86d8-4e94076d5598	450483de-bf9a-4bdf-b1d7-ee3560b1c71e
28652c93-3773-4132-86d8-4e94076d5598	4cda110b-ab87-4104-86c3-66aead55fafd
28652c93-3773-4132-86d8-4e94076d5598	b1102e99-88dc-44e8-a859-fb2246c1566d
28652c93-3773-4132-86d8-4e94076d5598	1f4a0287-6591-4479-b191-e7b53975cf29
28652c93-3773-4132-86d8-4e94076d5598	e8905044-bc24-45d6-b0e1-02917a91466a
28652c93-3773-4132-86d8-4e94076d5598	be93fbcd-0ce0-48dd-8cfd-e41741854144
28652c93-3773-4132-86d8-4e94076d5598	2d56d5db-4943-461e-b2dd-a1d384f8bfb4
28652c93-3773-4132-86d8-4e94076d5598	8b2b039a-4b3d-44b3-8aaa-c1b83247968c
28652c93-3773-4132-86d8-4e94076d5598	1b273dec-84ca-4bdf-a800-1392c8f12a6f
28652c93-3773-4132-86d8-4e94076d5598	23c9ea38-7622-4775-a5bb-cb2925d5bba2
28652c93-3773-4132-86d8-4e94076d5598	d14d5b39-0b39-4cfa-b949-89118736fd9f
28652c93-3773-4132-86d8-4e94076d5598	2ff8b3e3-f75b-47fb-956c-e3f757406ac3
3edc0499-ea4d-423d-a6a1-179788bf8222	4f87527a-3d22-4d34-a91b-8fce37ea3223
3f6a6102-83a5-4453-ac0c-c269f88c27a6	2ff8b3e3-f75b-47fb-956c-e3f757406ac3
3f6a6102-83a5-4453-ac0c-c269f88c27a6	1b273dec-84ca-4bdf-a800-1392c8f12a6f
def8c6b4-daa1-479b-aa96-24fa84a2aeea	23c9ea38-7622-4775-a5bb-cb2925d5bba2
3edc0499-ea4d-423d-a6a1-179788bf8222	8be99f82-d9a2-41c6-adb8-7f78824995b2
8be99f82-d9a2-41c6-adb8-7f78824995b2	0efbe808-0a55-4acc-91b9-c92da1c91893
75265bf7-57ac-40fc-b397-7b3202812591	da5266bb-17fd-4370-a38e-349a3d19d3be
28652c93-3773-4132-86d8-4e94076d5598	4728896c-2b47-4c53-83c2-4480063884c8
3edc0499-ea4d-423d-a6a1-179788bf8222	defcfd6e-fe85-4026-bd95-b4532f16254e
3edc0499-ea4d-423d-a6a1-179788bf8222	934dbd76-8d1c-4209-99cf-d4e70d6dab61
28652c93-3773-4132-86d8-4e94076d5598	55db5432-6457-4455-8286-806d230c8b0f
28652c93-3773-4132-86d8-4e94076d5598	2c463bfb-3872-4994-bb00-6f09464f41ab
28652c93-3773-4132-86d8-4e94076d5598	f1311b47-ffb7-4a13-9c46-7ed7af031b12
28652c93-3773-4132-86d8-4e94076d5598	b7d5cd9e-a368-48b3-9243-1712006c5057
28652c93-3773-4132-86d8-4e94076d5598	9cf9d8d7-51b1-4bcd-9ab4-3a0c153c225c
28652c93-3773-4132-86d8-4e94076d5598	bf8400c4-dbef-4c65-bdfb-9baad734bc29
28652c93-3773-4132-86d8-4e94076d5598	25449408-f9b9-425d-ac1a-b34296ae75db
28652c93-3773-4132-86d8-4e94076d5598	9375b0d3-d30b-4559-a53f-eccf62938da8
28652c93-3773-4132-86d8-4e94076d5598	f7291743-b0eb-497f-b6a8-c0064197ed57
28652c93-3773-4132-86d8-4e94076d5598	2c212b3d-003d-47cd-8000-2253525c11db
28652c93-3773-4132-86d8-4e94076d5598	841dd101-63ae-49fb-a69f-1910656c331f
28652c93-3773-4132-86d8-4e94076d5598	ee059424-b879-4ca7-8c4e-f33d71d9fdc3
28652c93-3773-4132-86d8-4e94076d5598	7cd6689a-ca85-4c05-ad79-5d33173f0a02
28652c93-3773-4132-86d8-4e94076d5598	74dcf624-6ff9-4ff2-babb-91f6c6fe626b
28652c93-3773-4132-86d8-4e94076d5598	fb746287-5bc7-4a2f-86c3-a60bb85040ac
28652c93-3773-4132-86d8-4e94076d5598	e6d6e616-bc16-4c74-b86a-9ef1156c0c0e
28652c93-3773-4132-86d8-4e94076d5598	921c9903-bd7b-4bcf-a9bf-cdf612df72f8
b7d5cd9e-a368-48b3-9243-1712006c5057	fb746287-5bc7-4a2f-86c3-a60bb85040ac
f1311b47-ffb7-4a13-9c46-7ed7af031b12	921c9903-bd7b-4bcf-a9bf-cdf612df72f8
f1311b47-ffb7-4a13-9c46-7ed7af031b12	74dcf624-6ff9-4ff2-babb-91f6c6fe626b
8cb80a40-28ca-4f70-bb4c-3b3d23fc0068	3da5c134-77fd-48ae-aa56-a718ea127630
8cb80a40-28ca-4f70-bb4c-3b3d23fc0068	3cf90624-5447-4aa7-9bd9-187f6e27475b
8cb80a40-28ca-4f70-bb4c-3b3d23fc0068	001eb388-5e0a-4aa7-9220-9d8b253e5617
8cb80a40-28ca-4f70-bb4c-3b3d23fc0068	ea140d8f-5509-42b1-9d97-dfbef663ce49
8cb80a40-28ca-4f70-bb4c-3b3d23fc0068	843e48cd-d379-480f-9b7d-d2a7e255bf42
8cb80a40-28ca-4f70-bb4c-3b3d23fc0068	fcd6095e-f039-427a-b31f-461caded4045
8cb80a40-28ca-4f70-bb4c-3b3d23fc0068	3aaa0f7b-5798-48bc-a20f-3434d679093e
8cb80a40-28ca-4f70-bb4c-3b3d23fc0068	8e8518de-c026-417d-baf0-05495ee1fbd5
8cb80a40-28ca-4f70-bb4c-3b3d23fc0068	45a30da0-44fc-4e28-b79a-e31c38a75636
8cb80a40-28ca-4f70-bb4c-3b3d23fc0068	b4fd12d2-c1cf-4a38-9847-6882e36fdfd3
8cb80a40-28ca-4f70-bb4c-3b3d23fc0068	3bf268e6-6da0-4fa7-b547-d94ab337ce13
8cb80a40-28ca-4f70-bb4c-3b3d23fc0068	71a4c6a7-066c-490e-b940-19d314875c01
8cb80a40-28ca-4f70-bb4c-3b3d23fc0068	1a266800-dd22-4c63-8a74-28c5f8e5b507
8cb80a40-28ca-4f70-bb4c-3b3d23fc0068	c19a5f44-7001-4b1c-876b-c9b40e844ec8
8cb80a40-28ca-4f70-bb4c-3b3d23fc0068	90d66a07-36d6-4ec3-824b-39dc6ca85809
8cb80a40-28ca-4f70-bb4c-3b3d23fc0068	ac017606-25ca-41c5-bdeb-6d5c1a260649
8cb80a40-28ca-4f70-bb4c-3b3d23fc0068	89ee27d0-b4b6-4f44-b643-a91be650251d
001eb388-5e0a-4aa7-9220-9d8b253e5617	89ee27d0-b4b6-4f44-b643-a91be650251d
001eb388-5e0a-4aa7-9220-9d8b253e5617	c19a5f44-7001-4b1c-876b-c9b40e844ec8
538419ab-6282-4178-8ca3-3ed943c4de09	68f5eac4-5cf2-4052-85b2-8073209efb4d
ea140d8f-5509-42b1-9d97-dfbef663ce49	90d66a07-36d6-4ec3-824b-39dc6ca85809
538419ab-6282-4178-8ca3-3ed943c4de09	8dd2f017-b0ba-4d63-bad5-4af3a2e4a663
8dd2f017-b0ba-4d63-bad5-4af3a2e4a663	096e2383-fb7d-46db-b8e4-d5c5fb9e8090
980285be-de6e-4a9e-a122-03481b461a7f	9eb8596e-e7da-4278-b1e6-eea8e3567f5e
28652c93-3773-4132-86d8-4e94076d5598	911db872-d15d-4e81-bd80-dd3caaea5ced
8cb80a40-28ca-4f70-bb4c-3b3d23fc0068	8717b5d9-edab-4a4c-9ed4-ef49614a69a1
538419ab-6282-4178-8ca3-3ed943c4de09	05732f5c-1a13-463b-a1c3-5ad62753772c
538419ab-6282-4178-8ca3-3ed943c4de09	87c7df8f-b33c-46ef-aa3b-a35042d9e526
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
06f3df14-23c6-4b95-b216-e71fd69ea0c1	\N	3278606b-0f5b-42f0-86a7-61245cea805d	f	t	\N	\N	\N	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	admin	1728679383682	\N	0
04eb8d0b-398d-4bbd-ad20-f5796b496e73	foobar@example.com	foobar@example.com	f	t	\N	foo	bar	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	foo	1728681915432	\N	0
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
1f5fdeeb-d0e7-464d-bb6a-6a57f18ce817	\N	password	06f3df14-23c6-4b95-b216-e71fd69ea0c1	1728679383822	\N	{"value":"SM9pzW9F4o77Zf6PoM/1N0vKe9pKUq7G7sfhQ1IU+W8=","salt":"MWPX+9zsakjhJCsfn+9Nkw==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
4b7c5d90-657f-4f13-ba11-908f2091d0f9	\N	password	04eb8d0b-398d-4bbd-ad20-f5796b496e73	1728681915648	\N	{"value":"3BCSEV4MaghRW116UwiP1DoRu0GePnO2ElNzdt5qoPc=","salt":"+HmOOzmC0u71L1HNRK1GtQ==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2024-10-11 20:42:54.975955	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.25.1	\N	\N	8679374289
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2024-10-11 20:42:54.993239	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.25.1	\N	\N	8679374289
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2024-10-11 20:42:55.026326	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.25.1	\N	\N	8679374289
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2024-10-11 20:42:55.032315	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	8679374289
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2024-10-11 20:42:55.105032	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.25.1	\N	\N	8679374289
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2024-10-11 20:42:55.111954	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.25.1	\N	\N	8679374289
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2024-10-11 20:42:55.499872	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.25.1	\N	\N	8679374289
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2024-10-11 20:42:55.509269	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.25.1	\N	\N	8679374289
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2024-10-11 20:42:55.522958	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.25.1	\N	\N	8679374289
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2024-10-11 20:42:55.620201	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.25.1	\N	\N	8679374289
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2024-10-11 20:42:55.683451	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	8679374289
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2024-10-11 20:42:55.688737	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	8679374289
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2024-10-11 20:42:55.713746	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	8679374289
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-10-11 20:42:55.731054	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.25.1	\N	\N	8679374289
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-10-11 20:42:55.734102	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	8679374289
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-10-11 20:42:55.738051	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.25.1	\N	\N	8679374289
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-10-11 20:42:55.742826	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.25.1	\N	\N	8679374289
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2024-10-11 20:42:55.825291	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.25.1	\N	\N	8679374289
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2024-10-11 20:42:55.867387	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.25.1	\N	\N	8679374289
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2024-10-11 20:42:55.884204	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.25.1	\N	\N	8679374289
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2024-10-11 20:42:55.888788	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.25.1	\N	\N	8679374289
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2024-10-11 20:42:55.893757	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.25.1	\N	\N	8679374289
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2024-10-11 20:42:55.922803	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.25.1	\N	\N	8679374289
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2024-10-11 20:42:55.931236	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.25.1	\N	\N	8679374289
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2024-10-11 20:42:55.9338	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.25.1	\N	\N	8679374289
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2024-10-11 20:42:55.950562	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.25.1	\N	\N	8679374289
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2024-10-11 20:42:56.001204	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.25.1	\N	\N	8679374289
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2024-10-11 20:42:56.006495	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.25.1	\N	\N	8679374289
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2024-10-11 20:42:56.064252	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.25.1	\N	\N	8679374289
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2024-10-11 20:42:56.154269	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.25.1	\N	\N	8679374289
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2024-10-11 20:42:56.176274	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.25.1	\N	\N	8679374289
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2024-10-11 20:42:56.186787	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.25.1	\N	\N	8679374289
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-10-11 20:42:56.197932	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	8679374289
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-10-11 20:42:56.200853	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.25.1	\N	\N	8679374289
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-10-11 20:42:56.22768	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.25.1	\N	\N	8679374289
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2024-10-11 20:42:56.235376	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.25.1	\N	\N	8679374289
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-10-11 20:42:56.242053	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	8679374289
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2024-10-11 20:42:56.24866	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.25.1	\N	\N	8679374289
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2024-10-11 20:42:56.255177	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.25.1	\N	\N	8679374289
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-10-11 20:42:56.257805	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.25.1	\N	\N	8679374289
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-10-11 20:42:56.262017	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.25.1	\N	\N	8679374289
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2024-10-11 20:42:56.271825	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.25.1	\N	\N	8679374289
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-10-11 20:42:56.336556	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.25.1	\N	\N	8679374289
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2024-10-11 20:42:56.342018	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.25.1	\N	\N	8679374289
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-10-11 20:42:56.347445	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.25.1	\N	\N	8679374289
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-10-11 20:42:56.353623	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.25.1	\N	\N	8679374289
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-10-11 20:42:56.355625	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.25.1	\N	\N	8679374289
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-10-11 20:42:56.396918	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.25.1	\N	\N	8679374289
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-10-11 20:42:56.410749	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.25.1	\N	\N	8679374289
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2024-10-11 20:42:56.436821	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.25.1	\N	\N	8679374289
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2024-10-11 20:42:56.471241	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.25.1	\N	\N	8679374289
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2024-10-11 20:42:56.478734	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	8679374289
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2024-10-11 20:42:56.485017	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.25.1	\N	\N	8679374289
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2024-10-11 20:42:56.490353	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.25.1	\N	\N	8679374289
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-10-11 20:42:56.499723	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.25.1	\N	\N	8679374289
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-10-11 20:42:56.508802	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.25.1	\N	\N	8679374289
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-10-11 20:42:56.543312	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.25.1	\N	\N	8679374289
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-10-11 20:42:56.74187	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.25.1	\N	\N	8679374289
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2024-10-11 20:42:56.767294	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.25.1	\N	\N	8679374289
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2024-10-11 20:42:56.777404	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.25.1	\N	\N	8679374289
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2024-10-11 20:42:56.802371	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.25.1	\N	\N	8679374289
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2024-10-11 20:42:56.815899	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.25.1	\N	\N	8679374289
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2024-10-11 20:42:56.82341	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.25.1	\N	\N	8679374289
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2024-10-11 20:42:56.829832	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.25.1	\N	\N	8679374289
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2024-10-11 20:42:56.835011	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.25.1	\N	\N	8679374289
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2024-10-11 20:42:56.845626	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.25.1	\N	\N	8679374289
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2024-10-11 20:42:56.852988	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.25.1	\N	\N	8679374289
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2024-10-11 20:42:56.860989	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.25.1	\N	\N	8679374289
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2024-10-11 20:42:56.881036	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.25.1	\N	\N	8679374289
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2024-10-11 20:42:56.890647	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.25.1	\N	\N	8679374289
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2024-10-11 20:42:56.898922	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.25.1	\N	\N	8679374289
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-10-11 20:42:56.927835	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	8679374289
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-10-11 20:42:56.938399	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	8679374289
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-10-11 20:42:56.992543	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	8679374289
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-10-11 20:42:57.020719	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.25.1	\N	\N	8679374289
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-10-11 20:42:57.028523	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.25.1	\N	\N	8679374289
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-10-11 20:42:57.044861	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.25.1	\N	\N	8679374289
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-10-11 20:42:57.047969	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.25.1	\N	\N	8679374289
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-10-11 20:42:57.073172	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.25.1	\N	\N	8679374289
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-10-11 20:42:57.0779	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.25.1	\N	\N	8679374289
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-10-11 20:42:57.089628	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.25.1	\N	\N	8679374289
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-10-11 20:42:57.093961	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	8679374289
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-10-11 20:42:57.106364	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	8679374289
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-10-11 20:42:57.109509	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	8679374289
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-10-11 20:42:57.121251	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	8679374289
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2024-10-11 20:42:57.130438	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.25.1	\N	\N	8679374289
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2024-10-11 20:42:57.147421	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.25.1	\N	\N	8679374289
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2024-10-11 20:42:57.160902	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.25.1	\N	\N	8679374289
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-10-11 20:42:57.174004	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.25.1	\N	\N	8679374289
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-10-11 20:42:57.18278	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.25.1	\N	\N	8679374289
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-10-11 20:42:57.190489	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	8679374289
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-10-11 20:42:57.200991	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.25.1	\N	\N	8679374289
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-10-11 20:42:57.203961	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.25.1	\N	\N	8679374289
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-10-11 20:42:57.216651	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.25.1	\N	\N	8679374289
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-10-11 20:42:57.22027	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.25.1	\N	\N	8679374289
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-10-11 20:42:57.27236	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.25.1	\N	\N	8679374289
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-10-11 20:42:57.330523	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	8679374289
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-10-11 20:42:57.333487	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	8679374289
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-10-11 20:42:57.352594	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	8679374289
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-10-11 20:42:57.3622	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	8679374289
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-10-11 20:42:57.365319	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	8679374289
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-10-11 20:42:57.373732	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.25.1	\N	\N	8679374289
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-10-11 20:42:57.38312	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.25.1	\N	\N	8679374289
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2024-10-11 20:42:57.395585	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.25.1	\N	\N	8679374289
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2024-10-11 20:42:57.403235	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.25.1	\N	\N	8679374289
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2024-10-11 20:42:57.409972	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.25.1	\N	\N	8679374289
18.0.15-30992-index-consent	keycloak	META-INF/jpa-changelog-18.0.15.xml	2024-10-11 20:42:57.424917	107	EXECUTED	9:80071ede7a05604b1f4906f3bf3b00f0	createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE		\N	4.25.1	\N	\N	8679374289
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2024-10-11 20:42:57.434541	108	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.25.1	\N	\N	8679374289
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-10-11 20:42:57.4445	109	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.25.1	\N	\N	8679374289
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-10-11 20:42:57.447761	110	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.25.1	\N	\N	8679374289
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-10-11 20:42:57.458887	111	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	8679374289
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2024-10-11 20:42:57.469437	112	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.25.1	\N	\N	8679374289
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2024-10-11 20:42:57.484012	113	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.25.1	\N	\N	8679374289
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2024-10-11 20:42:57.489099	114	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.25.1	\N	\N	8679374289
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2024-10-11 20:42:57.509157	115	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.25.1	\N	\N	8679374289
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2024-10-11 20:42:57.512358	116	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.25.1	\N	\N	8679374289
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2024-10-11 20:42:57.52282	117	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.25.1	\N	\N	8679374289
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2024-10-11 20:42:57.534585	118	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	8679374289
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-10-11 20:42:57.552423	119	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.25.1	\N	\N	8679374289
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-10-11 20:42:57.56495	120	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.25.1	\N	\N	8679374289
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-10-11 20:42:57.573383	121	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	8679374289
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-10-11 20:42:57.582975	122	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	8679374289
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-10-11 20:42:57.592438	123	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.25.1	\N	\N	8679374289
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-10-11 20:42:57.595645	124	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	8679374289
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-10-11 20:42:57.599747	125	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	8679374289
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-10-11 20:42:57.609529	126	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.25.1	\N	\N	8679374289
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-10-11 20:42:57.616285	127	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	8679374289
25.0.0-28265-index-cleanup	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-10-11 20:42:57.626755	128	EXECUTED	9:8c0cfa341a0474385b324f5c4b2dfcc1	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION; dropIndex ...		\N	4.25.1	\N	\N	8679374289
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-10-11 20:42:57.63098	129	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	8679374289
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-10-11 20:42:57.641825	130	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	8679374289
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-10-11 20:42:57.657406	131	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.25.1	\N	\N	8679374289
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-10-11 20:42:57.672486	132	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.25.1	\N	\N	8679374289
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-10-11 20:42:57.67551	133	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.25.1	\N	\N	8679374289
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-10-11 20:42:57.683804	134	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.25.1	\N	\N	8679374289
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	870cda08-b62f-4572-ad45-e8f105aef2cc	f
3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	00a59f91-955b-4bd6-8a50-04ef48d3eb77	t
3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	ddc7c8a2-5096-44f3-945e-47d1c59057c2	t
3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	367e4646-da88-4a9e-b064-ea4875de785a	t
3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	df600c68-8316-4bfe-a0bf-6a2569c3ee85	f
3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	e7c17ef3-6940-42d2-9ea4-740ba4786c73	f
3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	2560dbea-6828-434c-a09f-3e0a6175ddca	t
3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	29fff4ec-d1cb-4105-9203-dd2661ff910d	t
3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	bcdfb684-445f-4109-89ed-3e3a1421ab78	f
3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	12be406b-33e7-4186-aa12-0d196f650f9f	t
3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	eb8159fe-8bb4-4184-af19-9ab02a0be00c	t
d954e40a-95eb-4c8d-bbe6-a1de520c31a8	6e19494c-632c-436d-8fca-f7e243ba70de	f
d954e40a-95eb-4c8d-bbe6-a1de520c31a8	0bb5c221-8de7-4f23-ae3d-b5144e138e96	t
d954e40a-95eb-4c8d-bbe6-a1de520c31a8	d2093271-2662-4829-8ecb-79fb23eb9bd9	t
d954e40a-95eb-4c8d-bbe6-a1de520c31a8	e69de729-aeb1-4853-bc52-fe7ceb05376d	t
d954e40a-95eb-4c8d-bbe6-a1de520c31a8	8db8f53c-46af-49d7-a339-cd093a0d316d	f
d954e40a-95eb-4c8d-bbe6-a1de520c31a8	847e2b44-2b44-4588-ba5d-60e8f64921e7	f
d954e40a-95eb-4c8d-bbe6-a1de520c31a8	a0697fdd-acb1-4b25-9c70-a38d704072d1	t
d954e40a-95eb-4c8d-bbe6-a1de520c31a8	e03ed03f-90d7-4029-86bd-ff0cf87d8591	t
d954e40a-95eb-4c8d-bbe6-a1de520c31a8	6f779370-cb02-4849-8a63-bce28a6da83c	f
d954e40a-95eb-4c8d-bbe6-a1de520c31a8	3f964c38-1350-4181-b7b4-86ea2e7d3350	t
d954e40a-95eb-4c8d-bbe6-a1de520c31a8	597c1f45-6b30-424b-ac29-9f6c636d856e	t
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.migration_model (id, version, update_time) FROM stdin;
uzuz2	25.0.4	1728679378
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id, version) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version) FROM stdin;
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.org (id, enabled, realm_id, group_id, name, description) FROM stdin;
\.


--
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.org_domain (id, name, verified, org_id) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
4ca28a62-c69b-4834-9c73-929d5f93caeb	audience resolve	openid-connect	oidc-audience-resolve-mapper	e8fe6ba7-81c0-48c6-b3e5-6dc17c8c77fe	\N
74f9820a-5b82-474d-8263-539fc4ee43ab	locale	openid-connect	oidc-usermodel-attribute-mapper	121db436-e63f-49ba-a93a-7a6951e5315e	\N
251734b6-7fe5-4b69-913a-a57dbf8f2f64	role list	saml	saml-role-list-mapper	\N	00a59f91-955b-4bd6-8a50-04ef48d3eb77
af124be5-d193-431a-8f9f-fc7331f00ffb	full name	openid-connect	oidc-full-name-mapper	\N	ddc7c8a2-5096-44f3-945e-47d1c59057c2
98b91005-1a8c-4ecd-ad36-44fe0b623672	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	ddc7c8a2-5096-44f3-945e-47d1c59057c2
ffd50636-6c2c-4200-8845-b9f2fadaf41f	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	ddc7c8a2-5096-44f3-945e-47d1c59057c2
f69e4701-4d1e-4483-a5b1-a298ce32fd85	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	ddc7c8a2-5096-44f3-945e-47d1c59057c2
57f28bfe-9e92-4fb7-b3d2-bb5232e811f0	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	ddc7c8a2-5096-44f3-945e-47d1c59057c2
e93af33c-8154-4fcb-9352-e5271d54aec1	username	openid-connect	oidc-usermodel-attribute-mapper	\N	ddc7c8a2-5096-44f3-945e-47d1c59057c2
193f5b40-9efd-480a-a9ba-e29095a311df	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	ddc7c8a2-5096-44f3-945e-47d1c59057c2
08b0942c-a7a6-4f03-bae4-b09f48d9022c	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	ddc7c8a2-5096-44f3-945e-47d1c59057c2
4765a11f-3dbd-421a-ba5c-3703c9958d96	website	openid-connect	oidc-usermodel-attribute-mapper	\N	ddc7c8a2-5096-44f3-945e-47d1c59057c2
8512e064-5492-43fc-af06-962a0e88a14e	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	ddc7c8a2-5096-44f3-945e-47d1c59057c2
27e9ae9c-3c5b-462a-8b97-0c70c8cf1207	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	ddc7c8a2-5096-44f3-945e-47d1c59057c2
f32c174e-9b6d-4341-a880-4bf0ca8f5cd5	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	ddc7c8a2-5096-44f3-945e-47d1c59057c2
e3c10076-6ba3-46d6-bc3f-cddc3d656609	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	ddc7c8a2-5096-44f3-945e-47d1c59057c2
2520afb0-372a-4399-917f-8968d6b023f0	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	ddc7c8a2-5096-44f3-945e-47d1c59057c2
d45880ce-5874-40dd-8419-05ede59026e6	email	openid-connect	oidc-usermodel-attribute-mapper	\N	367e4646-da88-4a9e-b064-ea4875de785a
53b600d1-f226-4198-b4c1-bec31211ffac	email verified	openid-connect	oidc-usermodel-property-mapper	\N	367e4646-da88-4a9e-b064-ea4875de785a
be0f16cf-1541-4974-b0d5-8a302058be21	address	openid-connect	oidc-address-mapper	\N	df600c68-8316-4bfe-a0bf-6a2569c3ee85
54b6780f-8033-4e5c-95d1-1d85796e9eb7	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	e7c17ef3-6940-42d2-9ea4-740ba4786c73
dad20401-7b25-4bd3-ba03-382ee4d9453d	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	e7c17ef3-6940-42d2-9ea4-740ba4786c73
a28996c8-e8a4-44cf-b1ab-607d3a1923bb	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	2560dbea-6828-434c-a09f-3e0a6175ddca
7b24c658-c840-426a-8453-1235ad16129c	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	2560dbea-6828-434c-a09f-3e0a6175ddca
4195dcc2-b905-48cd-b05e-b0b5cd16f9da	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	2560dbea-6828-434c-a09f-3e0a6175ddca
be2db91b-06e3-438e-842c-b3da8f34a42d	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	29fff4ec-d1cb-4105-9203-dd2661ff910d
14007598-fb50-4cec-a8c0-9dfc48ebd34d	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	bcdfb684-445f-4109-89ed-3e3a1421ab78
0b3025a9-4407-4934-a1d2-990066409b1c	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	bcdfb684-445f-4109-89ed-3e3a1421ab78
b578ad35-fee6-46a3-a51f-168c12077636	acr loa level	openid-connect	oidc-acr-mapper	\N	12be406b-33e7-4186-aa12-0d196f650f9f
57735a6c-e935-4805-a1b7-2841a2f17d29	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	eb8159fe-8bb4-4184-af19-9ab02a0be00c
3363731c-ec42-4204-a0dc-744976686060	sub	openid-connect	oidc-sub-mapper	\N	eb8159fe-8bb4-4184-af19-9ab02a0be00c
1f95fe11-b79c-4530-a7d1-f0a08b3f136c	audience resolve	openid-connect	oidc-audience-resolve-mapper	a8298116-778e-4155-8ed9-9454d57106ff	\N
c7c2293d-15d4-4aff-8041-ea368108a33f	role list	saml	saml-role-list-mapper	\N	0bb5c221-8de7-4f23-ae3d-b5144e138e96
405dd886-1126-49f1-ae21-2aec94f076da	full name	openid-connect	oidc-full-name-mapper	\N	d2093271-2662-4829-8ecb-79fb23eb9bd9
25030ae8-650b-480d-8776-b8443e3c8b36	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	d2093271-2662-4829-8ecb-79fb23eb9bd9
e0e7d87c-7758-48b8-8f72-13aa7fa28e9e	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	d2093271-2662-4829-8ecb-79fb23eb9bd9
d8566be3-2a82-4744-9780-d129a4a200fc	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	d2093271-2662-4829-8ecb-79fb23eb9bd9
728a3b17-6a56-4434-a7eb-f5f9922013c9	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	d2093271-2662-4829-8ecb-79fb23eb9bd9
03494e63-8bf9-4baf-8db6-9042e9b6b0e0	username	openid-connect	oidc-usermodel-attribute-mapper	\N	d2093271-2662-4829-8ecb-79fb23eb9bd9
4debc218-0bbc-4152-b343-163aa884b68a	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	d2093271-2662-4829-8ecb-79fb23eb9bd9
23753cf6-6775-4e39-a9d3-1828e167a39c	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	d2093271-2662-4829-8ecb-79fb23eb9bd9
bb8870de-8957-43ca-9e79-48b4d21fa0a8	website	openid-connect	oidc-usermodel-attribute-mapper	\N	d2093271-2662-4829-8ecb-79fb23eb9bd9
7e69646a-216c-44fc-9a0a-d42790b84118	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	d2093271-2662-4829-8ecb-79fb23eb9bd9
87096dfb-e5ec-4fef-9725-e46242a07452	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	d2093271-2662-4829-8ecb-79fb23eb9bd9
61d92d72-ee44-4885-ab2e-01e01fea1d92	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	d2093271-2662-4829-8ecb-79fb23eb9bd9
bb96f115-c7ba-4899-b34a-e96192138a55	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	d2093271-2662-4829-8ecb-79fb23eb9bd9
50024c73-d99e-4353-8274-9277f9cdd258	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	d2093271-2662-4829-8ecb-79fb23eb9bd9
f571c201-b07e-4318-bf0a-78cd7371cb55	email	openid-connect	oidc-usermodel-attribute-mapper	\N	e69de729-aeb1-4853-bc52-fe7ceb05376d
8fb786f2-dfcf-4949-a67c-961e4ca4ee70	email verified	openid-connect	oidc-usermodel-property-mapper	\N	e69de729-aeb1-4853-bc52-fe7ceb05376d
f5d24ef6-2449-4383-b472-cad69974ea33	address	openid-connect	oidc-address-mapper	\N	8db8f53c-46af-49d7-a339-cd093a0d316d
9e27069b-7b29-4725-bb0b-e266e24d01d3	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	847e2b44-2b44-4588-ba5d-60e8f64921e7
b5d65740-b8b2-40dc-986a-daa15596b5a7	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	847e2b44-2b44-4588-ba5d-60e8f64921e7
e636e65d-73d8-4e5a-9fc2-0775d36b5742	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	a0697fdd-acb1-4b25-9c70-a38d704072d1
2a668e87-1bef-4f4f-ab81-ef6501e0d573	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	a0697fdd-acb1-4b25-9c70-a38d704072d1
3e3c31f3-8722-41c1-9370-974b48be5986	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	a0697fdd-acb1-4b25-9c70-a38d704072d1
0d33c9fe-2a06-46b2-823b-265a6d64ab8b	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	e03ed03f-90d7-4029-86bd-ff0cf87d8591
0412401d-1c46-4a0b-a5cf-64a47d0c76fe	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	6f779370-cb02-4849-8a63-bce28a6da83c
54d917b5-1aff-4237-91ed-36a395d4c4ed	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	6f779370-cb02-4849-8a63-bce28a6da83c
7282520e-66db-471b-94a8-c89b0c0a3c09	acr loa level	openid-connect	oidc-acr-mapper	\N	3f964c38-1350-4181-b7b4-86ea2e7d3350
128d1a03-c386-4234-bca6-6bccfccb3f32	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	597c1f45-6b30-424b-ac29-9f6c636d856e
dddf95c8-f0d5-45ee-9b76-e87e0ac64165	sub	openid-connect	oidc-sub-mapper	\N	597c1f45-6b30-424b-ac29-9f6c636d856e
e0bc83ae-8330-4405-aa15-6f355de37e30	locale	openid-connect	oidc-usermodel-attribute-mapper	c6697c1f-2ead-4af7-b8cd-195dd0332614	\N
05d84df4-4cfb-4fc0-840d-ae62e239ef63	aud-mapper-oauth-proxy-client	openid-connect	oidc-audience-mapper	51abee6f-2294-4cea-a78a-fbfd60c8fc07	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
74f9820a-5b82-474d-8263-539fc4ee43ab	true	introspection.token.claim
74f9820a-5b82-474d-8263-539fc4ee43ab	true	userinfo.token.claim
74f9820a-5b82-474d-8263-539fc4ee43ab	locale	user.attribute
74f9820a-5b82-474d-8263-539fc4ee43ab	true	id.token.claim
74f9820a-5b82-474d-8263-539fc4ee43ab	true	access.token.claim
74f9820a-5b82-474d-8263-539fc4ee43ab	locale	claim.name
74f9820a-5b82-474d-8263-539fc4ee43ab	String	jsonType.label
251734b6-7fe5-4b69-913a-a57dbf8f2f64	false	single
251734b6-7fe5-4b69-913a-a57dbf8f2f64	Basic	attribute.nameformat
251734b6-7fe5-4b69-913a-a57dbf8f2f64	Role	attribute.name
08b0942c-a7a6-4f03-bae4-b09f48d9022c	true	introspection.token.claim
08b0942c-a7a6-4f03-bae4-b09f48d9022c	true	userinfo.token.claim
08b0942c-a7a6-4f03-bae4-b09f48d9022c	picture	user.attribute
08b0942c-a7a6-4f03-bae4-b09f48d9022c	true	id.token.claim
08b0942c-a7a6-4f03-bae4-b09f48d9022c	true	access.token.claim
08b0942c-a7a6-4f03-bae4-b09f48d9022c	picture	claim.name
08b0942c-a7a6-4f03-bae4-b09f48d9022c	String	jsonType.label
193f5b40-9efd-480a-a9ba-e29095a311df	true	introspection.token.claim
193f5b40-9efd-480a-a9ba-e29095a311df	true	userinfo.token.claim
193f5b40-9efd-480a-a9ba-e29095a311df	profile	user.attribute
193f5b40-9efd-480a-a9ba-e29095a311df	true	id.token.claim
193f5b40-9efd-480a-a9ba-e29095a311df	true	access.token.claim
193f5b40-9efd-480a-a9ba-e29095a311df	profile	claim.name
193f5b40-9efd-480a-a9ba-e29095a311df	String	jsonType.label
2520afb0-372a-4399-917f-8968d6b023f0	true	introspection.token.claim
2520afb0-372a-4399-917f-8968d6b023f0	true	userinfo.token.claim
2520afb0-372a-4399-917f-8968d6b023f0	updatedAt	user.attribute
2520afb0-372a-4399-917f-8968d6b023f0	true	id.token.claim
2520afb0-372a-4399-917f-8968d6b023f0	true	access.token.claim
2520afb0-372a-4399-917f-8968d6b023f0	updated_at	claim.name
2520afb0-372a-4399-917f-8968d6b023f0	long	jsonType.label
27e9ae9c-3c5b-462a-8b97-0c70c8cf1207	true	introspection.token.claim
27e9ae9c-3c5b-462a-8b97-0c70c8cf1207	true	userinfo.token.claim
27e9ae9c-3c5b-462a-8b97-0c70c8cf1207	birthdate	user.attribute
27e9ae9c-3c5b-462a-8b97-0c70c8cf1207	true	id.token.claim
27e9ae9c-3c5b-462a-8b97-0c70c8cf1207	true	access.token.claim
27e9ae9c-3c5b-462a-8b97-0c70c8cf1207	birthdate	claim.name
27e9ae9c-3c5b-462a-8b97-0c70c8cf1207	String	jsonType.label
4765a11f-3dbd-421a-ba5c-3703c9958d96	true	introspection.token.claim
4765a11f-3dbd-421a-ba5c-3703c9958d96	true	userinfo.token.claim
4765a11f-3dbd-421a-ba5c-3703c9958d96	website	user.attribute
4765a11f-3dbd-421a-ba5c-3703c9958d96	true	id.token.claim
4765a11f-3dbd-421a-ba5c-3703c9958d96	true	access.token.claim
4765a11f-3dbd-421a-ba5c-3703c9958d96	website	claim.name
4765a11f-3dbd-421a-ba5c-3703c9958d96	String	jsonType.label
57f28bfe-9e92-4fb7-b3d2-bb5232e811f0	true	introspection.token.claim
57f28bfe-9e92-4fb7-b3d2-bb5232e811f0	true	userinfo.token.claim
57f28bfe-9e92-4fb7-b3d2-bb5232e811f0	nickname	user.attribute
57f28bfe-9e92-4fb7-b3d2-bb5232e811f0	true	id.token.claim
57f28bfe-9e92-4fb7-b3d2-bb5232e811f0	true	access.token.claim
57f28bfe-9e92-4fb7-b3d2-bb5232e811f0	nickname	claim.name
57f28bfe-9e92-4fb7-b3d2-bb5232e811f0	String	jsonType.label
8512e064-5492-43fc-af06-962a0e88a14e	true	introspection.token.claim
8512e064-5492-43fc-af06-962a0e88a14e	true	userinfo.token.claim
8512e064-5492-43fc-af06-962a0e88a14e	gender	user.attribute
8512e064-5492-43fc-af06-962a0e88a14e	true	id.token.claim
8512e064-5492-43fc-af06-962a0e88a14e	true	access.token.claim
8512e064-5492-43fc-af06-962a0e88a14e	gender	claim.name
8512e064-5492-43fc-af06-962a0e88a14e	String	jsonType.label
98b91005-1a8c-4ecd-ad36-44fe0b623672	true	introspection.token.claim
98b91005-1a8c-4ecd-ad36-44fe0b623672	true	userinfo.token.claim
98b91005-1a8c-4ecd-ad36-44fe0b623672	lastName	user.attribute
98b91005-1a8c-4ecd-ad36-44fe0b623672	true	id.token.claim
98b91005-1a8c-4ecd-ad36-44fe0b623672	true	access.token.claim
98b91005-1a8c-4ecd-ad36-44fe0b623672	family_name	claim.name
98b91005-1a8c-4ecd-ad36-44fe0b623672	String	jsonType.label
af124be5-d193-431a-8f9f-fc7331f00ffb	true	introspection.token.claim
af124be5-d193-431a-8f9f-fc7331f00ffb	true	userinfo.token.claim
af124be5-d193-431a-8f9f-fc7331f00ffb	true	id.token.claim
af124be5-d193-431a-8f9f-fc7331f00ffb	true	access.token.claim
e3c10076-6ba3-46d6-bc3f-cddc3d656609	true	introspection.token.claim
e3c10076-6ba3-46d6-bc3f-cddc3d656609	true	userinfo.token.claim
e3c10076-6ba3-46d6-bc3f-cddc3d656609	locale	user.attribute
e3c10076-6ba3-46d6-bc3f-cddc3d656609	true	id.token.claim
e3c10076-6ba3-46d6-bc3f-cddc3d656609	true	access.token.claim
e3c10076-6ba3-46d6-bc3f-cddc3d656609	locale	claim.name
e3c10076-6ba3-46d6-bc3f-cddc3d656609	String	jsonType.label
e93af33c-8154-4fcb-9352-e5271d54aec1	true	introspection.token.claim
e93af33c-8154-4fcb-9352-e5271d54aec1	true	userinfo.token.claim
e93af33c-8154-4fcb-9352-e5271d54aec1	username	user.attribute
e93af33c-8154-4fcb-9352-e5271d54aec1	true	id.token.claim
e93af33c-8154-4fcb-9352-e5271d54aec1	true	access.token.claim
e93af33c-8154-4fcb-9352-e5271d54aec1	preferred_username	claim.name
e93af33c-8154-4fcb-9352-e5271d54aec1	String	jsonType.label
f32c174e-9b6d-4341-a880-4bf0ca8f5cd5	true	introspection.token.claim
f32c174e-9b6d-4341-a880-4bf0ca8f5cd5	true	userinfo.token.claim
f32c174e-9b6d-4341-a880-4bf0ca8f5cd5	zoneinfo	user.attribute
f32c174e-9b6d-4341-a880-4bf0ca8f5cd5	true	id.token.claim
f32c174e-9b6d-4341-a880-4bf0ca8f5cd5	true	access.token.claim
f32c174e-9b6d-4341-a880-4bf0ca8f5cd5	zoneinfo	claim.name
f32c174e-9b6d-4341-a880-4bf0ca8f5cd5	String	jsonType.label
f69e4701-4d1e-4483-a5b1-a298ce32fd85	true	introspection.token.claim
f69e4701-4d1e-4483-a5b1-a298ce32fd85	true	userinfo.token.claim
f69e4701-4d1e-4483-a5b1-a298ce32fd85	middleName	user.attribute
f69e4701-4d1e-4483-a5b1-a298ce32fd85	true	id.token.claim
f69e4701-4d1e-4483-a5b1-a298ce32fd85	true	access.token.claim
f69e4701-4d1e-4483-a5b1-a298ce32fd85	middle_name	claim.name
f69e4701-4d1e-4483-a5b1-a298ce32fd85	String	jsonType.label
ffd50636-6c2c-4200-8845-b9f2fadaf41f	true	introspection.token.claim
ffd50636-6c2c-4200-8845-b9f2fadaf41f	true	userinfo.token.claim
ffd50636-6c2c-4200-8845-b9f2fadaf41f	firstName	user.attribute
ffd50636-6c2c-4200-8845-b9f2fadaf41f	true	id.token.claim
ffd50636-6c2c-4200-8845-b9f2fadaf41f	true	access.token.claim
ffd50636-6c2c-4200-8845-b9f2fadaf41f	given_name	claim.name
ffd50636-6c2c-4200-8845-b9f2fadaf41f	String	jsonType.label
53b600d1-f226-4198-b4c1-bec31211ffac	true	introspection.token.claim
53b600d1-f226-4198-b4c1-bec31211ffac	true	userinfo.token.claim
53b600d1-f226-4198-b4c1-bec31211ffac	emailVerified	user.attribute
53b600d1-f226-4198-b4c1-bec31211ffac	true	id.token.claim
53b600d1-f226-4198-b4c1-bec31211ffac	true	access.token.claim
53b600d1-f226-4198-b4c1-bec31211ffac	email_verified	claim.name
53b600d1-f226-4198-b4c1-bec31211ffac	boolean	jsonType.label
d45880ce-5874-40dd-8419-05ede59026e6	true	introspection.token.claim
d45880ce-5874-40dd-8419-05ede59026e6	true	userinfo.token.claim
d45880ce-5874-40dd-8419-05ede59026e6	email	user.attribute
d45880ce-5874-40dd-8419-05ede59026e6	true	id.token.claim
d45880ce-5874-40dd-8419-05ede59026e6	true	access.token.claim
d45880ce-5874-40dd-8419-05ede59026e6	email	claim.name
d45880ce-5874-40dd-8419-05ede59026e6	String	jsonType.label
be0f16cf-1541-4974-b0d5-8a302058be21	formatted	user.attribute.formatted
be0f16cf-1541-4974-b0d5-8a302058be21	country	user.attribute.country
be0f16cf-1541-4974-b0d5-8a302058be21	true	introspection.token.claim
be0f16cf-1541-4974-b0d5-8a302058be21	postal_code	user.attribute.postal_code
be0f16cf-1541-4974-b0d5-8a302058be21	true	userinfo.token.claim
be0f16cf-1541-4974-b0d5-8a302058be21	street	user.attribute.street
be0f16cf-1541-4974-b0d5-8a302058be21	true	id.token.claim
be0f16cf-1541-4974-b0d5-8a302058be21	region	user.attribute.region
be0f16cf-1541-4974-b0d5-8a302058be21	true	access.token.claim
be0f16cf-1541-4974-b0d5-8a302058be21	locality	user.attribute.locality
54b6780f-8033-4e5c-95d1-1d85796e9eb7	true	introspection.token.claim
54b6780f-8033-4e5c-95d1-1d85796e9eb7	true	userinfo.token.claim
54b6780f-8033-4e5c-95d1-1d85796e9eb7	phoneNumber	user.attribute
54b6780f-8033-4e5c-95d1-1d85796e9eb7	true	id.token.claim
54b6780f-8033-4e5c-95d1-1d85796e9eb7	true	access.token.claim
54b6780f-8033-4e5c-95d1-1d85796e9eb7	phone_number	claim.name
54b6780f-8033-4e5c-95d1-1d85796e9eb7	String	jsonType.label
dad20401-7b25-4bd3-ba03-382ee4d9453d	true	introspection.token.claim
dad20401-7b25-4bd3-ba03-382ee4d9453d	true	userinfo.token.claim
dad20401-7b25-4bd3-ba03-382ee4d9453d	phoneNumberVerified	user.attribute
dad20401-7b25-4bd3-ba03-382ee4d9453d	true	id.token.claim
dad20401-7b25-4bd3-ba03-382ee4d9453d	true	access.token.claim
dad20401-7b25-4bd3-ba03-382ee4d9453d	phone_number_verified	claim.name
dad20401-7b25-4bd3-ba03-382ee4d9453d	boolean	jsonType.label
4195dcc2-b905-48cd-b05e-b0b5cd16f9da	true	introspection.token.claim
4195dcc2-b905-48cd-b05e-b0b5cd16f9da	true	access.token.claim
7b24c658-c840-426a-8453-1235ad16129c	true	introspection.token.claim
7b24c658-c840-426a-8453-1235ad16129c	true	multivalued
7b24c658-c840-426a-8453-1235ad16129c	foo	user.attribute
7b24c658-c840-426a-8453-1235ad16129c	true	access.token.claim
7b24c658-c840-426a-8453-1235ad16129c	resource_access.${client_id}.roles	claim.name
7b24c658-c840-426a-8453-1235ad16129c	String	jsonType.label
a28996c8-e8a4-44cf-b1ab-607d3a1923bb	true	introspection.token.claim
a28996c8-e8a4-44cf-b1ab-607d3a1923bb	true	multivalued
a28996c8-e8a4-44cf-b1ab-607d3a1923bb	foo	user.attribute
a28996c8-e8a4-44cf-b1ab-607d3a1923bb	true	access.token.claim
a28996c8-e8a4-44cf-b1ab-607d3a1923bb	realm_access.roles	claim.name
a28996c8-e8a4-44cf-b1ab-607d3a1923bb	String	jsonType.label
be2db91b-06e3-438e-842c-b3da8f34a42d	true	introspection.token.claim
be2db91b-06e3-438e-842c-b3da8f34a42d	true	access.token.claim
0b3025a9-4407-4934-a1d2-990066409b1c	true	introspection.token.claim
0b3025a9-4407-4934-a1d2-990066409b1c	true	multivalued
0b3025a9-4407-4934-a1d2-990066409b1c	foo	user.attribute
0b3025a9-4407-4934-a1d2-990066409b1c	true	id.token.claim
0b3025a9-4407-4934-a1d2-990066409b1c	true	access.token.claim
0b3025a9-4407-4934-a1d2-990066409b1c	groups	claim.name
0b3025a9-4407-4934-a1d2-990066409b1c	String	jsonType.label
14007598-fb50-4cec-a8c0-9dfc48ebd34d	true	introspection.token.claim
14007598-fb50-4cec-a8c0-9dfc48ebd34d	true	userinfo.token.claim
14007598-fb50-4cec-a8c0-9dfc48ebd34d	username	user.attribute
14007598-fb50-4cec-a8c0-9dfc48ebd34d	true	id.token.claim
14007598-fb50-4cec-a8c0-9dfc48ebd34d	true	access.token.claim
14007598-fb50-4cec-a8c0-9dfc48ebd34d	upn	claim.name
14007598-fb50-4cec-a8c0-9dfc48ebd34d	String	jsonType.label
b578ad35-fee6-46a3-a51f-168c12077636	true	introspection.token.claim
b578ad35-fee6-46a3-a51f-168c12077636	true	id.token.claim
b578ad35-fee6-46a3-a51f-168c12077636	true	access.token.claim
3363731c-ec42-4204-a0dc-744976686060	true	introspection.token.claim
3363731c-ec42-4204-a0dc-744976686060	true	access.token.claim
57735a6c-e935-4805-a1b7-2841a2f17d29	AUTH_TIME	user.session.note
57735a6c-e935-4805-a1b7-2841a2f17d29	true	introspection.token.claim
57735a6c-e935-4805-a1b7-2841a2f17d29	true	id.token.claim
57735a6c-e935-4805-a1b7-2841a2f17d29	true	access.token.claim
57735a6c-e935-4805-a1b7-2841a2f17d29	auth_time	claim.name
57735a6c-e935-4805-a1b7-2841a2f17d29	long	jsonType.label
c7c2293d-15d4-4aff-8041-ea368108a33f	false	single
c7c2293d-15d4-4aff-8041-ea368108a33f	Basic	attribute.nameformat
c7c2293d-15d4-4aff-8041-ea368108a33f	Role	attribute.name
03494e63-8bf9-4baf-8db6-9042e9b6b0e0	true	introspection.token.claim
03494e63-8bf9-4baf-8db6-9042e9b6b0e0	true	userinfo.token.claim
03494e63-8bf9-4baf-8db6-9042e9b6b0e0	username	user.attribute
03494e63-8bf9-4baf-8db6-9042e9b6b0e0	true	id.token.claim
03494e63-8bf9-4baf-8db6-9042e9b6b0e0	true	access.token.claim
03494e63-8bf9-4baf-8db6-9042e9b6b0e0	preferred_username	claim.name
03494e63-8bf9-4baf-8db6-9042e9b6b0e0	String	jsonType.label
23753cf6-6775-4e39-a9d3-1828e167a39c	true	introspection.token.claim
23753cf6-6775-4e39-a9d3-1828e167a39c	true	userinfo.token.claim
23753cf6-6775-4e39-a9d3-1828e167a39c	picture	user.attribute
23753cf6-6775-4e39-a9d3-1828e167a39c	true	id.token.claim
23753cf6-6775-4e39-a9d3-1828e167a39c	true	access.token.claim
23753cf6-6775-4e39-a9d3-1828e167a39c	picture	claim.name
23753cf6-6775-4e39-a9d3-1828e167a39c	String	jsonType.label
25030ae8-650b-480d-8776-b8443e3c8b36	true	introspection.token.claim
25030ae8-650b-480d-8776-b8443e3c8b36	true	userinfo.token.claim
25030ae8-650b-480d-8776-b8443e3c8b36	lastName	user.attribute
25030ae8-650b-480d-8776-b8443e3c8b36	true	id.token.claim
25030ae8-650b-480d-8776-b8443e3c8b36	true	access.token.claim
25030ae8-650b-480d-8776-b8443e3c8b36	family_name	claim.name
25030ae8-650b-480d-8776-b8443e3c8b36	String	jsonType.label
405dd886-1126-49f1-ae21-2aec94f076da	true	introspection.token.claim
405dd886-1126-49f1-ae21-2aec94f076da	true	userinfo.token.claim
405dd886-1126-49f1-ae21-2aec94f076da	true	id.token.claim
405dd886-1126-49f1-ae21-2aec94f076da	true	access.token.claim
4debc218-0bbc-4152-b343-163aa884b68a	true	introspection.token.claim
4debc218-0bbc-4152-b343-163aa884b68a	true	userinfo.token.claim
4debc218-0bbc-4152-b343-163aa884b68a	profile	user.attribute
4debc218-0bbc-4152-b343-163aa884b68a	true	id.token.claim
4debc218-0bbc-4152-b343-163aa884b68a	true	access.token.claim
4debc218-0bbc-4152-b343-163aa884b68a	profile	claim.name
4debc218-0bbc-4152-b343-163aa884b68a	String	jsonType.label
50024c73-d99e-4353-8274-9277f9cdd258	true	introspection.token.claim
50024c73-d99e-4353-8274-9277f9cdd258	true	userinfo.token.claim
50024c73-d99e-4353-8274-9277f9cdd258	updatedAt	user.attribute
50024c73-d99e-4353-8274-9277f9cdd258	true	id.token.claim
50024c73-d99e-4353-8274-9277f9cdd258	true	access.token.claim
50024c73-d99e-4353-8274-9277f9cdd258	updated_at	claim.name
50024c73-d99e-4353-8274-9277f9cdd258	long	jsonType.label
61d92d72-ee44-4885-ab2e-01e01fea1d92	true	introspection.token.claim
61d92d72-ee44-4885-ab2e-01e01fea1d92	true	userinfo.token.claim
61d92d72-ee44-4885-ab2e-01e01fea1d92	zoneinfo	user.attribute
61d92d72-ee44-4885-ab2e-01e01fea1d92	true	id.token.claim
61d92d72-ee44-4885-ab2e-01e01fea1d92	true	access.token.claim
61d92d72-ee44-4885-ab2e-01e01fea1d92	zoneinfo	claim.name
61d92d72-ee44-4885-ab2e-01e01fea1d92	String	jsonType.label
728a3b17-6a56-4434-a7eb-f5f9922013c9	true	introspection.token.claim
728a3b17-6a56-4434-a7eb-f5f9922013c9	true	userinfo.token.claim
728a3b17-6a56-4434-a7eb-f5f9922013c9	nickname	user.attribute
728a3b17-6a56-4434-a7eb-f5f9922013c9	true	id.token.claim
728a3b17-6a56-4434-a7eb-f5f9922013c9	true	access.token.claim
728a3b17-6a56-4434-a7eb-f5f9922013c9	nickname	claim.name
728a3b17-6a56-4434-a7eb-f5f9922013c9	String	jsonType.label
7e69646a-216c-44fc-9a0a-d42790b84118	true	introspection.token.claim
7e69646a-216c-44fc-9a0a-d42790b84118	true	userinfo.token.claim
7e69646a-216c-44fc-9a0a-d42790b84118	gender	user.attribute
7e69646a-216c-44fc-9a0a-d42790b84118	true	id.token.claim
7e69646a-216c-44fc-9a0a-d42790b84118	true	access.token.claim
7e69646a-216c-44fc-9a0a-d42790b84118	gender	claim.name
7e69646a-216c-44fc-9a0a-d42790b84118	String	jsonType.label
87096dfb-e5ec-4fef-9725-e46242a07452	true	introspection.token.claim
87096dfb-e5ec-4fef-9725-e46242a07452	true	userinfo.token.claim
87096dfb-e5ec-4fef-9725-e46242a07452	birthdate	user.attribute
87096dfb-e5ec-4fef-9725-e46242a07452	true	id.token.claim
87096dfb-e5ec-4fef-9725-e46242a07452	true	access.token.claim
87096dfb-e5ec-4fef-9725-e46242a07452	birthdate	claim.name
87096dfb-e5ec-4fef-9725-e46242a07452	String	jsonType.label
bb8870de-8957-43ca-9e79-48b4d21fa0a8	true	introspection.token.claim
bb8870de-8957-43ca-9e79-48b4d21fa0a8	true	userinfo.token.claim
bb8870de-8957-43ca-9e79-48b4d21fa0a8	website	user.attribute
bb8870de-8957-43ca-9e79-48b4d21fa0a8	true	id.token.claim
bb8870de-8957-43ca-9e79-48b4d21fa0a8	true	access.token.claim
bb8870de-8957-43ca-9e79-48b4d21fa0a8	website	claim.name
bb8870de-8957-43ca-9e79-48b4d21fa0a8	String	jsonType.label
bb96f115-c7ba-4899-b34a-e96192138a55	true	introspection.token.claim
bb96f115-c7ba-4899-b34a-e96192138a55	true	userinfo.token.claim
bb96f115-c7ba-4899-b34a-e96192138a55	locale	user.attribute
bb96f115-c7ba-4899-b34a-e96192138a55	true	id.token.claim
bb96f115-c7ba-4899-b34a-e96192138a55	true	access.token.claim
bb96f115-c7ba-4899-b34a-e96192138a55	locale	claim.name
bb96f115-c7ba-4899-b34a-e96192138a55	String	jsonType.label
d8566be3-2a82-4744-9780-d129a4a200fc	true	introspection.token.claim
d8566be3-2a82-4744-9780-d129a4a200fc	true	userinfo.token.claim
d8566be3-2a82-4744-9780-d129a4a200fc	middleName	user.attribute
d8566be3-2a82-4744-9780-d129a4a200fc	true	id.token.claim
d8566be3-2a82-4744-9780-d129a4a200fc	true	access.token.claim
d8566be3-2a82-4744-9780-d129a4a200fc	middle_name	claim.name
d8566be3-2a82-4744-9780-d129a4a200fc	String	jsonType.label
e0e7d87c-7758-48b8-8f72-13aa7fa28e9e	true	introspection.token.claim
e0e7d87c-7758-48b8-8f72-13aa7fa28e9e	true	userinfo.token.claim
e0e7d87c-7758-48b8-8f72-13aa7fa28e9e	firstName	user.attribute
e0e7d87c-7758-48b8-8f72-13aa7fa28e9e	true	id.token.claim
e0e7d87c-7758-48b8-8f72-13aa7fa28e9e	true	access.token.claim
e0e7d87c-7758-48b8-8f72-13aa7fa28e9e	given_name	claim.name
e0e7d87c-7758-48b8-8f72-13aa7fa28e9e	String	jsonType.label
8fb786f2-dfcf-4949-a67c-961e4ca4ee70	true	introspection.token.claim
8fb786f2-dfcf-4949-a67c-961e4ca4ee70	true	userinfo.token.claim
8fb786f2-dfcf-4949-a67c-961e4ca4ee70	emailVerified	user.attribute
8fb786f2-dfcf-4949-a67c-961e4ca4ee70	true	id.token.claim
8fb786f2-dfcf-4949-a67c-961e4ca4ee70	true	access.token.claim
8fb786f2-dfcf-4949-a67c-961e4ca4ee70	email_verified	claim.name
8fb786f2-dfcf-4949-a67c-961e4ca4ee70	boolean	jsonType.label
f571c201-b07e-4318-bf0a-78cd7371cb55	true	introspection.token.claim
f571c201-b07e-4318-bf0a-78cd7371cb55	true	userinfo.token.claim
f571c201-b07e-4318-bf0a-78cd7371cb55	email	user.attribute
f571c201-b07e-4318-bf0a-78cd7371cb55	true	id.token.claim
f571c201-b07e-4318-bf0a-78cd7371cb55	true	access.token.claim
f571c201-b07e-4318-bf0a-78cd7371cb55	email	claim.name
f571c201-b07e-4318-bf0a-78cd7371cb55	String	jsonType.label
f5d24ef6-2449-4383-b472-cad69974ea33	formatted	user.attribute.formatted
f5d24ef6-2449-4383-b472-cad69974ea33	country	user.attribute.country
f5d24ef6-2449-4383-b472-cad69974ea33	true	introspection.token.claim
f5d24ef6-2449-4383-b472-cad69974ea33	postal_code	user.attribute.postal_code
f5d24ef6-2449-4383-b472-cad69974ea33	true	userinfo.token.claim
f5d24ef6-2449-4383-b472-cad69974ea33	street	user.attribute.street
f5d24ef6-2449-4383-b472-cad69974ea33	true	id.token.claim
f5d24ef6-2449-4383-b472-cad69974ea33	region	user.attribute.region
f5d24ef6-2449-4383-b472-cad69974ea33	true	access.token.claim
f5d24ef6-2449-4383-b472-cad69974ea33	locality	user.attribute.locality
9e27069b-7b29-4725-bb0b-e266e24d01d3	true	introspection.token.claim
9e27069b-7b29-4725-bb0b-e266e24d01d3	true	userinfo.token.claim
9e27069b-7b29-4725-bb0b-e266e24d01d3	phoneNumber	user.attribute
9e27069b-7b29-4725-bb0b-e266e24d01d3	true	id.token.claim
9e27069b-7b29-4725-bb0b-e266e24d01d3	true	access.token.claim
9e27069b-7b29-4725-bb0b-e266e24d01d3	phone_number	claim.name
9e27069b-7b29-4725-bb0b-e266e24d01d3	String	jsonType.label
b5d65740-b8b2-40dc-986a-daa15596b5a7	true	introspection.token.claim
b5d65740-b8b2-40dc-986a-daa15596b5a7	true	userinfo.token.claim
b5d65740-b8b2-40dc-986a-daa15596b5a7	phoneNumberVerified	user.attribute
b5d65740-b8b2-40dc-986a-daa15596b5a7	true	id.token.claim
b5d65740-b8b2-40dc-986a-daa15596b5a7	true	access.token.claim
b5d65740-b8b2-40dc-986a-daa15596b5a7	phone_number_verified	claim.name
b5d65740-b8b2-40dc-986a-daa15596b5a7	boolean	jsonType.label
2a668e87-1bef-4f4f-ab81-ef6501e0d573	true	introspection.token.claim
2a668e87-1bef-4f4f-ab81-ef6501e0d573	true	multivalued
2a668e87-1bef-4f4f-ab81-ef6501e0d573	foo	user.attribute
2a668e87-1bef-4f4f-ab81-ef6501e0d573	true	access.token.claim
2a668e87-1bef-4f4f-ab81-ef6501e0d573	resource_access.${client_id}.roles	claim.name
2a668e87-1bef-4f4f-ab81-ef6501e0d573	String	jsonType.label
3e3c31f3-8722-41c1-9370-974b48be5986	true	introspection.token.claim
3e3c31f3-8722-41c1-9370-974b48be5986	true	access.token.claim
e636e65d-73d8-4e5a-9fc2-0775d36b5742	true	introspection.token.claim
e636e65d-73d8-4e5a-9fc2-0775d36b5742	true	multivalued
e636e65d-73d8-4e5a-9fc2-0775d36b5742	foo	user.attribute
e636e65d-73d8-4e5a-9fc2-0775d36b5742	true	access.token.claim
e636e65d-73d8-4e5a-9fc2-0775d36b5742	realm_access.roles	claim.name
e636e65d-73d8-4e5a-9fc2-0775d36b5742	String	jsonType.label
0d33c9fe-2a06-46b2-823b-265a6d64ab8b	true	introspection.token.claim
0d33c9fe-2a06-46b2-823b-265a6d64ab8b	true	access.token.claim
0412401d-1c46-4a0b-a5cf-64a47d0c76fe	true	introspection.token.claim
0412401d-1c46-4a0b-a5cf-64a47d0c76fe	true	userinfo.token.claim
0412401d-1c46-4a0b-a5cf-64a47d0c76fe	username	user.attribute
0412401d-1c46-4a0b-a5cf-64a47d0c76fe	true	id.token.claim
0412401d-1c46-4a0b-a5cf-64a47d0c76fe	true	access.token.claim
0412401d-1c46-4a0b-a5cf-64a47d0c76fe	upn	claim.name
0412401d-1c46-4a0b-a5cf-64a47d0c76fe	String	jsonType.label
54d917b5-1aff-4237-91ed-36a395d4c4ed	true	introspection.token.claim
54d917b5-1aff-4237-91ed-36a395d4c4ed	true	multivalued
54d917b5-1aff-4237-91ed-36a395d4c4ed	foo	user.attribute
54d917b5-1aff-4237-91ed-36a395d4c4ed	true	id.token.claim
54d917b5-1aff-4237-91ed-36a395d4c4ed	true	access.token.claim
54d917b5-1aff-4237-91ed-36a395d4c4ed	groups	claim.name
54d917b5-1aff-4237-91ed-36a395d4c4ed	String	jsonType.label
7282520e-66db-471b-94a8-c89b0c0a3c09	true	introspection.token.claim
7282520e-66db-471b-94a8-c89b0c0a3c09	true	id.token.claim
7282520e-66db-471b-94a8-c89b0c0a3c09	true	access.token.claim
128d1a03-c386-4234-bca6-6bccfccb3f32	AUTH_TIME	user.session.note
128d1a03-c386-4234-bca6-6bccfccb3f32	true	introspection.token.claim
128d1a03-c386-4234-bca6-6bccfccb3f32	true	id.token.claim
128d1a03-c386-4234-bca6-6bccfccb3f32	true	access.token.claim
128d1a03-c386-4234-bca6-6bccfccb3f32	auth_time	claim.name
128d1a03-c386-4234-bca6-6bccfccb3f32	long	jsonType.label
dddf95c8-f0d5-45ee-9b76-e87e0ac64165	true	introspection.token.claim
dddf95c8-f0d5-45ee-9b76-e87e0ac64165	true	access.token.claim
e0bc83ae-8330-4405-aa15-6f355de37e30	true	introspection.token.claim
e0bc83ae-8330-4405-aa15-6f355de37e30	true	userinfo.token.claim
e0bc83ae-8330-4405-aa15-6f355de37e30	locale	user.attribute
e0bc83ae-8330-4405-aa15-6f355de37e30	true	id.token.claim
e0bc83ae-8330-4405-aa15-6f355de37e30	true	access.token.claim
e0bc83ae-8330-4405-aa15-6f355de37e30	locale	claim.name
e0bc83ae-8330-4405-aa15-6f355de37e30	String	jsonType.label
05d84df4-4cfb-4fc0-840d-ae62e239ef63	oauth-proxy-client	included.client.audience
05d84df4-4cfb-4fc0-840d-ae62e239ef63	true	id.token.claim
05d84df4-4cfb-4fc0-840d-ae62e239ef63	false	lightweight.claim
05d84df4-4cfb-4fc0-840d-ae62e239ef63	true	access.token.claim
05d84df4-4cfb-4fc0-840d-ae62e239ef63	true	introspection.token.claim
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	
_browser_header.xContentTypeOptions	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	nosniff
_browser_header.referrerPolicy	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	no-referrer
_browser_header.xRobotsTag	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	none
_browser_header.xFrameOptions	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	SAMEORIGIN
_browser_header.contentSecurityPolicy	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	1; mode=block
_browser_header.strictTransportSecurity	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	max-age=31536000; includeSubDomains
bruteForceProtected	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	false
permanentLockout	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	false
maxTemporaryLockouts	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	0
maxFailureWaitSeconds	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	900
minimumQuickLoginWaitSeconds	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	60
waitIncrementSeconds	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	60
quickLoginCheckMilliSeconds	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	1000
maxDeltaTimeSeconds	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	43200
failureFactor	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	30
realmReusableOtpCode	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	false
firstBrokerLoginFlowId	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	7f93ff67-ccc7-401d-ab29-c412eeb9b4e0
displayName	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	Keycloak
displayNameHtml	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	RS256
offlineSessionMaxLifespanEnabled	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	false
offlineSessionMaxLifespan	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	5184000
bruteForceProtected	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	false
permanentLockout	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	false
maxTemporaryLockouts	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	0
maxFailureWaitSeconds	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	900
minimumQuickLoginWaitSeconds	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	60
waitIncrementSeconds	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	60
quickLoginCheckMilliSeconds	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	1000
maxDeltaTimeSeconds	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	43200
failureFactor	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	30
realmReusableOtpCode	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	false
defaultSignatureAlgorithm	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	RS256
offlineSessionMaxLifespanEnabled	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	false
offlineSessionMaxLifespan	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	5184000
actionTokenGeneratedByAdminLifespan	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	43200
actionTokenGeneratedByUserLifespan	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	300
oauth2DeviceCodeLifespan	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	600
oauth2DevicePollingInterval	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	5
webAuthnPolicyRpEntityName	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	keycloak
webAuthnPolicySignatureAlgorithms	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	ES256
webAuthnPolicyRpId	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	
webAuthnPolicyAttestationConveyancePreference	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	not specified
webAuthnPolicyAuthenticatorAttachment	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	not specified
webAuthnPolicyRequireResidentKey	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	not specified
webAuthnPolicyUserVerificationRequirement	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	not specified
webAuthnPolicyCreateTimeout	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	0
webAuthnPolicyAvoidSameAuthenticatorRegister	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	false
webAuthnPolicyRpEntityNamePasswordless	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	ES256
webAuthnPolicyRpIdPasswordless	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	
webAuthnPolicyAttestationConveyancePreferencePasswordless	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	not specified
webAuthnPolicyRequireResidentKeyPasswordless	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	not specified
webAuthnPolicyCreateTimeoutPasswordless	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	false
cibaBackchannelTokenDeliveryMode	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	poll
cibaExpiresIn	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	120
cibaInterval	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	5
cibaAuthRequestedUserHint	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	login_hint
parRequestUriLifespan	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	60
firstBrokerLoginFlowId	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	0827ef01-b057-4727-98d5-a9a2a954720b
organizationsEnabled	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	false
clientSessionIdleTimeout	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	0
clientSessionMaxLifespan	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	0
clientOfflineSessionIdleTimeout	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	0
clientOfflineSessionMaxLifespan	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	0
client-policies.profiles	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	{"profiles":[]}
client-policies.policies	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	
_browser_header.xContentTypeOptions	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	nosniff
_browser_header.referrerPolicy	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	no-referrer
_browser_header.xRobotsTag	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	none
_browser_header.xFrameOptions	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	SAMEORIGIN
_browser_header.contentSecurityPolicy	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	1; mode=block
_browser_header.strictTransportSecurity	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	max-age=31536000; includeSubDomains
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	jboss-logging
d954e40a-95eb-4c8d-bbe6-a1de520c31a8	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3
password	password	t	t	d954e40a-95eb-4c8d-bbe6-a1de520c31a8
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.redirect_uris (client_id, value) FROM stdin;
56ee7430-711e-4931-a812-bed36a17be94	/realms/master/account/*
e8fe6ba7-81c0-48c6-b3e5-6dc17c8c77fe	/realms/master/account/*
121db436-e63f-49ba-a93a-7a6951e5315e	/admin/master/console/*
eba96f4c-fc01-4e8b-b3af-e9f5a042f2b4	/realms/houseproject/account/*
a8298116-778e-4155-8ed9-9454d57106ff	/realms/houseproject/account/*
c6697c1f-2ead-4af7-b8cd-195dd0332614	/admin/houseproject/console/*
51abee6f-2294-4cea-a78a-fbfd60c8fc07	http://houseproject.internal/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
cfd5b11b-0e4c-4763-884c-7608e4e0ea33	VERIFY_EMAIL	Verify Email	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	t	f	VERIFY_EMAIL	50
1f7603ec-4de3-4e6c-8e76-8f3ca30379f6	UPDATE_PROFILE	Update Profile	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	t	f	UPDATE_PROFILE	40
c3d0ae92-e641-4a30-894a-0b2308bf8b61	CONFIGURE_TOTP	Configure OTP	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	t	f	CONFIGURE_TOTP	10
d20b3484-dd4c-4533-a113-c1e2a8c9ec75	UPDATE_PASSWORD	Update Password	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	t	f	UPDATE_PASSWORD	30
76c3db5a-7843-4a7b-9ed2-8fabb5e64b71	TERMS_AND_CONDITIONS	Terms and Conditions	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	f	f	TERMS_AND_CONDITIONS	20
0b1897bb-b477-4978-87f5-d22f45d134ec	delete_account	Delete Account	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	f	f	delete_account	60
51f32ec5-7b67-436b-ab95-12fbd9973f9c	delete_credential	Delete Credential	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	t	f	delete_credential	100
8be9ab97-76e4-4fed-aa9b-a18d39d786fb	update_user_locale	Update User Locale	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	t	f	update_user_locale	1000
f706b2a3-fa29-4951-beb3-29b2a8a51f57	webauthn-register	Webauthn Register	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	t	f	webauthn-register	70
9fd2dc16-b03c-41db-87f5-45e5abf29ed2	webauthn-register-passwordless	Webauthn Register Passwordless	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	t	f	webauthn-register-passwordless	80
5cf36cce-8a84-4c7d-abd0-8288c9e7f076	VERIFY_PROFILE	Verify Profile	3e4b0bf0-9fb0-4b73-997f-e7d306a6c7b3	t	f	VERIFY_PROFILE	90
16be0cea-40f4-4383-bf97-9d032444f87d	VERIFY_EMAIL	Verify Email	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	t	f	VERIFY_EMAIL	50
b0b5abf6-260d-4d4f-9484-95ce52e5723d	UPDATE_PROFILE	Update Profile	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	t	f	UPDATE_PROFILE	40
2638e322-a0a7-4b14-a001-0028f1425f3c	CONFIGURE_TOTP	Configure OTP	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	t	f	CONFIGURE_TOTP	10
895df8b4-e34e-4a4e-8eb6-ceff0cb3729c	UPDATE_PASSWORD	Update Password	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	t	f	UPDATE_PASSWORD	30
e54b327c-495d-46fc-b33c-13bc12d52f75	TERMS_AND_CONDITIONS	Terms and Conditions	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	f	f	TERMS_AND_CONDITIONS	20
8d20d043-ff6a-4d9e-9619-c786b81053f8	delete_account	Delete Account	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	f	f	delete_account	60
75a597e3-6172-49bd-b208-8cb754602d7c	delete_credential	Delete Credential	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	t	f	delete_credential	100
857bd941-2d6b-49d7-9379-1eb27c57106c	update_user_locale	Update User Locale	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	t	f	update_user_locale	1000
ea91755a-ebcf-4047-90d2-a857af9068a2	webauthn-register	Webauthn Register	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	t	f	webauthn-register	70
ab81c497-12af-459c-8552-d3fb48879a79	webauthn-register-passwordless	Webauthn Register Passwordless	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	t	f	webauthn-register-passwordless	80
158b9331-f46e-4626-888b-5f09e8c823c3	VERIFY_PROFILE	Verify Profile	d954e40a-95eb-4c8d-bbe6-a1de520c31a8	t	f	VERIFY_PROFILE	90
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
e8fe6ba7-81c0-48c6-b3e5-6dc17c8c77fe	6b89af9f-cf76-4f08-86af-6954ed36fa1d
e8fe6ba7-81c0-48c6-b3e5-6dc17c8c77fe	8be99f82-d9a2-41c6-adb8-7f78824995b2
a8298116-778e-4155-8ed9-9454d57106ff	376545ba-50c4-4da3-9122-9421779f6437
a8298116-778e-4155-8ed9-9454d57106ff	8dd2f017-b0ba-4d63-bad5-4af3a2e4a663
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
3edc0499-ea4d-423d-a6a1-179788bf8222	06f3df14-23c6-4b95-b216-e71fd69ea0c1
28652c93-3773-4132-86d8-4e94076d5598	06f3df14-23c6-4b95-b216-e71fd69ea0c1
55db5432-6457-4455-8286-806d230c8b0f	06f3df14-23c6-4b95-b216-e71fd69ea0c1
2c463bfb-3872-4994-bb00-6f09464f41ab	06f3df14-23c6-4b95-b216-e71fd69ea0c1
f1311b47-ffb7-4a13-9c46-7ed7af031b12	06f3df14-23c6-4b95-b216-e71fd69ea0c1
b7d5cd9e-a368-48b3-9243-1712006c5057	06f3df14-23c6-4b95-b216-e71fd69ea0c1
9cf9d8d7-51b1-4bcd-9ab4-3a0c153c225c	06f3df14-23c6-4b95-b216-e71fd69ea0c1
bf8400c4-dbef-4c65-bdfb-9baad734bc29	06f3df14-23c6-4b95-b216-e71fd69ea0c1
25449408-f9b9-425d-ac1a-b34296ae75db	06f3df14-23c6-4b95-b216-e71fd69ea0c1
9375b0d3-d30b-4559-a53f-eccf62938da8	06f3df14-23c6-4b95-b216-e71fd69ea0c1
f7291743-b0eb-497f-b6a8-c0064197ed57	06f3df14-23c6-4b95-b216-e71fd69ea0c1
2c212b3d-003d-47cd-8000-2253525c11db	06f3df14-23c6-4b95-b216-e71fd69ea0c1
841dd101-63ae-49fb-a69f-1910656c331f	06f3df14-23c6-4b95-b216-e71fd69ea0c1
ee059424-b879-4ca7-8c4e-f33d71d9fdc3	06f3df14-23c6-4b95-b216-e71fd69ea0c1
7cd6689a-ca85-4c05-ad79-5d33173f0a02	06f3df14-23c6-4b95-b216-e71fd69ea0c1
74dcf624-6ff9-4ff2-babb-91f6c6fe626b	06f3df14-23c6-4b95-b216-e71fd69ea0c1
fb746287-5bc7-4a2f-86c3-a60bb85040ac	06f3df14-23c6-4b95-b216-e71fd69ea0c1
e6d6e616-bc16-4c74-b86a-9ef1156c0c0e	06f3df14-23c6-4b95-b216-e71fd69ea0c1
921c9903-bd7b-4bcf-a9bf-cdf612df72f8	06f3df14-23c6-4b95-b216-e71fd69ea0c1
538419ab-6282-4178-8ca3-3ed943c4de09	04eb8d0b-398d-4bbd-ad20-f5796b496e73
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.web_origins (client_id, value) FROM stdin;
121db436-e63f-49ba-a93a-7a6951e5315e	+
c6697c1f-2ead-4af7-b8cd-195dd0332614	+
51abee6f-2294-4cea-a78a-fbfd60c8fc07	*
\.


--
-- PostgreSQL database dump complete
--

