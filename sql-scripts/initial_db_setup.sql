--Drop Tables
SET SERVEROUTPUT ON
 
BEGIN
    FOR I IN (
        WITH MYTABLES AS (
            SELECT 'PAYMENT' AS TNAME FROM DUAL
            UNION ALL SELECT 'CART' FROM DUAL
            UNION ALL SELECT 'ORDERTB' FROM DUAL
            UNION ALL SELECT 'USERTB' FROM DUAL
            UNION ALL SELECT 'STOCK' FROM DUAL
            UNION ALL SELECT 'ROLES' FROM DUAL
        )
        SELECT M.TNAME
        FROM MYTABLES M INNER JOIN USER_TABLES O ON M.TNAME = O.TABLE_NAME
    )
    LOOP
        BEGIN
            DBMS_OUTPUT.PUT_LINE('TABLE NAME TO BE DROPPED: ' || I.TNAME);
            EXECUTE IMMEDIATE 'DROP TABLE ' || I.TNAME;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE(SQLERRM);
        END;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/
-------------------------------------------
 
--Drop sequences 
BEGIN
    FOR I IN (
        WITH MYSEQUENCES AS (
            SELECT 'ROLE_ID_SEQ' AS SEQ_NAME FROM DUAL
            UNION ALL SELECT 'ORDER_ID_SEQ' FROM DUAL
            UNION ALL SELECT 'PAYMENT_ID_SEQ' FROM DUAL
        )
        SELECT M.SEQ_NAME
        FROM MYSEQUENCES M INNER JOIN USER_SEQUENCES O ON M.SEQ_NAME = O.SEQUENCE_NAME
    )
    LOOP
        BEGIN
            DBMS_OUTPUT.PUT_LINE('SEQUENCE TO BE DROPPED: ' || I.SEQ_NAME);
            EXECUTE IMMEDIATE 'DROP SEQUENCE ' || I.SEQ_NAME;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE(SQLERRM);
        END;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

-- Create Sequences
CREATE SEQUENCE ROLE_ID_SEQ START WITH 1;
CREATE SEQUENCE ORDER_ID_SEQ START WITH 1;
CREATE SEQUENCE PAYMENT_ID_SEQ START WITH 1;

-- Create Tables
CREATE TABLE ROLES 
(
    ROLE_ID NUMBER(6,0) DEFAULT ROLE_ID_SEQ.NEXTVAL NOT NULL, 
    ROLE_NAME VARCHAR2(50) NOT NULL, 
    CONSTRAINT PK_ROLES PRIMARY KEY (ROLE_ID), 
    CONSTRAINT UK_ROLES_ROLE_NAME UNIQUE (ROLE_NAME)
);
/

CREATE TABLE USERTB 
(
    USERNAME VARCHAR2(20) NOT NULL, 
    FIRSTNAME VARCHAR2(50) NOT NULL, 
    LASTNAME VARCHAR2(50), 
    PASSWORD VARCHAR2(100) NOT NULL, 
    ROLE_ID NUMBER(6,0) NOT NULL,
    CONSTRAINT PK_USERTB PRIMARY KEY (USERNAME),
    CONSTRAINT USER_ROLE_FK FOREIGN KEY (ROLE_ID) REFERENCES ROLES (ROLE_ID) ON DELETE CASCADE ENABLE
);
/

CREATE TABLE STOCK 
(
    PRODUCT VARCHAR2(50) NOT NULL, 
    QUANTITY NUMBER NOT NULL, 
    UNITPRICE NUMBER NOT NULL, 
    DESCRIPTION VARCHAR2(200),
    CONSTRAINT PK_STOCK PRIMARY KEY (PRODUCT)
);
/

CREATE TABLE ORDERTB 
(
    ORDER_ID NUMBER(10,0) DEFAULT ORDER_ID_SEQ.NEXTVAL NOT NULL, 
    USERNAME VARCHAR2(50) NOT NULL, 
    ORDER_QTY NUMBER NOT NULL, 
    ORDER_STATUS VARCHAR2(50),
    ORDER_DATE DATE,
    CONSTRAINT ORDER_USER_FK FOREIGN KEY (USERNAME) REFERENCES USERTB (USERNAME) ON DELETE CASCADE ENABLE,
    CONSTRAINT PK_ORDER PRIMARY KEY (ORDER_ID)
);
/

CREATE TABLE CART
(
    PRODUCT VARCHAR2(50) NOT NULL, 
    QUANTITY NUMBER NOT NULL, 
    PRICE NUMBER NOT NULL, 
    USERNAME VARCHAR2(20) NOT NULL, 
    ORDER_ID NUMBER(10,0), 
    CART_STATUS VARCHAR2(15),
    CONSTRAINT PK_CART PRIMARY KEY (PRODUCT, USERNAME, ORDER_ID),
    CONSTRAINT FK_CART_PRODUCT FOREIGN KEY (PRODUCT) REFERENCES STOCK (PRODUCT),
    CONSTRAINT FK_CART_USERNAME FOREIGN KEY (USERNAME) REFERENCES USERTB (USERNAME),
    CONSTRAINT FK_CART_ORDER_ID FOREIGN KEY (ORDER_ID) REFERENCES ORDERTB (ORDER_ID)
);
/


