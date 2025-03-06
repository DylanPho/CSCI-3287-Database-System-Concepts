----------------------------------------------
-- Change Plocation and Dnum for project 10 --
----------------------------------------------
UPDATE PROJECT
SET PLOCATION='Bellaire',DNUM=5
WHERE PNUMBER=10;

--------------------------------------------------------------------------------
-- Change the salary of all employees in the 'Headquarters' department by 10% --
--------------------------------------------------------------------------------
UPDATE EMPLOYEE
SET SALARY=SALARY*1.1
WHERE DNO IN(SELECT DNUMBER
             FROM DEPARTMENT
             WHERE DNAME='Headquarters');

-------------------------------------------------------------
-- Query to find the birthdate and address of John B Smith --
-------------------------------------------------------------
SELECT Bdate, Address
FROM EMPLOYEE
WHERE Fname = 'John' AND Minit = 'B' AND Lname = 'Smith';

----------------------------------------------------------------------------------------------------
-- Query to find the sex and salary of all employees with a salary greater than or equal to 25000 --
----------------------------------------------------------------------------------------------------
SELECT DISTINCT Sex, Salary
FROM EMPLOYEE
WHERE Salary >= 25000;

------------------------------------------------------------------------------------------
-- Retrive the name and address of all employees who work for the 'Research' department --
------------------------------------------------------------------------------------------
SELECT Fname, Lname, Address
FROM EMPLOYEE, DEPARTMENT
WHERE Dname = 'Research' AND Dnumber = Dno;

-------------------------------------------------------------------------------------------
-- Retrieve thre name and department name of all employees that do not have a supervisor --
-------------------------------------------------------------------------------------------
SELECT Fname, Lname, Dname
FROM EMPLOYEE, DEPARTMENT
WHERE Super_ssn IS NULL AND Dno = Dnumber;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- For every project located in "Stafford", list the project number, the controlling deparment number, and the department manager's last name, address, and birthdate --
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT Pnumber, Dnum, Lname, Address, Bdate
FROM PROJECT, DEPARTMENT, EMPLOYEE
WHERE Dnum=Dnumber AND Mgr_ssn=SSN AND Plocation='Stafford';

-----------------------------------------------------------------------------------------------------------------------------------
-- For each employee, retrieve the empolyee's first and last name and the first and last name of his or her immediate supervisor --
-----------------------------------------------------------------------------------------------------------------------------------
SELECT E.Fname, E.Lname, S.Fname, S.Lname
FROM EMPLOYEE E, EMPLOYEE S
WHERE E.Super_ssn = S.SSN;

-- or --

SELECT E.Fname, E.Lname, S.Fname AS MGRFname, S.Lname AS MGRLname
FROM EMPLOYEE E, EMPLOYEE S
WHERE E.Super_ssn = S.SSN;

-- or --

SELECT *
FROM EMPLOYEE AS E, EMPLOYEE AS S
WHERE E.Super_ssn = S.SSN;

-- or --

SELECT E.*, S.Fname AS MGR
FROM EMPLOYEE AS E, EMPLOYEE AS S
WHERE E.Super_ssn = S.SSN; 

----------------------------------------------------------------------------------------------------------------
-- 
----------------------------------------------------------------------------------------------------------------

SELECT * FROM EMPLOYEE
WHERE Address LIKE '%Houston, TX';

SELECT * FROM EMPLOYEE
WHERE Ssn LIKE '___453___';