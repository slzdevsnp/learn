SET client_min_messages TO DEBUG;
DO
 $code$
 DECLARE
  current_record record;
  count int;
 BEGIN
  RAISE DEBUG 'In the beginning FOUND = %', FOUND; --f
  count := 0;
  FOR current_record IN SELECT *
                        FROM files
                        LIMIT 3
                    LOOP
   RAISE DEBUG 'While iterating step %, FOUND = %', count, FOUND; --select does not fill FOUND -f

   IF current_record.pk % 2 = 0 THEN
     -- this statement will fail
     PERFORM pk
     FROM files
     WHERE f_hash = 'FAIL' || current_record.f_hash;

     RAISE DEBUG 'After a failing statement FOUND = %', FOUND;
   ELSE
      -- this statement will succeed
      PERFORM pk
      FROM files
      WHERE f_hash = current_record.f_hash;

      RAISE DEBUG 'After a succeeding statement FOUND = %', FOUND;
   END IF;
   count := count + 1;

  END LOOP;

  RAISE DEBUG 'Outside the loop FOUND = %', FOUND;

 END
 $code$;
