--Using NULL
--Display teachers with no department
SELECT name
FROM teacher
WHERE dept IS NULL

--Inner join misses NULL rows
SELECT teacher.name, dept.name
 FROM teacher JOIN dept ON teacher.dept=dept.id

--Display all teachers and departments, including those with NULL dept
SELECT teacher.name, dept.name
  FROM teacher
  LEFT JOIN dept ON dept.id = teacher.dept

--Display all departments
SELECT teacher.name, dept.name
  FROM teacher
  RIGHT JOIN dept ON dept.id = teacher.dept

--Use COALESCE to enter default number if cell is NULL
SELECT name, COALESCE(mobile,'07986 444 2266') 
  FROM teacher

--Display teachers and departments with 'None' in place of NULL
SELECT teacher.name, COALESCE(dept.name, 'None')
  FROM teacher
  LEFT JOIN dept ON dept.id = teacher.dept

--Display the count of teachers and mobile phones
SELECT COUNT(name), COUNT(mobile)
  FROM teacher

--Display the number of staff by department including those will NULL
SELECT dept.name, COUNT(teacher.name)
  FROM teacher
  RIGHT JOIN dept ON dept.id = teacher.dept
  GROUP BY dept.name

--Categorise teacher departments by Art or Sci
SELECT name, 
  CASE
    WHEN teacher.dept = 1 THEN 'Sci'
    WHEN teacher.dept = 2 THEN 'Sci'
    ELSE 'Art' 
    END AS department
  FROM teacher

--Use CASE to show the name of each teacher followed by 'Sci' if the teacher 
--is in dept 1 or 2, show 'Art' if the teacher's dept is 3 and 'None' otherwise
SELECT name,
  CASE
    WHEN dept = 1 THEN 'Sci'
    WHEN dept = 2 THEN 'Sci'
    WHEN dept = 3 THEN 'Art'
    ELSE 'None'
    END AS department
  FROM teacher
 