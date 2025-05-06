-- PRJ2: Create Tables for Crime Reporting Database (Improved for MySQL)
-- Filename: create.sql

CREATE TABLE Area (
    AREA INT PRIMARY KEY,
    AREA_NAME VARCHAR(15)
) 

CREATE TABLE Reporting_districts (
    Rpt_Dist_No INT PRIMARY KEY,
    AREA INT,
    FOREIGN KEY (AREA) REFERENCES Area(AREA)
) 

CREATE TABLE Crime_premises (
    Premis_Cd INT PRIMARY KEY,
    Premis_Desc VARCHAR(100)
) 

CREATE TABLE Weapon (
    Weapon_Used_Cd INT PRIMARY KEY,
    Weapon_Desc VARCHAR(50)
) 

CREATE TABLE Status (
    Status VARCHAR(2) PRIMARY KEY,
    Status_Desc VARCHAR(50)
) 

CREATE TABLE Crime_Code (
    Crm_Cd INT PRIMARY KEY,
    Crm_Cd_Desc VARCHAR(100),
    Part_1_2 INT
) 

CREATE TABLE MOCODE_Description (
    Mocode VARCHAR(4) PRIMARY KEY,
    Mocode_Desc VARCHAR(500)
) 

CREATE TABLE CrimeReports (
    DR_NO INT PRIMARY KEY,
    Date_Rptd DATETIME,
    Date_OCC DATETIME,
    Time_OCC TIME,
    Rpt_Dist_No INT,
    Vict_Age INT,
    Vict_Sex VARCHAR(1),
    Vict_Descent VARCHAR(1),
    Premis_Cd INT,
    Weapon_Used_Cd INT,
    Status VARCHAR(2),
    Location VARCHAR(100),
    Cross_Street VARCHAR(100),
    LAT FLOAT,
    LON FLOAT,
    FOREIGN KEY (Rpt_Dist_No) REFERENCES Reporting_districts(Rpt_Dist_No),
    FOREIGN KEY (Premis_Cd) REFERENCES Crime_premises(Premis_Cd),
    FOREIGN KEY (Weapon_Used_Cd) REFERENCES Weapon(Weapon_Used_Cd),
    FOREIGN KEY (Status) REFERENCES Status(Status)
) 

CREATE TABLE Crime (
    DR_NO INT,
    Crm_Cd INT,
    PRIMARY KEY (DR_NO, Crm_Cd),
    FOREIGN KEY (DR_NO) REFERENCES CrimeReports(DR_NO),
    FOREIGN KEY (Crm_Cd) REFERENCES Crime_Code(Crm_Cd)
) 

CREATE TABLE Crime_MOCodes (
    DR_NO INT,
    Mocode VARCHAR(4),
    PRIMARY KEY (DR_NO, Mocode),
    FOREIGN KEY (DR_NO) REFERENCES CrimeReports(DR_NO),
    FOREIGN KEY (Mocode) REFERENCES MOCODE_Description(Mocode)
) 