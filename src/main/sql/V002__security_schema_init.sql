SET ROLE postgres;

CREATE SCHEMA app_security;

GRANT USAGE ON SCHEMA app_security TO reader;
ALTER DEFAULT PRIVILEGES IN SCHEMA app_security GRANT SELECT ON TABLES TO reader;
ALTER DEFAULT PRIVILEGES IN SCHEMA app_security GRANT ALL ON TABLES TO booking_app;

CREATE TABLE app_security.role
(
    role_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name    TEXT NOT NULL UNIQUE
);

CREATE TABLE app_security.user_credentials
(
    user_credentials_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    customer_id         INT         NOT NULL REFERENCES shared.customer (customer_id),
    role_id             INT         NOT NULL REFERENCES app_security.role (role_id),
    email               TEXT        NOT NULL UNIQUE,
    password            VARCHAR(72) NOT NULL,
    phone_number        TEXT
);
