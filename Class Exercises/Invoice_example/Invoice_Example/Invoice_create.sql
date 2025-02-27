
-- --------------------------------------------------------
-- CATEGORY
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS CATEGORY (
  Category_id 	INT NOT NULL,
  Category 		VARCHAR(45) NOT NULL,
  PRIMARY KEY (Category_id)
);

-- --------------------------------------------------------
-- PRODUCT
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS PRODUCT (
  Product_id 	INT NOT NULL,
  Description 	VARCHAR(45) NOT NULL,
  Category 		INT NOT NULL,
  Price 		DECIMAL NULL,
  PRIMARY KEY (Product_id),
  FOREIGN KEY (Category)
    REFERENCES CATEGORY (Category_id)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
);

-- --------------------------------------------------------
-- CLIENT
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS CLIENT (
  Client_id 	INT NOT NULL,
  Name 			VARCHAR(45) NULL,
  Address 		VARCHAR(45) NULL,
  City 			VARCHAR(45) NULL,
  State 		VARCHAR(2) NULL,
  PRIMARY KEY (Client_id)
);

-- --------------------------------------------------------
-- INVOICE
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS INVOICE (
  Invoice_number 	INT NOT NULL,
  Payment 			DECIMAL NULL,
  Client_id 		INT NOT NULL,
  PRIMARY KEY (Invoice_number),
  FOREIGN KEY (Client_id)
    REFERENCES CLIENT (Client_id)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
);

-- --------------------------------------------------------
-- ITEM
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS ITEM (
  Invoice_number 	INT NOT NULL,
  Product_id 		INT NOT NULL,
  Quantity 			INT NOT NULL,
  PRIMARY KEY (Invoice_number, Product_id),
  FOREIGN KEY (Invoice_number)
    REFERENCES INVOICE (Invoice_number)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  FOREIGN KEY (Product_id)
    REFERENCES PRODUCT (Product_id)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
);

