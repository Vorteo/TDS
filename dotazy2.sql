
/*INSERT + SELECT*/
INSERT INTO "User" (fname,lname,phone,email,type,login,creation_date,is_active,address_id)
SELECT fname,lname,phone,email,type,login,creation_date,is_active,address_id
FROM "User" 
WHERE user_id = 9;

/*UPDATE*/
UPDATE category 
SET description = 'novy popis kategorie' 
WHERE name = 'Windows';

/*DELETE*/
DELETE FROM "User"
WHERE user_id = 12;

/*MODIFY*/
ALTER TABLE "User"
MODIFY type DEFAULT 'Unregistered customer';

/*CREATE*/
CREATE TABLE TEMPTABLE (
    name VARCHAR2(30) NOT NULL,
    city VARCHAR2(30) NOT NULL,
    description VARCHAR2(100),
    hire_date DATE NOT NULL
);

/*RENAME*/
ALTER TABLE temptable
RENAME COLUMN description TO text;

/*DEFAULT*/
ALTER TABLE temptable
MODIFY city DEFAULT 'Praha';

/*EXTERNAL,DIRECTORY*/
CREATE OR REPLACE DIRECTORY ext_tab_data AS '/data';

CREATE TABLE countries_ext (
  country_code      VARCHAR2(5),
  country_name      VARCHAR2(50),
  country_language  VARCHAR2(50)
)
ORGANIZATION EXTERNAL (
  TYPE ORACLE_LOADER
  DEFAULT DIRECTORY ext_tab_data
  ACCESS PARAMETERS (
    RECORDS DELIMITED BY NEWLINE
    FIELDS TERMINATED BY ','
    MISSING FIELD VALUES ARE NULL
    (
      country_code      CHAR(5),
      country_name      CHAR(50),
      country_language  CHAR(50)
    )
  )
  LOCATION ('Countries1.txt')
)

SELECT *
FROM   countries_ext
ORDER BY country_name;

/*TIMESTAMP*/
SELECT TIMESTAMP
FROM "Order";

/*TIMESTAMP WITH TIME ZONE*/
ALTER TABLE TEMPTABLE
MODIFY hire_date TIMESTAMP WITH TIME ZONE;

/*TIMESTAMP same as DATE, WITH TIME ZONE - fractional seconds,time zone offset, name; with local time convert zone time to local time*/
INSERT INTO temptable(name,city,hire_date) VALUES('datum','Praha', TIMESTAMP '2003-01-01 2:00:00');
INSERT INTO temptable(name,city,hire_date) VALUES('datum','Madrid',TIMESTAMP '2003-01-01 2:00:00 -8:00');

/*TRUNCATE - smaze data v tabulce*/
TRUNCATE TABLE temptable;

/*TIMESTAMP WITH LOCAL TIME ZONE*/
ALTER TABLE TEMPTABLE
MODIFY hire_date TIMESTAMP WITH LOCAL TIME ZONE;

INSERT INTO temptable(name,city,hire_date) VALUES('datum','Praha', TIMESTAMP '2020-01-01 2:00:00');
INSERT INTO temptable(name,city,hire_date) VALUES('datum','Madrid',TIMESTAMP '2003-01-01 2:00:00 -8:00');

TRUNCATE TABLE temptable;

/*INTERVAL*/
select interval '4 5:12:10.222' day to second(3)
from dual;

select interval '20' month
from dual;

/*polovit FLASHBACK*/
ALTER TABLE temptable
ENABLE ROW MOVEMENT;

/*zobrazit recyclebin*/
SELECT *
FROM user_recyclebin;

/*DROP TABLE*/
DROP TABLE temptable;

/*FLASHBACK vraceni zpet pred DROP*/
FLASHBACK TABLE temptable TO BEFORE DROP;

/*Pridat comment na tabulku nebo sloupec*/
COMMENT ON TABLE temptable IS 'novy komentar';

/*odebrat COMMENT*/
COMMENT ON TABLE temptable IS NULL;

SELECT *
FROM USER_TAB_COMMENTS;

/*set unused*/
/*udelat neviditelny sloupec, logigal delete, na velke tabulky*/
alter table temptable set unused (city);
alter table temptable drop unused columns;

/*CREATE TABLE podle SELECTU*/
CREATE TABLE address_copy AS (SELECT fname,lname, city,street,psc FROM "User" JOIN address USING(address_id));
DROP TABLE address_copy;

/*constraints user*/
SELECT * 
FROM user_constraints;  

