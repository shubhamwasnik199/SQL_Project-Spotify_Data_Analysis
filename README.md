# SQL_Project-Spotify_Data_Analysis.


# OVERVIEW
In this project, a Spotify dataset containing numerous attributes about songs, albums, and artists is analyzed using SQL. The entire process of normalizing a denormalized dataset, running SQL queries with different levels of complexity (simple, medium, and advanced), and The project's main objectives are to learn advanced SQL skills and use the dataset to produce insightful analysis.


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



## Key Features
- **Dataset Normalization**: Converting a denormalized dataset into a normalized form to ensure data integrity and reduce redundancy.
- **SQL Queries**:
  - Easy: Basic data retrieval and filtering.
  - Medium: Involved grouping, order, aggregations function.
  - Advanced: Complex queries, subqueries, window functions, CTEs, and performance optimization.


## Project Goals
1. Practice advanced SQL concepts and techniques.
2. Extract meaningful insights from the Spotify dataset.
3. Optimize query performance for efficiency.

## Tools and Technologies
- **SQL**: The core tool for data manipulation and analysis.
- **Database Management System (DBMS)**: Use a relational database PostgreSQL for this project.



## Analysis Base on Questions
#Easy Level
1. Retrieve the names of all tracks that have more than 1 billion streams.
2. List all albums along with their respective artists.
3. Get the total number of comments for tracks where licensed = TRUE.
4. Find all tracks that belong to the album type single.
5. Count the total number of tracks by each artist.

#Medium Level
6. Calculate the average danceability of tracks in each album.
7. Find the top 5 tracks with the highest energy values.
8. List all tracks along with their views and likes where official_video = TRUE.
9. For each album, calculate the total views of all associated tracks.
10. Retrieve the track names that have been streamed on Spotify more than YouTube.

#Advanced Level
11. Find the top 3 most-viewed tracks for each artist using window functions.
12. Write a query to find tracks where the liveness score is above the average.
13. Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
14. Find tracks where the energy-to-liveness ratio is greater than 1.2.
15. Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.



## Insights and Highlights
Some of the key insights derived from the dataset include:

- The most popular genres and their trends over time.
- Top-performing artists and their most successful albums.
- Patterns in track duration and popularity across different years.



