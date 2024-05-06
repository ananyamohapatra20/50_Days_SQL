SELECT * FROM financials;
SELECT * FROM movies;

SELECT  m.movie_id,title,industry,release_year,f.currency,
CASE WHEN f.unit="Billions" THEN ROUND((f.revenue-f.budget)*1000,2)
WHEN f.unit="Thousands" THEN ROUND((f.revenue-f.budget)/1000,2)
ELSE (f.revenue-f.budget)
END AS profit_in_mlns
FROM 
movies m
JOIN financials f
ON m.movie_id=f.movie_id
WHERE industry="Bollywood"
ORDER BY profit_in_mlns DESC