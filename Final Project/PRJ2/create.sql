-- PRJ2: Create Tables for Crime Reporting Database (Improved for MySQL)
-- Filename: create.sql

CREATE TABLE Area (
    AREA INT PRIMARY KEY,
    AREA_NAME VARCHAR(10)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Reporting_districts (
    Rpt_Dist_No INT PRIMARY KEY,
    AREA INT,
    FOREIGN KEY (AREA) REFERENCES Area(AREA)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Crime_premises (
    Premis_Cd INT PRIMARY KEY,
    Premis_Desc VARCHAR(45)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Weapon (
    Weapon_Used_Cd INT PRIMARY KEY,
    Weapon_Desc VARCHAR(45)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Status (
    Status VARCHAR(2) PRIMARY KEY,
    Status_Desc VARCHAR(45)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Crime_Code (
    Crm_Cd INT PRIMARY KEY,
    Crm_Cd_Desc VARCHAR(45),
    Part_1_2 INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE MOCODE_Description (
    Mocode VARCHAR(4) PRIMARY KEY,
    Mocode_Desc VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE CrimeReports (
    DR_NO INT PRIMARY KEY,
    Date_Rptd DATETIME,
    Date_OCC DATETIME,
    Time_OCC TIME,
    AREA INT,
    Vict_Age INT,
    Vict_Sex VARCHAR(1),
    Vict_Descent VARCHAR(1),
    Premis_Cd INT,
    Weapon_Used_Cd INT,
    Status VARCHAR(2),
    Location VARCHAR(45),
    Cross_Street VARCHAR(45),
    LAT FLOAT,
    LON FLOAT,
    FOREIGN KEY (AREA) REFERENCES Area(AREA),
    FOREIGN KEY (Premis_Cd) REFERENCES Crime_premises(Premis_Cd),
    FOREIGN KEY (Weapon_Used_Cd) REFERENCES Weapon(Weapon_Used_Cd),
    FOREIGN KEY (Status) REFERENCES Status(Status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Crime (
    DR_NO INT,
    Crm_Cd INT,
    Crime_Seriousness INT,
    PRIMARY KEY (DR_NO, Crm_Cd, Crime_Seriousness),
    FOREIGN KEY (DR_NO) REFERENCES CrimeReports(DR_NO),
    FOREIGN KEY (Crm_Cd) REFERENCES Crime_Code(Crm_Cd)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Crime_MOCodes (
    DR_NO INT,
    Mocode VARCHAR(4),
    PRIMARY KEY (DR_NO, Mocode),
    FOREIGN KEY (DR_NO) REFERENCES CrimeReports(DR_NO),
    FOREIGN KEY (Mocode) REFERENCES MOCODE_Description(Mocode)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;