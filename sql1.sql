SELECT title,release_year FROM movies
WHERE studio="Marvel Studios";
SELECT * FROM movies
WHERE title LIKE "%Avenger%";
SELECT release_year FROM movies
WHERE title="The Godfather";
SELECT DISTINCT studio FROM movies
WHERE industry="Bollywood";