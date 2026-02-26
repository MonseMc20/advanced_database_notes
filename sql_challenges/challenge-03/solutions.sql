
-- 1) Find the longest time that an employee has been at the studio 
SELECT MAX(years_employed) FROM employees ;

-- 2) For each role, find the average number of years employed by employees in that role
SELECT role, AVG(years_employed) FROM employees GROUP BY role;

-- 3) Find the total number of employee years worked in each building
SELECT building, sum(years_employed) FROM employees group by building;

-- 1)Find the number of Artists in the studio (without a HAVING clause)
SELECT role, count(name) FROM employees where Role = "Artist";

-- 2) Find the number of Employees of each role in the studio
SELECT role, count(name) FROM employees group by role;

-- 3) Find the total number of years employed by all Engineers 
SELECT role, sum(years_employed) FROM employees where role = "Engineer";

-- TUTORIAL
-- Complete the following query to return the:
-- Number of different shapes
-- The standard deviation (stddev) of the unique weights
select count(distinct shape) number_of_shapes,
       Stddev(unique weight) distinct_weight_stddev
from   bricks;

-- Complete the following query to return the total weight for each shape stored in the bricks table:
select shape, sum(weight) shape_weight
from   bricks
group by shape


-- Complete the following query to find the shapes which have a total weight less than four:
select shape, sum ( weight )
from   bricks
having sum(weight) < 4
group  by shape;