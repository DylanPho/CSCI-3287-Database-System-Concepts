-- Dylan Phoutthavong
-- March 12th, 2025
-- CSCI 3287

-- 4. Add constraints (PRIMARY KEY and FOREIGN KEY)

-- Primart Keys
ALTER TABLE patients ADD PRIMARY KEY (id);
ALTER TABLE encounters ADD PRIMARY KEY (id);
ALTER TABLE organizations ADD PRIMARY KEY (id);
ALTER TABLE payers ADD PRIMARY KEY (id);

-- Foreign Keys
ALTER TABLE encounters ADD FOREIGN KEY (patient) REFERENCES patients(id) ON DELETE CASCADE;
ALTER TABLE encounters ADD FOREIGN KEY (payer) REFERENCES payers(id);ON DELETE CASCADE;
ALTER TABLE procedures ADD FOREIGN KEY (encounter_id) REFERENCES patient(id) ON DELETE CASCADE;
ALTER TABLE procedures ADD FOREIGN KEY (encounter_id) REFERENCES encounters(id) ON DELETE CASCADE;

-- 5. When we import a dataset, the system will “guess” the data type for each column. Modify the columns BASE_ENCOUNTER_COST, TOTAL_CLAIM_COST and PAYER_COVERAGE from varchar to DECIMAL(16,2).
-- ALTER TABLE <tablename> MODIFY <columnname> DECIMAL(<num integers>,<num decimal points>);
ALTER TABLE encounters MODIFY BASE_ENCOUNTER_COST DECIMAL(16,2);
ALTER TABLE encounters MODIFY TOTAL_CLAIM_COST DECIMAL(16,2);
ALTER TABLE encounters MODIFY PAYER_COVERAGE DECIMAL(16,2);

-- 6. The columns START (encounters table) is of type varchar (ex: ‘2016-08-09T15:38:00Z’). The datetime format is not valid for MySQL. We need to convert the content to ‘2016-08-09 15:38:00’.
UPDATE encounters
SET START = REPLACE(SUBSTRING_INDEX(START, 'Z', 1), 'T', ' ');

-- 7. Modify the START column to DATETIME
ALTER TABLE encounters MODIFY START DATETIME;

-- 8. Repeat the process above to modify column STOP to DATETIME
UPDATE encounters
SET STOP = REPLACE(SUBSTRING_INDEX(STOP, 'Z', 1), 'T', ' ');

-- 9. In encounters table, create a new column PATIENT_COVERAGE of type DECIMAL(16.2). Use the parameter “AFTER PAYER_CODE” to create the column in that position.
ALTER TABLE encounters ADD PATIENT_COVERAGE DECIMAL(16,2) AFTER CODE;

-- 10. Update the new column PATIENT_COVERAGE with the value from TOTAL_CLAIM_COST - PAYER_COVERAGE
UPDATE encounters
SET PATIENT_COVERAGE = TOTAL_CLAIM_COST - PAYER_COVERAGE;

-- 11. We want modify columns BIRTHDATE and DEATHDATE to type DATE. However, the year has only two digits. If we try to convert the dates, MySQL specification says that Year values in the range 00-69 become 2000-2069, and Year values in the range 70-99 become 1970-1999. So, a patient born in 7/25/33 would be converted to 7/25/2033.
-- This query splits the current varchar date into individual items (month, day, year):
        -- select
        -- SUBSTRING_INDEX(BIRTHDATE, '/', 1) as month,
        -- SUBSTRING_INDEX(SUBSTRING_INDEX(BIRTHDATE, '/', 2), '/', -1) as day,
        -- SUBSTRING_INDEX(SUBSTRING_INDEX(BIRTHDATE, '/', 3), '/', -1) as year
        -- from patients
--You can use the CASE-WHEN option to fix the year. Use the following rules:
    -- year between 00 and 10, concatenate '20' in front of the year
    -- year BETWEEN 11 and 99, concatenate '19' in front of the year
-- This query shows how to convert a string to date format.
        -- SELECT STR_TO_DATE('03/11/2025', '%m/%d/%Y')
-- Update the content of the column BIRTHDATE and DEATHDATE and modify the type of the columns to DATE.

--Extend the column size to 15
ALTER TABLE patients MODIFY BIRTHDATE VARCHAR(15);

