--Drop Tables
SET SERVEROUTPUT ON

BEGIN
    FOR i IN (
        WITH mytables AS (
            SELECT
                'PAYMENT' AS tname
            FROM
                dual
            UNION ALL
            SELECT
                'CART'
            FROM
                dual
            UNION ALL
            SELECT
                'ORDERTB'
            FROM
                dual
            UNION ALL
            SELECT
                'USERTB'
            FROM
                dual
            UNION ALL
            SELECT
                'STOCK'
            FROM
                dual
            UNION ALL
            SELECT
                'ROLES'
            FROM
                dual
        )
        SELECT
            m.tname
        FROM
                 mytables m
            INNER JOIN user_tables o ON m.tname = o.table_name
    ) LOOP
        BEGIN
            dbms_output.put_line('TABLE NAME TO BE DROPPED: ' || i.tname);
            EXECUTE IMMEDIATE 'DROP TABLE ' || i.tname;
        EXCEPTION
            WHEN OTHERS THEN
                dbms_output.put_line(sqlerrm);
        END;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(sqlerrm);
END;
/
 
--Drop sequences 
BEGIN
    FOR i IN (
        WITH mysequences AS (
            SELECT
                'ROLE_ID_SEQ' AS seq_name
            FROM
                dual
            UNION ALL
            SELECT
                'CART_ID_SEQ'
            FROM
                dual
            UNION ALL
            SELECT
                'ORDER_ID_SEQ'
            FROM
                dual
            UNION ALL
            SELECT
                'PAYMENT_ID_SEQ'
            FROM
                dual
        )
        SELECT
            m.seq_name
        FROM
                 mysequences m
            INNER JOIN user_sequences o ON m.seq_name = o.sequence_name
    ) LOOP
        BEGIN
            dbms_output.put_line('SEQUENCE TO BE DROPPED: ' || i.seq_name);
            EXECUTE IMMEDIATE 'DROP SEQUENCE ' || i.seq_name;
        EXCEPTION
            WHEN OTHERS THEN
                dbms_output.put_line(sqlerrm);
        END;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(sqlerrm);
END;
/

-- Create Sequences
CREATE SEQUENCE role_id_seq START WITH 1;

CREATE SEQUENCE cart_id_seq START WITH 1;

CREATE SEQUENCE order_id_seq START WITH 1;

CREATE SEQUENCE payment_id_seq START WITH 1;

-- Create Tables
CREATE TABLE roles (
    role_id   NUMBER(6, 0) DEFAULT role_id_seq.NEXTVAL NOT NULL,
    role_name VARCHAR2(50) NOT NULL,
    CONSTRAINT pk_roles PRIMARY KEY ( role_id ),
    CONSTRAINT uk_roles_role_name UNIQUE ( role_name )
);
/

CREATE TABLE usertb (
    username  VARCHAR2(20) NOT NULL,
    firstname VARCHAR2(50) NOT NULL,
    lastname  VARCHAR2(50),
    password  VARCHAR2(100) NOT NULL,
    role_id   NUMBER(6, 0) NOT NULL,
    CONSTRAINT pk_usertb PRIMARY KEY ( username ),
    CONSTRAINT user_role_fk FOREIGN KEY ( role_id )
        REFERENCES roles ( role_id )
            ON DELETE CASCADE
    ENABLE
);
/

CREATE TABLE stock (
    product     VARCHAR2(50) NOT NULL,
    quantity    NUMBER NOT NULL,
    unitprice   NUMBER NOT NULL,
    description VARCHAR2(200),
    CONSTRAINT pk_stock PRIMARY KEY ( product )
);
/

CREATE TABLE ordertb (
    order_id     NUMBER(10, 0) DEFAULT order_id_seq.NEXTVAL NOT NULL,
    username     VARCHAR2(50) NOT NULL,
    order_qty    NUMBER NOT NULL,
    order_status VARCHAR2(50),
    order_date   DATE,
    CONSTRAINT order_user_fk FOREIGN KEY ( username )
        REFERENCES usertb ( username )
            ON DELETE CASCADE
    ENABLE,
    CONSTRAINT pk_order PRIMARY KEY ( order_id )
);
/

CREATE TABLE cart (
    cart_id     NUMBER(10,0) DEFAULT cart_id_seq.NEXTVAL NOT NULL,
    product     VARCHAR2(50) NOT NULL,
    quantity    NUMBER NOT NULL,
    price       NUMBER NOT NULL,
    username    VARCHAR2(20) NOT NULL,
    order_id    NUMBER(10, 0),
    cart_status VARCHAR2(15),
    CONSTRAINT fk_cart_product FOREIGN KEY ( product )
        REFERENCES stock ( product ),
    CONSTRAINT fk_cart_username FOREIGN KEY ( username )
        REFERENCES usertb ( username ),
    CONSTRAINT fk_cart_order_id FOREIGN KEY ( order_id )
        REFERENCES ordertb ( order_id )
);
/

