
/*DISTINCT, CONCAT, ||*/
SELECT DISTINCT city
FROM ADDRESS;

SELECT 'Name of user: ' || CONCAT(CONCAT(fname,' '),lname) || ', email: ' || email || ', phone: ' || phone AS "Basic info"
FROM "User";

/*LOWER, UPPER, INITCAP - prvni pismeno velke pro kazde slovo*/
SELECT LOWER(name),UPPER(manufacturer), INITCAP(description)
FROM Product
WHERE (manufacturer LIKE 'Samsung' OR  manufacturer LIKE 'Sony') AND quantity <= 35 ;

/*BETWEEN AND, LIKE %*/
SELECT *
FROM Product
WHERE (price BETWEEN 5000 AND 15000) AND description LIKE '%mobilní%';

/* IS NULL, NOT IN*/
SELECT *
from "Order"
WHERE payment_id IS NULL;

SELECT *
FROM "User"
WHERE type NOT IN('Registred customer', 'Unregistered customer');

/*ORDER BY DESC/ASC*/
SELECT *
FROM Product
ORDER BY manufacturer DESC, name;

/*COUNT,AVG, MIN, MAX, SUM*/
SELECT COUNT(order_id) AS "Number of orders", MIN(total_price) AS "min price", 
        MAX(total_price) AS "max price", AVG(total_price) AS "avg price", 
        SUM(total_price) AS "sum price of orders"
FROM "Order";

/*SUBSTR, LENGTH, INSTR, RPAD, LPAD, TRIM, REPLACE*/
SELECT SUBSTR('Here is some text',6,8) AS "substr", LENGTH('dafafafmafoafmaofmaofmafoomfqomqo') AS "Length", 
        INSTR('This function performs a case-insensitive search.','case') AS "Position of word - case",
        RPAD(LPAD('Hello world!',25, 'SQL'),35,'ORACLE') AS "lpad and rpad",
        TRIM('#' FROM '######hello world#') AS "trim",
        REPLACE('Hello world!','!','...?') AS "replace"
FROM DUAL;

/*ROUND, TRUNC, MOD*/
SELECT ROUND(AVG(price) / sum(quantity),2) AS "round 2", 
       TRUNC(AVG(price) / sum(quantity),2) AS "trunc 2",
       MOD(AVG(price),3) AS "mod",
       ROUND(SUM(price),-3) AS "round to thousand"
FROM Product;

/*DATE FUNCTIONS*/
SELECT creation_date AS "Creation Date", 
       ROUND(MONTHS_BETWEEN(SYSDATE,creation_date)) AS "months between creation date and current date",
       TO_CHAR(ADD_MONTHS(creation_date, 1),'MONTH') AS "Next month",
       NEXT_DAY(creation_date,7) AS "Next sunday",
       TO_CHAR(LAST_DAY(creation_date),'DD.MONTH') AS "Last day",
       TO_CHAR(ROUND(creation_date,'MONTH'),'DD.MM.YY') AS "Round date",
       TO_CHAR(TRUNC(creation_date,'MONTH'),'DD.MM.YY') "Trunc date"
FROM "Order";

/*string to number*/
SELECT TO_NUMBER(phone)
FROM "User";

/*NULLIF - vraci null pokud jsou oba parametry stejne*/
/*TO_DATE string na datum*/
SELECT  TO_DATE('24.05.2021', 'DD.MM.YY') "To date", NULLIF('Hello','Hello!') 
FROM DUAL;

/*NVL - replace null value with alternative*/
/*NVL2 kdyz exp1 neni null = vraci druhy, kdyz je null vraci treti*/
SELECT NVL(login,'no login') "Login", NVL2(login,fname,lname)
FROM "User";

/*vraci prvni not null */
SELECT COALESCE(login,fname)
FROM "User";

/*neco jako CASE kdyz bude argument roven necemu tak udela neco, napr sort*/
SELECT *
FROM Product
ORDER BY DECODE('P','Q',quantity,'P',price,'W',weight);

/*CASE kdyz neco, tak vypise neco*/
SELECT order_id, amount,
CASE
    WHEN amount > 2 THEN 'The amount is greater than 2'
    WHEN amount = 2 THEN 'The amount is 2'
    ELSE 'The amount is under 2 '
END AS QuantityText
FROM orderitem;

/*one copy of common column*/
SELECT *
FROM "User" NATURAL JOIN address;

/*cross join, cartesian*/
SELECT order_id, state, total_price, user_id,payment_id, transport.transport_id, name, description, price
FROM "Order" CROSS JOIN transport;


/* difference between ON and USING, on = each column from tables, using only one*/
SELECT u.fname,u.lname, COUNT(o.order_id) AS "orders"
FROM "User" u JOIN "Order" o ON u.user_id = o.user_id
GROUP BY u.fname, u.lname
HAVING COUNT(o.order_id) >= 2;


/*vypsat uzivatele, kteri koupili Iphone SE 64GB*/
/*JOIN USING()*/
SELECT u.user_id,u.fname, u.lname
FROM "User" u
WHERE  u.user_id IN 
		(SELECT o.user_id 
		 FROM "Order" o JOIN orderitem USING(order_id)
		 JOIN product USING(product_id)
		 WHERE product.name = 'Iphone SE 64GB'
		);

