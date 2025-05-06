-- query4.sql: Aggregation - Crimes per premises type
SELECT cp.Premis_Desc, COUNT(*) AS Crime_Count
FROM CrimeReports cr
JOIN Crime_premises cp ON cr.Premis_Cd = cp.Premis_Cd
GROUP BY cp.Premis_Desc;