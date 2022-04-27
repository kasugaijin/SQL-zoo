-- SELECT Basics Exercises
-- Show population of Germany
SELECT population FROM world
  WHERE name = 'Germany'

--Show population of three countries
SELECT name, population FROM world
  WHERE name IN ('Sweden', 'Norway', 'Denmark');

--Show countries with land areas within defined range
SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000

-- SELECT from WORLD Exercises
-- Display the name, continent and population
SELECT name, continent, population FROM world

-- Display countries with more than 200 million population
SELECT name FROM world
WHERE population >= 200000000

-- Display per capita GDP for countries with more than 200 million population
SELECT name, gdp/population AS per_capita_gdp
FROM world
WHERE population >= 200000000

-- Display population in millions for countries in S.America
SELECT name, population/1000000
FROM world
WHERE continent = 'South America'

-- Display population for three countries
SELECT name, population
FROM world
WHERE name IN ('France', 'Germany', 'Italy')

--Display countries with 'united' in the name
SELECT name
FROM world
WHERE name LIKE '%United%'

--Display countries with either large area or large population
SELECT name, population, area
FROM world
WHERE area > 3000000 OR population > 250000000;

--Display countries that are either large area or large population, but not both
SELECT name, population, area
FROM world
WHERE area > 3000000 XOR population > 250000000