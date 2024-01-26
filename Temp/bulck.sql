DECLARE
  
  TYPE va_int IS VARRAY(200) OF PLS_INTEGER;
  v_int    va_int;
  
  v_val    PLS_INTEGER;
  v_tf    PLS_INTEGER := 1;
  v_idx    PLS_INTEGER := 0;
  


    nCount number := 200;
    sUnionQUery clob;

  
BEGIN
    FOR i IN 1..nCount LOOP      
      if i != nCount then
      sUnionQUery := sUnionQUery || 'select ROUND(dbms_random.value(1,999)) AS NUM  from dual union ';      
      elsif i = nCount  then   
      sUnionQUery := sUnionQUery || 'select ROUND(dbms_random.value(1,999)) AS NUM  from dual';           
      end if;      
    END LOOP;
 EXECUTE IMMEDIATE sUnionQUery BULK COLLECT INTO v_int;
 
 
 


    

 
  DBMS_OUTPUT.PUT('Input Array ['||v_int.COUNT||'] -> [');
  FOR idx IN v_int.FIRST..v_int.LAST LOOP
     IF idx < v_int.LAST THEN
        DBMS_OUTPUT.PUT(v_int(idx)||', ');
     ELSE
        DBMS_OUTPUT.PUT_LINE(v_int(idx)||']');
     END IF;
  END LOOP;
 
WHILE v_tf = 1 LOOP
  v_tf := 0;
  v_idx := v_idx+1;
  FOR idx IN v_int.FIRST..v_int.LAST LOOP
 
  IF idx < v_int.COUNT THEN
     IF v_int(idx) > v_int(idx+1) THEN
        v_val := v_int(idx);
        v_int(idx) := v_int(idx+1);
        v_int(idx+1) := v_val;
        v_tf := 1;
     END IF;
  END IF;
 
  END LOOP;
END LOOP;
  DBMS_OUTPUT.PUT_LINE(' Ascending Sort Iterations -> '||v_idx);
 
  DBMS_OUTPUT.PUT('Sorted Array ['||v_int.COUNT||'] -> [');
  FOR idx IN v_int.FIRST..v_int.LAST LOOP
     IF idx < v_int.LAST THEN
        DBMS_OUTPUT.PUT(v_int(idx)||', ');
     ELSE
        DBMS_OUTPUT.PUT_LINE(v_int(idx)||']');
     END IF;
  END LOOP;
 
END;