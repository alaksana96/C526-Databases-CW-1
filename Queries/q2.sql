SELECT name
FROM   person
WHERE  person.gender = 'M'
EXCEPT
SELECT DISTINCT males.name
FROM   person AS males
JOIN   person AS children
ON     children.father = males.name
WHERE  males.gender = 'M'
ORDER BY name;