/*CREATE VIEW*/
CREATE OR REPLACE VIEW "Products Above Average Price" AS
SELECT name, price
FROM product
WHERE price > (SELECT AVG(price) FROM product);

SELECT *
FROM "Products Above Average Price";

/*FORCE pro neexistuji tabulku, NOFORCE jen pro existujici*/
CREATE OR REPLACE VIEW "Orders finished and cancelled" AS
SELECT order_id,state, total_price, creation_date
FROM "Order"
WHERE (state = 'Finished' OR state = 'Cancelled') AND total_price > 12000
WITH READ ONLY;

SELECT *
FROM "Orders finished and cancelled";

CREATE OR REPLACE VIEW "category_list" AS
SELECT name, description
FROM category
WHERE name LIKE 'S%'
WITH CHECK OPTION;

INSERT INTO "category_list" VALUES('Sony','some text about category');

INSERT INTO "category_list" VALUES('Aafafaf','some text about category');

SELECT *
FROM "category_list";

CREATE OR REPLACE VIEW "customers order product" AS
SELECT "User".user_id,"User".fname, "User".lname
FROM "User"
WHERE  "User".user_id IN 
		(SELECT o.user_id 
		 FROM "Order" o JOIN orderitem ON o.order_id = orderitem.order_id
		 JOIN product ON product.product_id=orderitem.product_id
		 WHERE product.manufacturer LIKE 'S%'      
		)
WITH READ ONLY;

SELECT *
FROM "customers order product";

/*REGEXP*/
SELECT fname
FROM "User"
WHERE REGEXP_LIKE(fname,'^M|^P');

SELECT REGEXP_REPLACE( '4024007187788590','(^\d{3})(.*)(\d{4}$)', '\1**********\3' ) AS  "Mask number"
FROM DUAL;
  
SELECT REGEXP_REPLACE('example of replace', '^(\S*)', 'REPLACED WORD')
FROM DUAL;

SELECT REGEXP_REPLACE(fname, '(.)', '\1 ')
FROM "User";


SELECT description, REGEXP_COUNT (description, 't', 20, 'c')
FROM Product;

SELECT REGEXP_INSTR ('Revoluèní Galaxy S20 pøichází nabitý špièkovými funkcemi, fantastickým designem...', 'f')
FROM DUAL;

SELECT REGEXP_SUBSTR ('Revoluèní Galaxy S20 pøichází nabitý špièkovými funkcemi, fantastickým designem...', '(\S*)(\s)',1,2)
FROM DUAL;



CREATE SEQUENCE sequence_1
start with 1
increment by 1
minvalue 0
maxvalue 100
cycle;

CREATE TABLE seq_table(
    ID number(10),
    name varchar2(15)
);

INSERT INTO seq_table VALUES(sequence_1.nextval,'Michal');

select *
from seq_table;

ALTER SEQUENCE sequence_1
maxvalue 200;

CREATE INDEX idx_name
ON "User" (lname, fname);

DROP INDEX idx_name;

SELECT*
FROM "User";

/*GRANT, REVOKE*/
/*GRANT SELECT, INSERT, UPDATE, DELETE ON "User" TO PUBLIC ;*/
/*REVOKE SELECT ON "User" FROM PUBLIC;*/

/*Prodecure*/
EXEC NotifyUser;

/*Transaction, COMMIT, ROLLBACK*/
BEGIN
    INSERT INTO category(name,description) VALUES('kat','dadaddad');
    INSERT INTO category(name,description) VALUES('kat', 'aa');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
    dbms_output.put_line('nelze vlozit kategorie se stejnym nazvem');
    ROLLBACK;
END;


/*ALTER TABLE category 
MODIFY name UNIQUE;
*/

select *
from category;

/*Hierarchy */
CREATE TABLE Employee (
        name varchar2(20),
        employee_id int,
        manager_id int
        );

insert into Employee values('Martin',1,10);
insert into Employee values('Petr',10,2);
insert into Employee values('Jan',3,2);
insert into Employee values('Lukas',2,null);
insert into Employee values('Patrik',4,10);

select *
from Employee;

/*CONNECT BY PRIOR*/
select name, employee_id, manager_id, prior name, level
from Employee
connect by prior employee_id = manager_id
start with manager_id is null;


/*START WITH*/
select lpad(' ',level*5,' ')|| name, employee_id, manager_id, prior name, level
from Employee
connect by prior employee_id = manager_id
start with manager_id is null
order siblings by name;

select lpad(' ',level*3,' ')||name,
SYS_CONNECT_BY_PATH(name,'/') boss
from Employee
connect by prior employee_id = manager_id
start with manager_id is null;
