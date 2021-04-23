--Constraints are some rectrictions for fields 
--1) Primary key
--2)Foreign key ==> Repeated data and multiple null are allowed
--3)Unique => Unique Data, but you can use "null" multiple times
--4) Not null ==> 
--5)Check 

--Create A workers table whose fields are below

CREATE TABLE workers (

    id CHAR(5),
    name VARCHAR2(50) UNIQUE,
    salary NUMBER(5) NOT NULL, --number (5,0) same with number (5),
    hiring_date date,
    CONSTRAINT id_pk PRIMARY KEY(id)
);
INSERT INTO workers VALUES('1001', 'Ali Can', 700, '13-Apr-18');
INSERT INTO workers VALUES('1002', null, 12000, '14-Apr-18');
INSERT INTO workers VALUES('1003', null, 5000, '15-Apr-18');
INSERT INTO workers VALUES('1004', 'Veli Han', 5000, '15-Apr-18');

SELECT * FROM workers;

CREATE TABLE adresses 
(
    id CHAR(5),
    street VARCHAR2(30),
    city VARCHAR2(15),
    state CHAR(2),
    CONSTRAINT id_fk FOREIGN KEY(id) REFERENCES workers(id)
);

INSERT INTO adresses VALUES('1001', 'Flower', 'Miami', 'FL');
INSERT INTO adresses VALUES('1001', 'Orange', 'Jacjsonwille', 'FL');
INSERT INTO adresses VALUES(null, 'Apple', 'Tampa', 'FL');
INSERT INTO adresses VALUES(null, 'Apricot', 'St. Lucie', 'FL');

SELECT * FROM adresses;


CREATE TABLE parent 
(
    id CHAR(5),
    num_of_kids NUMBER (2),
    name_of_spouse VARCHAR2(50),
    CONSTRAINT id1_fk FOREIGN KEY (id) REFERENCES workers(id),
    CONSTRAINT check_num_of_kids CHECK(num_of_kids>=0) --YOU CAN ERROR IF IT IS NOT JUIST
);

INSERT INTO parent VALUES ('1001', 4, 'Ayse');
INSERT INTO parent VALUES ('1002', -2, 'Emine');

SELECT * FROM parent;


CREATE TABLE suppliers 
(
    supplier_id NUMBER(10),
    supplier_name VARCHAR2(50),
    contact_name VARCHAR2(50),
    CONSTRAINT supplier_id_pk PRIMARY KEY(supplier_id)
)

INSERT INTO suppliers VALUES(1, 'IBM', 'jOHN wALKER');
INSERT INTO suppliers VALUES(2, 'APPLE', 'sTEVE mAX');
INSERT INTO suppliers VALUES(3, 'SAMSUNG', 'Tae SHAUN');

SELECT * FROM suppliers;

--hOW CAN we update A SPECIFIC data in a table
UPDATE suppliers
SET contact_name= 'Ali CAN'
WHERE supplier_id=1;

--How to update multiple data
UPDATE suppliers
SET supplier_name= 'Windows',
    contact_name = 'Mary Star'
WHERE supplier_id = 2;

--How to update multiple records in a table

UPDATE suppliers
SET contact_name= 'Veli han'
WHERE supplier_id>1;

--primary key ALSO can be updated
UPDATE suppliers
SET supplier_id =1
WHERE contact_name ='Ali CAN';

--Update the table to the beginning state
UPDATE suppliers
SET contact_name = 'John Walker'
WHERE supplier_id = 1;

UPDATE suppliers
SET supplier_name = 'APPLE',
    contact_name = 'Steve Max'
WHERE supplier_id = 2;

UPDATE suppliers
SET contact_name = 'Tae Shaun'
WHERE supplier_id = 3;


--Create 

CREATE TABLE products 
(
    supplier_id NUMBER (10),
    product_id NUMBER(10),
    product_name VARCHAR2(30),
    customer_name VARCHAR2(50),
    CONSTRAINT supplier_id_fk FOREIGN KEY(supplier_id) REFERENCES suppliers (supplier_id)
);

INSERT INTO products VALUES (1, 11, 'Laptop', 'Ali CAN');
INSERT INTO products VALUES (2, 22, 'Ipad', 'Eddie MURPHY');
INSERT INTO products VALUES (3, 33, 'Galaxy 12', 'MARY star');

SELECT * FROM products;

--CHANGE ALI CAN to john walker

UPDATE products
SET customer_name= 'John Walker'
WHERE supplier_id=1;

--we will update the name of the product to 'radio' if the customer names are same in suppliers tabel and 

UPDATE products
SET product_name= 'Radio'
WHERE products.customer_name= (SELECT contact_name
                                FROM suppliers
                                WHERE suppliers.contact_name= 'John Walker');

--Update the contact name to 'Ali Can' if the product name is Ipad

UPDATE suppliers 
SET contact_name = 'Ali Can'
WHERE supplier_id = (SELECT supplier_id
                                FROM products 
                                WHERE product_name= 'Ipad'
                                );

--Update the customer name to 'Ayse Han' if the supplier name is samsung

UPDATE products 
SET customer_name = 'Ayse Han'
WHERE supplier_id = (SELECT supplier_id
                    FROM suppliers 
                    WHERE supplier_name= 'SAMSUNG'
                    );

--Update the supplier name to 'Google' if the customer name is Eddie MURPHY

UPDATE suppliers 
SET supplier_name = 'Google'
WHERE supplier_id = (SELECT supplier_id
                    FROM products
                    WHERE customer_name= 'Eddie MURPHY'
                    );









