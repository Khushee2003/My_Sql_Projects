
-- Advanced SQL Project Dataset;
CREATE DATABASE Spotify_data;
USE Spotify_data;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

-- EDA 
SELECT COUNT(*) FROM spotify_data.spotify;
SELECT COUNT(distinct artist) from spotify_data.spotify;
SELECT COUNT(distinct album) from spotify_data.spotify;
SELECT distinct album_type from spotify_data.spotify;
select duration_min from spotify_data.spotify;
select max(duration_min) from spotify_data.spotify;
SELECT * FROM spotify
WHERE duration_min=0;

select distinct channel from spotify_data.spotify;
SELECT distinct most_played_on FROM spotify_data.spotify;
-- ----------------------------------------------
/*-- Data Analysis Easy Category
-- ---------------------------------------
Retrieve the names of all tracks that have more than 1 billion streams.
List all albums along with their respective artists.
Get the total number of comments for tracks where licensed = TRUE.
Find all tracks that belong to the album type single.
Count the total number of tracks by each artist.
*/


-- 1.Retrieve the names of all tracks that have more than 1 billion streams.
SELECT * FROM spotify
WHERE  stream > 100000000;

-- 2.List all albums along with their respective artists.
SELECT 
      Distinct album, artist
FROM spotify_data.spotify;


SELECT 
      Distinct album
FROM spotify_data.spotify
ORDER BY 1;

-- 3.Get the total number of comments for tracks where licensed TRUE = 1.

SELECT * FROM Spotify
WHERE licensed = 1;

-- 4.Find all tracks that belong to the album type single.
SELECT * FROM spotify
WHERE album_type LIKE 'single'; 

SELECT 
    artist,
    COUNT(*) as total_no_songe
FROM spotify
GROUP BY artist
ORDER BY 2 DESC;

-- 6.Calculate the average danceability of tracks in each album.

SELECT 
    album,
    avg(danceability) as avg_danceability
FROM spotify
GROUP BY 1;

SELECT 
   track,
   MAX(energy)
FROM spotify
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- 8.Find the top 5 tracks with the highest energy values.
SELECT 
    track,
    SUM(views) as total_views,
    SUM(likes) as total_views
FROM Spotify
WHERE official_video = 1
group by 1
order by 2 desc
limit 5;

-- 9.List all tracks along with their views and likes where official_video = TRUE.
SELECT 
    album,
    track,
    sum(views)
FROM spotify
GROUP BY 1,2
ORDER BY 3 DESC;

-- 10.Retrieve the track names that have been streamed on Spotify more than YouTube.
SELECT
    track,
    COALESCE(SUM(CASE WHEN most_played_on = 'youtube' THEN stream END), 0) AS streamed_on_youtube,
    COALESCE(SUM(CASE WHEN most_played_on = 'spotify' THEN stream END), 0) AS streamed_on_spotify
FROM spotify
GROUP BY track
HAVING streamed_on_youtube > 0
LIMIT 50;
-- 11.Find the top 3 most-viewed tracks for each artist using window functions.
SELECT 
     artist,
     track,
     sum(views) as total_view,
     DENSE_RANK() OVER(partition by artist	 order by sum(views) desc) as r
FROM spotify
GROUP BY 1,2
ORDER BY 1,3 DESC;

-- 12.Write a query to find tracks where the liveness score is above the average.
SELECT  * FROM spotify
WHERE liveness > (SELECT AVG(liveness) FROM spotify);

 -- 13 use with a calculate the difference between the highest and lowest energy values for tracks in each album.
 WITH cte 
 as 
 (select 
     album,
     MAX(energy) as highest_energy,
     MIN(energy) as lowest_energy
from spotify
group by 1
)
SELECT 
     album,
     highest_energy - lowesrt_energery  as energy_diff
FROM cte
ORDER BY 2 DESC;

-- 14.Query optimize
explain analyze 
SELECT 
     artist,
     track,
     views
FROM spotify
WHERE artist = "Gorillaz"
   AND 
      most_played_on = 'youtube'
ORDER BY  stream DESC LIMIT 25;