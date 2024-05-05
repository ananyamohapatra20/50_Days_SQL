-- 1. How many movies were released between 2015 and 2022
SELECT COUNT(*) FROM movies
WHERE release_year IN (2015,2022);
-- 2. Print the max and min movie release year
SELECT MAX(release_year) as max_rlse_yr,
MIN(release_year) as min_rlse_yr
FROM movies;
-- 3. Print a year and how many movies were released in that year starting with the latest year
SELECT release_year,COUNT(*) as cnt_movies
FROM movies
GROUP BY release_year
ORDER BY release_year DESC