/*RIGHT JOIN*/
/*Vypsat vsechny uzivatele a jejich objednavky*/
SELECT u.user_id, u.fname, u.lname, order_id
FROM "Order" o RIGHT OUTER JOIN "User" u ON u.user_id = o.user_id;

/*funguje jako LEFT + RIGHT JOIN */
SELECT u.user_id, u.fname, u.lname, order_id
FROM "Order" o FULL OUTER JOIN "User" u ON u.user_id = o.user_id;

/*LEFT JOIN*/
SELECT category.category_id,category.name,product.name
FROM category LEFT JOIN productcategory on category.category_id = productcategory.category_id
LEFT JOIN product ON product.product_id = productcategory.product_id
ORDER BY product.name;

/*VARIANCE, STDDEV*/
SELECT VARIANCE(total_price),STDDEV(total_price)
FROM "Order";

/*COUNT*/
SELECT COUNT(payment_id)
FROM "Order";

SELECT COUNT(*)
FROM "Order";

SELECT COUNT(DISTINCT psc)
FROM address;

/*ROLLUP - sum vsech na konci*/
SELECT user_id, SUM(amount) 
FROM "Order" INNER JOIN orderitem USING (order_id)
GROUP BY ROLLUP(user_id);

/*CUBE total quantity by manufacturer and name*/
SELECT manufacturer,name,SUM(quantity)
FROM product
GROUP BY CUBE(manufacturer,name)
ORDER BY manufacturer,name;

/*GROUPING*/
SELECT state,type,SUM(total_price) AS "total price"
FROM "User" u JOIN "Order" USING(user_id)
GROUP BY GROUPING SETS((state,type),
                        (state),
                        (type),
                        ())
ORDER BY GROUPING(state),GROUPING(type), type;

/*UNION ALL - vsechno, UNION bez duplicit*/
SELECT name
FROM transport
UNION ALL
SELECT name
FROM payment
ORDER BY name;

/*INTERSECT*/
SELECT  u.user_id, fname, total_price, o.creation_date
FROM "User" u LEFT JOIN "Order" o ON u.user_id = o.user_id
INTERSECT
SELECT  u.user_id, fname, total_price, o.creation_date
FROM "User" u RIGHT JOIN "Order" o ON u.user_id = o.user_id;

/*MINUS*/
SELECT  u.user_id, fname, total_price, o.creation_date
FROM "User" u LEFT JOIN "Order" o ON u.user_id = o.user_id
MINUS
SELECT  u.user_id, fname, total_price, o.creation_date
FROM "User" u RIGHT JOIN "Order" o ON u.user_id = o.user_id;

/*sub query in FROM */
/*Dotaz, ktery vypise uzivatele s nejvetsim poctem objednavek */
SELECT u.user_id, u.fname, u.lname, COUNT(o.order_id) AS Pocet
FROM "User" u LEFT JOIN "Order" o ON u.user_id = o.user_id
GROUP BY u.fname,u.lname, u.user_id
HAVING COUNT(o.order_id) =	( 
											SELECT MAX(pocet)
											FROM (
													SELECT COUNT(o.order_id) AS pocet
													FROM "User" u LEFT JOIN "Order" o ON u.user_id = o.user_id
													GROUP BY u.user_Id
												  ) t
											);
  
/*Vypise jmena a prijmeni uzivatelu, kteri maji 2 a vice objednavek.*/                                            
SELECT u.fname,u.lname 
FROM "User" u
WHERE u.user_id IN (
								SELECT user_id
								FROM "Order"
								GROUP BY user_id
								HAVING COUNT(order_id) >= 2
							  );
  
/*Vypište jména a pøijmení uživatelù, kteøí si objednali telefon 'Iphone SE 64GB'*/                              
SELECT  u.user_id,u.fname, u.lname
FROM "User" u JOIN "Order" o ON u.user_id = o.user_id
JOIN orderitem ON orderitem.order_id = o.order_id
WHERE orderitem.product_id  = ALL(
								SELECT product_id
								FROM product
								WHERE product.name = 'Iphone SE 64GB'
								);
 
 /*stejny dotaz jen s EXISTS*/                               
SELECT u.user_id,u.fname, u.lname
FROM "User" u
WHERE EXISTS 
		(SELECT o.user_id 
		 FROM "Order" o JOIN orderitem ON o.order_id = orderitem.order_id
		 JOIN product ON product.product_id=orderitem.product_id
		 WHERE u.user_id = o.user_id AND product.name = 'Iphone SE 64GB'  
		);

/*Dotaz, ktery vypise produkty, ktere si alespon dva uzivatele koupili naposledy.*/    
SELECT product_id,name 
FROM (
		SELECT product.product_id, product.name, user_id  
		FROM "Order" o1 JOIN orderitem ON o1.order_id = orderitem.order_id
		JOIN  product ON product.product_id = orderitem.product_id
		WHERE o1.creation_date = (
								SELECT MAX(creation_date)
								FROM "Order" o2
								WHERE o1.user_id = o2.user_id
								)
	)t
GROUP BY product_id,name
HAVING COUNT(*) > 1;