-- Update the column
UPDATE patients
SET BIRTHDATE = STR_TO_DATE(CONCAT(
    CASE
        WHEN SUBSTRING_INDEX(BIRTHDATE, '/', -1) BETWEEN 00 AND 10 THEN CONCAT('20', SUBSTRING_INDEX(BIRTHDATE, '/', -1))
        ELSE CONCAT('19', SUBSTRING_INDEX(BIRTHDATE, '/', -1))
    END,
    '/',
    SUBSTRING_INDEX(BIRTHDATE, '/', 1),
    '/',
    SUBSTRING_INDEX(SUBSTRING_INDEX(BIRTHDATE, '/', 2), '/', -1)
), '%Y/%m/%d');

-- Modify the column
ALTER TABLE patients MODIFY BIRTHDATE DATE;

--Extend the column size to 15
ALTER TABLE patients MODIFY DEATHDATE VARCHAR(15);

-- Update the column to NULL if the value is empty
UPDATE patients SET DEATHDATE = NULL WHERE DEATHDATE = '' OR DEATHDATE = '//';

-- Update the column
UPDATE patients
SET DEATHDATE = STR_TO_DATE(CONCAT(
    CASE
        WHEN SUBSTRING_INDEX(DEATHDATE, '/', -1) BETWEEN 00 AND 10 THEN CONCAT('20', SUBSTRING_INDEX(DEATHDATE, '/', -1))
        ELSE CONCAT('19', SUBSTRING_INDEX(DEATHDATE, '/', -1))
    END,
    '/',
    SUBSTRING_INDEX(DEATHDATE, '/', 1),
    '/',
    SUBSTRING_INDEX(SUBSTRING_INDEX(DEATHDATE, '/', 2), '/', -1)
), '%Y/%m/%d');

-- Modify the column
ALTER TABLE patients MODIFY DEATHDATE DATE;

-- 12. Write a query to display the encounters grouped by patients. Provide the count of encounters per patient and the sum of all PATIENT_COVERAGE values.
SELECT patient, COUNT(*) as encounters, SUM(PATIENT_COVERAGE) as total_patient_coverage
FROM encounters
GROUP BY patient;

-- 13. Write a query to inform the code and description of the top procedure covered by each payer. Note that the PAYER_COVERED must have a value greater than zero to be considered a payer covered.
SELECT e.Id, e.CODE, e.DESCRIPTION, e.PAYER_COVERAGE
FROM encounters e
JOIN (
    -- Get the top PAYER_COVERED value for each payer
    SELECT Id, MAX(PAYER_COVERAGE) AS MAX_COVERED
    FROM encounters
    WHERE PAYER_COVERAGE > 0
    GROUP BY id
) max_proc
ON e.Id = max_proc.id AND e.PAYER_COVERAGE = max_proc.MAX_COVERED
ORDER BY e.Id;

-- 14. Write a query to find the most expensive claim for each encounter class (ex: urgentcare, ambulatory, etc). Provide the code and description.
SELECT e.ENCOUNTERCLASS, p.CODE, p.DESCRIPTION, e.TOTAL_CLAIM_COST
FROM encounters e
JOIN procedures p ON e.Id = p.ENCOUNTER  -- Correcting the join condition
JOIN (
    -- Get the highest TOTAL_CLAIM_COST for each encounter class
    SELECT ENCOUNTERCLASS, MAX(TOTAL_CLAIM_COST) AS MAX_CLAIM
    FROM encounters
    WHERE TOTAL_CLAIM_COST > 0
    GROUP BY ENCOUNTERCLASS
) max_enc
ON e.ENCOUNTERCLASS = max_enc.ENCOUNTERCLASS 
AND e.TOTAL_CLAIM_COST = max_enc.MAX_CLAIM
ORDER BY e.ENCOUNTERCLASS;

-- 15. Write a query to find what patient uses the greatest number of payers. For example, a patient may use only Medicare, while others may use different payers such as Medicare, Cigna Health, etc.  Provide the name of the patient and the name of the payers.
WITH top_patient AS (
    -- Find the patient with the highest number of distinct payers
    SELECT p.Id, p.FIRST, p.LAST, COUNT(DISTINCT e.PAYER) AS num_payers
    FROM patients p
    JOIN encounters e ON p.Id = e.PATIENT
    GROUP BY p.Id, p.FIRST, p.LAST
    ORDER BY num_payers DESC
    LIMIT 1
)
SELECT DISTINCT tp.FIRST, tp.LAST, py.NAME AS payer_name  -- DISTINCT removes duplicates
FROM top_patient tp
JOIN encounters e ON tp.Id = e.PATIENT
JOIN payers py ON e.PAYER = py.Id
ORDER BY tp.LAST, py.NAME;
