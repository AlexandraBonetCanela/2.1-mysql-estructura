USE spotify;

INSERT INTO country (name) VALUES
('United States'),
('South Korea'),
('Spain');

INSERT INTO user (username, email, password, date_birth, type, gender, country_id, post_code) VALUES
('MikuMako', 'mikumako@gmail.com', 'FVGRSK44tgsdg7', '1990-05-15', 'FREE', 'MALE', 1, '90210'),
('XipIXop', 'xipixop@gmail.com', 'fsg678ir3F6m4g;', '1992-07-20', 'PREMIUM', 'FEMALE', 2, '12345');

INSERT INTO subscription (user_id, starting_date, renewal_date, payment_type) VALUES
(2, '2024-01-01', '2025-01-01', 'CREDIT_CARD');

INSERT INTO credit_card (card_number, expiration_month, expiration_year, security_code, user_id) VALUES
(1234567890123456, 12, 2025, 123, 2);

INSERT INTO paypal (username, user_id) VALUES
('XipIXop_paypal', 2);

INSERT INTO payment (date, total_price, user_id, subscription_id) VALUES
('2024-01-01 10:00:00', 9.99, 2, 1);

INSERT INTO payment_credit_card (payment_id, credit_card_id) VALUES
(1, 1);

INSERT INTO artist (name, img_urg) VALUES
('Ateez', 'img1_url'),
('Stray Kids', 'img2_url');

INSERT INTO album (title, artist_id, year_released, cover_image_url) VALUES
('Golden Hour', 1, 2022, 'cover_img1_url'),
('Chk Chk Boom', 2, 2023, 'cover_img2_url');

INSERT INTO song (album_id, title, duration, total_streams) VALUES
(1, 'Work', '00:03:45', 10000),
(2, 'Chk Chk Boom', '00:04:20', 5000);

INSERT INTO playlist (title, number_songs, state, user_id) VALUES
('TOP 100 K-POP', 10, 'ACTIVE', 1),
('Workout Mix', 15, 'ACTIVE', 2);

INSERT INTO playlist_details (playlist_id, song_id, user_id, added_date) VALUES
(1, 1, 1, '2024-10-01'),
(2, 2, 2, '2024-10-02');

INSERT INTO user_follows_artist (user_id) VALUES
(1),
(2);

INSERT INTO artists_relationship (artist_1_id, artist_2_id) VALUES
(1, 2);

INSERT INTO album_favourites (album_id, user_id) VALUES
(1, 1),
(2, 2);

INSERT INTO song_favourites (song_id, user_id) VALUES
(1, 1),
(2, 2);