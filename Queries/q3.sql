SELECT	name
FROM	person AS mothers
WHERE NOT EXISTS
      ( SELECT  gender
        FROM	  person
		    EXCEPT
		    SELECT  gender
		    FROM    person
		    WHERE   mothers.name = person.mother
		  )
ORDER BY name