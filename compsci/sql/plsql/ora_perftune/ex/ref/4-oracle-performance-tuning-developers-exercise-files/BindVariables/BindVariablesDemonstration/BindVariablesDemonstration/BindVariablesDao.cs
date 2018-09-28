using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using Oracle.ManagedDataAccess.Client;

namespace BindVariablesDemonstration
{
    public class BindVariablesDao : StudentGradesDao
    {

        public override List<CourseGrade> LoadGrades(int studentId, String termCode)
        {
            List<CourseGrade> grades = new List<CourseGrade>();

            String conString = ConfigurationManager.ConnectionStrings["STUDENT"].ConnectionString;
            using (OracleConnection con = new OracleConnection(conString))
            {
                con.Open();
                using (OracleCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = @"SELECT department_code, course_number, course_title,
                        credits, grade_code, points FROM v_student_grades    
                        WHERE student_id = :student_id AND term_code = :term_code";

                    // Add in paramters for the query
                    OracleParameter studentIdParm = new OracleParameter(":student_id", studentId);
                    cmd.Parameters.Add(studentIdParm);
                    OracleParameter termCodeParm = new OracleParameter(":term_code", termCode);
                    cmd.Parameters.Add(termCodeParm);


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











        private OracleParameter CreateParameter(String parameterName, OracleDbType dbType, object value)
        {
            OracleParameter parm = new OracleParameter(":student_id", dbType);
            parm.Value = value;
            return parm;
        }

                    //        cmd.Parameters.Add(this.CreateParameter(":student_id", OracleDbType.Int32, studentId));
                    //cmd.Parameters.Add(this.CreateParameter(":term_code", OracleDbType.Varchar2, termCode));


    }
}
