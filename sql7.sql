-- 1. Generate a report of all Hindi movies sorted by their revenue amount in millions.
-- Print movie name, revenue, currency, and unit
SELECT * FROM financials;
SELECT * FROM movies;
SELECT * FROM moviesdb.languages;
SELECT m.title,
CASE WHEN f.unit="Billons" THEN ROUND(f.revenue*1000,1)
WHEN f.unit="Thousands" THEN ROUND(f.revenue/1000,1)
ELSE ROUND(f.revenue,1)
END AS revenue
,f.currency,f.unit
FROM financials f
JOIN movies m
ON m.movie_id=f.movie_id
JOIN 
languages l
ON m.language_id=l.language_id
WHERE l.name="Hindi"
ORDER BY revenue DESC;

	SELECT 
		title, revenue, currency, unit, 
			CASE 
					WHEN unit="Thousands" THEN ROUND(revenue/1000,2)
			WHEN unit="Billions" THEN ROUND(revenue*1000,2)
					ELSE revenue 
			END as revenue_mln
	FROM movies m
	JOIN financials f
			ON m.movie_id=f.movie_id
	JOIN languages l
			ON m.language_id=l.language_id
	WHERE l.name="Hindi"
	ORDER BY revenue_mln DESC