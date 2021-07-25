CREATE DATABASE movie_ratings_db;

USE movie_ratings_db;

CREATE TABLE movies
(
    movieId INT PRIMARY KEY,
    title VARCHAR(500),
    genres VARCHAR(100)
);

CREATE TABLE ratings
(
    userId INT,
    movieId INT,
    rating FLOAT,
    `timestamp` INT,
#     CONSTRAINT fk_movies_movieId FOREIGN KEY (movieId) REFERENCES movies (movieId)
    FOREIGN KEY  (movieId) REFERENCES movies(movieId)
);


# drop table ratings;
# SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/csv_src/movies.csv'
INTO TABLE movies
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/csv_src/ratings.csv'
INTO TABLE ratings
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

# SELECT title, genres FROM movies WHERE movieId = 1;

SELECT movies.title, movies.movieId, rating
FROM movies, ratings
LIMIT 0, 10;


# input_genres
# input_year
# input_title_regex
# input_movie_count


SELECT title, avg(rating) as avg_rating, genres
FROM movies
JOIN ratings r on movies.movieId = r.movieId

WHERE
    (movies.genres LIKE '%Drama%')
    AND (movies.title LIKE '%(1999)')
    AND (movies.title REGEXP 'T')


group by movies.movieId, title, genres
order by avg_rating desc;
# LIMIT 0, 10;


