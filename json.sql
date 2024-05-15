SELECT *FROM items
WHERE properties->"$.weight"=500;

SELECT *FROM items
WHERE properties->"$.color"="blue";

SELECT *FROM items
WHERE JSON_EXTRACT(properties,"$.color")="blue";