--  Print profit % for all the movies
SELECT *, (revenue-budget) as profit,
((revenue-budget)/budget)*100 as profit_percentage
FROM financials;

SELECT *,
IF(currency="USD",revenue*83,revenue) as cnvt
FROM financials;

SELECT *,
CASE WHEN unit="Billions" THEN revenue*1000
WHEN unit="Thousands" THEN revenue/1000
WHEN unit="Millions" THEN revenue
END AS unit_cnvrt
FROM financials;

SELECT * FROM financials;