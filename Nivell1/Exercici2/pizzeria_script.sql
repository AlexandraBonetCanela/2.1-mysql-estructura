CREATE DATABASE IF NOT EXISTS pizzeria;

USE pizzeria;

CREATE TABLE IF NOT EXISTS province (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(256) NOT NULL,
    UNIQUE INDEX uidx_province_name (name)
);

CREATE TABLE IF NOT EXISTS town (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR (256) NOT NULL,
    province_id INT UNSIGNED NOT NULL,
    CONSTRAINT fk_town_province_id FOREIGN KEY (province_id) REFERENCES province(id),
    UNIQUE INDEX uidx_town_province_town (name, province_id)
);
# client province_id could not necesserily be here
CREATE TABLE IF NOT EXISTS client (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR (256) NOT NULL,
    surnames VARCHAR(256) NOT NULL,
    address VARCHAR(256) NOT NULL,
    post_code CHAR(5) NOT NULL,
    town_id INT UNSIGNED NOT NULL,
    province_id INT UNSIGNED NOT NULL,
    telephone INT UNSIGNED NOT NULL,
    CONSTRAINT fk_client_province_id FOREIGN KEY (province_id) REFERENCES province(id),
    CONSTRAINT fk_client_town_id FOREIGN KEY (town_id) REFERENCES town(id)
);

CREATE TABLE IF NOT EXISTS shop (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(250) NOT NULL,
    post_code CHAR(5) NOT NULL,
    town_id INT UNSIGNED NOT NULL,
    province_id INT UNSIGNED NOT NULL,
    CONSTRAINT fk_town_id FOREIGN KEY (town_id) REFERENCES town(id),
    CONSTRAINT fk_province_id FOREIGN KEY (province_id) REFERENCES province(id)
);

CREATE TABLE IF NOT EXISTS product (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR (256) NOT NULL,
    description VARCHAR (256),
    category ENUM ('PIZZA', 'BURGER', 'DRINK') NOT NULL,
    image_url VARCHAR(256),
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS purchase_order (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    date DATETIME NOT NULL,
    type ENUM ('TO_COLLECT', 'TAKE_AWAY') NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    pizza_items INT UNSIGNED NOT NULL,
    burger_items INT UNSIGNED NOT NULL,
    drink_items INT UNSIGNED NOT NULL,
    shop_id INT UNSIGNED NOT NULL,
    client_id INT UNSIGNED NOT NULL,
    CONSTRAINT fk_po_shop_id FOREIGN KEY (shop_id) REFERENCES shop(id),
    CONSTRAINT fk_po_client_id FOREIGN KEY (client_id) REFERENCES client(id)
);

CREATE TABLE IF NOT EXISTS employee (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR (256) NOT NULL,
    surnames VARCHAR (256) NOT NULL,
    NIF CHAR (9),
    type ENUM ('CHEF', 'DRIVER') NOT NULL,
    shop_id INT UNSIGNED NOT NULL,
    UNIQUE INDEX uidx_NIF (NIF),
    CONSTRAINT fk_employee_shop_id FOREIGN KEY (shop_id) REFERENCES shop(id)
);

CREATE TABLE IF NOT EXISTS delivery (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    purchase_order_id INT UNSIGNED NOT NULL,
    delivery_person_id INT UNSIGNED NOT NULL,
    delivery_time DATETIME NOT NULL,
    CONSTRAINT fk_delivery_po_id FOREIGN KEY (purchase_order_id) REFERENCES purchase_order(id),
    CONSTRAINT fk_delivery_delivery_person_id FOREIGN KEY (delivery_person_id) REFERENCES employee(id)
);

CREATE TABLE IF NOT EXISTS purchase_order_detail (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    purchase_order_id INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    CONSTRAINT fk_pod_product_id FOREIGN KEY  (product_id) REFERENCES product(id),
    CONSTRAINT fk_pod_purchase_order_id FOREIGN KEY (purchase_order_id) REFERENCES purchase_order(id)
);

CREATE TABLE pizza (
    product_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    pizza_category_id INT UNSIGNED NOT NULL
);

CREATE TABLE pizza_category (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR (256) NOT NULL
);
INSERT INTO province (name)
VALUES ('Barcelona'),
       ('Girona'),
       ('Lleida'),
       ('Tarragona');

INSERT INTO town (name, province_id)
VALUES ('Lleida', 3),
       ('Balaguer', 3),
       ('Tàrrega', 3),
       ('La Seu d\'Urgell', 3),
       ('Cervera', 3),
       ('Solsona', 3),
       ('Mollerusa', 3),
       ('Vielha e Mijaran', 3),
       ('Ponts', 3),
       ('Alcarràs', 3),
       ('Barcelona', 1),
       ('Badalona', 1),
       ('Terrassa', 1),
       ('Sabadell', 1),
       ('Manresa', 1),
       ('Igualada', 1),
       ('Sant Cugat del Vallès', 1),
       ('Castelldefels', 1),
       ('Sitges', 1),
       ('Esplugues de Llobregat', 1),
       ('Tarragona', 4),
       ('Reus', 4),
       ('Salou', 4),
       ('Cambrils', 4),
       ('Amposta', 4),
        ('Montblanc', 4),
        ('Girona', 2),
        ('Figueres', 2),
        ('Blanes', 2),
        ('Lloret de Mar', 2),
        ('Olot', 2);

SELECT * FROM town;

INSERT INTO client (name, surnames, address, post_code, town_id, province_id, telephone)
VALUES ('José Antonio', 'Velazquez Mayordomo', 'Avinguda de València 3, 4rt 5a', 25001, 1, 3, 674332211),
        ('Maria Cristina', 'Garcia Garcia', 'Carrer Aribau 456, 4rt 5a', 08011, 11, 1, 654321234),
        ('Juanito', 'Peque', );

INSERT INTO shop (address, post_code, town_id, province_id)
VALUES ()
