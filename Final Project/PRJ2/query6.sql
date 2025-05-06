-- query6.sql: Your choice - Crime count by reporting district
SELECT cr.Rpt_Dist_No, COUNT(*) AS Total_Crimes
FROM CrimeReports cr
GROUP BY cr.Rpt_Dist_No;