CREATE TABLE PAYMENT 
(
    PAYMENT_ID NUMBER(10,0) DEFAULT PAYMENT_ID_SEQ.NEXTVAL NOT NULL ENABLE, 
    ORDER_ID NUMBER(10,0) NOT NULL ENABLE, 
    PAYMENT_MODE VARCHAR2(50),
    PAYMENT_DATE DATE, 
    PAYMENT_STATUS VARCHAR2(50),
    CONSTRAINT PAYMENT_PK PRIMARY KEY (PAYMENT_ID),
    CONSTRAINT PAYMENT_ORDER_FK FOREIGN KEY (ORDER_ID) REFERENCES ORDERTB (ORDER_ID) ON DELETE CASCADE ENABLE
);
/

create or replace PROCEDURE add_role (
    in_role_name VARCHAR2
) AS
    v_exists VARCHAR(5);
    e_exists EXCEPTION;
BEGIN
    SELECT
        'Y'
    INTO v_exists
    FROM
        roles
    WHERE
        role_name = in_role_name;

    IF ( v_exists = 'Y' ) THEN
        RAISE e_exists;
    END IF;
EXCEPTION
    WHEN no_data_found THEN
        INSERT INTO roles VALUES (
            role_id_seq.NEXTVAL,
            in_role_name
        );

        dbms_output.put_line('Role Added');
        COMMIT;
    WHEN e_exists THEN
        dbms_output.put_line('Role already exists');
END add_role;
/

CREATE OR REPLACE PROCEDURE add_user (
    in_username VARCHAR2,
    in_frstname VARCHAR2,
    in_lastname VARCHAR2,
    in_hashPwd VARCHAR2,
    in_role_id NUMBER
) AS
    v_exists VARCHAR(5);
    e_exists EXCEPTION;
    e_user_exists_msg VARCHAR2(100) := 'User already exists with the same username';
BEGIN
    SELECT
        'Y'
    INTO v_exists
    FROM
        usertb
    WHERE
        username = in_username;

    IF ( v_exists = 'Y' ) THEN
        RAISE_APPLICATION_ERROR(-20001, e_user_exists_msg);
    END IF;
EXCEPTION
    WHEN no_data_found THEN
        INSERT INTO usertb (username,
                firstname,
                lastname,
                password,
                role_id) 
        VALUES (
            in_username,
            in_frstname,
            in_lastname,
            in_hashPwd,
            in_role_id
        );

        dbms_output.put_line('User Added');
        COMMIT;
END add_user;
/

CREATE OR REPLACE PROCEDURE add_stock (
    in_product_name     VARCHAR2,
	in_product_quantity NUMBER,
	in_product_cost     NUMBER,
    in_description      VARCHAR2,
    out_result OUT NUMBER
) AS
	v_exists VARCHAR(5);
    e_exists EXCEPTION;
    e_prod_exists_msg VARCHAR2(100) := 'Product already exists';
BEGIN
SELECT
        'Y'
    INTO v_exists
    FROM
        stock
    WHERE
        product = in_product_name;

    IF ( v_exists = 'Y' ) THEN
        RAISE_APPLICATION_ERROR(-20002, e_prod_exists_msg);
    END IF;
EXCEPTION
    WHEN no_data_found THEN
        INSERT INTO stock VALUES (
            in_product_name,
			in_product_quantity,
			in_product_cost,
            in_description
        );
        out_result:=1;
		COMMIT;
        dbms_output.put_line('Product added in stock');
        
END add_stock;
/

CREATE OR REPLACE PROCEDURE add_cart (
    in_product_name  VARCHAR2,
    in_quantity NUMBER,
	in_tot_price NUMBER,
	in_username VARCHAR2,
    out_result OUT NUMBER
) IS
BEGIN

	INSERT INTO cart (product, quantity, price, username)
	VALUES (
            in_product_name,
			in_quantity,
            in_tot_price,
			in_username
        );
        
    out_result:=1;
	dbms_output.put_line('Product added to cart');
	COMMIT;
END add_cart;
/

CREATE OR REPLACE PROCEDURE add_payment (
    in_order_id       NUMBER,
    in_payment_mode   VARCHAR2,
    in_payment_status VARCHAR2,
    out_result OUT NUMBER
) IS
BEGIN

	INSERT INTO payment VALUES (
		payment_id_seq.NEXTVAL,
		in_order_id,
		in_payment_mode,
		sysdate,
		in_payment_status
            );
    out_result:= 1;
END add_payment;
/

