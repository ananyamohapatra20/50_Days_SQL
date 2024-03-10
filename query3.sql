-- PROBLEM STATEMENT: Write a sql query to return the footer values from input table, meaning all the last 
-- non null values from each field as shown in expected output.									
DROP TABLE IF EXISTS FOOTER;
CREATE TABLE FOOTER(
	id INT PRIMARY KEY,
	car VARCHAR(20),
	length INT,
	width INT,
	height INT
);
INSERT INTO FOOTER VALUES (1, 'Hyundai Tucson', 15, 6, NULL);
INSERT INTO FOOTER VALUES (2, NULL, NULL, NULL, 20);
INSERT INTO FOOTER VALUES (3, NULL, 12, 8, 15);
INSERT INTO FOOTER VALUES (4, 'Toyota Rav4', NULL, 15, NULL);
INSERT INTO FOOTER VALUES (5, 'Kia Sportage', NULL, NULL, 18); 

SELECT * FROM FOOTER;
--Solution 1
SELECT * FROM
(SELECT car FROM FOOTER WHERE car IS NOT NULL ORDER BY id DESC LIMIT 1) car
CROSS JOIN (SELECT length FROM FOOTER WHERE length IS NOT NULL ORDER BY id DESC LIMIT 1) length
CROSS JOIN (SELECT width FROM FOOTER WHERE width IS NOT NULL ORDER BY id DESC LIMIT 1) width
CROSS JOIN (SELECT height FROM FOOTER WHERE height IS NOT NULL ORDER BY id DESC LIMIT 1) height

--Solution 2
WITH cte as (SELECT * ,SUM(CASE WHEN car IS NOT NULL THEN 1 ELSE 0 END)OVER(ORDER BY id) as car_segment,
			SUM(CASE WHEN length IS NOT NULL THEN 1 ELSE 0 END)OVER(ORDER BY id) as length_segment,
			SUM(CASE WHEN width IS NOT NULL THEN 1 ELSE 0 END)OVER(ORDER BY id) as width_segment,
			SUM(CASE WHEN height IS NOT NULL THEN 1 ELSE 0 END)OVER(ORDER BY id) as height_segment
			FROM FOOTER) 
SELECT 
FIRST_VALUE(car) OVER(PARTITION BY car_segment ORDER BY id) as new_car,
FIRST_VALUE(length) OVER(PARTITION BY length_segment ORDER BY id) as new_length,
FIRST_VALUE(width) OVER(PARTITION BY width_segment ORDER BY id) as new_width,
FIRST_VALUE(height) OVER(PARTITION BY height_segment ORDER BY id) as new_height
FROM cte
ORDER BY id DESC
LIMIT 1;









