-- 1. FIND 5 OLDEST USERS
SELECT * FROM users ORDER BY created_at LIMIT 5;

-- 2. What day of the week do most usres register on
SELECT
    DAYNAME(created_at) AS 'DAY_OF_WEEK',
    COUNT(username) AS 'NUM_REGISTER'
FROM users
GROUP BY DAY_OF_WEEK ORDER BY NUM_REGISTER DESC;

-- 3. Identify Inactive Users (users with no photos)
SELECT username, image_url
FROM users
LEFT JOIN photos  
    ON users.id = photos.user_id
WHERE image_url IS NULL;

-- 4. Identify most popular photo and who created it
SELECT photos.id, photos.image_url, username, COUNT(*) AS 'total'
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC LIMIT 1;

-- 5. HOW MANY TIMES DOES THE AVERAGE USER POST
SELECT 
    COUNT(*)/(SELECT COUNT(*) FROM users) AS 'average post per users'
FROM photos;

-- 6. What are the top 5 most commonly used hashtags
SELECT tag_name, COUNT(*) AS total
FROM tags
INNER JOIN photo_tags
    ON tags.id = photo_tags.tag_id
GROUP BY tags.id ORDER BY total DESC LIMIT 5;

-- 7. Find Bots - users who have liked every single photo
-- SELECT username, COUNT(*) AS total
-- FROM users
-- INNER JOIN likes
--     ON users.id = likes.user_id
-- GROUP BY users.id ORDER BY total DESC
-- WHERE total = (SELECT COUNT(*) from photos);   -----> This will not work because WHERE clause execute before GROUP BY. USE HAVING will solve because HAVING will filter the result based on what we have after GROUP BY
SELECT 
    username, 
    COUNT(*) AS total
FROM users
INNER JOIN likes
    ON users.id = likes.user_id
GROUP BY users.id
HAVING total = (SELECT COUNT(*) from photos);