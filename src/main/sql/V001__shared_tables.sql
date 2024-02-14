SET ROLE postgres;

CREATE SCHEMA shared;

GRANT USAGE ON SCHEMA shared TO reader;
ALTER DEFAULT PRIVILEGES IN SCHEMA shared GRANT SELECT ON TABLES TO reader;

CREATE TABLE shared.customer
(
    customer_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    first_name  TEXT,
    last_name   TEXT,
    username    TEXT NOT NULL UNIQUE
);
