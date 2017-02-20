SELECT  name,  mother,  father
FROM  person
WHERE  dob <= ALL
      (  SELECT dob
         FROM person AS persona
         WHERE persona.mother = person.mother
         AND persona.father = person.father
      )
AND  mother IS NOT NULL
AND  father IS NOT NULL
ORDER BY name