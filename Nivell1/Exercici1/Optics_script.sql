CREATE TABLE providers (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR (256) NOT NULL,
	street_name VARCHAR (256),
    street_number SMALLINT,
    floor SMALLINT UNSIGNED,
    door SMALLINT UNSIGNED,
	city VARCHAR (256),
	post_code CHAR (5),
	telephone INT UNSIGNED,
	fax VARCHAR (20),
	NIF CHAR (9)
);

CREATE TABLE glasses (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	brand VARCHAR (256) NOT NULL,
	left_eye_prescription VARCHAR (250),
	right_eye_prescription VARCHAR (250),
	frame ENUM('rimless', 'plastic', 'metal'),
    frame_color VARCHAR(250),
    left_lens_color VARCHAR(250),
    right_lens_color VARCHAR(250),
    price DECIMAL UNSIGNED,
	provider_id INT,
    CONSTRAINT fk_provider_id FOREIGN KEY (provider_id) REFERENCES providers(id)
);

CREATE TABLE client (
    id INT UNSIGNED AUTO_INCREMENT,
    name VARCHAR(256) NOT NULL,
    address VARCHAR(256),
    telephone INT UNSIGNED,
    email VARCHAR(256),
    registered_date DATETIME,
    recommended_client INT
);

CREATE TABLE client_glasses (
    id INT UNSIGNED AUTO_INCREMENT,
    client_id INT UNSIGNED,
    employee_id INT UNSIGNED,
    glasses_id INT UNSIGNED
)