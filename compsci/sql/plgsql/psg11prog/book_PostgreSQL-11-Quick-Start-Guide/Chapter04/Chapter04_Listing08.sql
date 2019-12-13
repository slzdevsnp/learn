CREATE OR REPLACE FUNCTION
f_file_by_type( file_type text DEFAULT 'txt' )
RETURNS SETOF files
AS
  $code$
  BEGIN
    RETURN QUERY
    SELECT *
    FROM files
    WHERE f_type = file_type
    ORDER BY f_name;
  END
  $code$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION
f_file_by_type_mod( file_type text DEFAULT 'txt' )
RETURNS TABLE(f_name text, f_type text)
AS
  $code$
  BEGIN
    RETURN QUERY
    SELECT f.f_name, f.f_type
    FROM files f
    WHERE f.f_type = file_type
    ORDER BY f_name;
  END
  $code$
LANGUAGE plpgsql;
