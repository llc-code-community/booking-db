SET ROLE postgres;

CREATE SCHEMA app_security;
CREATE ROLE booking_app;

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
    customer_id         INT         NOT NULL REFERENCES shared.customer,
    role_id             INT         NOT NULL REFERENCES app_security.role,
    email               TEXT        NOT NULL UNIQUE,
    password            VARCHAR(72) NOT NULL
);

CREATE TABLE app_security.token
(
    token_id            BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_credentials_id INT     NOT NULL REFERENCES app_security.user_credentials,
    jwt                 TEXT    NOT NULL UNIQUE,
    is_revoked          BOOLEAN NOT NULL,
    is_expired          BOOLEAN NOT NULL
);
