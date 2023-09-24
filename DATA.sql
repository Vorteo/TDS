INSERT INTO address (city, street, country, psc)
VALUES ('Ostrava','Frýdecká 25','Czech Republic',70030);

INSERT INTO "User" (fname ,lname, phone, email,type, creation_date, is_active, address_id)
VALUES ('Michal','Beneš','+420722501062','m.benes@seznam.cz','Unregistered customer',SYSDATE, 1, (SELECT address_id FROM address WHERE psc = 70030));

INSERT INTO address (city, street, country, psc)
VALUES ('Frýdek-Místek', 'Frýdlanstká 405', 'Czech', 73801);

INSERT INTO "User" (fname, lname, phone, email, type, creation_date, is_active, address_id)
VALUES ('Jan', 'Novák', '+420735501162', 'j.novak@gmail.com', 'Unregistered customer', SYSDATE,1, (SELECT address_id FROM address WHERE psc = 73801));

INSERT INTO "User" (fname, lname, phone, email, type, login, creation_date, is_active, address_id)
VALUES ('Petr', 'Mára', '+420625128035', 'p.mara@gmail.com', 'Registred customer', 'MARA6258', SYSDATE, 1, (SELECT address_id FROM address WHERE psc = 73801));

INSERT INTO address (city, street, country, psc)
VALUES ('Paskov','Paskovská 325','Czech',73921);

INSERT INTO "User" (fname, lname, phone, email, type, login, creation_date, is_active, address_id)
VALUES ('Marek', 'Vrabec', '+420888265328', 'm.vrabec@seznam.com', 'Registred customer', 'VRABEC328', SYSDATE, 1, (SELECT address_id FROM address WHERE psc = 73921));

INSERT INTO address (city, street, country, psc)
VALUES ('Ostrava','Èeskobratrská 85','Czech',73935);

INSERT INTO "User" (fname, lname, phone, email, type, login, creation_date, is_active, address_id)
VALUES ('Martin', 'Kaloè', '+420608298468', 'm.kaloc@seznam.com', 'Employe', 'KALOC328', SYSDATE, 1, (SELECT address_id FROM address WHERE psc = 73935));

INSERT INTO address (city, street, country, psc)
VALUES ('Brušperk',' Hlavní 38','Czech',73955);

INSERT INTO "User" (fname, lname, phone, email, type, login, creation_date, is_active, address_id)
VALUES ('Patrik','Thomas','+420120358987','p.thomas@centrum.cz','Admin','THOMAS328',SYSDATE, 1, (SELECT address_id FROM address WHERE psc = 73955));

INSERT INTO address (city, street, country, psc)
VALUES ('Vratimov','Frýdecka 125','Czech',73932);

INSERT INTO "User" (fname, lname, phone, email, type, creation_date, is_active, address_id)
VALUES ('Lukáš','Moravec','+420115268652','l.moravec@gmail.com','Unregistered customer',SYSDATE,1, (SELECT address_id FROM address WHERE psc = 73932));

INSERT INTO address (city, street, country, psc)
VALUES ('Horní Datynì','Vratimovská 148','Czech',73932);

INSERT INTO "User" (fname, lname, phone, email, type, login, creation_date, is_active, address_id)
VALUES ('Jakub','Dostal','+420722501199','j.dostal@seznam.cz','Registred customer','DOSTAL255', SYSDATE, 1,(SELECT address_id FROM address WHERE city = 'Horní Datynì'));

INSERT INTO Product (name, manufacturer, color, weight, price, quantity, added, changed, is_active, description)
VALUES ('Iphone SE 64GB', 'Apple', 'Black', 113, 6500, 20,SYSDATE, SYSDATE, 1, 'New iphone SE 2020');

INSERT INTO Product (name,manufacturer,description,color,weight,price,quantity,added,changed,is_active)
VALUES ('Galaxy S20','Samsung','Revoluèní Galaxy S20 pøichází nabitý špièkovými funkcemi, fantastickým designem...','Blue',290,15500,30,SYSDATE,SYSDATE,1);

