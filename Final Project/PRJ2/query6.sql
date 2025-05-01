-- query6.sql: Your choice - Crime count by reporting district
SELECT rd.Rpt_Dist_No, COUNT(cr.DR_NO) AS total_crimes
FROM CrimeReports cr
JOIN Reporting_districts rd ON cr.AREA = rd.AREA
GROUP BY rd.Rpt_Dist_No;