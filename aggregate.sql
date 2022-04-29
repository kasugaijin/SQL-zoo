--Aggregate Functions (SUM, COUNT, AVG...) Exercises
--Total world population
SELECT SUM(population)
  FROM world

--Display each continent name once
SELECT DISTINCT(continent)
  FROM world

--Display total GDP of African continent
SELECT SUM(gdp)
  FROM world
  WHERE continent = 'Africa'

--Display count of contries with area > 1,000,000 sq km
SELECT COUNT(area)
  FROM world
  WHERE area >= 1000000

--Display total population of three countries
SELECT SUM(population)
  FROM world
  WHERE name IN('Estonia', 'Latvia', 'Lithuania')

--Display the number of countries per continent
SELECT continent, COUNT(name)
  FROM world
  GROUP BY continent

--Display count of countries with population >10 million per continent
SELECT continent, COUNT(population)
  FROM world
  WHERE population > 10000000
  GROUP BY continent

--Display continents with populations > 100 million
SELECT continent
  FROM world
  GROUP BY continent
    HAVING SUM(population) > 100000000 
