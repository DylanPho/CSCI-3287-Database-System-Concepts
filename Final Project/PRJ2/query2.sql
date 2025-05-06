-- query2.sql: Outer Join - Crimes and weapons used (some crimes may not have a weapon)
SELECT cc.Crm_Cd_Desc, w.Weapon_Desc
FROM CrimeReports cr
LEFT JOIN Crime c ON cr.DR_NO = c.DR_NO
LEFT JOIN Crime_Code cc ON c.Crm_Cd = cc.Crm_Cd
LEFT JOIN Weapon w ON cr.Weapon_Used_Cd = w.Weapon_Used_Cd;