CREATE TABLE payment (
    payment_id     NUMBER(10, 0) DEFAULT payment_id_seq.NEXTVAL
        NOT NULL ENABLE,
    order_id       NUMBER(10, 0)
        NOT NULL ENABLE,
    payment_mode   VARCHAR2(50),
    payment_date   DATE,
    payment_status VARCHAR2(50),
    CONSTRAINT payment_pk PRIMARY KEY ( payment_id ),
    CONSTRAINT payment_order_fk FOREIGN KEY ( order_id )
        REFERENCES ordertb ( order_id )
            ON DELETE CASCADE
    ENABLE
);
/

-- Procedures
CREATE OR REPLACE PROCEDURE add_role (
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
    in_hashpwd  VARCHAR2,
    in_role_id  NUMBER
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
        raise_application_error(-20001, e_user_exists_msg);
    END IF;
EXCEPTION
    WHEN no_data_found THEN
        INSERT INTO usertb (
            username,
            firstname,
            lastname,
            password,
            role_id
        ) VALUES (
            in_username,
            in_frstname,
            in_lastname,
            in_hashpwd,
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
    out_result          OUT NUMBER
) AS
    v_exists          VARCHAR(5);
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
        raise_application_error(-20002, e_prod_exists_msg);
    END IF;
EXCEPTION
    WHEN no_data_found THEN
        INSERT INTO stock VALUES (
            in_product_name,
            in_product_quantity,
            in_product_cost,
            in_description
        );

        out_result := 1;
        COMMIT;
        dbms_output.put_line('Product added in stock');
END add_stock;
/

CREATE OR REPLACE PROCEDURE add_cart (
    in_product_name VARCHAR2,
    in_quantity     NUMBER,
    in_tot_price    NUMBER,
    in_username     VARCHAR2,
    out_result      OUT NUMBER
) IS
BEGIN
    INSERT INTO cart (
        product,
        quantity,
        price,
        username
    ) VALUES (
        in_product_name,
        in_quantity,
        in_tot_price,
        in_username
    );

    out_result := 1;
    dbms_output.put_line('Product added to cart');
    COMMIT;
END add_cart;
/

CREATE OR REPLACE PROCEDURE add_payment (
    in_order_id       NUMBER,
    in_payment_mode   VARCHAR2,
    in_payment_status VARCHAR2,
    out_result        OUT NUMBER
) IS
BEGIN
    INSERT INTO payment VALUES (
        payment_id_seq.NEXTVAL,
        in_order_id,
        in_payment_mode,
        sysdate,
        in_payment_status
    );

    out_result := 1;
END add_payment;
/

CREATE OR REPLACE PROCEDURE add_order (
    in_username     VARCHAR2,
    in_order_qty    NUMBER,
    in_order_status VARCHAR2,
    out_result      OUT NUMBER
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

    out_result := 1;
    dbms_output.put_line('Order Added');
    COMMIT;
END add_order;
/

CREATE OR REPLACE PROCEDURE payment_checkout (
    p_username  IN VARCHAR2,
    currentcart OUT NUMBER
) AS
    v_order_id NUMBER;
BEGIN
    SELECT
        order_id
    INTO v_order_id
    FROM
        ordertb
    WHERE
            username = p_username
        AND order_status = 'PENDING'
        AND ROWNUM = 1;

    UPDATE payment
    SET
        payment_status = 'COMPLETED'
    WHERE
        order_id = v_order_id;

    UPDATE ordertb
    SET
        order_status = 'COMPLETED',
        order_date = sysdate
    WHERE
        order_id = v_order_id;

    UPDATE cart
    SET
        order_id = v_order_id,
        cart_status = 'PURCHASED'
    WHERE
            cart_status = 'RESERVED'
        AND username = p_username;

    SELECT
        COUNT(*)
    INTO currentcart
    FROM
        cart
    WHERE
        order_id IS NULL
        AND username = p_username;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error processing cart: ' || sqlerrm);
        RAISE;
END payment_checkout;
/

DECLARE
    out_result NUMBER;
BEGIN
    --Initializing with dummy records
    add_role('Admin');
    add_role('Customer');
    add_user('jdoe', 'John', 'Doe', '$2a$12$xZfNYVYeduMjK0gJOlxM6u8kfpc55L7rtCU7AxLpeI/OpS3DYmmDy', 1);
    add_user('stella', 'Stella', 'Holmes', '$2a$12$GZHfDBFof.iOXm3YB4c8YuOwVUvSDk0aFbkCDpY/tD6zoPAiv1b5a', 2);
    add_stock('Tylenol', 100, 8.99, 'Pain reliever and fever reducer', out_result);
    add_stock('Advil', 150, 10.49, 'Pain reliever and anti-inflammatory', out_result);
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