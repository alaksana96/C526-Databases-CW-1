SELECT father, mother, CONCAT(CAST(100*MaleKids/TotalKids AS VARCHAR(3)), '%') as male
FROM (
        SELECT DISTINCT father,
                        mother,
                        COUNT(CASE WHEN gender = 'M' THEN gender END) OVER (PARTITION BY father, mother) as MaleKids,
                        COUNT(gender) OVER (PARTITION BY father, mother) as TotalKids
        FROM person
        WHERE father IS NOT NULL
        AND mother IS NOT NULL
        ) AS kids
ORDER BY father, mother
