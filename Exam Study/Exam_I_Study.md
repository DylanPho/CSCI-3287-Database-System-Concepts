# Database Fundamentals Exam I Study Guide

## Chapter 1: Introduction to Databases (Skip 1.7)

### Topics to Study

- **1.1 Introduction** – Overview of databases, their purpose, and why they are important.
  - <mark>A database is a structured collection of data that enables efficient storage, retrieval, and management.
- **1.2 Characteristics of the Database Approach** – How databases improve efficiency compared to traditional file systems.
  - <mark> A database provides a structured way of handling data, ensuring security, integrity, and easy accessibility.
- **1.3 Database Users** – Different types of users, including database administrators (DBAs), developers, and end-users.
  - <mark>Includes Database Administrators (DBAs) who maintain the system, Application Developers who build software, and End-Users who retrieve and manipulate data.
- **1.4 Advantages of Using the Database Approach** – Key benefits like improved data integrity, security, and concurrency.
  - <mark>**Data Integrity**: Ensures accuracy and consistency.
  - <mark>**Security**: Controls access via authentication.
  - <mark>**Concurrency**: Allows multiple users to access data simultaneously.
- **1.5 When Not to Use a DBMS** – Scenarios where databases might not be the best option.
  - <mark>In small-scale projects with limited data, using a DBMS may be unnecessary due to complexity.
- **1.6 Data Models, Schemas, and Instances** – Understanding the three-schema architecture.
  - <mark>A schema defines the database structure, while an instance is a snapshot of the current data.
  
### Example
A bank database consists of a table called `Customers`:
```
CREATE TABLE CUstomers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Balance DECIMAL(10,2)
);
```
- **Schema**: Table structure.
- **Instance**: Actual data in the table
  
### Practice Questions
1. **What is the difference between a schema and an instance?**
   -    **Answer**: <mark> A schema defines the structure of the database, while an instance is the data current;y stored.

**Scenario**: A company wants to store employee records, including their names, addresses, and salaries. How would a DBMS improve efficiency over a traditional file-based system?

**Answer**: <mark>A DBMS allows centralized data management, reducing redundancy, ensuring consistency, and supporting concurrent access, unlike a file-based system where data duplication is common.

**Q**: What are two advantages of using a DBMS over a file-based system? **A**: <mark>(1) Reduces data redundancy, (2) Enhances data integrity and security.

### Topics to Disregard
- **1.7 Database Management System Architecture** – Skip this section.

## Chapter 2: Database System Concepts and Architecture
### Topics to Study
- **2.1 Data Models** – Different ways to represent data:
  - <mark>**Relational Model** (Tables)
  - <mark>**Hierarchical Model** (Tree structure)
  - <mark>**Network Model** (Graph-like)
- **2.2 Database System Architecture** – Three-schema architecture:
  - <mark>**Internal Level**: Physical storage.
  - <mark>**Conceptual Level**: Logical database design.
  - <mark>**External Level**: Views for users.
- **2.3 Data Independence** – Separation of schema and data storage.
  
- **2.4 Database Languages and Interfaces** – SQL for querying, relational algebra for logical data retrieval.
  
- **2.5 The Database System Environment** – Components like transaction management and concurrency control.
  
- **2.6 Centralized vs. Distributed DBMSs** – A **centralized** system has a single database, while a **distributed** DBMS spreads data across multiple locations.

### Example
SQL Query to retireve data from a relational model:
```
SELECT Name FROM Customers WHERE Balance > 1000;
```

**Schema Example**: Consider a database with a table `Students`:
```
Students(StudentID, Name, Age, Major)
```
  - `StudentID` is the **Primary Key** (ensures uniqueness).
  - `Major` should reference a `Departments` table via **Foreign Key**.

### Practice Question
2. **What are the three levels of database architecture?**
   - **Answer**: Internal, Conceptual, and External levels.

**Q**: <mark>What type of key should be used to uniquely identify each student in a database?

**A**: <mark>Primary Key (e.g., StudentID).

## Chapter 3: The Relational Model (Skip 3.8, 3.9)
### Topics to Study
- **3.1 Overview of the Relational Model** – Organizes data into tables (relations).
  
- **3.2 Relational Model Concepts** – Tables (relations), rows (tuples), and columns (attributes).
  - <mark>**Tuples (Rows), Attributes (Columns), Relations (Tables)**.
- **3.3 Constraints and Keys** – Primary keys, foreign keys, and relational integrity.
  - <mark>**Primary Key**: Uniquely identifies a record.
  - <mark>**Foreign Key**: Establishes relationships between tables.
