DO
 $code$
 BEGIN
  FOR counter IN 1 .. 5 LOOP
      RAISE INFO 'This is the % time I say HELLO', counter;
  END LOOP;

  FOR counter IN 1 .. 5 BY 2 LOOP
      RAISE INFO 'This is the % time I say HELLO', counter;
  END LOOP;
 END
 $code$;
