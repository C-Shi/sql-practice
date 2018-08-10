-- print the total number of book in the database
SELECT count(*) FROM books;

-- print out how many books were released each year
SELECT COUNT(*) AS 'Number released', released_year FROM books GROUP BY released_year;

-- count the total number of books in stock
SELECT SUM(stock_quantity) AS 'Total Stock' FROM books;

-- Average released year for each author
SELECT  CONCAT(author_fname, ' ', author_lname) AS 'Author', AVG(released_year) AS 'Ave released year' FROM books GROUP BY author_lname, author_fname;

-- Find the full name of the author who wrote the longest book 
SELECT CONCAT(author_fname, ' ', author_lname), pages FROM books ORDER BY pages DESC LIMIT 1;
SELECT CONCAT(author_fname, ' ', author_lname), pages FROM books WHERE pages = (SELECT MAX(pages) FROM books);

-- print year, # books release that year, and the average pages
SELECT released_year AS 'year', COUNT(*) AS '# books', AVG(pages) FROM books GROUP BY released_year;