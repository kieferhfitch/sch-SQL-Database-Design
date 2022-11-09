--Part B

--B.1 - Creating tables
--Creating table COFFEE_SHOP
CREATE TABLE COFFEE_SHOP (
    shop_id INT AUTO_INCREMENT,
    shop_name VARCHAR(50),
    city VARCHAR(50),
    `state` CHAR(2),
    PRIMARY KEY(shop_id)
);

--Creating table SUPPLIER
CREATE TABLE SUPPLIER (
    supplier_id INT AUTO_INCREMENT,
    company_name VARCHAR(50) NOT NULL,
    country VARCHAR(30) NOT NULL,
    sales_contact_name VARCHAR(60) NOT NULL,
    email VARCHAR(50) NOT NULL,
    PRIMARY KEY(supplier_id)
);

--Creating table COFFEE
CREATE TABLE COFFEE (
    coffee_id INT AUTO_INCREMENT,
    shop_id INT,
    supplier_id INT,
    coffee_name VARCHAR(30),
    price_per_pound NUMERIC(5,2),
    PRIMARY KEY(coffee_id),
    FOREIGN KEY(shop_id)
      REFERENCES COFFEE_SHOP(shop_id),
    FOREIGN KEY(supplier_id)
      REFERENCES SUPPLIER(supplier_id)
);

--Creating table EMPLOYEE
CREATE TABLE EMPLOYEE (
    employee_id INT AUTO_INCREMENT,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    hire_date DATE,
    job_title VARCHAR(30),
    shop_id INT,
    PRIMARY KEY(employee_id),
    FOREIGN KEY(shop_id)
      REFERENCES COFFEE_SHOP(shop_id)
);

--B.2 - Inserting rows into the databases
--Inserting rows into COFFEE_SHOP
INSERT INTO COFFEE_SHOP
    (shop_name, city, `state`)
VALUES
    ("The Coffee Bean & Tea Leaf", "Los Angeles", "CA"),
    ("Biggby Coffee", "East Lansing", "MI"),
    ("Tim Hortons", "Evans Mills", "NY")
;

--Inserting rows into SUPPLIER
INSERT INTO SUPPLIER
    (company_name, country, sales_contact_name, email)
VALUES
    ("Bean Express", "United States", "Michael Jones", "michael.jones@beanexpress.com"),
    ("Coffee Co", "United States", "Julie Hargrove", "julie.hargrove@coffeeco.com"),
    ("Brew it!", "United States", "Dana Newport", "dana.newport@brewit.com")
;

--Inserting rows into COFFEE
INSERT INTO COFFEE
    (shop_id, supplier_id, coffee_name, price_per_pound)
VALUES
    (1, 1, "Chocolate Bean", 4.99),
    (2, 2, "Caramel Dream", 3.99),
    (3, 3, "Vanilla Bean", 4.49)
;

--Inserting rows into EMPLOYEE
INSERT INTO EMPLOYEE
    (first_name, last_name, hire_date, job_title, shop_id)
VALUES
    ("Jake", "Alston", '2018-05-01', "Barista", 1),
    ("Layla", "Herring", '2020-01-15', "Manager", 2),
    ("Eli", "Cruze", '2017-08-10', "Barista", 3)
;

--B.3 - Create a view of all attributes in EMPLOYEE concatenatiing first_name and last_name
CREATE VIEW EMPLOYEE_VIEW AS
SELECT
    employee_id,
    CONCAT(first_name, " ", last_name) AS employee_full_name,
    hire_date, job_title,
    shop_id
FROM EMPLOYEE
;

--B.4 - Create an index on the coffee_name from the COFFEE table
CREATE INDEX idx_coffee_name
ON COFFEE(coffee_name)
;

--B.5 - Create a SFW query for a table or view
SELECT coffee_name
FROM COFFEE
WHERE price_per_pound > 4.00
;

--B.6 - Create a query that joins three different tables together with attributes from all three
SELECT
    COFFEE_SHOP.shop_name AS "Shop Name",
    COFFEE.coffee_name AS "Coffee Name",
    COFFEE.price_per_pound AS "Price Per Pound",
    SUPPLIER.company_name AS "Supplier"
FROM COFFEE
JOIN COFFEE_SHOP
ON COFFEE.shop_id = COFFEE_SHOP.shop_id
JOIN SUPPLIER
ON COFFEE.supplier_id = SUPPLIER.supplier_id
;