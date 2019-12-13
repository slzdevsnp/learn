DO
 $code$
 BEGIN
    PERFORM pk FROM files;
    --FOUND is a global variable
    IF FOUND THEN
       RAISE DEBUG 'FOUND value: %',FOUND;
       RAISE DEBUG 'The files tables contain some data in pk column';
    END IF;
 END
 $code$;
