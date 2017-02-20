SELECT  split_part(name, ' ', 1) as name, COUNT(split_part(name, ' ', 1)) as popularity
FROM  person
GROUP BY  split_part(name, ' ', 1)
HAVING  COUNT(split_part(name, ' ', 1)) > 1
ORDER BY  popularity DESC,  name