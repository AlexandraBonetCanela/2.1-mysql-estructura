CREATE DATABASE IF NOT EXISTS spotify;

USE spotify;

CREATE TABLE IF NOT EXISTS country (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(256) NOT NULL
);

CREATE TABLE IF NOT EXISTS user(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(256) NOT NULL,
    email VARCHAR(256) NOT NULL,
    password VARCHAR(256) NOT NULL,
    date_birth DATE NOT NULL,
    type ENUM('FREE', 'PREMIUM') NOT NULL,
    gender ENUM('MALE', 'FEMALE', 'PREFER_NOT_SAY', 'NON_BINARY') NOT NULL,
    country_id INT UNSIGNED,
    post_code CHAR(5),
    CONSTRAINT fk_user_country_id FOREIGN KEY (country_id) REFERENCES country(id)
);

CREATE TABLE IF NOT EXISTS subscription (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    starting_date DATE NOT NULL,
    renewal_date DATE NOT NULL,
    payment_type ENUM('PAYPAL', 'CREDIT_CARD') NOT NULL,
    CONSTRAINT fk_subscription_user_id FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE IF NOT EXISTS credit_card (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    card_number INT UNSIGNED NOT NULL,
    expiration_month TINYINT UNSIGNED CHECK (expiration_month BETWEEN 1 AND 12) NOT NULL,
    expiration_year YEAR NOT NULL,
    security_code TINYINT UNSIGNED NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    CONSTRAINT fk_credit_card_user_id FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE IF NOT EXISTS paypal (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(250) NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    CONSTRAINT fk_paypal_user_id FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE IF NOT EXISTS payment (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    date DATETIME NOT NULL,
    total_price DECIMAL(10,2) CHECK(total_price >= 0),
    user_id INT UNSIGNED NOT NULL,
    subscription_id INT UNSIGNED NOT NULL,
    CONSTRAINT fk_payment_subscription_id FOREIGN KEY (subscription_id) REFERENCES subscription(id),
    CONSTRAINT fk_payment_user_id FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE IF NOT EXISTS payment_credit_card (
    payment_id INT UNSIGNED NOT NULL,
    credit_card_id INT UNSIGNED NOT NULL,
    CONSTRAINT fk_pcc_subcription_id FOREIGN KEY (payment_id) REFERENCES payment(id),
    CONSTRAINT fk_pcc_credit_card_id FOREIGN KEY (credit_card_id) REFERENCES credit_card(id),
    UNIQUE INDEX uidx_subscription_id_credit_card (payment_id,credit_card_id)
);

CREATE TABLE IF NOT EXISTS payment_paypal (
    payment_id INT UNSIGNED NOT NULL,
    paypal_id INT UNSIGNED NOT NULL,
    CONSTRAINT fk_pp_payment_id FOREIGN KEY (payment_id) REFERENCES payment(id),
    CONSTRAINT fk_pp_paypal_id FOREIGN KEY (paypal_id) REFERENCES paypal(id)
);

CREATE TABLE IF NOT EXISTS playlist (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(250) NOT NULL,
    number_songs INT UNSIGNED NOT NULL,
    date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    state ENUM ('ACTIVE', 'DELETED') NOT NULL,
    deleted_date DATETIME DEFAULT NULL,
    user_id INT UNSIGNED NOT NULL,
    CONSTRAINT fk_playlist_user_id FOREIGN KEY (user_id) REFERENCES user(id),
    UNIQUE INDEX uidx_playlist_title_user_id (title, user_id)
);

CREATE TABLE IF NOT EXISTS artist (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(250) NOT NULL,
    img_urg VARCHAR(250) NOT NULL
);

CREATE TABLE IF NOT EXISTS album (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(250) NOT NULL,
    artist_id INT UNSIGNED NOT NULL,
    year_released YEAR NOT NULL,
    cover_image_url VARCHAR(250),
    CONSTRAINT fk_album_artist_id FOREIGN KEY (artist_id) REFERENCES artist(id)
);

CREATE TABLE IF NOT EXISTS song (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    album_id INT UNSIGNED NOT NULL,
    title VARCHAR(250) NOT NULL,
    duration TIME NOT NULL,
    total_streams INT UNSIGNED NOT NULL,
    CONSTRAINT fk_song_album_id FOREIGN KEY (album_id) REFERENCES album(id)
);

CREATE TABLE IF NOT EXISTS playlist_details (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    playlist_id INT UNSIGNED NOT NULL,
    song_id INT UNSIGNED NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    added_date DATE NOT NULL,
    CONSTRAINT fk_pd_playlist_id FOREIGN KEY (playlist_id) REFERENCES playlist(id),
    CONSTRAINT fk_pd_song_id FOREIGN KEY (song_id) REFERENCES song(id),
    CONSTRAINT fk_pf_user_id FOREIGN KEY (user_id) REFERENCES user(id),
    UNIQUE INDEX uidx_pd_playlist_id_song_id (playlist_id, song_id)
);

CREATE TABLE IF NOT EXISTS user_follows_artist (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    CONSTRAINT fk_follow_user_id FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE IF NOT EXISTS artists_relationship (
    artist_1_id INT UNSIGNED NOT NULL,
    artist_2_id INT UNSIGNED NOT NULL,
    CONSTRAINT fk_atist_rel_artist_1_id FOREIGN KEY (artist_1_id) REFERENCES artist(id),
    CONSTRAINT fk_artist_rel_artist_2_id FOREIGN KEY (artist_2_id) REFERENCES artist(id),
    UNIQUE INDEX uidx_artist_rel_artist1_2 (artist_1_id, artist_2_id)
);

CREATE TABLE IF NOT EXISTS album_favourites (
    album_id INT UNSIGNED NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    CONSTRAINT fk_album_fav_album_id FOREIGN KEY (album_id) REFERENCES album(id),
    CONSTRAINT fk_album_fav_user_id FOREIGN KEY (user_id) REFERENCES user(id),
    UNIQUE INDEX uidx_album_fav_album_user (album_id, user_id)
);

CREATE TABLE IF NOT EXISTS song_favourites (
    song_id INT UNSIGNED NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    CONSTRAINT fk_song_fav_song_id FOREIGN KEY (song_id) REFERENCES song(id),
    CONSTRAINT fk_song_fav_user_id FOREIGN KEY (user_id) REFERENCES user(id)
);