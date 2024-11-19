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

CREATE TABLE IF NOT EXISTS client (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR (256) NOT NULL,
    surnames VARCHAR(256) NOT NULL,
    address VARCHAR(256) NOT NULL,
    post_code CHAR(5) NOT NULL,
    town_id INT UNSIGNED NOT NULL,
    telephone INT UNSIGNED NOT NULL,
    CONSTRAINT fk_client_town_id FOREIGN KEY (town_id) REFERENCES town(id)
);

CREATE TABLE IF NOT EXISTS shop (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(250) NOT NULL,
    post_code CHAR(5) NOT NULL,
    town_id INT UNSIGNED NOT NULL,
    CONSTRAINT fk_town_id FOREIGN KEY (town_id) REFERENCES town(id)
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
select * from client;
INSERT INTO client (name, surnames, address, post_code, town_id, telephone)
VALUES ('José Antonio', 'Velazquez Mayordomo', 'Avinguda de València 3, 4rt 5a', 25001, 1, 674332211),
        ('Maria Cristina', 'Garcia Garcia', 'Carrer Aribau 456, 4rt 5a', 08011, 11, 654321234),
        ('Juanito', 'Peque', 'Carrer Palafurjell 45, 4r 6r', 21004, 27, 655435676);

INSERT INTO shop (address, post_code, town_id)
VALUES ('Avinguda Ricard Vinyes 45', 25003, 1),
       ('Avinguda Paralel 35', 08009, 11),
       ('Avinguda Pikachu 34', 29078, 21),
       ('Avinguda Ernest Bannach 23', 34588, 27);

INSERT INTO product (name, description, category, image_url, price)
VALUES ('Maxi Burger', 'Maxi Burger amb formatge i ceba', 'BURGER', 'http://fksgisgsf.jpeg', 8.00),
       ('Mini Burger', 'Mini Burger amb formatge i ceba', 'BURGER', 'http://fsjdfsdf.jpeg', 3.00),
       ('Chicken Burger', 'Burger de pollastre amb formatge i ceba', 'BURGER', 'http://esfsedfs.jpeg', 6.00),
       ('Double Maxi Burger', 'Maxi Burger amb doble porcio de vedella, formatge i ceba', 'BURGER', 'http://sefsfsf.jpeg', 11.00),
       ('Fanta Orange', 'Fanta taronja', 'DRINK', 'http://fdsgfsdfs/jpeg', 2.30),
       ('Coca Cola', 'Coca cola, la de veritat', 'DRINK', 'http://efsdfsd.jpeg', 2.30),
       ('Coca Cola Zero', 'Coca cola zero', 'DRINK', 'http://sfsfsd.jpeg', 2.30),
       ('Sweeps', 'Swweeps', 'DRINK', 'http://sfsdfsf.jpeg', 2.30),
       ('Pizza 4 formatges', 'Pizza 4 formatges amb Brie, formatge blau, feta i emmental', 'PIZZA', 'http://sfsfsd.jpeg', 13.34),
       ('Pizza Margarita', 'Pizza Margarita, base de tomata i emmental', 'PIZZA', 'http://sfsfsd.jpeg', 10.89),
       ('Pizza 4 estacions', 'Pizza amb Peperoni, romesco, chili i allioli', 'PIZZA', 'http://sfsfsd.jpeg', 13.45);


INSERT INTO pizza_category (name)
VALUES ('Classic'),
       ('Specialty'),
       ('Vegetarian'),
       ('Spicy');


INSERT INTO pizza (product_id, pizza_category_id)
VALUES (9, 1),
       (10, 1),
       (11, 2);


INSERT INTO purchase_order (date, type, total_price, pizza_items, burger_items, drink_items, shop_id, client_id)
VALUES ('2024-10-29 18:45:00', 'TO_COLLECT', 25.50, 2, 1, 1, 1, 1),
       ('2024-10-29 19:00:00', 'TAKE_AWAY', 40.00, 3, 2, 2, 2, 2),
       ('2024-10-29 19:30:00', 'TO_COLLECT', 13.45, 1, 0, 1, 3, 3);


INSERT INTO employee (name, surnames, NIF, type, shop_id)
VALUES ('Carlos', 'Gomez Ramirez', '12345678A', 'CHEF', 1),
       ('Ana', 'Lopez Sanchez', '87654321B', 'DRIVER', 2),
       ('Miguel', 'Garcia Fernandez', '11223344C', 'DRIVER', 3);


INSERT INTO delivery (purchase_order_id, delivery_person_id, delivery_time)
VALUES (1, 2, '2024-10-29 19:15:00'),
       (2, 3, '2024-10-29 19:45:00');

INSERT INTO purchase_order_detail (purchase_order_id, product_id)
VALUES (1, 9),
       (1, 2),
       (1, 5),
       (2, 10),
       (2, 1),
       (2, 6),
       (3, 11);


SELECT SUM(po.drink_items), t.name FROM purchase_order po
         INNER JOIN client c on po.client_id = c.id
         INNER JOIN town t on c.town_id = t.id
WHERE t.name = 'Barcelona';

SELECT COUNT(d.id) AS 'Ana deliveries' FROM delivery d
INNER JOIN employee e on d.delivery_person_id = e.id
WHERE e.name = 'Ana';