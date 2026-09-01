-- Netflix Data Analysis using SQL 

create database Netflix;
CREATE TABLE Netflix (
	show_id VARCHAR(6),
	type VARCHAR(10),
	title VARCHAR(150),
	director VARCHAR(208),
	casts VARCHAR(1000),
	country VARCHAR(150),
	date_added VARCHAR(50),
	release_year INT,
	rating VARCHAR(10),
	duration VARCHAR(15),
	listed_in VARCHAR(100),
	description VARCHAR(250)
);
SELECT * FROM netflix;

SELECT type, COUNT(*) AS total_content
FROM netflix
GROUP BY type;

SELECT count(*) as total_content FROM netflix;
SELECT DISTINCT type FROM netflix;
SELECT COUNT(type) FROM netflix;

-- 2.Find the most common rating for movies and Tv shows
SELECT  type,
       rating
FROM netflix;

SELECT 
     type,
     rating,
     COUNT(*) FROM netflix
GROUP BY 1,2
ORDER BY 1,3 DESC;

-- Find the release_year in 2020
SELECT * FROM netflix WHERE type = 'movie' AND  release_year = 2020;


-- Find the top 5 countries with the most content on Netflix

SELECT country as new_country
from  netflix
GROUP BY country
ORDER BY new_country
LIMIT 5;


-- Identify the longest movie
SELECT MAX(duration) FROM  netflix;

-- Find content added in the last 5 year
SELECT date_added
FROM netflix
Group By date_added
ORDER BY date_added ASC
LIMIT 5;


-- Find all the Movies TV show by director 'Rajiv Chillaka'

SELECT * FROM netflix WHERE director LIKE '%Rajiv Chilaka%';

-- List all TV show with more than 5 seasons
SELECT  duration
FROM netflix
GROUP BY duration
ORDER BY duration
LIMIT 5;

-- Count the number of content items in each gener
SELECT listed_in, show_id FROM netflix;

-- Find each year and the average numbers of content release by Indian On netfilex,return top 5 year with highest avg content release  
SELECT  AVG(release_year)
FROM netflix
GROUP BY release_year
ORDER BY release_year DESC
LIMIT 5;

-- list all movies that are documentaries
SELECT * FROM netflix
WHERE listed_in LIKE '%documentaries%';

-- Find all content without a directore
SELECT * FROM netflix
WHERE director IS NOT NULL;

-- Find how many movies actor 'Salman Khan ' appeared in last 10 year
 SELECT COUNT(*) AS movie_count
FROM netflix
WHERE casts LIKE '%Salman Khan%'
  AND release_year >= YEAR(CURDATE()) - 10;
  
-- Find the top 10 actors who have appered in the highest number of movie product in India
SELECT 
    COUNT(*)
FROM netflix
WHERE country = 'India'
GROUP by casts
ORDER BY COUNT(*) DESC
LIMIT 10;



SELECT 
    category,
    COUNT(*) AS content_count
FROM (
    SELECT 
        CASE 
            WHEN description LIKE '%kill%' OR description LIKE '%violence%' THEN 'Bad'
            ELSE 'Good'
        END AS category
    FROM netflix
) AS categorized_content
GROUP BY category;



