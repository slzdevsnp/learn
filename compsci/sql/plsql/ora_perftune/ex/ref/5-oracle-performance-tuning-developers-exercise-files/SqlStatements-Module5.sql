-- ---------------------------------------------------------------------------------
--
-- This is the main SQL statement used throughout the module
-- 
-- ---------------------------------------------------------------------------------

SELECT cs.department_code, cs.course_number,
    cs.course_title, cs.credits, g.grade_code, g.points
    FROM course_enrollments c
    INNER JOIN grades g
        ON c.grade_code = g.grade_code
    INNER JOIN course_offerings co
        ON c.course_offering_id = co.course_offering_id
    INNER JOIN courses cs
        ON co.department_code = cs.department_code
        AND co.course_number = cs.course_number
    WHERE student_id = '206960'
        AND co.term_code = 'FA2012';
		
-- ---------------------------------------------------------------------------------
--
-- This is the SQL statement against the small version of the course enrollments table
-- 
-- ---------------------------------------------------------------------------------

SELECT cs.department_code, cs.course_number,
    cs.course_title, cs.credits, g.grade_code, g.points
    FROM course_enrollments_small c
    INNER JOIN grades g
        ON c.grade_code = g.grade_code
    INNER JOIN course_offerings co
        ON c.course_offering_id = co.course_offering_id
    INNER JOIN courses cs
        ON co.department_code = cs.department_code
        AND co.course_number = cs.course_number
    WHERE student_id = '206960'
        AND co.term_code = 'FA2012';

	
-- ---------------------------------------------------------------------------------
--
-- Use the following two commands to create and drop the index on the studnet id column
-- to see the impact on the execution plan
--
-- ----------------------------------------------------------------------------------
	
-- CREATE INDEX IX_COURSE_ENROLL_STUDENT_ID ON course_enrollments (student_id);
-- DROP INDEX IX_COURSE_ENROLL_STUDENT_ID;