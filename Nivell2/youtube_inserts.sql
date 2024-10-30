
USE youtube;

INSERT INTO country (name) VALUES
('United States'),
('Canada'),
('United Kingdom'),
('Australia'),
('Germany'),
('France'),
('Spain'),
('India');

INSERT INTO user (username, email, password, date_birth, gender, country_id, post_code) VALUES
('john_doe', 'john@example.com', 'hashed_password_1', '1990-05-15', 'MALE', 1, '90210'),
('jane_smith', 'jane@example.com', 'hashed_password_2', '1995-08-22', 'FEMALE', 2, 'K1A0B'),
('alex_brown', 'alex@example.com', 'hashed_password_3', '1988-11-30', 'NON_BINARY', 3, 'W1A1A'),
('linda_white', 'linda@example.com', 'hashed_password_4', '1992-03-12', 'FEMALE', 4, '20004'),
('mike_green', 'mike@example.com', 'hashed_password_5', '1985-07-04', 'MALE', 5, '80331');

INSERT INTO video (title, description, weight, video_file_name, duration, thumbail_path, total_views, total_likes, total_dislikes, state, user_id, published_date) VALUES
('Travel Vlog: New York City', 'Exploring the beautiful streets of NYC!', 2.5, 'nyc_vlog.mp4', '00:15:30', 'http://example.com/thumb1.jpg', 1500, 200, 10, 'PUBLIC', 1, '2024-10-01 10:00:00'),
('Cooking Tutorial: Pasta', 'Learn how to cook delicious pasta!', 1.5, 'pasta_tutorial.mp4', '00:12:00', 'http://example.com/thumb2.jpg', 2500, 350, 5, 'PUBLIC', 2, '2024-10-02 12:30:00'),
('Fitness Challenge: 30 Days', 'Join the 30-day fitness challenge!', 3.0, 'fitness_challenge.mp4', '00:20:00', 'http://example.com/thumb3.jpg', 1000, 150, 20, 'PUBLIC', 3, '2024-10-03 14:15:00'),
('Gadget Review: Latest Smartphone', 'Review of the latest smartphone features.', 2.0, 'smartphone_review.mp4', '00:10:00', 'http://example.com/thumb4.jpg', 3000, 500, 15, 'PUBLIC', 4, '2024-10-04 09:00:00'),
('DIY Home Decor Ideas', 'Creative home decor ideas on a budget!', 1.0, 'diy_home_decor.mp4', '00:08:00', 'http://example.com/thumb5.jpg', 1200, 100, 2, 'PUBLIC', 5, '2024-10-05 11:45:00');

INSERT INTO tag (name) VALUES
('Travel'),
('Cooking'),
('Fitness'),
('Reviews'),
('DIY'),
('Tech'),
('Lifestyle');

INSERT INTO video_tag (video_id, tag_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO channel (name, description, creator_id) VALUES
('John’s Adventures', 'A channel dedicated to travel and adventure.', 1),
('Jane’s Kitchen', 'Learn to cook delicious meals with Jane.', 2),
('Alex Fitness', 'Fitness tips and challenges with Alex.', 3),
('Linda Tech', 'Latest gadget reviews and tech tips.', 4),
('Mike DIY', 'DIY projects and home improvement tips.', 5);

INSERT INTO subscriber (channel_id, subscriber_id) VALUES
(1, 2),
(2, 3),
(3, 4),
(4, 5),
(5, 1);

INSERT INTO video_reaction (reaction_type, video_id, user_id, time) VALUES
('LIKE', 1, 2, '2024-10-01 11:00:00'),
('DISLIKE', 1, 3, '2024-10-01 11:30:00'),
('LIKE', 2, 4, '2024-10-02 13:00:00'),
('LIKE', 3, 5, '2024-10-03 15:00:00'),
('LIKE', 4, 1, '2024-10-04 10:00:00');

INSERT INTO playlist (name, state, user_id, date_created) VALUES
('Travel Favorites', 'PUBLIC', 1, '2024-10-01 10:00:00'),
('Cooking Essentials', 'PRIVATE', 2, '2024-10-02 12:30:00'),
('Fitness Goals', 'PUBLIC', 3, '2024-10-03 14:15:00');

INSERT INTO comment (text, user_id, video_id) VALUES
('Great video, I loved the tips!', 2, 1),
('Can you make a video on Italian cuisine?', 3, 2),
('This challenge looks fun!', 4, 3),
('Amazing review! Thanks for sharing.', 5, 4),
('I tried this DIY project and it worked!', 1, 5);

INSERT INTO comment_reaction (reaction_type, time, user_id, comment_id) VALUES
('LIKE', '2024-10-01 12:00:00', 1, 1),
('DISLIKE', '2024-10-02 13:15:00', 2, 2),
('LIKE', '2024-10-03 15:30:00', 3, 3),
('LIKE', '2024-10-04 16:45:00', 4, 4),
('LIKE', '2024-10-05 18:00:00', 5, 5);