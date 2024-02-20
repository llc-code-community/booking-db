SET ROLE postgres;

CREATE SCHEMA app_payment;

GRANT USAGE ON SCHEMA app_payment TO reader;
ALTER DEFAULT PRIVILEGES IN SCHEMA app_payment GRANT SELECT ON TABLES TO reader;
ALTER DEFAULT PRIVILEGES IN SCHEMA app_payment GRANT ALL ON TABLES TO booking_app;

CREATE TABLE app_payment.payment_method
(
    payment_method_id   INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    payment_method_name TEXT NOT NULL UNIQUE
);

CREATE TABLE app_payment.payment_status
(
    payment_status_id   INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    payment_status_name TEXT NOT NULL UNIQUE
);

CREATE TABLE app_payment.payment_transaction
(
    transaction_id      BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    reservation_id      BIGINT  NOT NULL REFERENCES app_booking.reservation,
    payment_method_id   INT NOT NULL REFERENCES app_payment.payment_method,
    payment_status_id   INT NOT NULL REFERENCES app_payment.payment_status,
    amount              NUMERIC NOT NULL CHECK (amount > 0),
    payment_date        DATE NOT NULL CHECK (payment_date <= CURRENT_DATE)
);