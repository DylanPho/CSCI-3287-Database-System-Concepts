-- query1.sql: Join - Total incidents per area
SELECT a.AREA_NAME, COUNT(cr.DR_NO) AS total_incidents
FROM CrimeReports cr
JOIN Area a ON cr.AREA = a.AREA
GROUP BY a.AREA_NAME;