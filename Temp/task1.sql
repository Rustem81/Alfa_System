DECLARE  
    TYPE va_int IS VARRAY(100) OF PLS_INTEGER;
    v_val       PLS_INTEGER;
    v_tf        PLS_INTEGER := 1;
    v_idx       PLS_INTEGER := 0;
    nCount number :=100;
    nRandom number;
    data_array va_int := va_int(null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
BEGIN
    FOR i IN 1..nCount 
        LOOP
            select ROUND(dbms_random.value(1,999)) AS NUM into nRandom from dual; --получаем случайное число
            data_array(i) := nRandom; --заполняем значение по индексу в массиве
        END LOOP;  
      DBMS_OUTPUT.PUT('Input Array ['||data_array.COUNT||'] -> [');
      FOR idx IN data_array.FIRST..data_array.LAST LOOP
         IF idx < data_array.LAST THEN
            DBMS_OUTPUT.PUT(data_array(idx)||', ');
         ELSE
            DBMS_OUTPUT.PUT_LINE(data_array(idx)||']');
         END IF;
      END LOOP;
    WHILE v_tf = 1 LOOP
      v_tf := 0;
      v_idx := v_idx+1;
      FOR idx IN data_array.FIRST..data_array.LAST LOOP    
      IF idx < data_array.COUNT THEN
         IF data_array(idx) > data_array(idx+1) THEN
            v_val := data_array(idx);
            data_array(idx) := data_array(idx+1);
            data_array(idx+1) := v_val;
            v_tf := 1;
         END IF;
      END IF;    
      END LOOP;
    END LOOP;
      DBMS_OUTPUT.PUT_LINE(' Ascending Sort Iterations -> '||v_idx);
      DBMS_OUTPUT.PUT('Sorted Array ['||data_array.COUNT||'] -> [');
      FOR idx IN data_array.FIRST..data_array.LAST LOOP
         IF idx < data_array.LAST THEN
            DBMS_OUTPUT.PUT(data_array(idx)||', ');
         ELSE
            DBMS_OUTPUT.PUT_LINE(data_array(idx)||']');
         END IF;
      END LOOP; 
END;