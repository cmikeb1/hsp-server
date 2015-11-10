USE oic;

SET AUTOCOMMIT = 0;

START TRANSACTION;

-- SMART on FHIR Application Launcher
INSERT INTO client_details (client_id, client_name, access_token_validity_seconds) VALUES
	('fhir_starter', 'FHIR Starter', 86400);

INSERT INTO client_redirect_uri (owner_id, redirect_uri) VALUES
	((SELECT id from client_details where client_id = 'fhir_starter'), 'http://localhost:8080/hsp-reference-apps');

INSERT INTO client_scope (owner_id, scope) VALUES
	((SELECT id from client_details where client_id = 'fhir_starter'), 'user/*.*'),
	((SELECT id from client_details where client_id = 'fhir_starter'), 'smart/orchestrate_launch');

INSERT INTO client_grant_type (owner_id, grant_type) VALUES
	((SELECT id from client_details where client_id = 'fhir_starter'), 'authorization_code');

INSERT INTO whitelisted_site (creator_user_id, client_id) VALUES
    ('admin', 'fhir_starter');

INSERT INTO whitelisted_site_scope (owner_id, scope) VALUES
    ((SELECT id from client_details where client_id = 'fhir_starter'), 'user/*.*');

INSERT INTO whitelisted_site_scope (owner_id, scope) VALUES
    ((SELECT id from client_details where client_id = 'fhir_starter'), 'smart/orchestrate_launch');

-- HSP Resource Server
INSERT INTO client_details (client_id, client_secret, client_name, dynamically_registered, refresh_token_validity_seconds, access_token_validity_seconds, id_token_validity_seconds, allow_introspection) VALUES
	('hsp_resource_server', 'secret', 'HSP Resource Server', false, null, 3600, 600, true);

INSERT INTO client_scope (owner_id, scope) VALUES
	((SELECT id from client_details where client_id = 'hsp_resource_server'), 'launch'),
	((SELECT id from client_details where client_id = 'hsp_resource_server'), 'patient/*.read'),
	((SELECT id from client_details where client_id = 'hsp_resource_server'), 'user/*.*'),
	((SELECT id from client_details where client_id = 'hsp_resource_server'), 'smart/orchestrate_launch');



-- HSP Reference Apps

-- Pediatric Growth Chart
INSERT INTO client_details (client_id, client_name, logo_uri, access_token_validity_seconds, token_endpoint_auth_method) VALUES
	('growth_chart', 'Pediatric Growth Chart', 'http://smartplatforms.org/wp-content/uploads/pgc-male-healthyweight-os.png', 86400, 'NONE');

INSERT INTO client_scope (owner_id, scope) VALUES
	((SELECT id from client_details where client_id = 'growth_chart'), 'launch'),
	((SELECT id from client_details where client_id = 'growth_chart'), 'patient/*.read');

INSERT INTO client_grant_type (owner_id, grant_type) VALUES
	((SELECT id from client_details where client_id = 'growth_chart'), 'authorization_code');



-- Bilirubin App
INSERT INTO client_details (client_id, client_name, logo_uri, access_token_validity_seconds, token_endpoint_auth_method) VALUES
	('bilirubin_chart', 'Bilirubin App', 'http://localhost:8080/bilirubin-app/static/bilirubin-chart/images/bilirubin.png', 86400, 'NONE');

INSERT INTO client_scope (owner_id, scope) VALUES
	((SELECT id from client_details where client_id = 'bilirubin_chart'), 'launch'),
	((SELECT id from client_details where client_id = 'bilirubin_chart'), 'patient/*.read');

INSERT INTO client_grant_type (owner_id, grant_type) VALUES
	((SELECT id from client_details where client_id = 'bilirubin_chart'), 'authorization_code');


-- Cardiac Risk App
INSERT INTO client_details (client_id, client_name, logo_uri, access_token_validity_seconds, token_endpoint_auth_method) VALUES
	('cardiac_risk', 'Cardiac Risk', 'https://fhir.smartplatforms.org/images/apps/cardio.png', 86400, 'NONE');

INSERT INTO client_scope (owner_id, scope) VALUES
	((SELECT id from client_details where client_id = 'cardiac_risk'), 'launch'),
	((SELECT id from client_details where client_id = 'cardiac_risk'), 'patient/*.read');

INSERT INTO client_grant_type (owner_id, grant_type) VALUES
	((SELECT id from client_details where client_id = 'cardiac_risk'), 'authorization_code');

-- BP Centiles App
INSERT INTO client_details (client_id, client_name, logo_uri, access_token_validity_seconds, token_endpoint_auth_method) VALUES
	('bp_centiles', 'BP Centiles', 'https://fhir.smartplatforms.org/images/apps/bpc.png', 86400, 'NONE');

