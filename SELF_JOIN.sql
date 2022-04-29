--SELF JOIN
--How many stops in the database?
SELECT COUNT(id)
  from stops

--Display the id for a stop
SELECT id
  FROM stops
  WHERE name = 'Craiglockhart'

--Give the id and the name for the stops on the '4' 'LRT' service
SELECT stops.id, stops.name
  FROM  stops
  JOIN route ON stops.id = route.stop
  WHERE route.num = '4' AND route.company = 'LRT'

--Find the two routes that visit two defined stops
SELECT company, num, COUNT(*)
  FROM route WHERE stop=149 OR stop=53
  GROUP BY company, num
  HAVING COUNT(*) = 2

--Display services between 'Craiglockhart' and 'London Road'
SELECT a.company, a.num, a.stop, b.stop
  FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
  WHERE a.stop=53 AND 
    b.stop = 
    (
    SELECT DISTINCT(route.stop) 
    FROM route 
    JOIN stops ON stops.id = route.stop 
    WHERE stops.name = 'London Road'
    )

--Display the services between 'Craiglockhart' and 'London Road' showing stop names
SELECT a.company, a.num, stopa.name, stopb.name
  FROM route a JOIN route b ON
    (a.company = b.company AND a.num = b.num)
     JOIN stops stopa ON (a.stop = stopa.id)
    JOIN stops stopb ON (b.stop = stopb.id)
  WHERE stopa.name = 'Craiglockhart' AND stopb.name = 'London Road'

--Give a list of all the services which connect stops 115 and 137 
SELECT DISTINCT(a.company), a.num
  FROM route a JOIN route b ON (a.company = b.company AND a.num = b.num)
  WHERE a.stop = 115 AND b.stop = 137

--Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'
SELECT DISTINCT(a.company), a.num
  FROM route a JOIN route b ON
    (a.company=b.company AND a.num=b.num)
    JOIN stops stopa ON (a.stop=stopa.id)
    JOIN stops stopb ON (b.stop=stopb.id)
  WHERE stopa.name='Craiglockhart' AND stopb.name = 'Tollcross'

--Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, 
--including 'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. 
--of the relevant services. 
SELECT stopb.name, a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE a.stop=53
