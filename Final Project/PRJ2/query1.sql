-- query1.sql: Join - Total incidents per area
SELECT a.Area_Name, COUNT(*) AS Total_Incidents
FROM CrimeReports cr
JOIN Reporting_districts rd ON cr.Rpt_Dist_No = rd.Rpt_Dist_No
JOIN Area a ON rd.Area = a.Area
GROUP BY a.Area_Name;