INSERT INTO client_scope (owner_id, scope) VALUES
	((SELECT id from client_details where client_id = 'bp_centiles'), 'launch'),
	((SELECT id from client_details where client_id = 'bp_centiles'), 'patient/*.read');

INSERT INTO client_grant_type (owner_id, grant_type) VALUES
	((SELECT id from client_details where client_id = 'bp_centiles'), 'authorization_code');

-- Diabetes Monograph App
INSERT INTO client_details (client_id, client_name, logo_uri, access_token_validity_seconds, token_endpoint_auth_method) VALUES
	('diabetes_monograph', 'Diabetes Monograph', 'https://fhir.smartplatforms.org/images/apps/monograph.png', 86400, 'NONE');

INSERT INTO client_scope (owner_id, scope) VALUES
	((SELECT id from client_details where client_id = 'diabetes_monograph'), 'launch'),
	((SELECT id from client_details where client_id = 'diabetes_monograph'), 'patient/*.read');

INSERT INTO client_grant_type (owner_id, grant_type) VALUES
	((SELECT id from client_details where client_id = 'diabetes_monograph'), 'authorization_code');

-- Disease Monograph App
INSERT INTO client_details (client_id, client_name, logo_uri, access_token_validity_seconds, token_endpoint_auth_method) VALUES
	('disease_monograph', 'Disease Monograph', 'https://fhir.smartplatforms.org/images/apps/dm.png', 86400, 'NONE');

INSERT INTO client_scope (owner_id, scope) VALUES
	((SELECT id from client_details where client_id = 'disease_monograph'), 'launch'),
	((SELECT id from client_details where client_id = 'disease_monograph'), 'patient/*.read');

INSERT INTO client_grant_type (owner_id, grant_type) VALUES
	((SELECT id from client_details where client_id = 'disease_monograph'), 'authorization_code');


-- FHIR Demo App
INSERT INTO client_details (client_id, client_name, logo_uri, access_token_validity_seconds, token_endpoint_auth_method) VALUES
	('fhir_demo', 'FHIR Demo App', 'https://fhir.smartplatforms.org/images/apps/demo.png', 86400, 'NONE');

INSERT INTO client_scope (owner_id, scope) VALUES
	((SELECT id from client_details where client_id = 'fhir_demo'), 'launch'),
	((SELECT id from client_details where client_id = 'fhir_demo'), 'patient/*.read');

INSERT INTO client_grant_type (owner_id, grant_type) VALUES
	((SELECT id from client_details where client_id = 'fhir_demo'), 'authorization_code');

-- My Web App
INSERT INTO client_details (client_id, client_name, logo_uri, access_token_validity_seconds, token_endpoint_auth_method) VALUES
	('my_web_app', 'My Web App', 'https://fhir.smartplatforms.org/images/apps/my.png', 86400, 'NONE');

INSERT INTO client_scope (owner_id, scope) VALUES
	((SELECT id from client_details where client_id = 'my_web_app'), 'launch'),
	((SELECT id from client_details where client_id = 'my_web_app'), 'patient/*.read');

INSERT INTO client_grant_type (owner_id, grant_type) VALUES
	((SELECT id from client_details where client_id = 'my_web_app'), 'authorization_code');

-- Test Client
INSERT INTO client_details (client_id, client_name, client_secret, access_token_validity_seconds, token_endpoint_auth_method) VALUES
	('test_client', 'Test', 'secret', 86400, 'NONE');

INSERT INTO client_redirect_uri (owner_id, redirect_uri) VALUES
	((SELECT id from client_details where client_id = 'test_client'), 'http://localhost:8080/hsp-java-client-example-spring-mvc/launch/redirect');

INSERT INTO client_scope (owner_id, scope) VALUES
	((SELECT id from client_details where client_id = 'test_client'), 'launch'),
	((SELECT id from client_details where client_id = 'test_client'), 'system/*.read'),
	((SELECT id from client_details where client_id = 'test_client'), 'patient/*.read'),
	((SELECT id from client_details where client_id = 'test_client'), 'offline_access');

INSERT INTO client_grant_type (owner_id, grant_type) VALUES
	((SELECT id from client_details where client_id = 'test_client'), 'authorization_code'),
	((SELECT id from client_details where client_id = 'test_client'), 'client_credentials'),
	((SELECT id from client_details where client_id = 'test_client'), 'refresh_token');

