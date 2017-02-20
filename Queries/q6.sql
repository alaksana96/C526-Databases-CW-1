SELECT  parent.name,
        COUNT(CASE
              WHEN child.dob >= DATE('1940-01-01')
              AND child.dob <= DATE('1949-12-31')
              THEN parent.name
              ELSE NULL END) AS Forties,
        COUNT(CASE
              WHEN child.dob >= DATE('1950-01-01')
              AND child.dob <= DATE('1959-12-31')
              THEN parent.name
              ELSE NULL END) AS Fifties,
        COUNT(CASE
              WHEN child.dob >= DATE('1960-01-01')
              AND child.dob <= DATE('1969-12-31')
              THEN parent.name
              ELSE NULL END) AS Sixties
FROM  person AS parent
JOIN  person AS child
  ON  parent.name = child.mother
  OR  parent.name = child.father
WHERE child.dob  > DATE('1939-12-31')
GROUP BY parent.name
HAVING COUNT(parent.name) >= 2
ORDER BY  parent.name