DECLARE
    nCount number :=5;
    p_id number;
    sSQL_Query varchar(200) := 'insert into tst_simpletable VALUES (:1)';
BEGIN
 /* --insert into tst_simpletable (id) VALUES (TST_SIMPLETABLE_SEQ.nextval)  */  
         FOR i IN 1..nCount 
             LOOP
                    select TST_SIMPLETABLE_SEQ.nextval into p_id from dual;
                    execute immediate 'insert into tst_simpletable (id) VALUES (:id)' using p_id;
             END LOOP;  
 dbms_output.put_line('Sorted Array  ');  
end; 



