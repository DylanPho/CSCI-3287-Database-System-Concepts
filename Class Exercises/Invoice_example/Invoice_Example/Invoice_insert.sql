-- --------------------------------------------------------
-- CATEGORY
-- --------------------------------------------------------
INSERT INTO CATEGORY (Category_id, Category) VALUES (1, 'Electronic');
INSERT INTO CATEGORY (Category_id, Category) VALUES (2, 'Furniture');
INSERT INTO CATEGORY (Category_id, Category) VALUES (3, 'Sports');
INSERT INTO CATEGORY (Category_id, Category) VALUES (4, 'Automotive');
INSERT INTO CATEGORY (Category_id, Category) VALUES (5, 'Books');

-- --------------------------------------------------------
-- PRODUCT
-- --------------------------------------------------------
INSERT INTO PRODUCT (Product_id, Description, Category, Price) VALUES (10, 'Watch', 1, 250);
INSERT INTO PRODUCT (Product_id, Description, Category, Price) VALUES (20, 'Computer', 1, 900);
INSERT INTO PRODUCT (Product_id, Description, Category, Price) VALUES (30, 'Bike', 3, 1200);
INSERT INTO PRODUCT (Product_id, Description, Category, Price) VALUES (40, 'Tire', 4, 200);
INSERT INTO PRODUCT (Product_id, Description, Category, Price) VALUES (50, 'Database', 5, 88);

-- --------------------------------------------------------
-- CLIENT
-- --------------------------------------------------------
INSERT INTO CLIENT (Client_id, Name, Address, City, State) VALUES (1, 'S-MART', '2389 Smart ln', 'Denver', 'CO');
INSERT INTO CLIENT (Client_id, Name, Address, City, State) VALUES (2, 'Have It All', '123 Warehouse st', 'Pueblo', 'CO');
INSERT INTO CLIENT (Client_id, Name, Address, City, State) VALUES (3, 'Everything++', '555 Storage ave', 'Topeka', 'KS');

-- --------------------------------------------------------
-- INVOICE
-- --------------------------------------------------------
INSERT INTO INVOICE (Invoice_number, Client_id, Payment) VALUES (1001, 1, 0);
INSERT INTO INVOICE (Invoice_number, Client_id, Payment) VALUES (1002, 2, 800);
INSERT INTO INVOICE (Invoice_number, Client_id, Payment) VALUES (1003, 3, 9000);
INSERT INTO INVOICE (Invoice_number, Client_id, Payment) VALUES (1004, 2, 2500);

-- --------------------------------------------------------
-- ITEM
-- --------------------------------------------------------
INSERT INTO ITEM (Invoice_number, Product_id, Quantity) VALUES (1001, 10, 3);
INSERT INTO ITEM (Invoice_number, Product_id, Quantity) VALUES (1001, 30, 1);
INSERT INTO ITEM (Invoice_number, Product_id, Quantity) VALUES (1002, 40, 4);
INSERT INTO ITEM (Invoice_number, Product_id, Quantity) VALUES (1003, 20, 10);
INSERT INTO ITEM (Invoice_number, Product_id, Quantity) VALUES (1004, 10, 10);
