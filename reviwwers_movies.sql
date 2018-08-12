
-- CREATE MANY TO MANY RELATIONSHIP TABLES 
CREATE TABLE reviewers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);

CREATE TABLE series (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    released_year YEAR(4),
    genre VARCHAR(100)
);

CREATE TABLE reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    rating DECIMAL(2,1),
    series_id INT,
    reviewer_id INT,
    FOREIGN KEY (series_id) REFERENCES series(id),
    FOREIGN KEY (reviewer_id) REFERENCES reviewers(id)
);

-- CHALLENGE MATCHING SERIES WITH ITS REVIEWS
SELECT title, rating FROM series JOIN reviews ON series.id = reviews.series_id;

SELECT
    title, 
    ROUND(AVG(rating), 2) AS 'average'
FROM series
JOIN reviews
    ON series.id = reviews.series_id
GROUP BY series.id ORDER BY average DESC;

-- JOIN REVIEWER TOGETHER WITH RATING
SELECT first_name, last_name, rating
FROM reviewers
JOIN reviews
    ON reviewers.id = reviews.reviewer_id;
    
-- UNREVIEWED SERIES CHALLENGE
SELECT 
    title,
    rating
FROM series
LEFT JOIN reviews
    ON series.id = reviews.series_id
WHERE rating IS NULL;

-- SELECT AVERAGE RATING BY GENRE
SELECT genre, AVG(rating) as 'average'
FROM series 
JOIN reviews
    ON series.id = reviews.series_id
GROUP BY genre ORDER BY average;

-- CHALLENGE 6 REVIEWERS STATS
SELECT 
    first_name,
    last_name,
    COUNT(rating) AS 'COUNT',
    IFNULL(MIN(rating), 0) AS 'MIN',
    IFNULL(MAX(rating), 0) AS 'MAX',
    IFNULL(AVG(rating), 0) AS 'AVERAGE',
    -- IF STATEMENT IS AN ALTERNATIVE FOR CASE-END STATEMENT, BUT ONLY WORK ON 2 SITUATION IF(condition, true do, false do)
    IF(COUNT(rating) >=1, 'ACTIVE', 'INACTIVE') AS 'STATUS'
FROM reviewers
LEFT JOIN reviews
    ON  reviewers.id = reviews.reviewer_id
GROUP BY reviewers.id;


-- JOIN THREE TABLE TOGETHER 
SELECT 
    title, 
    rating, 
    CONCAT(first_name, ' ', last_name) AS 'reviewer'
FROM series
JOIN reviews
    ON series.id = reviews.series_id
JOIN reviewers
    ON reviewers.id = reviews.reviewer_id;