-- Q1 returns (name,dod) 
SELECT personb.NAME, 
       persona.dod 
FROM   person AS persona 
       JOIN person AS personb 
         ON persona.NAME = personb.mother 
WHERE  persona.dod IS NOT NULL; 

-- Q2 returns (name) 
SELECT NAME 
FROM   person 
WHERE  person.gender = 'M' 
EXCEPT 
SELECT DISTINCT males.NAME 
FROM   person AS males 
       JOIN person AS children 
         ON children.father = males.NAME 
WHERE  males.gender = 'M' 
ORDER  BY NAME; 

-- Q3 returns (name) 
SELECT NAME 
FROM   person AS mothers 
WHERE  NOT EXISTS (SELECT gender 
                   FROM   person 
                   EXCEPT 
                   SELECT gender 
                   FROM   person 
                   WHERE  mothers.NAME = person.mother) 
ORDER  BY NAME; 

-- Q4 returns (name,father,mother) 
SELECT NAME, 
       mother, 
       father 
FROM   person 
WHERE  dob <= ALL (SELECT dob 
                   FROM   person AS persona 
                   WHERE  persona.mother = person.mother 
                          AND persona.father = person.father) 
       AND mother IS NOT NULL 
       AND father IS NOT NULL 
ORDER  BY NAME; 

-- Q5 returns (name,popularity) 
SELECT Split_part(NAME, ' ', 1)        AS NAME, 
       Count(Split_part(NAME, ' ', 1)) AS popularity 
FROM   person 
GROUP  BY Split_part(NAME, ' ', 1) 
HAVING Count(Split_part(NAME, ' ', 1)) > 1 
ORDER  BY popularity DESC, 
          NAME; 

-- Q6 returns (name,forties,fifties,sixties) 
SELECT parent.NAME, 
       Count(CASE 
               WHEN child.dob >= Date('1940-01-01') 
                    AND child.dob <= Date('1949-12-31') THEN parent.NAME 
               ELSE NULL 
             END) AS Forties, 
       Count(CASE 
               WHEN child.dob >= Date('1950-01-01') 
                    AND child.dob <= Date('1959-12-31') THEN parent.NAME 
               ELSE NULL 
             END) AS Fifties, 
       Count(CASE 
               WHEN child.dob >= Date('1960-01-01') 
                    AND child.dob <= Date('1969-12-31') THEN parent.NAME 
               ELSE NULL 
             END) AS Sixties 
FROM   person AS parent 
       JOIN person AS child 
         ON parent.NAME = child.mother 
             OR parent.NAME = child.father 
GROUP  BY parent.NAME 
HAVING Count(parent.NAME) >= 2 
ORDER  BY parent.NAME; 

-- Q7 returns (father,mother,child,born) 
SELECT father, 
       mother, 
       NAME                  AS child, 
       Rank() 
         OVER( 
           partition BY father, mother 
           ORDER BY dob ASC) AS born 
FROM   person 
WHERE  father IS NOT NULL 
       AND mother IS NOT NULL; 

-- Q8 returns (father,mother,male) 
SELECT father, 
       mother, 
       Concat(Cast(100 * malekids / totalkids AS VARCHAR(3)), '%') AS male 
FROM   (SELECT DISTINCT father, 
                        mother, 
                        Count(CASE 
                                WHEN gender = 'M' THEN gender 
                              END) 
                          OVER ( 
                            partition BY father, mother) AS MaleKids, 
                        Count(gender) 
                          OVER ( 
                            partition BY father, mother) AS TotalKids 
        FROM   person 
        WHERE  father IS NOT NULL 
               AND mother IS NOT NULL) AS kids 
ORDER  BY father, 
          mother; 