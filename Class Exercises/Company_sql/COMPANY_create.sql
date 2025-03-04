-- -----------------------------------------------------
-- Table EMPLOYEE
-- -----------------------------------------------------
DROP TABLE IF EXISTS EMPLOYEE ;

CREATE TABLE IF NOT EXISTS EMPLOYEE (
  SSN CHAR(9) NOT NULL,
  Fname VARCHAR(15) NOT NULL,
  Minit CHAR NULL,
  Lname VARCHAR(15) NOT NULL,
  Bdate DATE NULL,
  Address VARCHAR(30) NOT NULL,
  Sex CHAR NOT NULL,
  Salary DECIMAL(10,2) NULL,
  Super_ssn CHAR(9) NULL,
  Dno INT NOT NULL,
  PRIMARY KEY (SSN)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table DEPARTMENT
-- -----------------------------------------------------
DROP TABLE IF EXISTS DEPARTMENT ;

CREATE TABLE IF NOT EXISTS DEPARTMENT (
  Dnumber INT NOT NULL,
  Dname VARCHAR(15) NOT NULL,
  Mgr_ssn CHAR(9) NULL,
  Mgr_start_date DATE NULL,
  PRIMARY KEY (Dnumber),
  UNIQUE(Dname),
  FOREIGN KEY (Mgr_ssn) 
	REFERENCES EMPLOYEE (SSN)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table DEPT_LOCATIONS
-- -----------------------------------------------------
DROP TABLE IF EXISTS DEPT_LOCATIONS ;

CREATE TABLE IF NOT EXISTS DEPT_LOCATIONS (
  Dnumber INT NOT NULL,
  Dlocation VARCHAR(15) NOT NULL,
  PRIMARY KEY (Dnumber, Dlocation),
  FOREIGN KEY (Dnumber) 
	REFERENCES DEPARTMENT (Dnumber)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table PROJECT
-- -----------------------------------------------------
DROP TABLE IF EXISTS PROJECT ;

CREATE TABLE IF NOT EXISTS PROJECT (
  Pnumber INT NOT NULL,
  Pname VARCHAR(15) NOT NULL,
  Plocation VARCHAR(15) NULL,
  Dnum INT NOT NULL,
  PRIMARY KEY (Pnumber),
  UNIQUE(Pname),
  FOREIGN KEY (Dnum) 
	REFERENCES DEPARTMENT (Dnumber)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table WORKS_ON
-- -----------------------------------------------------
DROP TABLE IF EXISTS WORKS_ON ;

CREATE TABLE IF NOT EXISTS WORKS_ON (
  Essn CHAR(9) NOT NULL,
  Pno INT NOT NULL,
  Hours DECIMAL(3,1) NULL,
  PRIMARY KEY (Essn, Pno),
  FOREIGN KEY (Essn) 
	REFERENCES EMPLOYEE (SSN)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  FOREIGN KEY (Pno) 
	REFERENCES PROJECT (Pnumber)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table DEPENDENT
-- -----------------------------------------------------
DROP TABLE IF EXISTS DEPENDENT ;

CREATE TABLE IF NOT EXISTS DEPENDENT (
  Essn CHAR(9) NOT NULL,
  Dependent_name VARCHAR(15) NOT NULL,
  Sex CHAR NOT NULL,
  Bdate DATE NOT NULL,
  Relationship VARCHAR(8) NOT NULL,
  PRIMARY KEY (Essn, Dependent_name),
  FOREIGN KEY (Essn) 
	REFERENCES EMPLOYEE (SSN)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- CONSTRAINTS
-- -----------------------------------------------------
ALTER TABLE EMPLOYEE 
ADD CONSTRAINT fk_EMPLOYEE_EMPLOYEE
    FOREIGN KEY (Super_ssn) 
		REFERENCES EMPLOYEE (SSN)
		ON DELETE NO ACTION
		ON UPDATE CASCADE;
    
ALTER TABLE EMPLOYEE 
ADD CONSTRAINT fk_EMPLOYEE_DEPARTMENT2
    FOREIGN KEY (Dno)
		REFERENCES DEPARTMENT (Dnumber)
		ON DELETE NO ACTION
		ON UPDATE CASCADE;
