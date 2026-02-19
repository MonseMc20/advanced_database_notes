# Session – 2026-02-19

## Topics covered
- Tables should only have attributes from the object to prevent duplicated information. 
- Table A can be connected to table B via FK (the reference of the PK of table B)
- To join the information from two tables with the same data
     SELECT * FROM student JOIN cursos ON student.curso_id = cursos.id
- JOINS 
    [](MonseMc20/advanced_database_notes/diagrams/diagram.excalidraw.svg)
    [](MonseMc20/advanced_database_notes/diagrams/JOINS.jpeg)
    - INNER JOIN, ALL the records that are between both tables (default)
    - LEFT JOIN, ALL the records that are present in table A
    - RIGHT JOIN, ALL the records that are present in table B and the attributes that are NOT present on table B from table A will be marked as null when joining
    - In the students example, doing a RIGHT JOIN, will show ALL the available courses eventhough no students are enrolled. Thus, NULL will appear on the attribute NAME
    - CROSS JOIN multiplies attribute by attribute
- ALIAS
    SELECT * FROM empleados JOIN empleados AS managers ON em.manager.id = managers.id
-   If I need a specific attribute from a table, I must specify the table from which I need it
    example: empleados.name, managers.name

INNER JOINS
- EXCERCISE 6: Find the domestic and international sales for each movie
    SELECT * FROM movies JOIN boxoffice ON movies.id = boxoffice.movie_id;
- EXCERCISE 7: Show the sales numbers for each movie that did better internationally rather than domestically
    SELECT * FROM movies JOIN boxoffice ON movies.id = boxoffice.movie_id where boxoffice.international_sales > boxoffice.domestic_sales;
- EXCERCISE 8: List all the movies by their ratings in descending order
    SELECT * FROM movies JOIN boxoffice ON movies.id = boxoffice.movie_id ORDER BY boxoffice.rating DESC;

OUTER JOINS
- EXCERCISE 7: Find the list of all buildings that have employees 
    SELECT DISTINCT building FROM employees LEFT JOIN buildings on employees.building = buildings.building_name;
- EXCERCISE 8: Find the list of all buildings and their capacity
    SELECT * FROM buildings;
- EXCERCISE 9: List all buildings and the distinct employee roles in each building (including empty buildings) 
    SELECT DISTINCT employees.role, buildings.building_name FROM buildings LEFT JOIN employees on employees.building = buildings.building_name;

- Interview answer
    SELECT pages.page_id FROM pages 
    LEFT JOIN page_likes 
    ON pages.page_id = page_likes.page_id 
    WHERE page_likes.liked_date IS NULL 
    ORDER BY pages.page_id ASC;
## What I understood
- Database tables
    - PK
    - FK
    - JOINS
    - ALIAS
## What is still confusing
- I still need to practice more OUTER JOINS

## Questions
- No questions

## Related concepts
- [Concept name](../concepts/concept-name.md)

## Resources used
- SQL Lesson 6: Multi-table queries with JOINs `https://sqlbolt.com/lesson/select_queries_with_joins`
- SQL Lesson 7: OUTER JOINs `https://sqlbolt.com/lesson/select_queries_with_outer_joins`
- Interview question `https://datalemur.com/questions/sql-page-with-no-likes`