CREATE OR REPLACE PROCEDURE add_order (
	in_username VARCHAR2,
	in_order_qty NUMBER,
	in_order_status VARCHAR2,
    out_result OUT NUMBER
) AS
BEGIN
        INSERT INTO ordertb (
			order_id,
            username,
            order_qty,
            order_status,
			order_date
        ) VALUES (
            order_id_seq.NEXTVAL,
            in_username,
            in_order_qty,
			in_order_status,
			sysdate	
        );
        
        out_result:=1;

        dbms_output.put_line('Order Added');
        COMMIT;
END add_order;
/

create or replace PROCEDURE payment_checkout(p_username IN VARCHAR2, currentcart OUT NUMBER) 
AS
    v_order_id NUMBER;
BEGIN
    -- Retrieve the pending order_id for the specified user
    SELECT ORDER_ID 
    INTO v_order_id 
    FROM ORDERTB 
    WHERE USERNAME = p_username 
	AND ORDER_STATUS = 'PENDING'
    AND ROWNUM = 1; -- Ensure only one row is fetched

    --UPDATE PAYMENT STATUS
    UPDATE PAYMENT
    SET PAYMENT_STATUS='COMPLETED'
    WHERE ORDER_ID = v_order_id;

    --Update the ordertb
    UPDATE ORDERTB
    SET order_status = 'COMPLETED',
        order_date = SYSDATE
    WHERE order_id = v_order_id;

    UPDATE cart
    SET ORDER_ID = v_order_id,
        CART_STATUS = 'PURCHASED'
    WHERE CART_STATUS = 'RESERVED'
    AND USERNAME = p_username;

	SELECT COUNT(*) 
	INTO currentcart 
	FROM cart 
	where order_id is null
    and username=p_username;

    -- Commit the transaction
    COMMIT;

    -- Optionally, handle exceptions or logging here
EXCEPTION
    WHEN OTHERS THEN
        -- Handle exceptions appropriately (e.g., logging, rollback, etc.)
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error processing cart: ' || SQLERRM);
        RAISE;
END payment_checkout;
/

DECLARE
    out_result NUMBER;
BEGIN
    --Inserting dummy records
    add_role('Admin');
    add_role('Customer');
    add_user('jdoe', 'John', 'Doe', '$2a$12$xZfNYVYeduMjK0gJOlxM6u8kfpc55L7rtCU7AxLpeI/OpS3DYmmDy', 1);
    
    add_stock('Tylenol', 100, 8.99, 'Pain reliever and fever reducer', out_result);
    add_stock('Advil', 150, 10.49, 'Pain reliever and anti-inflammatory',out_result);
    add_stock('Aspirin', 200, 5.99, 'Pain reliever and anti-inflammatory', out_result);
    add_stock('Benadryl', 75, 7.49, 'Allergy relief medication', out_result);
    add_stock('Claritin', 80, 12.99, 'Non-drowsy allergy relief', out_result);
    add_stock('Zyrtec', 90, 11.99, 'Allergy relief medication', out_result);
    add_stock('Allegra', 85, 13.49, 'Non-drowsy allergy relief', out_result);
    add_stock('Nyquil', 50, 9.99, 'Cold and flu relief medication', out_result);
    add_stock('Dayquil', 60, 8.99, 'Daytime cold and flu relief', out_result);
    add_stock('Robitussin', 45, 6.99, 'Cough syrup', out_result);
    add_stock('Sudafed', 55, 7.49, 'Nasal decongestant', out_result);
    add_stock('Mucinex', 65, 10.49, 'Expectorant and cough suppressant', out_result);
    add_stock('Pepto-Bismol', 70, 5.99, 'Digestive relief', out_result);
    add_stock('Tums', 90, 4.99, 'Antacid', out_result);
    add_stock('Imodium', 85, 7.99, 'Anti-diarrheal medication', out_result);
    add_stock('Dulcolax', 95, 6.49, 'Laxative', out_result);
    add_stock('Miralax', 100, 10.99, 'Laxative', out_result);
    add_stock('Gas-X', 80, 4.49, 'Anti-gas medication', out_result);
    add_stock('Metamucil', 60, 9.99, 'Fiber supplement', out_result);
    add_stock('Zantac', 75, 7.99, 'Heartburn relief', out_result);
    add_stock('Prilosec', 70, 11.49, 'Acid reducer', out_result);
    add_stock('Nexium', 65, 13.99, 'Acid reducer', out_result);
    add_stock('Prevacid', 55, 12.49, 'Acid reducer', out_result);
    add_stock('Hydrocortisone', 100, 4.99, 'Anti-itch cream', out_result);
    add_stock('Neosporin', 75, 6.49, 'Antibiotic ointment', out_result);
    add_stock('Benadryl Cream', 80, 5.99, 'Anti-itch cream', out_result);
    add_stock('Cortizone-10', 85, 7.49, 'Anti-itch cream', out_result);
    add_stock('Polysporin', 90, 6.99, 'Antibiotic ointment', out_result);
    add_stock('Calamine Lotion', 95, 4.49, 'Anti-itch lotion', out_result);
    add_stock('Lamisil', 100, 12.99, 'Antifungal cream', out_result);

END;