-- query2.sql: Outer Join - Crimes and weapons used (some crimes may not have a weapon)
SELECT c.Crm_Cd, cc.Crm_Cd_Desc, w.Weapon_Desc
FROM Crime c
LEFT JOIN Weapon w ON c.Crm_Cd = w.Weapon_Used_Cd
JOIN Crime_Code cc ON c.Crm_Cd = cc.Crm_Cd;