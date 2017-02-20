SELECT  father,
        mother,
        name AS child,
        RANK() OVER(PARTITION BY father, mother ORDER BY dob ASC) AS born
FROM    person
WHERE   father IS NOT NULL
AND     mother IS NOT NULL