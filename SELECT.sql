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

--Display group of countries with population and GDP rounded to 2 decimal places
SELECT name, ROUND(population/1000000, 2), ROUND(GDP/1000000000, 2)
  FROM world
  WHERE continent = 'South America'

--Display per capita GDP rounded to nearest thousand for countries with more than 1 trillion GDP
SELECT name, ROUND(GDP/population, -3)
  FROM world
  WHERE GDP > 1000000000000

--Display countries where capital and name are the same length
SELECT name, capital
  FROM world
  WHERE LENGTH(capital) = Length(name)

--Display countries where the name and capital start with the same letter, but not the same word
SELECT name, capital
  FROM world
  WHERE LEFT(name,1) = LEFT(capital,1) AND name != capital

--Display the country that contains 'a' 'e' 'i' 'o' 'u' and is one word
SELECT name
   FROM world
   WHERE name LIKE '%a%' AND
      LIKE '%e%' AND
      LIKE '%i%' AND
      LIKE '%o%' AND
      LIKE '%u%' AND
      NOT LIKE '%char(32)%'

--SELECT from Nobel Tutorial
--Display winners of 1950
SELECT yr, subject, winner
  FROM nobel
  WHERE yr = 1950

--Display winner of literature in 1962
SELECT winner
  FROM nobel
  WHERE yr = 1962
  AND subject = 'Literature'

--Display year and subject Einstein won
SELECT yr, subject
  FROM nobel
  WHERE winner LIKE '%EINST%'

--Display all 'Peace' winners from 2000 inclusive
SELECT winner
  FROM nobel
  WHERE subject = 'Peace' AND yr >= 2000

--Display winners of literature within a range of years
SELECT * 
  FROM nobel
  WHERE yr BETWEEN 1980 AND 1989 AND subject = 'Literature'

--Display preseidential winners
SELECT * FROM nobel
  WHERE winner IN ('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter', 'Barack Obama')

--Display winners with first name John
SELECT winner
  FROM nobel
  WHERE winner LIKE 'John%'

--Display winner of Physics in 1980 and chemistry in 1984
SELECT *
  FROM nobel
  WHERE subject = 'Physics' AND yr = '1980' OR 
    subject = 'Chemistry' AND yr = '1984'

--Display winners in 1980 excluding Chemistry and Medicine
SELECT * 
  FROM nobel
  WHERE yr = 1980 AND 
    subject != 'Chemistry' AND 
    subject != 'Medicine'

--Display winners of medicine pre 1910 and literature 2004 on
SELECT * 
  FROM nobel
  WHERE subject = 'Medicine' AND yr < 1910 OR
    subject = 'Literature' AND yr >= 2004

--Display non ASCII character winner
SELECT *
  FROM nobel
  WHERE winner = 'PETER GRÜNBERG'

--Display winner with apostrophe
SELECT *
  FROM nobel
  WHERE winner = 'EUGENE O\'NEILL'

-- Display all winners beginning with 'Sir'
SELECT winner, yr, subject
  FROM nobel
  WHERE winner LIKE 'Sir%'

--Display 1984 winners and subjects with physics and chemistry last
SELECT winner, subject
  FROM nobel
  WHERE yr = 1984
  ORDER BY subject IN ('Physics','Chemistry'), subject, winner