- **3.4 Schema and Instance** – A database schema is predefined; instances change over time.
  
- **3.5 Relational Algebra** – Selection (σ), projection (π), and joins (⨝).

- **3.6 Relational Calculus** – Mathematical approach to query formulation.
  
- **3.7 Operations on Relations** – Insert, delete, and update operations.
  
### Example 
A `Students` table:
```
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Major VARCHAR(50)
);
```

### Practice Question
3. **What is the difference between a primary key and a foreign key?**
   - **Answer**: A primary key uniquely identifies a recrod, while a foreign key establishes a relationship between two tables.

### Topics to Disregard
- **3.8 Views** – Skip this section.
- **3.9 Transactions and Securit** – Skip this section.

## Chapter 4: Enhanced Entity-Relationship (EER) Model (Skip 4.6, 4.7)
### Topics to Study
- **4.1 ER Model Concepts** – Entities, attributes, relationships.
  
- **4.2 ER Diagrams** – Visual representation of database schemas.
  
- **4.3 Constraints in ER Models** – Cardinality, participation constraints.
  
- **4.4 Specialization and Generalization** – Hierarchical relationships between entities.
  - <mark>**Generalization**: Grouping similar entities into a parent entity.
  - <mark>**Specialization**: Creating subtypes from a parent entity.
- **4.5 Aggregation** – Higher-level abstraction for relationships.

### Example
ER Diagram for a University:
  - **Entity**: `Students`
  - **Attributes**: `StudentsID`, `Name`
  - **Relationships**: `Enrolled` in `Courses`

### Practice Question
4. **What is the differences between generalization and specialization?**
   - **Answer**: <mark>Generalization groups entities into a higher-level entity, while specialization breaks an entity into subtypes.

### Topics to Disregard
- **4.6 Concepts of UML Notation** – Skip this section.
- **4.7 ER-to-Relational Mapping** – Skip this section.

## Chapter 5: Relational Algebra and SQL
### Topics to Study
- **5.1 Overview of Relational Algebra** – Foundation for SQL queries.
  - <mark>**Selection (σ)**: Filters rows.
  - <mark>**Projection (π)**: Selects columns.
  - <mark>**Join (⨝)**: Combines tables.
- **5.2 SQL Basics** – SELECT, INSERT, UPDATE, DELETE commands.
  
- **5.3 Advanced SQL Queries** – Nested queries, joins, and set operations.
  
- **5.4 Constraints and Triggers** – How to enforce business rules in SQL.
  
- **5.5 Views and Indexes** – Optimizing performance.

### Example
Retrieve employees earning more than $50,000:
```
SELECT Name FROM Employees WHERE Salary > 50000;
```

### Practice Question
5. **What does the following qury do?**
   ```
   SELECT COUNT(*) FROM Orders;
   ```
   - **Answer**: <mark>Counts the total number of orders.

## Chapter 8: Relational Algebra and Relational Calculus (Skip 8.6, 8.7)
### Topics to Study
- **8.1 Unary Relational Operations** – SELECT, PROJECT operations.
- **8.2 Binary Relational Operations** – JOIN, UNION, INTERSECTION.
- **8.3 Aggregate Functions and Grouping** – COUNT, SUM, AVG in SQL.
- **8.4 The Tuple Relational Calculus** – Expression of queries without specifying an explicit procedure.
- **8.5 The Domain Relational Calculus** – A more abstract form of query language.

### Topics to Disregard
- **8.6 Query-by-Example (QBE)** – Skip this section.
- **8.7 Formal Query Languages** – Skip this section.

## Crow’s Foot ER Diagram
### Topics to Study
- **Basics of Crow’s Foot Notation** – Visualizing one-to-one (1:1), one-to-many (1:M), and many-to-many (M:N) relationships.
  - Relationships:
    - <mark>**One-to-Many (1:M)**: A customer can place many orders.
    - <mark>**Many-to-Many (M:N)**: Students enroll in multiple courses.
- **Symbols in Crow’s Foot Diagrams** – Understanding crows' foot symbols and their meanings.
  - Symbols:
    - <mark>**Crow’s foot** = Many.
    - <mark>**Single line** = One.
- **Mapping ER Diagrams to Relational Models** – Translating diagrams into tables.

### Example:
A `Students` table linked to `Courses` through an enrollment table.

### Practice Question
7. **What does a crow's foot symbol indicate?**
   - **Answer**: <amrk>A "many" relationship