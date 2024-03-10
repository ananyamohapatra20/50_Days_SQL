-- A ski resort company is planning to construct a new ski slope using a pre-existing network of 
-- mountain huts and trails between them. A new slope has to begin at one of the mountain huts, 
-- have a middle station at another hut connected with the first one by a direct trail, and end at 
-- the third mountain hut which is also connected by a direct trail to the second hut. The altitude 
-- of the three huts chosen for constructing the ski slope has to be strictly decreasing.

-- You are given two SQL tables, mountain_huts and trails, with the following structure:
-- create table mountain_huts (
--  id integer not null,
--  name varchar(40) not null,
--  altitude integer not null,
--  unique(name),
--  unique(id)
--  );
-- create table trails (
--  hut1 integer not null,
--  hut2 integer not null
--  );
-- insert into mountain_huts values (1, 'Dakonat', 1900);
-- insert into mountain_huts values (2, 'Natisa', 2100);
-- insert into mountain_huts values (3, 'Gajantut', 1600);
-- insert into mountain_huts values (4, 'Rifat', 782);
-- insert into mountain_huts values (5, 'Tupur', 1370);
-- insert into trails values (1, 3);
-- insert into trails values (3, 2);
-- insert into trails values (3, 5);
-- insert into trails values (4, 5);
-- insert into trails values (1, 5);
-- Each entry in the table trails represents a direct connection between huts with IDs hut1 and 
-- hut2. Note that all trails are bidirectional.
-- Create a query that finds all triplets(startpt,middlept,endpt) representing the mountain huts 
-- that may be used for construction of a ski slope.
-- Output returned by the query can be ordered in any way.
-- Assume that:
--  there is no trail going from a hut back to itself;
--  for every two huts there is at most one direct trail connecting them;
--  each hut from table trails occurs in table mountain_huts;

DROP TABLE IF EXISTS mountain_huts;
CREATE TABLE mountain_huts (
	id INTEGER NOT NULL UNIQUE,
	name VARCHAR(40) NOT NULL UNIQUE,
	altitute INTEGER NOT NULL
	
);
INSERT INTO mountain_huts VALUES(1,'Dakonat',1900);
INSERT INTO mountain_huts VALUES(2,'Natisa',2100);
INSERT INTO mountain_huts VALUES(3,'Gajantut',1600);
INSERT INTO mountain_huts VALUES(4,'Rifat',782);
INSERT INTO mountain_huts VALUES(5,'Tupur',1370);
drop table if exists trails;
create table trails 
(
	hut1 INTEGER NOT NULL,
	hut2 INTEGER NOT NULL
	
);
INSERT INTO trails VALUES(1,3);
INSERT INTO trails VALUES(3,2);
INSERT INTO trails VALUES(3,5);
INSERT INTO trails VALUES(4,5);
INSERT INTO trails VALUES(1,5);

SELECT * FROM mountain_huts;
SELECT * FROM trails;

WITH cte_trails1 AS (
		SELECT t1.hut1 AS start_hut ,h1.name AS start_hut_name,
		h1.altitute AS start_hut_altitute,t1.hut2 AS end_hut
		FROM mountain_huts h1
		JOIN trails t1
		ON h1.id = t1.hut1),
cte_trails2 AS ( SELECT t2.*,h2.name AS end_hut_name,
		h2.altitute AS end_hut_altitute,
		CASE WHEN start_hut_altitute > h2.altitute THEN 1
		ELSE 0
		END AS altitute_flag
		FROM cte_trails1 AS t2
		JOIN mountain_huts AS h2
		ON h2.id = t2.end_hut),
cte_final AS (
		SELECT CASE WHEN altitute_flag = 1 THEN start_hut ELSE end_hut END AS start_hut,
		CASE WHEN altitute_flag = 1 THEN start_hut_name ELSE end_hut_name END AS start_hut_name,
		CASE WHEN altitute_flag = 1 THEN end_hut ELSE start_hut END AS end_hut,
		CASE WHEN altitute_flag = 1 THEN end_hut_name ELSE start_hut_name END AS end_hut_name
		FROM cte_trails2)
SELECT C1.start_hut_name startpoint,
C1.end_hut_name middlepoint,
C2.end_hut_name endpoint
FROM cte_final C1
JOIN cte_final C2 ON C1.end_hut=C2.start_hut
		
--Combinations 
-- 1,3,5
-- 2,3,5
-- 3,5,4
-- 1,5,4








