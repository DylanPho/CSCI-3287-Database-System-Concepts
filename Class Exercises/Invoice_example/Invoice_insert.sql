---------------------------
---Create CATEGORY table---
---------------------------

CREATE TABLE IF NOT EXISTS CATEGORY (
    Category_id INT NOT NULL,
    Category_name VARCHAR(45) NOT NULL,
    PRIMARY KEY (Category_id)
);

---------------------------
---Create PRODUCT table---
---------------------------

CREATE TABLE IF NOT EXISTS PRODUCT (
    Product_id	INT NOT NULL,
    Description VARCHAR(45) NOT NULL,
    CATEGORY	INT NOT NULL,
    PRICE	DECIMAL NULL,
    PRIMARY KEY (Product_id),
    FOREIGN KEY (Category)
      REFERENCES CATEGORY (Category_id)
      ON DELETE NO ACTION
      ON UPDATE CASCADE
    );

---------------------------
---Create CLIENT table---
---------------------------
CREATE TABLE IF NOT EXISTS CLIENT (
    Client_id INT NOT NULL,
    Name VARCHAR(45) NOT NULL,
    Address VARCHAR(45) NOT NULL,
    City VARCHAR(45) NOT NULL,
    State VARCHAR(45) NOT NULL,
    PRIMARY KEY (Client_id)
);

---------------------------
---Create INVOICE table---
---------------------------
CREATE TABLE IF NOT EXISTS INVOICE (
    Invoice_id INT NOT NULL,
    Client_id INT NOT NULL,
    Invoice_date DATE NOT NULL,
    PRIMARY KEY (Invoice_id),
    FOREIGN KEY (Client_id)
      REFERENCES CLIENT (Client_id)
      ON DELETE NO ACTION
      ON UPDATE CASCADE
);

---------------------------
---Create ITEM table---
---------------------------
CREATE TABLE IF NOT EXISTS ITEM (
    Item_id INT NOT NULL,
    Invoice_id INT NOT NULL,
    Product_id INT NOT NULL,
    Quantity INT NOT NULL,
    PRIMARY KEY (Item_id),
    FOREIGN KEY (Invoice_id)
      REFERENCES INVOICE (Invoice_id)
      ON DELETE NO ACTION
      ON UPDATE CASCADE,
    FOREIGN KEY (Product_id)
      REFERENCES PRODUCT (Product_id)
      ON DELETE NO ACTION
      ON UPDATE CASCADE
);