INSERT INTO Product (name,manufacturer,description,color,weight,price,quantity,added,changed,is_active)
VALUES ('Iphone XR','Apple','Dostupnìjší varianta slavného telefonu s nejvýkonnìjším smartphonovým procesorem...','Èervená',210,18500,25,SYSDATE,SYSDATE, 1);

INSERT INTO Product (name,manufacturer,description,color,weight,price,quantity,added,changed,is_active)
VALUES ('Galaxy S10','Samsung','Galaxy S10 nabízí svým uživatelùm nejnovìjší mobilní technologie...','Modrá',190,13300,40,SYSDATE,SYSDATE, 1);

INSERT INTO Product (name,manufacturer,color,weight,price,quantity,added,changed,is_active)
VALUES ('Xperia 5 Dual','Sony','Èerná',136,13600,15,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,1);

INSERT INTO Product (name,manufacturer,description,color,weight,price,quantity,added,changed,is_active)
VALUES ('Redmi Note 8T','Xiaomi','Inteligentní elegán, který zvládne všechny vaše požadavky levou zadní...','Modrá',140,4990,60,SYSDATE,SYSDATE,1);

INSERT INTO Product (name,manufacturer,description,color,weight,price,quantity,added,changed,is_active)
VALUES ('8A','Honor','Smartphone s vícevrstvou povrchovou texturou a prostorným displejem nabízí osmijádrový výkon...','Èerná',133,3490,120,SYSDATE,SYSDATE,1);

INSERT INTO Product (name,manufacturer,description,color,weight,price,quantity,added,changed,is_active)
VALUES ('Zenfone 7','Asus','Chytrý telefon se špièkovým výkonem, výklopným trojitým fotoaparátem pro pøední i zadní stranu...','Èervená',165,16790,38,SYSDATE,SYSDATE,1);

INSERT INTO Category (name, description)
VALUES ('Pro nároèné', 'information about this category');

INSERT INTO Category (name, description)
VALUES ('Pro nenároèné','something about category');

INSERT INTO Category (name,description)
VALUES ('Zlatá støední cesta','average category');

INSERT INTO productcategory (product_id, category_id)
VALUES (1,3);

INSERT INTO productcategory (product_id,category_id)
VALUES (2,2);

INSERT INTO productcategory (product_id,category_id)
VALUES (3,2);

INSERT INTO productcategory (product_id,category_id)
VALUES (4,2);

INSERT INTO productcategory (product_id,category_id)
VALUES (5,2);

INSERT INTO productcategory (product_id,category_id)
VALUES (6,4);

INSERT INTO productcategory (product_id,category_id)
VALUES (7,4);

INSERT INTO productcategory (product_id,category_id)
VALUES (8,2);

INSERT INTO Category (name,description)
VALUES ('iOS','Telefon s operaèním systémem iOS');

INSERT INTO Category (name,description)
VALUES ('Android','Telefon s operaèním systémem Android');

INSERT INTO productcategory (product_id, category_id)
VALUES (1,5);

INSERT INTO productcategory (product_id, category_id)
VALUES (3,5);

INSERT INTO productcategory (product_id, category_id)
VALUES (2,6);

INSERT INTO productcategory (product_id, category_id)
VALUES (4,6);

INSERT INTO productcategory (product_id, category_id)
VALUES (5,6);

INSERT INTO productcategory (product_id, category_id)
VALUES (6,6);

INSERT INTO productcategory (product_id, category_id)
VALUES (7,6);

INSERT INTO productcategory (product_id, category_id)
VALUES (8,6);

INSERT INTO Payment (name,price,paid)
VALUES ('Cash',25,SYSDATE);

INSERT INTO Payment (name,price,paid)
VALUES ('Cash',25,SYSDATE);

