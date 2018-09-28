using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using Oracle.ManagedDataAccess.Client;


namespace BindVariablesDemonstration
{
    public class LiteralValuesDao : StudentGradesDao
    {


        public override List<CourseGrade> LoadGrades(int studentId, String termCode)
        {
            List<CourseGrade> grades = new List<CourseGrade>();

            String connectionString = ConfigurationManager.ConnectionStrings["STUDENT"].ConnectionString;
            using (OracleConnection con = new OracleConnection(connectionString))
            {
                con.Open();
                using (OracleCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = @"SELECT department_code, course_number, course_title,
                        credits, grade_code, points FROM v_student_grades    
                        WHERE student_id = " + studentId + " AND term_code = '" + termCode + "'";
                   
                    using (OracleDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            grades.Add(this.MapRow(reader));
                        }
                    }
                }
            }
            return grades;
        }


    }
}
