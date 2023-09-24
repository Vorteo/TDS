/*Address*/
CREATE TABLE address (
    address_id  INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
    city        VARCHAR2(30) NOT NULL,
    street      VARCHAR2(50) NOT NULL,
    country     VARCHAR2(30) NOT NULL,
    psc         INTEGER NOT NULL
);
ALTER TABLE address ADD CONSTRAINT address_pk PRIMARY KEY ( address_id );

/*Category*/
CREATE TABLE category (
    category_id  INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
    name         VARCHAR2(40) NOT NULL,
    description  CLOB NOT NULL
);
ALTER TABLE category ADD CONSTRAINT category_pk PRIMARY KEY ( category_id );

/*Order*/
CREATE TABLE "Order" (
    order_id       INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
    creation_date  DATE NOT NULL,
    state          VARCHAR2(60) NOT NULL,
    total_price    NUMBER(19, 4) NOT NULL,
    changed        DATE NOT NULL,
    user_id        INTEGER NOT NULL,
    transport_id   INTEGER NOT NULL,
    payment_id     INTEGER
);
ALTER TABLE "Order" ADD CONSTRAINT order_pk PRIMARY KEY ( order_id );

/*OrderItem*/
CREATE TABLE orderitem (
    amount      INTEGER NOT NULL,
    order_id    INTEGER NOT NULL,
    product_id  INTEGER NOT NULL
);
ALTER TABLE orderitem ADD CONSTRAINT orderitem_pk PRIMARY KEY ( order_id, product_id );

/*Payment*/
CREATE TABLE payment (
    payment_id  INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
    name        VARCHAR2(30) NOT NULL,
    price       NUMBER(19, 4) NOT NULL,
    paid        DATE NOT NULL
);
ALTER TABLE payment ADD CONSTRAINT payment_pk PRIMARY KEY ( payment_id );

/*Product*/
CREATE TABLE product (
    product_id    INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
    name          VARCHAR2(40) NOT NULL,
    manufacturer  VARCHAR2(50) NOT NULL,
    description   CLOB,
    image         BLOB,
    quantity      INTEGER NOT NULL,
    price         NUMBER(19, 4) NOT NULL,
    weight        INTEGER NOT NULL,
    color         VARCHAR2(20) NOT NULL,
    added         DATE NOT NULL,
    changed       DATE NOT NULL,
    is_active     CHAR(1) NOT NULL
);
ALTER TABLE product ADD CONSTRAINT product_pk PRIMARY KEY ( product_id );

/*ProductCategory*/
CREATE TABLE productcategory (
    category_id  INTEGER NOT NULL,
    product_id   INTEGER NOT NULL
);
ALTER TABLE productcategory ADD CONSTRAINT productcategory_pk PRIMARY KEY ( category_id, product_id );

/*ProductHistory*/
CREATE TABLE producthistory (
    history_id      INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
    attribute_name  VARCHAR2(60) NOT NULL,
    value           VARCHAR2(100) NOT NULL,
    changed         DATE NOT NULL,
    product_id      INTEGER NOT NULL
);
ALTER TABLE producthistory ADD CONSTRAINT producthistory_pk PRIMARY KEY ( history_id );

/*Transport*/
CREATE TABLE transport (
    transport_id  INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
    name          VARCHAR2(30) NOT NULL,
    description   CLOB,
    price         NUMBER(19, 4) NOT NULL
);
ALTER TABLE transport ADD CONSTRAINT transport_pk PRIMARY KEY ( transport_id );

/*User*/
CREATE TABLE "User" (
    user_id        INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
    fname          VARCHAR2(50) NOT NULL,
    lname          VARCHAR2(50) NOT NULL,
    phone          VARCHAR2(13) NOT NULL,
    email          VARCHAR2(60) NOT NULL,
    type           VARCHAR2(40) NOT NULL,
    login          VARCHAR2(30),
    creation_date  DATE,
    is_active      CHAR(1) NOT NULL,
    address_id     INTEGER NOT NULL
);
ALTER TABLE "User" ADD CONSTRAINT user_pk PRIMARY KEY ( user_id );


ALTER TABLE "Order"
    ADD CONSTRAINT order_payment_fk FOREIGN KEY ( payment_id )
        REFERENCES payment ( payment_id ) ON DELETE RESTRICT;

ALTER TABLE "Order"
    ADD CONSTRAINT order_transport_fk FOREIGN KEY ( transport_id )
        REFERENCES transport ( transport_id ) ON DELETE RESTRICT;

ALTER TABLE "Order"
    ADD CONSTRAINT order_user_fk FOREIGN KEY ( user_id )
        REFERENCES "User" ( user_id ) ON DELETE RESTRICT;

ALTER TABLE orderitem
    ADD CONSTRAINT orderitem_order_fk FOREIGN KEY ( order_id )
        REFERENCES "Order" ( order_id ) ON DELETE RESTRICT;

ALTER TABLE orderitem
    ADD CONSTRAINT orderitem_product_fk FOREIGN KEY ( product_id )
        REFERENCES product ( product_id ) ON DELETE RESTRICT;

ALTER TABLE productcategory
    ADD CONSTRAINT productcategory_category_fk FOREIGN KEY ( category_id )
        REFERENCES category ( category_id ) ON DELETE RESTRICT;

ALTER TABLE productcategory
    ADD CONSTRAINT productcategory_product_fk FOREIGN KEY ( product_id )
        REFERENCES product ( product_id ) ON DELETE RESTRICT;

ALTER TABLE producthistory
    ADD CONSTRAINT producthistory_product_fk FOREIGN KEY ( product_id )
        REFERENCES product ( product_id ) ON DELETE RESTRICT;

ALTER TABLE "User"
    ADD CONSTRAINT user_address_fk FOREIGN KEY ( address_id )
        REFERENCES address ( address_id ) ON DELETE RESTRICT;
    

/* INTEGRITNI OMEZENI */
ALTER TABLE "User"
ADD CONSTRAINT email_check CHECK (email LIKE '%@%');

ALTER TABLE "User"
ADD CONSTRAINT login_length_check CHECK (LENGTH(login)>=8);

ALTER TABLE "User"
ADD CONSTRAINT type_check CHECK (type IN ('Registred customer','Unregistered customer', 'Employe', 'Admin' ));

ALTER TABLE "Order"
ADD CONSTRAINT state_check CHECK (state IN ('Accepted', 'Processing', 'Waiting', 'Payment received', 'Sent', 'Finished', 'Cancelled'));

ALTER TABLE ORDERITEM
ADD CONSTRAINT amount_check CHECK (amount >= 1);

ALTER TABLE Payment
ADD CONSTRAINT payment_name_check CHECK (name IN ('Cash', 'Card', 'Online'));

ALTER TABLE Transport
ADD CONSTRAINT transport_name_check CHECK (name IN ('Personal', 'Post', 'Courier'));

ALTER TABLE "User"
ADD CONSTRAINT phone_check CHECK (LENGTH(phone) >= 9);

/*        
DROP TABLE ORDERITEM;
DROP TABLE PRODUCTCATEGORY;
DROP TABLE PRODUCTHISTORY;
DROP TABLE CATEGORY;
DROP TABLE "Order";
DROP TABLE PAYMENT;
DROP TABLE TRANSPORT;
DROP TABLE PRODUCT;
DROP TABLE "User";
DROP TABLE ADDRESS;
*/
