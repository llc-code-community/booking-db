SET ROLE postgres;

CREATE SCHEMA app_hotel;

GRANT USAGE ON SCHEMA app_hotel TO reader;
ALTER DEFAULT PRIVILEGES IN SCHEMA app_hotel GRANT SELECT ON TABLES TO reader;
ALTER DEFAULT PRIVILEGES IN SCHEMA app_hotel GRANT ALL ON TABLES TO booking_app;

CREATE TABLE app_hotel.hotel
(
    hotel_id   INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name       TEXT NOT NULL UNIQUE,
    description TEXT,
    address    TEXT NOT NULL,
    star_rating INT NOT NULL,
    latitude    DOUBLE PRECISION NOT NULL,
    longitude    DOUBLE PRECISION NOT NULL
);

CREATE TABLE app_hotel.rental_object_type
(
    rental_object_type_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    type_name             TEXT NOT NULL UNIQUE
);

-- TODO: available stay dates logic
CREATE TABLE app_hotel.rentable_object
(
    rentable_object_id    BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    rental_object_type_id INT     NOT NULL REFERENCES app_hotel.rental_object_type,
    hotel_id              INT REFERENCES app_hotel.hotel,
    initial_price         NUMERIC NOT NULL CHECK (initial_price > 0),
    people_amount         INT     NOT NULL CHECK (people_amount > 0),
    start_date            DATE NOT NULL,
    end_date              DATE NOT NULL,
    CHECK (start_date <= end_date)
);

-- sleeping room, bathroom, living room
CREATE TABLE app_hotel.room_type
(
    room_type_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    type_name    TEXT NOT NULL UNIQUE
);

CREATE TABLE app_hotel.room
(
    room_id            BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    rentable_object_id BIGINT NOT NULL REFERENCES app_hotel.rentable_object,
    room_type_id       INT    NOT NULL REFERENCES app_hotel.room_type,
    floor              INT    NOT NULL,
    description        TEXT
);


-- breakfast, wifi, parking, TV, etc.
CREATE TABLE app_hotel.rental_object_attribute
(
    rental_object_attribute_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    attribute_name             TEXT NOT NULL UNIQUE
);

CREATE TABLE app_hotel.rental_object_attribute_assignment
(
    rental_object_attribute_assignment_id BIGINT  NOT NULL GENERATED ALWAYS AS IDENTITY,
    rental_object_attribute_id            INT     NOT NULL REFERENCES app_hotel.rental_object_attribute,
    rentable_object_id                    INT     NOT NULL REFERENCES app_hotel.rentable_object,
    price                                 NUMERIC NOT NULL DEFAULT 0
);

-- amount of beds, window view, etc.
CREATE TABLE app_hotel.room_attribute
(
    room_attribute_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    attribute_name    TEXT NOT NULL UNIQUE
);

CREATE TABLE app_hotel.room_attribute_assignment
(
    room_attribute_assignment_id BIGINT  NOT NULL GENERATED ALWAYS AS IDENTITY,
    room_attribute_id            INT     NOT NULL REFERENCES app_hotel.room_attribute,
    room_id                      BIGINT  NULL REFERENCES app_hotel.room,
    price                        NUMERIC NOT NULL DEFAULT 0
);