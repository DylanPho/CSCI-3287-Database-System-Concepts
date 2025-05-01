-- query4.sql: Aggregation - Crimes per premises type
SELECT p.Premis_Desc, COUNT(cr.DR_NO) AS incident_count
FROM CrimeReports cr
JOIN Crime_premises p ON cr.Premis_Cd = p.Premis_Cd
GROUP BY p.Premis_Desc;