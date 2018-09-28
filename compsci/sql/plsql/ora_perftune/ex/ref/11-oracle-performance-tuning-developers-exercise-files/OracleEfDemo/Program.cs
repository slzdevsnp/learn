using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OracleEf;
using System.Data.Entity;

namespace OracleEfDemo
{
    class Program
    {
        static void Main(string[] args)
        {
            PrintStudentGpa();

            Console.ReadKey();
        }


        static void PrintStudentGpa()
        {
            using (StudentDb db = new StudentDb())
            {

                var student = db.STUDENTS
                    .Include(s => s.COURSE_ENROLLMENTS.Select(ce => ce.COURSE_OFFERINGS.COURS))
                    .Include(s => s.COURSE_ENROLLMENTS.Select(ce => ce.GRADE))
                    .Where(x => x.STUDENT_ID == 208167).FirstOrDefault();

                decimal totalPoints = 0.0m;
                decimal totalCreditsAttempted = 0.0m;

                foreach (var enrollment in student.COURSE_ENROLLMENTS)
                {
                    decimal credits = enrollment.COURSE_OFFERINGS.COURS.CREDITS;
                    decimal? gradePoints = enrollment.GRADE.POINTS;

                    totalCreditsAttempted += credits;
                    totalPoints += (gradePoints.Value * credits);
                }
                decimal gpa = totalPoints / totalCreditsAttempted;


                Console.WriteLine("{0} {1} GPA = {2:0.00}", 
                    student.FIRST_NAME, student.LAST_NAME, gpa);
            }
        }

















        static void PrintStarApplicants()
        {
            using (StudentDb db = new StudentDb())
            {
                var applicants = db.APPLICATIONS
                    .Where(a => a.GPA > 3.5m)
                    .Where(b => b.SAT_MATH_SCORE > 700);

                foreach (APPLICATION a in applicants)
                {
                    Console.WriteLine("{0} {1} - {2}, {3}",
                        a.FIRST_NAME, a.LAST_NAME,
                        a.CITY, a.STATE);
                }
            }
        }

    }
}
