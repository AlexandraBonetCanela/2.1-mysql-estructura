CREATE DATABASE IF NOT EXISTS spotify;

USE spotify;

CREATE TABLE user(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(256) NOT NULL,
    email VARCHAR(256) NOT NULL,
    password VARCHAR(256) NOT NULL,
    date_birth DATE,
    gender ENUM('MALE', 'FEMALE', 'PREFER_NOT_SAY', 'NON_BINARY'),
    country_id INT UNSIGNED,
    post_code CHAR(5),
    CONSTRAINT fk_user_country_id FOREIGN KEY (country_id) REFERENCES country(id)
);

CREATE TABLE country (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(256) NOT NULL
);

CREATE TABLE subscription (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED,
    started_date DATE NOT NULL,
    renovation_date DATE NOT NULL,
    payment_type ENUM('PAYPAL', 'CREDIT_CARD'),
    CONSTRAINT fk_subscription_user_id FOREIGN KEY (user_id) REFERENCES user(id)
);


