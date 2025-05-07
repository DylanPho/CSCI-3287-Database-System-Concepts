-- query5.sql: Your choice - Top 5 most frequent crime types
SELECT cc.Crm_Cd_Desc AS `Crime Description`, COUNT(*) AS `Frequency`
FROM Crime c
JOIN Crime_Code cc ON c.Crm_Cd = cc.Crm_Cd
GROUP BY cc.Crm_Cd_Desc
ORDER BY Frequency DESC
LIMIT 5;
