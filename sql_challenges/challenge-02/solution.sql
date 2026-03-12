
-- INNER JOINS
-- EXCERCISE 6: Find the domestic and international sales for each movie
    SELECT * FROM movies JOIN boxoffice ON movies.id = boxoffice.movie_id;
-- EXCERCISE 7: Show the sales numbers for each movie that did better internationally rather than domestically
    SELECT * FROM movies JOIN boxoffice ON movies.id = boxoffice.movie_id where boxoffice.international_sales > boxoffice.domestic_sales;
-- EXCERCISE 8: List all the movies by their ratings in descending order
    SELECT * FROM movies JOIN boxoffice ON movies.id = boxoffice.movie_id ORDER BY boxoffice.rating DESC;

-- OUTER JOINS
-- EXCERCISE 7: Find the list of all buildings that have employees 
    SELECT DISTINCT building FROM employees LEFT JOIN buildings on employees.building = buildings.building_name;
-- EXCERCISE 8: Find the list of all buildings and their capacity
    SELECT * FROM buildings;
-- EXCERCISE 9: List all buildings and the distinct employee roles in each building (including empty buildings) 
    SELECT DISTINCT employees.role, buildings.building_name FROM buildings LEFT JOIN employees on employees.building = buildings.building_name;

-- Interview answer
    SELECT pages.page_id FROM pages 
    LEFT JOIN page_likes 
    ON pages.page_id = page_likes.page_id 
    WHERE page_likes.liked_date IS NULL 

    ORDER BY pages.page_id ASC;
