-- Dylan Phoutthavong
-- March 18th, 2025
-- CSCI 3287

-- 1) Create the Restaurant Database with constraints (Primary key, Foreign key and Unique).
-- NOTE: 
    -- 1. The Cuisine name and the Interaction Title must be unique values.
    -- 2. The Rating value in the User_Feedback table is a value between 1 and 5 but can also be NULL. The value is only used for INteractions of type "Review"
    -- 3. Use Auto_Increment for the IDs PKs that are not member of an identifying relationship.
ALTER TABLE restaurant ADD PRIMARY KEY (Id);
ALTER TABLE cuisine ADD PRIMARY KEY (Id);
ALTER TABLE interaction ADD PRIMARY KEY (Id);
ALTER TABLE user ADD PRIMARY KEY (Id);
ALTER TABLE cuisine_restaurant ADD FOREIGN KEY (Cuisine) REFERENCES cuisine(Id);
ALTER TABLE cuisine_restaurant ADD FOREIGN KEY (Restaurant) REFERENCES restaurant(Id);
ALTER TABLE interaction ADD UNIQUE (Title);
ALTER TABLE user ADD UNIQUE (email);


-- 2) Create the inserts to populate the database
create table if not exists restaurant (
    Id int,
    Name varchar(50),
    Address varchar(50),
    Phone varchar(50),
    Email varchar(50)
);
INSERT INTO restaurant (Id, Name, Address, Phone, Email) VALUES 
(1, 'TutoDolce', '964-1564 Lorem, Ave', '(853) 683-9146', 'gravida.sagittis@outlook.couk'),
(2, 'Pasta Bowl', 'P.O. Box 628, 2749 Eget Avenue', '(483) 177-6909', 'cras.vehicula.aliquet@yahoo.org'),
(3, 'Soup and Sabor',  'Ap #815-8970 Risus. Ave', '(386) 951-9878', 'vitae.risus@hotmail.com'),
(4, 'SeaLand', '417-1668 Ultricies Ave', '(857) 722-5734', 'laoreet.lectus@google.net'),
(5, 'Sandwich King', '809-2246 Sapien Ave', '(363) 613-1266', 'quisque.porttitor.eros@outlook.com'),
(6, 'Pasta Bowl', '123 Noname Start St', '(123) 456-7890', 'support@example.com');

create table if not exists cuisine_restaurant (
    Cuisine int,
    Restaurant int
);
INSERT INTO cuisine_restaurant (Cuisine, Restaurant) VALUES 
(7, 5),
(7, 6),
(7, 6),
(5, 2),
(4, 3),
(3, 2),
(6, 1),
(7, 4),
(3, 6),
(3, 6),
(3, 2),
(4, 5),
(4, 3),
(3, 6),
(6, 5),
(6, 6),
(6, 1),
(6, 2),
(5, 1),
(5, 5);
-- remove any duplicate rows
DELETE c1 FROM cuisine_restaurant c1
INNER JOIN cuisine_restaurant c2 
WHERE c1.Cuisine = c2.Cuisine AND c1.Restaurant = c2.Restaurant AND c1.Id > c2.Id;

create table if not exists cuisine (
    Id int,
    Cuisine varchar(50)
);
INSERT into cuisine (Id, Cuisine) VALUES 
(1, 'Italian'),
(2, 'Mexican'),
(3, 'Thai'),
(4, 'French'),
(5, 'Indian'),
(6, 'Japanese'),
(7, 'American'),
(8, 'Chinese');

create table if not exists interaction (
    Id int,
   Title varchar(50)
);
INSERT into interaction (Id, Title) VALUES 
(1, 'Click'),
(2, 'Like'),
(3, 'Review');

create table if not exists user (
    Id int,
    First_name varchar(50),
    Last_name varchar(50),
    email varchar(50),
    Gender varchar(50)
);
INSERT into user (Id, First_name, Last_name, email, Gender) VALUES 
(1, 'Rahim', 'Mcdowell', 'at@hotmail.couk', 'Other'),
(2, 'Colette', 'Martinez', 'enim.suspendisse.aliquet@outlook.net', 'Female'),
(3, 'Alyssa', 'Nielsen', 'fermentum@yahoo.ca', 'Female'),
(4, 'Anne', 'Wilder', 'ut.odio.vel@outlook.edu', 'Female'),
(5, 'Ulysses', 'Hoover', 'ridiculus.mus.donec@yahoo.com', 'Other'),
(6, 'MacKenzie', 'Slater', 'pede.nunc.sed@yahoo.edu', 'Male'),
(7, 'Hall', 'Cabrera', 'tempor.lorem@protonmail.com', 'Other'),
(8, 'Judah', 'Richmond', 'nunc.sit.amet@hotmail.couk', 'Male'),
(9, 'Imani', 'Torres', 'nec.ante@icloud.edu', 'Female'),
(10, 'Tate', 'Boyd', 'integer.vitae@protonmail.net', 'Female');

-- 3) Write a transaction to update the name of a restuarant to "SpiceThing"
START TRANSACTION;
UPDATE restaurant
SET Name = 'SpiceThing'
WHERE Id = 1;
COMMIT;

-- 4) Write a query to show the total rating (Review) per restaurant and the average rating. Display the restaurant name, the total and average ratings.
SELECT r.Name, COUNT(i.Title) as Total, AVG(i.Title) as Average
FROM restaurant r
JOIN interaction i
ON r.Id = i.Id
GROUP BY r.Name;

-- 5) Write a query to count the number of restaurants by cuisine. Display the cusine name and total count.
SELECT c.Cuisine, COUNT(cr.Restaurant) as Total
FROM cuisine c
JOIN cuisine_restaurant cr
ON c.Id = cr.Cuisine
GROUP BY c.Cuisine;