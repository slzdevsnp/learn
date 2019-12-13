SET client_min_messages TO debug;
DO $code$
BEGIN
  RAISE DEBUG 'AA debug message';
  RAISE INFO  'AAn info message';
END $code$;

-- DEBUG:  A debug message
-- INFO:  An info message

SET client_min_messages TO info;
DO $code$
BEGIN
  RAISE DEBUG 'BA debug message';
  RAISE INFO  'BAn info message';
END $code$;

--INFO:  An info message
SET client_min_messages TO debug;
