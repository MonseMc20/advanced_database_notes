-- lesson 1
SELECT title FROM movies;
SELECT director FROM movies;
SELECT title, director FROM movies;
SELECT title, year FROM movies;
SELECT * FROM movies;

-- lesson 2
SELECT * FROM movies where id=6;
SELECT * FROM movies where year between 2000 and 2010;
SELECT * FROM movies where year not between 2000 and 2010;
SELECT * FROM movies where id between 1 and 5;

-- lesson 3
SELECT * FROM movies where title like "%toy story%";
SELECT * FROM movies where director="John Lasseter";
SELECT * FROM movies where director!="John Lasseter";
SELECT * FROM movies where title like "WALL-_";

-- lesson 4
SELECT DISTINCT director FROM movies order by director asc;
SELECT * FROM movies order by year desc limit 4 offset 0;
SELECT * FROM movies order by title asc limit 5 offset 0;
SELECT * FROM movies order by title asc limit 5 offset 5;

-- lesson 5
SELECT city,population FROM north_american_cities where country = "Canada";
SELECT * FROM north_american_cities where country = "United States" order by latitude desc;
SELECT city, longitude FROM north_american_cities WHERE longitude < -87.629798 ORDER BY longitude ASC;
SELECT * FROM north_american_cities where country = "Mexico" order by population desc limit 2;
SELECT * FROM north_american_cities where country = "United States" order by population desc limit 2 offset 2 ;

