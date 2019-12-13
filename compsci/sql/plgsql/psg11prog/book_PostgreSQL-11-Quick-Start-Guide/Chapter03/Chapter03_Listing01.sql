DO
 $code$
   DECLARE
      i int;  -- initial value is NULL
      t text DEFAULT 'Hello World!';
      d date DEFAULT CURRENT_DATE;
   BEGIN
      i:= -1;
      RAISE INFO 'Variables are: d = [%], t = [%], i = [%]',
                                                     d, t, i;
   END
 $code$;
