-- -----------------------------------------------------
-- DEPARTMENT
-- -----------------------------------------------------
INSERT INTO DEPARTMENT (Dnumber, Dname, Mgr_ssn, Mgr_start_date) VALUES 
(1, 'Headquarters', NULL, '1981-06-19');
INSERT INTO DEPARTMENT (Dnumber, Dname, Mgr_ssn, Mgr_start_date) VALUES 
(4, 'Administration', NULL, '1995-01-01');
INSERT INTO DEPARTMENT (Dnumber, Dname, Mgr_ssn, Mgr_start_date) VALUES 
(5, 'Research', NULL, '1988-05-22');

-- -----------------------------------------------------
-- DEPT_LOCATIONS
-- -----------------------------------------------------
INSERT INTO DEPT_LOCATIONS (Dnumber, Dlocation) VALUES (1, 'Houston');
INSERT INTO DEPT_LOCATIONS (Dnumber, Dlocation) VALUES (4, 'Stafford');
INSERT INTO DEPT_LOCATIONS (Dnumber, Dlocation) VALUES (5, 'Bellaire');
INSERT INTO DEPT_LOCATIONS (Dnumber, Dlocation) VALUES (5, 'Sugarland');
INSERT INTO DEPT_LOCATIONS (Dnumber, Dlocation) VALUES (5, 'Houston');

-- -----------------------------------------------------
-- EMPLOYEE
-- -----------------------------------------------------
INSERT INTO EMPLOYEE (SSN, Fname, Minit, Lname, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES 
('888665555', 'James', 'E', 'Bog', '1937-11-10', '450 Stone, Houston, TX', 'M', 55000, NULL, 1);
INSERT INTO EMPLOYEE (SSN, Fname, Minit, Lname, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES 
('333445555', 'Franklin', 'T', 'Wong', '1955-12-08', '638 Voss, houston, TX', 'M', 40000, '888665555', 5);
INSERT INTO EMPLOYEE (SSN, Fname, Minit, Lname, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES 
('123456789', 'John', 'B', 'Smith', '1965-01-09', '731 Fondren, Houston, TX', 'M', 30000, '333445555', 5);
INSERT INTO EMPLOYEE (SSN, Fname, Minit, Lname, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES 
('987654321', 'Jennifer', 'S', 'Wallace', '1941-06-20', '291 Berry, Bellaire, TX', 'F', 43000, '888665555', 4);
INSERT INTO EMPLOYEE (SSN, Fname, Minit, Lname, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES 
('999887777', 'Alicia', 'J', 'Zelaya', '1968-01-19', '3321 Castle, Spring, TX', 'F', 25000, '987654321', 4);
INSERT INTO EMPLOYEE (SSN, Fname, Minit, Lname, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES 
('987987987', 'Ahmad', 'V', 'Jabbar', '1969-03-29', '980 Dallas, Houston, TX', 'M', 25000, '987654321', 4);
INSERT INTO EMPLOYEE (SSN, Fname, Minit, Lname, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES 
('453453453', 'Joyce', 'A', 'English', '1972-07-31', '5631 Rice, Houston, TX', 'F', 25000, '333445555', 5);
INSERT INTO EMPLOYEE (SSN, Fname, Minit, Lname, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES 
('666884444', 'Ramesh', 'K', 'Narayan', '1962-09-15', '975 Fire Oak, Humble, TX', 'M', 38000, '333445555', 5);

-- -----------------------------------------------------
-- DEPDENDENT
-- -----------------------------------------------------
INSERT INTO DEPENDENT (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES 
('333445555', 'Alice', 'F', '1986-04-05', 'Daughter');
INSERT INTO DEPENDENT (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES 
('333445555', 'Theodore', 'M', '1983-10-25', 'Son');
INSERT INTO DEPENDENT (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES 
('333445555', 'Joy', 'F', '1958-05-03', 'Spouse');
INSERT INTO DEPENDENT (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES 
('987654321', 'Abner', 'M', '1942-02-28', 'Spouse');
INSERT INTO DEPENDENT (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES 
('123456789', 'Michael', 'M', '1988-01-04', 'Son');
INSERT INTO DEPENDENT (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES 
('123456789', 'Alice', 'F', '1988-12-30', 'Daughter');
INSERT INTO DEPENDENT (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES 
('123456789', 'Elizabeth', 'F', '1967-05-05', 'Spouse');

-- -----------------------------------------------------
-- PROJECT
-- -----------------------------------------------------
INSERT INTO PROJECT (Pnumber, Pname, Plocation, Dnum) VALUES (1, 'ProductX', 'Bellaire', 5);
INSERT INTO PROJECT (Pnumber, Pname, Plocation, Dnum) VALUES (2, 'ProductY', 'Sugarland', 5);
INSERT INTO PROJECT (Pnumber, Pname, Plocation, Dnum) VALUES (3, 'ProductZ', 'Houston', 5);
INSERT INTO PROJECT (Pnumber, Pname, Plocation, Dnum) VALUES (10, 'Computerization', 'Stafford', 4);
INSERT INTO PROJECT (Pnumber, Pname, Plocation, Dnum) VALUES (20, 'Reorganization', 'Houston', 1);
INSERT INTO PROJECT (Pnumber, Pname, Plocation, Dnum) VALUES (30, 'Newbenefits', 'Stafford', 4);

-- -----------------------------------------------------
-- WORKS_ON
-- -----------------------------------------------------
INSERT INTO WORKS_ON (Essn, Pno, Hours) VALUES ('123456789', 1, 32.5);
INSERT INTO WORKS_ON (Essn, Pno, Hours) VALUES ('123456789', 2, 7.5);
INSERT INTO WORKS_ON (Essn, Pno, Hours) VALUES ('666884444', 3, 40.0);
INSERT INTO WORKS_ON (Essn, Pno, Hours) VALUES ('453453453', 1, 20.0);
INSERT INTO WORKS_ON (Essn, Pno, Hours) VALUES ('453453453', 2, 20.0);
INSERT INTO WORKS_ON (Essn, Pno, Hours) VALUES ('333445555', 2, 10.0);
INSERT INTO WORKS_ON (Essn, Pno, Hours) VALUES ('333445555', 3, 10.0);
INSERT INTO WORKS_ON (Essn, Pno, Hours) VALUES ('333445555', 10, 10.0);
INSERT INTO WORKS_ON (Essn, Pno, Hours) VALUES ('333445555', 20, 10.0);
INSERT INTO WORKS_ON (Essn, Pno, Hours) VALUES ('999887777', 30, 30.0);
INSERT INTO WORKS_ON (Essn, Pno, Hours) VALUES ('999887777', 10, 10.0);
INSERT INTO WORKS_ON (Essn, Pno, Hours) VALUES ('987987987', 10, 35.0);
INSERT INTO WORKS_ON (Essn, Pno, Hours) VALUES ('987987987', 30, 5.0);
INSERT INTO WORKS_ON (Essn, Pno, Hours) VALUES ('987654321', 30, 20.0);
INSERT INTO WORKS_ON (Essn, Pno, Hours) VALUES ('987654321', 20, 15.0);
INSERT INTO WORKS_ON (Essn, Pno, Hours) VALUES ('888665555', 20, NULL);

-- -----------------------------------------------------
UPDATE DEPARTMENT SET Mgr_ssn = '333445555' WHERE Dnumber = 5;
UPDATE DEPARTMENT SET Mgr_ssn = '987654321' WHERE Dnumber = 4;
UPDATE DEPARTMENT SET Mgr_ssn = '888665555' WHERE Dnumber = 1;