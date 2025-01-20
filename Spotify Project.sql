
--- ADVANCE SQL PROJECT - Spotify Datasets


-- create table
DROP TABLE IF EXISTS spotify;
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



-- EDA --

SELECT COUNT(*) FROM Spotify;

SELECT COUNT(Artist) FROM Spotify;

SELECT COUNT( DISTINCT Artist) FROM Spotify;


SELECT DISTINCT Album_type FROM Spotify;

SELECT MAX( duration_min ) FROM Spotify;

SELECT MIN(duration_min) FROM Spotify;


SELECT * FROM Spotify
WHERE duration_min = 0;

DELETE FROM Spotify
WHERE duration_min = 0;

SELECT * FROM Spotify
WHERE duration_min = 0;

SELECT DISTINCT channel FROM Spotify;


SELECT DISTINCT most_played_on FROM Spotify;



/*
-- ---------------------------------
-- Data Analysis  - EAST Phase 
-- ---------------------------------
	
Retrieve the names of all tracks that have more than 1 billion streams.
List all albums along with their respective artists.
Get the total number of comments for tracks where licensed = TRUE.
Find all tracks that belong to the album type single.
Count the total number of tracks by each artist.
*/


-- Q 1. Retrieve the names of all tracks that have more than 1 billion streams.

SELECT * FROM Spotify
WHERE stream > 1000000000;


-- Q 2. List all albums along with their respective artists.

SELECT 
	DISTINCT Album, Artist
	FROM Spotify
ORDER BY 1;


SELECT 
	DISTINCT Album
	FROM Spotify
ORDER BY 1;




-- Q 3. Get the total number of comments for tracks where licensed = TRUE.

-- SELECT DISTINCT licensed FROM Spotify
	

SELECT 
	SUM(Comments) AS Totale_no_comments
	FROM Spotify
WHERE licensed = true;



-- Q 4. Find all tracks that belong to the album type single.

SELECT * FROM Spotify
WHERE album_type ILIKE 'Single';


-- Q 5. Count the total number of tracks by each artist.


SELECT Artist, ----- 1
	COUNT(*) as Total_songs -- 2
	FROM Spotify
group by Artist
ORDER BY 2 ;
	

/*
-- ---------------------------------
-- MEDIUM Phase 
-- ---------------------------------	


Calculate the average danceability of tracks in each album.
Find the top 5 tracks with the highest energy values.
List all tracks along with their views and likes where official_video = TRUE.
For each album, calculate the total views of all associated tracks.
Retrieve the track names that have been streamed on Spotify more than YouTube.
*/
	

-- Q 6. Calculate the average danceability of tracks in each album.
	
SELECT album,
	avg (danceability) as Average_danceability 
	FROM Spotify
group by 1
order by 2 desc;



-- Q 7. Find the top 5 tracks with the highest energy values.

SELECT track,
	max (energy)
	FROM Spotify
group by 1
order by 2 desc
LIMIT 5 ;


-- Q 8. List all tracks along with their views and likes where official_video = TRUE.


SELECT 
	track,
	SUM(views) as total_views,
	SUM(likes) as total_likes
FROM Spotify
WHERE official_video = 'true'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5 ;



-- Q 9. For each album, calculate the total views of all associated tracks.


SELECT 
	album,
	track,
	SUM(views) as total_view
FROM Spotify
GROUP BY 1, 2



-- 	Q 10. Retrieve the track names that have been streamed on Spotify more than YouTube.

	
SELECT 
	track,
	most_played_on,
    stream as streamed_on_YouTube,
	stream as streamed_on_Spotify
FROM Spotify



	
SELECT * FROM
(SELECT 
	track,
	-- most_played_on,
    COALESCE (SUM(CASE WHEN most_played_on = 'Youtube' THEN stream END),0) as streamed_on_youtube,
    COALESCE (SUM(CASE WHEN most_played_on = 'Spotify' THEN stream END),0) as streamed_on_spotify
FROM Spotify
GROUP BY 1
	) AS t1
WHERE  
	streamed_on_spotify > streamed_on_youtube
	AND
	streamed_on_youtube <> 0;
     



/*
-- ---------------------------------
-- ADVANCE Phase 
-- ---------------------------------

Find the top 3 most-viewed tracks for each artist using window functions.
Write a query to find tracks where the liveness score is above the average.
Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
Find tracks where the energy-to-liveness ratio is greater than 1.2.
Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.
*/


-- Q 11. Find the top 3 most-viewed tracks for each artist using window functions.

-- Each artists and total view for each track
-- track with highest view for each artist (we need top)
-- dense rank
-- cte and filder rank <=3


WITH ranking_artist
AS
(SELECT 
	artist,
	track,
	SUM(views) AS Most_view,
	DENSE_RANK() OVER (PARTITION BY artist ORDER BY SUM(views) DESC) AS RANK
	FROM Spotify
GROUP BY 1, 2
ORDER BY 1, 3 DESC 
)	
SELECT * FROM ranking_artist
	WHERE rank <= 3;



	
SELECT 
	artist,
	track,
	SUM(views) AS Most_view
	FROM Spotify
GROUP BY 1, 2
ORDER BY 1, 3 DESC 
	LIMIT 3;


-- Q 12. Write a query to find tracks where the liveness score is above the average.

	
SELECT 
	artist,
	track,
	liveness
	FROM Spotify
WHERE liveness > (SELECT AVG(liveness) FROM Spotify)



-- Q 13. Use a WITH clause to calculate the difference between the 
--       highest and lowest energy values for tracks in each album.
	

WITH cte 
AS
(SELECT 
	album,
	MAX(energy) as highest_energy,
	MIN(energy) as lowest_energery
FROM Spotify
GROUP BY 1
)
SELECT 
	album,
	highest_energy - lowest_energery AS energy_diff
FROM cte
ORDER BY 2 DESC;



--- 14. Find tracks where the energy-to-liveness ratio is greater than 1.2.

SELECT * FROM Spotify ;

SELECT 
	track,
	energy / liveness AS energy_to_liveness_ratio
FROM Spotify 
	WHERE energy / liveness > 1.2 ;



-- 15. Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.

SELECT * FROM Spotify ;

SELECT 
	track,
	SUM(likes) OVER (ORDER BY views) AS cumulative_sum
FROM Spotify
	ORDER BY SUM(likes) OVER (ORDER BY views) DESC ;




--- THE END ---
