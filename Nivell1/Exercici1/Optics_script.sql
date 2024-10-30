CREATE DATABASE IF NOT EXISTS optics;

USE optics;

CREATE TABLE IF NOT EXISTS supplier (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR (256) NOT NULL,
	street_name VARCHAR (256) NOT NULL,
    street_number SMALLINT UNSIGNED NOT NULL,
    floor SMALLINT UNSIGNED,
    door SMALLINT UNSIGNED,
	city VARCHAR (256),
	post_code INT UNSIGNED,
	telephone INT UNSIGNED NOT NULL,
	fax VARCHAR (20),
	NIF CHAR (9) NOT NULL,
    UNIQUE INDEX uidx_NIF (NIF)
);

CREATE TABLE IF NOT EXISTS brand (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR (256) NOT NULL,
    supplier_id INT UNSIGNED NOT NULL,
    CONSTRAINT fk_brand_supplier_id FOREIGN KEY (supplier_id) REFERENCES supplier(id)
);

CREATE TABLE IF NOT EXISTS glasses (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	left_eye_prescription VARCHAR (250),
	right_eye_prescription VARCHAR (250),
	frame ENUM('rimless', 'plastic', 'metal'),
    frame_color VARCHAR(250),
    left_lens_color VARCHAR(250),
    right_lens_color VARCHAR(250),
    price DECIMAL(10,2) CHECK (price >= 0),
	brand_id INT UNSIGNED,
    CONSTRAINT fk_glasses_brand_id FOREIGN KEY (brand_id) REFERENCES brand(id)
);

CREATE TABLE IF NOT EXISTS client (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(256) NOT NULL,
    address VARCHAR(256) NOT NULL,
    telephone INT UNSIGNED,
    email VARCHAR(256) NOT NULL,
    registered_date DATETIME NOT NULL,
    recommended_client INT UNSIGNED DEFAULT NULL,
    CONSTRAINT fk_client_recommended_client FOREIGN KEY (recommended_client) REFERENCES client(id)
);

CREATE TABLE IF NOT EXISTS employee (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR (256) NOT NULL,
    NIF CHAR (9) NOT NULL
);

CREATE TABLE IF NOT EXISTS purchase
(
    id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    client_id   INT UNSIGNED NOT NULL,
    employee_id INT UNSIGNED NOT NULL,
    total_quantity INT UNSIGNED NOT NULL,
    total_cost  DECIMAL(10,2) CHECK (total_cost >= 0),
    date        DATETIME NOT NULL,
    CONSTRAINT fk_purchase_employee_id FOREIGN KEY (employee_id) REFERENCES employee (id),
    CONSTRAINT fk_purchase_client_id FOREIGN KEY (client_id) REFERENCES client (id)
);

CREATE TABLE IF NOT EXISTS purchase_details (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    purchase_id INT UNSIGNED,
    glasses_id INT UNSIGNED NOT NULL,
    quantity INT UNSIGNED NOT NULL,
    CONSTRAINT fk_pd_purchase_id FOREIGN KEY (purchase_id) REFERENCES purchase(id),
    CONSTRAINT fk_purchase_glasses_id FOREIGN KEY (glasses_id) REFERENCES glasses(id)
);


INSERT INTO supplier (name, street_name, street_number, city, post_code, telephone, NIF)
VALUES ('Pakito glasses', 'Avinguda Roma', 7, 'Barelona', 08011, 93456578, '55754466G'),
        ('Ulleres SA', 'Carrer del Polígon dels Frares', 24, 'Lleida', 25001, 93454579, '35735566G'),
        ('Louis Vuitton Barcelona', 'Carrer Calàbria', 32, 'Barcelona', 08011, 93466576, '44887766F');

INSERT INTO brand (name, supplier_id)
VALUES ('Tous', 1),
       ('Channel', 1),
        ('Mechanis', 2),
        ('Louis Vuitton', 3),
        ('Mechanno', 2);

INSERT INTO glasses (left_eye_prescription, right_eye_prescription, frame, frame_color, left_lens_color, right_lens_color, price, brand_id)
VALUES ( '-2.00SPH 100AXIS' , '-2.35 SPH 90AXIS', 'plastic', 'white', 'blue', 'blue', 400, 1),
       ('-0.5CYL 69AXIS', '-1.4CYL 69AXIS', 'metal', 'yellow', 'blue', 'blue, ', 350, 2);

INSERT INTO client (name, address, telephone, email, registered_date, recommended_client)
VALUES ('Claudia Fontanella', 'Carrer Girona 87, 3r 2a 08011 Barcelona', 633545644, 'claudiafontanella@gmail.com', '2023-10-25 15:30:00', NULL),
       ('Stefania Bennet', 'Carrer Aribau 456, 1er 3a 09088 Barcelona', 675432345, 'stefaniaBenet@gmail.com', '2023-11-30 10:32:00', 1),
       ('Arnau Tordera', 'Carrer Obeses 45, 23456 Vic', 654889900, 'arnautordera@gmail.com', '2023-11-30 10:32:00', null);

INSERT INTO employee (name, NIF)
VALUES ('Sandra Olle', '45769809G'),
        ('Marta Olle', '34555666H');

INSERT INTO purchase (client_id, employee_id, total_cost, date, total_quantity)
VALUES (1, 1, 400, '2023-10-25 15:32:00', 1),
       (2, 1, 700, '2023-11-30 10:32:00', 2),
       (1, 2,350, '2024-10-25 15:30:00', 1),
       (3, 1, 350, '2024-10-26 15:30:00', 1);

INSERT INTO purchase_details (purchase_id, glasses_id, quantity)
VALUES (1, 1, 1),
       (2, 2, 2),
       (3, 2, 1),
       (4, 1, 1);



SELECT c.name, p.date, pd.* FROM client c
INNER JOIN purchase p
ON c.id = p.client_id
INNER JOIN purchase_details pd
ON p.id = pd.purchase_id
WHERE c.name = 'Claudia Fontanella' AND YEAR(p.date) BETWEEN '2019' AND '2025';

SELECT e.name, b.name FROM employee e
INNER JOIN purchase p on e.id = p.employee_id
INNER JOIN purchase_details pd on p.id = pd.purchase_id
INNER JOIN glasses g on pd.glasses_id = g.id
INNER JOIN brand b on g.brand_id = b.id
WHERE e.name = 'Sandra Olle' AND YEAR(p.date) BETWEEN '2013' AND '2024';

SELECT s.name, SUM(pd.quantity)FROM purchase_details pd
INNER JOIN purchase p on pd.purchase_id = p.id
INNER JOIN glasses g on pd.glasses_id = g.id
INNER JOIN brand b on g.brand_id = b.id
INNER JOIN supplier s on b.supplier_id = s.id
GROUP BY s.name;