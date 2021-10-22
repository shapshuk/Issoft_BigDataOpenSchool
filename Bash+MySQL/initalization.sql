CREATE DATABASE IF NOT EXISTS movie_ratings_db;

USE movie_ratings_db;

DROP TABLE IF EXISTS ratings;
DROP TABLE IF EXISTS movies;

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


LOAD DATA INFILE '/var/lib/mysql-files/movies.csv'
INTO TABLE movies
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE '/var/lib/mysql-files/ratings.csv'
INTO TABLE ratings
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;