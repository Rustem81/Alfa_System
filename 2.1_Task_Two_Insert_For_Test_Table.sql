DECLARE ncount NUMBER := 1000;

p_id NUMBER;

p_quantityin NUMBER;

p_quantityout NUMBER;

p_controldate DATE;

p_productname VARCHAR2(50);

BEGIN FOR i IN 1..ncount
LOOP
SELECT
    tst_simpletable_seq.NEXTVAL INTO p_id
FROM
    dual;

SELECT
    round(dbms_random.value (10, 20)) INTO p_quantityin
FROM
    dual;

SELECT
    round(dbms_random.value (5, 15)) INTO p_quantityout
FROM
    dual;

SELECT
    TO_DATE(
        TRUNC(
            DBMS_RANDOM.VALUE (
                TO_CHAR(DATE '2098-01-01', 'J'),
                TO_CHAR(DATE '2099-12-31', 'J')
            )
        ),
        'J'
    ) AS value INTO p_controldate
FROM
    DUAL;

SELECT
    CASE round(dbms_random.value (1, 4))
        WHEN 1 THEN 'oracledb_bug'
        WHEN 2 THEN 'microsoftsqlserver_bug'
        WHEN 3 THEN 'ibmdb2_bug'
        WHEN 4 THEN 'postgres_bug'
    END AS type INTO p_productname
FROM
    dual;

EXECUTE IMMEDIATE 'insert into tst_simpletable (id, dcontroldate, sproductname, nquantityin, nquantityout) values (:id, :dcontroldate, :sproductname, :nquantityin, :nquantityout)' USING p_id,
p_controldate,
p_productname,
p_quantityin,
p_quantityout;

END
LOOP;

END;