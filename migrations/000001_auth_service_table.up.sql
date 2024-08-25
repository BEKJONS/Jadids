-- Сначала создаем таблицу driver_licenses
CREATE TABLE driver_licenses
(
    id              UUID default gen_random_uuid(),
    first_name      VARCHAR(100),
    last_name       VARCHAR(100),
    father_name     VARCHAR(100),
    birth_date      DATE,
    address         TEXT,
    issue_date      DATE,
    expiration_date DATE,
    category        VARCHAR(50),
    issued_by       VARCHAR(100),
    license_number  VARCHAR PRIMARY KEY -- Тип VARCHAR, как вы хотите
);

-- Затем создаем таблицу cars
CREATE TABLE cars
(
    id                   UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    type                 VARCHAR(100),
    model                VARCHAR(100),
    color                VARCHAR(50),
    year                 INT,
    body_number          VARCHAR(100) UNIQUE,
    engine_number        VARCHAR(100) UNIQUE,
    horsepower           INT,
    license_plate        VARCHAR(100) UNIQUE,
    tech_passport_number UUID UNIQUE
);

-- Создаем остальные таблицы
CREATE TABLE users
(
    id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    driver_license VARCHAR REFERENCES driver_licenses (license_number), -- Изменен тип на VARCHAR
    email             VARCHAR UNIQUE,
    password          VARCHAR,
    role              VARCHAR,
    created_at        TIMESTAMP,
    updated_at        TIMESTAMP,
    deleted_at        BIGINT
);

CREATE TABLE Services
(
    id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    type               VARCHAR(100),
    name               VARCHAR(100),
    certificate_number VARCHAR(100) UNIQUE,
    manager_name       VARCHAR(150),
    address            TEXT,
    phone_number       VARCHAR(13)
);

CREATE TABLE Fines
(
    id                   UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tech_passport_number UUID REFERENCES cars (tech_passport_number),
    license_plate        VARCHAR(100) REFERENCES cars (license_plate),
    officer_id           UUID REFERENCES users (id),
    fine_owner           UUID REFERENCES users (id),
    fine_date            TIMESTAMP,
    payment_date         TIMESTAMP,
    user_id              UUID REFERENCES users (id)
);

CREATE TABLE Services_Provided
(
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    license_plate   VARCHAR(100) REFERENCES cars (license_plate),
    service_type    VARCHAR(100),
    service_date    DATE,
    expiration_date DATE,
    user_id         UUID REFERENCES users (id)
);
