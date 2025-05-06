-- query3.sql: Set Theory - Find MO codes described in MOCODE_Description that are not used in any crimes.
SELECT md.Mocode, md.Mocode_Desc
FROM MOCODE_Description md
WHERE md.Mocode NOT IN (
    SELECT DISTINCT cm.Mocode FROM Crime_MOCodes cm
);