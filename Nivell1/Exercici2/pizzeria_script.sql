CREATE DATABASE IF NOT EXISTS pizzeria;

CREATE TABLE client (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR (256) NOT NULL,
    surnames VARCHAR(256),
    address VARCHAR(256),
    post_code CHAR(5),
    town_id INT UNSIGNED,
    province_id INT UNSIGNED,
    telephone INT UNSIGNED,
    CONSTRAINT fk_client_province_id FOREIGN KEY (province_id) REFERENCES province(id),
    CONSTRAINT fk_client_town_id FOREIGN KEY (town_id) REFERENCES town(id)
);

CREATE TABLE town (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR (256) NOT NULL,
    province_id INT NOT NULL,
    CONSTRAINT fk_town_province_id FOREIGN KEY (province_id) REFERENCES province(id),
    UNIQUE INDEX uidx_town_province_town (name, province_id)
);

CREATE TABLE province (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(256) NOT NULL,
    UNIQUE INDEX uidx_province_name (name)
);


CREATE TABLE purchase_order (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    date DATETIME NOT NULL,
    type ENUM ('TO_COLLECT', 'TAKE_AWAY') NOT NULL,
    price DECIMAL NOT NULL,
    pizza_items INT NOT NULL,
    burger_items INT NOT NULL,
    drink_items INT NOT NULL,
    shop_id INT NOT NULL,
    client_id INT NOT NULL,
    CONSTRAINT fk_po_shop_id FOREIGN KEY (shop_id) REFERENCES shop(id),
    CONSTRAINT fk_po_client_id FOREIGN KEY (client_id) REFERENCES client(id)
);

CREATE TABLE purchase_order_detail (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    purchase_order_id INT NOT NULL,
    product_id INT NOT NULL,
    CONSTRAINT fk_pod_product_id FOREIGN KEY  (product_id) REFERENCES product(id),
    CONSTRAINT fk_pod_purchase_order_id FOREIGN KEY (purchase_order_id) REFERENCES purchase_order(id)
);


CREATE TABLE product (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR (256) NOT NULL,
    description VARCHAR (256),
    category ENUM ('TO_COLLECT', 'TAKE_AWAY') NOT NULL,
    image_url VARCHAR(256),
    price DECIMAL UNSIGNED
);

CREATE TABLE pizza_ (
    product_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    pizza_category_id INT NOT NULL
);

CREATE TABLE pizza_category (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR (256) NOT NULL
);

CREATE TABLE shop (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(250) NOT NULL,
    post_code CHAR(5) NOT NULL,
    town_id INT NOT NULL,
    province_id INT NOT NULL,
    CONSTRAINT fk_town_id FOREIGN KEY (town_id) REFERENCES town(id),
    CONSTRAINT fk_province_id FOREIGN KEY (province_id) REFERENCES province(id)
);

CREATE TABLE employee (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR (256) NOT NULL,
    surnames VARCHAR (256) NOT NULL,
    NIF CHAR (9),
    type ENUM ('CHEF', 'DRIVER') NOT NULL,
    UNIQUE INDEX uidx_NIF (NIF)
);
