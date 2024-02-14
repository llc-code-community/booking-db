CREATE ROLE reader;
CREATE ROLE booking_app;

GRANT reader TO booking_app;

CREATE DATABASE stage_booking;

\c stage_booking
