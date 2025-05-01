-- query3.sql: Set Theory - MO Codes used but not described
SELECT DISTINCT Mocode
FROM Crime_MOCodes
WHERE Mocode NOT IN (
    SELECT Mocode FROM MOCODE_Description
);