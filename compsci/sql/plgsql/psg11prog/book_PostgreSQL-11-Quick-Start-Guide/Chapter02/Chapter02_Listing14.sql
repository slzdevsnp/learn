BEGIN;
INSERT INTO archive_files
SELECT * FROM files;
DELETE FROM files where 1=1;
COMMIT;
