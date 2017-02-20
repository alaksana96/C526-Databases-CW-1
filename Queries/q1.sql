SELECT  personb.name,
        persona.dod
FROM    person AS persona
JOIN    person AS personb
ON      persona.name = personb.mother
WHERE   persona.dod IS NOT NULL