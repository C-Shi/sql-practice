DROP DATABASE ig_clone;

CREATE DATABASE ig_clone;
USE ig_clone;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    comment_text VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    photo_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(photo_id) REFERENCES photos(id)
);

CREATE TABLE likes (
    user_id INT NOT NULL,
    photo_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    -- set the combination of user_id and photo_id as PRIMARY KEY
    PRIMARY KEY(user_id, photo_id)
);

CREATE TABLE follows (
    follower_id INT NOT NULL,
    followee_id INT NOT NULL,
    create_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (followee_id) REFERENCES users(id),
    FOREIGN KEY (follower_id) REFERENCES users(id),
    PRIMARY KEY (followee_id, follower_id)
);

CREATE TABLE tags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(255) UNIQUE,
    create_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photo_tags(
    photo_id INT NOT NULL,
    tag_id INT NOT NULL,
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    FOREIGN KEY(tag_id) REFERENCES tags(id),
    PRIMARY KEY(photo_id, tag_id)
);

INSERT INTO users (username) VALUES
('BlueTheCat'), ('CharlieBrown'), ('ColtSteele');

INSERT INTO photos (image_url, user_id) VALUES
('askdjhf90', 1), ('sadrri30', 2), ('asdfhiuewr123', 3);

INSERT INTO comments(comment_text, user_id, photo_id) VALUES
('Meow!', 1, 2), ('Amazing', 3,2), ('I like this', 2, 1);

INSERT INTO likes (user_id, photo_id) VALUES
(1,1), (2,1), (1,2), (1,3), (3,3);

INSERT INTO follows(follower_id, followee_id) VALUES
(1,2), (1,3), (3,1), (2,3);