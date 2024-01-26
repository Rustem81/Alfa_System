DECLARE
  TYPE va_int IS VARRAY(100) OF NUMBER;
  v_int    va_int;
  v_val    NUMBER;
  v_tf    NUMBER := 1;
  v_idx    NUMBER := 0;
BEGIN
v_int := va_int(1,12,9,6,3,31,2,7,9, 1,12,9,6,3,31,2,7,9);
 
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