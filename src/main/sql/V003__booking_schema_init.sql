SET ROLE postgres;

CREATE SCHEMA app_booking;

GRANT USAGE ON SCHEMA app_booking TO reader;
ALTER DEFAULT PRIVILEGES IN SCHEMA app_booking GRANT SELECT ON TABLES TO reader;
ALTER DEFAULT PRIVILEGES IN SCHEMA app_booking GRANT ALL ON TABLES TO booking_app;

CREATE TABLE app_booking.rental_type
(
    property_type_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name             TEXT UNIQUE
);

CREATE TABLE app_booking.rentable_object
(
    rentable_object_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    property_type_id   INT              NOT NULL REFERENCES app_booking.rental_type (property_type_id),
    place_name         TEXT             NOT NULL,
    description        TEXT,
    latitude           DOUBLE PRECISION NOT NULL,
    longitude          DOUBLE PRECISION NOT NULL,
    initial_price      NUMERIC          NOT NULL
);
