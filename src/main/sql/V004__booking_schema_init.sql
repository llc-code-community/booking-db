SET ROLE postgres;

CREATE SCHEMA app_booking;

GRANT USAGE ON SCHEMA app_booking TO reader;
ALTER DEFAULT PRIVILEGES IN SCHEMA app_booking GRANT SELECT ON TABLES TO reader;
ALTER DEFAULT PRIVILEGES IN SCHEMA app_booking GRANT ALL ON TABLES TO booking_app;

CREATE TABLE app_booking.reservation
(
    reservation_id      BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_credentials_id INT     NOT NULL REFERENCES app_security.user_credentials,
    rentable_object_id   BIGINT  NOT NULL REFERENCES app_hotel.rentable_object,
    check_in_date        DATE    NOT NULL,
    check_out_date       DATE    NOT NULL,
    is_confirmed         BOOLEAN NOT NULL DEFAULT FALSE,
    CHECK (check_in_date <= check_out_date)
);