INSERT INTO Payment (name,price,paid)
VALUES ('Card',10,'28.11.21 11:05:01');

INSERT INTO Payment (name,price,paid)
VALUES ('Online',5,'25.11.20 19:30:01');

INSERT INTO Payment (name,price,paid)
VALUES ('Card',10,'24.11.20 21:30:01');

INSERT INTO Payment (name,price,paid)
VALUES ('Cash',40,'29.11.20 09:15:01');

INSERT INTO Transport (name,price,description)
VALUES ('Personal',89,'Vyzvednuti objednavky na jednom z nasich vydejnich mist...');

INSERT INTO Transport (name,price,description)
VALUES ('Post',115,'Doruceni objednavky ceskou postou...');

INSERT INTO Transport (name,price,description)
VALUES ('Courier',60,'Vyzvednuti na vydejnich mistech Zasilkovny');

INSERT INTO "Order" (creation_date,state,total_price,user_id,payment_id,changed,transport_id)
VALUES ('26.11.20 18:21:06','Finished',6565,3,1,'26.11.20 18:21:06',2);

INSERT INTO "Order" (creation_date,state,total_price,user_id,changed,transport_id)
VALUES (SYSDATE,'Processing',13595,4,SYSDATE,3);

INSERT INTO "Order" (creation_date,state,total_price,user_id,payment_id,changed,transport_id)
VALUES ('25.11.20 08:21:06','Sent',18565,6,4,'26.11.20 15:21:06',5);

INSERT INTO "Order" (creation_date,state,total_price,user_id,payment_id,changed,transport_id)
VALUES (SYSDATE,'Finished',10045,7,2,SYSDATE,2);

INSERT INTO "Order" (creation_date,state,total_price,user_id,payment_id,changed,transport_id)
VALUES (SYSDATE,'Finished',5040,8,3,SYSDATE,2);

INSERT INTO "Order" (creation_date,state,total_price,user_id,payment_id,changed,transport_id)
VALUES (SYSDATE,'Finished',16860,9,5,SYSDATE,3);

INSERT INTO "Order" (creation_date,state,total_price,user_id,changed,transport_id)
VALUES (SYSDATE,'Accepted',20395,8,SYSDATE,2);

INSERT INTO"Order" (creation_date,state,total_price,user_id,changed,transport_id)
VALUES ('26.11.20 18:21:06','Cancelled',31040,4,'27.11.20 18:21:06',2);

INSERT INTO orderitem (amount,order_id,product_id)
VALUES (1,3,1);

INSERT INTO orderitem (amount,order_id,product_id)
VALUES (1,5,1);

INSERT INTO orderitem (amount,order_id,product_id)
VALUES (2,5,7);

INSERT INTO orderitem (amount,order_id,product_id)
VALUES (1,8,3);

INSERT INTO orderitem (amount,order_id,product_id)
VALUES (2,9,6);

INSERT INTO orderitem (amount,order_id,product_id)
VALUES (1,10,6);

INSERT INTO orderitem (amount,order_id,product_id)
VALUES (1,11,8);

INSERT INTO orderitem (amount,order_id,product_id)
VALUES (1,12,4);

INSERT INTO orderitem (amount,order_id,product_id)
VALUES (2,12,7);

INSERT INTO orderitem (amount,order_id,product_id)
VALUES (2,16,2);

INSERT INTO producthistory (changed,attribute_name,value,product_id)
VALUES ('18.05.21 08:38:01','price',8000,1);

INSERT INTO producthistory (changed,attribute_name,value,product_id)
VALUES ('08.04.21 15:56:01','weight',250,4);

INSERT INTO producthistory (changed,attribute_name,value,product_id)
VALUES ('02.03.21 19:38:01','price',2000,6);

INSERT INTO producthistory (changed,attribute_name,value,product_id)
VALUES ('01.01.21 22:38:01','price',14000,2);


