--JOIN STATEMENTS
--Display all goal scorers from Germany
SELECT matchid, player 
  FROM goal 
  WHERE teamid = 'GER'

--Display a particular row
SELECT id,stadium,team1,team2
  FROM game
  WHERE id = 1012

--Display certain rows for every German goal
SELECT player, teamid, stadium, mdate
  FROM game 
  JOIN goal ON (game.id = goal.matchid)
   WHERE goal.teamid = 'GER'

--Display games and names for goal scorers where name starts with 'Mario'
SELECT game.team1, game.team2, goal.player
  FROM goal
  JOIN game
    ON goal.matchid = game.id
    WHERE goal.player LIKE 'Mario%'

--Display details for all goals scored in 10 minutes or less
SELECT player, teamid, coach, gtime
 FROM goal
 JOIN eteam
  ON goal.teamid = eteam.id
  WHERE gtime <= 10

--Display the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach
SELECT game.mdate, eteam.teamname 
  FROM game
  JOIN eteam
    ON game.team1 = eteam.id
    WHERE eteam.coach = 'Fernando Santos'

--List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
SELECT goal.player
  FROM goal 
  JOIN game
    ON goal.matchid = game.id
    WHERE game.stadium = 'National Stadium, Warsaw'

--Display the name of all players who scored a goal against Germany
SELECT DISTINCT(goal.player) 
  FROM goal
  JOIN game
    ON goal.matchid = game.id
    WHERE goal.teamid != 'GER' AND (game.team1 = 'GER' OR game.team2 = 'GER')

--Display team name and total goals scored
SELECT eteam.teamname, COUNT(goal.gtime)
  FROM goal
  JOIN eteam
    ON goal.teamid = eteam.id
    GROUP BY eteam.teamname

--Display stadium and total goals scored there
SELECT game.stadium, COUNT(goal.gtime)
  FROM game
  JOIN goal
    ON game.id = goal.matchid
    GROUP BY game.stadium
  
--Display for every match involving 'POL', the date and the number of goals scored
SELECT game.id, game.mdate, COUNT(goal.gtime) AS goals_scored
  FROM game 
  JOIN goal
    ON game.id = goal.matchid
    WHERE game.team1 = 'POL' OR game.team2 = 'POL'
  GROUP BY game.id, game.mdate

--Display matchid, match date and the number of goals scored by 'GER' for every game 'GER' scored
SELECT game.id, game.mdate, COUNT(goal.teamid) AS goals_scored
  FROM game
  JOIN goal
    ON game.id = goal.matchid
    WHERE goal.teamid = 'GER'
  GROUP BY game.mdate, game.id
  ORDER BY game.id

--Display every match with the goals scored by each team
SELECT game.mdate, game.team1, 
  SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) AS score1, 
  game.team2, 
  SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) AS score2
  
  FROM game 
  JOIN goal 
  ON goal.matchid = game.id
  GROUP BY game.mdate, game.team1, game.team2

ORDER BY game.mdate, game.id, game.team1, game.team2

--More JOIN statements
--Display movies made in 1962
SELECT id, title
  FROM movie
  WHERE yr = 1962

--Display the year a movie was made
SELECT yr
  FROM movie
  WHERE title = 'Citizen Kane'

--Display all movies with 'Star Trek' in title and order by year
SELECT id, title, yr
  FROM movie
  WHERE title LIKE '%Star Trek%'
  ORDER BY yr

--Display actor's ID
SELECT id 
  FROM actor
  WHERE name = 'Glenn Close'

--Display movie ID
SELECT id
  FROM movie
  WHERE title = 'Casablanca'

--Display all actors in a Casablanca
SELECT actor.name
  FROM actor
  JOIN casting
    ON actor.id = casting.actorid
  WHERE casting.movieid = 11768

--Display all actors in Alien
SELECT actor.name
  FROM actor
  JOIN casting
    ON actor.id = casting.actorid
  JOIN movie
    ON movie.id = casting.movieid
  WHERE movie.title = 'Alien'

--Display all movies Harrison Ford was in
SELECT movie.title
  FROM actor 
  JOIN casting 
    ON casting.actorid = actor.id
  JOIN movie 
    ON movie.id = casting.movieid
  WHERE actor.name = 'Harrison Ford'

--Display all movies Harrison Ford appeared in but not as a starring role
SELECT movie.title
  FROM actor
  JOIN casting
    ON casting.actorid = actor.id
  JOIN movie
    ON movie.id = casting.movieid
  WHERE actor.name = 'Harrison Ford' AND casting.ord != 1

--Display the movie and leading role for all movies in 1962
SELECT movie.title, actor.name
  FROM movie
  JOIN casting
    ON movie.id = casting.movieid
  JOIN actor
    ON actor.id = casting.actorid
  WHERE movie.yr = 1962 AND casting.ord = 1

--Display the year and the number of movies Rock Hudson made each year for any year in which he made more than 2 movies
SELECT yr,COUNT(title) 
  FROM movie 
  JOIN casting 
    ON movie.id=movieid
  JOIN actor
    ON actorid=actor.id
  WHERE name='Rock Hudson'
  GROUP BY yr
    HAVING COUNT(title) > 2
  
--Display the film title and the leading actor for all of the films 'Julie Andrews' played in
SELECT movie.title, actor.name
  FROM actor
  JOIN casting
    ON actor.id = casting.actorid
  JOIN movie
   ON movie.id = casting.movieid
  WHERE casting.movieid IN (SELECT casting.movieID 
                            FROM casting JOIN actor ON actor.id = casting.actorid 
                            WHERE actor.name = 'Julie Andrews') AND casting.ord = 1