-- Test Client using JWT
INSERT INTO client_details (client_id, client_name, jwks_uri, token_endpoint_auth_method, access_token_validity_seconds) VALUES
	('test_client_jwt', 'Test JWT', 'https:////hspc.isalusconsulting.com/dstu2/hsp-reference-authorization/jwk', 'PRIVATE_KEY', 86400);

-- INSERT INTO client_redirect_uri (owner_id, redirect_uri) VALUES
--	((SELECT id from client_details where client_id = 'test_client_jwt'), 'http://localhost:8080/hsp-java-client-example-spring-mvc/launch/redirect'),
--	((SELECT id from client_details where client_id = 'test_client_jwt'), 'http://localhost:8080/hsp-java-client-example-spring-mvc/example');

INSERT INTO client_scope (owner_id, scope) VALUES
--	((SELECT id from client_details where client_id = 'test_client_jwt'), 'launch'),
	((SELECT id from client_details where client_id = 'test_client_jwt'), 'system/*.read'),
--	((SELECT id from client_details where client_id = 'test_client_jwt'), 'patient/*.read'),
	((SELECT id from client_details where client_id = 'test_client_jwt'), 'offline_access');

INSERT INTO client_grant_type (owner_id, grant_type) VALUES
--	((SELECT id from client_details where client_id = 'test_client_jwt'), 'authorization_code'),
	((SELECT id from client_details where client_id = 'test_client_jwt'), 'client_credentials'),
	((SELECT id from client_details where client_id = 'test_client_jwt'), 'refresh_token');

-- Standalone Clinician Test Client
INSERT INTO client_details (client_id, client_name, client_secret, access_token_validity_seconds, token_endpoint_auth_method) VALUES
	('standalone_clinical_test_client', 'Standalone Clinician Test', 'secret', 86400, 'NONE');

INSERT INTO client_redirect_uri (owner_id, redirect_uri) VALUES
	((SELECT id from client_details where client_id = 'standalone_clinical_test_client'), 'http://localhost:8080/hsp-java-client-example-standalone-clinician-confidential-webapp/launch/redirect'),
	((SELECT id from client_details where client_id = 'standalone_clinical_test_client'), 'http://localhost:8080/hsp-java-client-example-standalone-clinician-confidential-webapp/patientHeightChart');

INSERT INTO client_scope (owner_id, scope) VALUES
	((SELECT id from client_details where client_id = 'standalone_clinical_test_client'), 'launch'),
	((SELECT id from client_details where client_id = 'standalone_clinical_test_client'), 'launch/patient'),
	((SELECT id from client_details where client_id = 'standalone_clinical_test_client'), 'patient/*.read'),
	((SELECT id from client_details where client_id = 'standalone_clinical_test_client'), 'offline_access');

INSERT INTO client_grant_type (owner_id, grant_type) VALUES
	((SELECT id from client_details where client_id = 'standalone_clinical_test_client'), 'authorization_code'),
	((SELECT id from client_details where client_id = 'standalone_clinical_test_client'), 'client_credentials'),
	((SELECT id from client_details where client_id = 'standalone_clinical_test_client'), 'refresh_token');

-- Standalone Patient Test Client
INSERT INTO client_details (client_id, client_name, client_secret, access_token_validity_seconds, token_endpoint_auth_method) VALUES
	('standalone_patient_test_client', 'Standalone Patient Test', 'secret', 86400, 'SECRET_BASIC');

INSERT INTO client_redirect_uri (owner_id, redirect_uri) VALUES
	((SELECT id from client_details where client_id = 'standalone_patient_test_client'), 'http://localhost:8080/hsp-java-client-example-standalone-patient-confidential-webapp/launch/redirect'),
	((SELECT id from client_details where client_id = 'standalone_patient_test_client'), 'http://localhost:8080/hsp-java-client-example-standalone-patient-confidential-webapp/myHeightChart');

INSERT INTO client_scope (owner_id, scope) VALUES
	((SELECT id from client_details where client_id = 'standalone_patient_test_client'), 'launch'),
	((SELECT id from client_details where client_id = 'standalone_patient_test_client'), 'launch/patient'),
	((SELECT id from client_details where client_id = 'standalone_patient_test_client'), 'user/*.read'),
	((SELECT id from client_details where client_id = 'standalone_patient_test_client'), 'offline_access');

INSERT INTO client_grant_type (owner_id, grant_type) VALUES
	((SELECT id from client_details where client_id = 'standalone_patient_test_client'), 'authorization_code'),
	((SELECT id from client_details where client_id = 'standalone_patient_test_client'), 'client_credentials'),
	((SELECT id from client_details where client_id = 'standalone_patient_test_client'), 'refresh_token');

COMMIT;

SET AUTOCOMMIT = 1;


