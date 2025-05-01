-- PRJ2: Create Tables for Crime Reporting Database (Improved for MySQL)
-- Filename: PHP_Plan.sql

/*
PRJ2 PHP Web Output Plan
------------------------
This outlines the user-facing layout for displaying the results of each query within a PHP-based web application.

🔸 General Layout:
- A single webpage (index.php) with a navbar or dropdown menu to switch between query results
- Each query result appears in a Bootstrap-styled table
- Queries are executed via MySQL and output via HTML tables

🔸 Query Sections:

1. Total Incidents per Area
   - Header: "Total Incidents by Area"
   - Columns: AREA_NAME, Total_Incidents

2. Crimes and Weapons Used
   - Header: "Crimes and Weapons Involved"
   - Columns: Crm_Cd_Desc, Weapon_Desc
   - Note: Use 'N/A' if weapon is NULL

3. MO Codes Used but Not Described
   - Header: "MOCodes Used in Reports but Not Described"
   - Columns: Mocode
   - Add message if result set is empty

4. Crimes per Premises Type
   - Header: "Crime Count by Premises Type"
   - Columns: Premis_Desc, Total_Crimes

5. Top 5 Most Frequent Crime Types
   - Header: "Top 5 Most Frequent Crime Types"
   - Columns: Crm_Cd_Desc, Frequency

6. Crime Count by Reporting District
   - Header: "Crime Count per Reporting District"
   - Columns: Rpt_Dist_No, Crime_Count
