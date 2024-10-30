CREATE DATABASE IF NOT EXISTS youtube;

USE youtube;

CREATE TABLE IF NOT EXISTS country (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(256) NOT NULL
);

CREATE TABLE IF NOT EXISTS user (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(256) NOT NULL,
    email VARCHAR(256) NOT NULL,
    password VARCHAR(256) NOT NULL,
    date_birth DATE NOT NULL,
    gender ENUM('MALE', 'FEMALE', 'PREFER_NOT_SAY', 'NON_BINARY') NOT NULL,
    country_id INT UNSIGNED NOT NULL,
    post_code CHAR(5),
    CONSTRAINT fk_user_country_id FOREIGN KEY (country_id) REFERENCES country(id)
);

CREATE TABLE IF NOT EXISTS video (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(256) NOT NULL,
    description VARCHAR(256) NOT NULL,
    weight DECIMAL NOT NULL,
    video_file_name VARCHAR(256) NOT NULL,
    duration TIME NOT NULL,
    thumbail_path VARCHAR(256) NOT NULL,
    total_views BIGINT UNSIGNED NOT NULL,
    total_likes BIGINT UNSIGNED NOT NULL,
    total_dislikes BIGINT UNSIGNED NOT NULL,
    state ENUM('PUBLIC', 'PRIVATE', 'HIDDEN') NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    published_date DATETIME NOT NULL,
    CONSTRAINT fk_video_user_id FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE IF NOT EXISTS tag (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(256) NOT NULL,
    UNIQUE INDEX uidx_tag_name (name)
);


CREATE TABLE IF NOT EXISTS video_tag (
    video_id INT UNSIGNED NOT NULL,
    tag_id INT UNSIGNED NOT NULL,
    CONSTRAINT fk_video_tag_video_id FOREIGN KEY (video_id) REFERENCES video(id),
    CONSTRAINT fk_video_tag_tag_id FOREIGN KEY (tag_id) REFERENCES tag(id),
    UNIQUE INDEX uidx_video_id_tag_id (video_id, tag_id)
);

CREATE TABLE IF NOT EXISTS channel (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(256) NOT NULL,
    description VARCHAR(256) NOT NULL,
    creator_id INT UNSIGNED NOT NULL,
    CONSTRAINT fk_channel_creator_id FOREIGN KEY (creator_id) REFERENCES user(id)
);

CREATE TABLE IF NOT EXISTS subscriber (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    channel_id INT UNSIGNED NOT NULL,
    subscriber_id INT UNSIGNED NOT NULL,
    CONSTRAINT fk_subscriber_channel_id FOREIGN KEY (channel_id) REFERENCES channel(id),
    CONSTRAINT fk_subscriber_subscriber_id FOREIGN KEY (subscriber_id) REFERENCES user(id),
    UNIQUE INDEX uidx_subscriber_channel_subscriber (channel_id, subscriber_id)
);

CREATE TABLE IF NOT EXISTS video_reaction (
    id            INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    reaction_type ENUM ('LIKE', 'DISLIKE') NOT NULL,
    video_id      INT UNSIGNED NOT NULL,
    user_id       INT UNSIGNED NOT NULL,
    time          DATETIME NOT NULL,
    CONSTRAINT fk_vr_video_id FOREIGN KEY (video_id) REFERENCES video (id),
    CONSTRAINT fk_vr_user_id FOREIGN KEY (user_id) REFERENCES user (id),
    UNIQUE INDEX uidx_vr_video_id_user_id (video_id, user_id)
);

CREATE TABLE IF NOT EXISTS playlist (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(256) NOT NULL,
    state ENUM('PUBLIC', 'PRIVATE') NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    date_created DATETIME NOT NULL,
    CONSTRAINT fk_playlist_user_id FOREIGN KEY (user_id) REFERENCES user(id),
    UNIQUE INDEX uidx_name_user_id (name, user_id)
);

CREATE TABLE IF NOT EXISTS comment (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    text VARCHAR(256) NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    video_id INT UNSIGNED NOT NULL,
    CONSTRAINT fk_comment_user_id FOREIGN KEY (user_id) REFERENCES user(id),
    CONSTRAINT fk_comment_video_id FOREIGN KEY (video_id) REFERENCES video(id)
);

CREATE TABLE IF NOT EXISTS comment_reaction (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    reaction_type ENUM ('LIKE', 'DISLIKE') NOT NULL,
    time DATETIME NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    comment_id INT UNSIGNED NOT NULL,
    CONSTRAINT fk_cr_user_id FOREIGN KEY (user_id) REFERENCES user(id),
    CONSTRAINT fk_cr_comment_id FOREIGN KEY (comment_id) REFERENCES comment(id),
    UNIQUE INDEX uidx_cr_user_id_comment_id (comment_id, user_id)
);