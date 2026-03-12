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
