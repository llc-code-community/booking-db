SET ROLE postgres;

CREATE SCHEMA shared;

GRANT USAGE ON SCHEMA shared TO reader;
ALTER DEFAULT PRIVILEGES IN SCHEMA shared GRANT SELECT ON TABLES TO reader;

CREATE TABLE shared.customer
(
    customer_id   INT PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    customer_name TEXT NOT NULL
);
