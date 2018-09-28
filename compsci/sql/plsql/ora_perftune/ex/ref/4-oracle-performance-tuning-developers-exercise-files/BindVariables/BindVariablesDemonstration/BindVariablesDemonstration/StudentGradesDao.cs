using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Oracle.ManagedDataAccess.Client;

namespace BindVariablesDemonstration
{
    public abstract class StudentGradesDao
    {

        public abstract List<CourseGrade> LoadGrades(int studentId, String termCode);


        protected CourseGrade MapRow(OracleDataReader reader)
        {
            CourseGrade cg = new CourseGrade();
            cg.DepartmentCode = reader.GetString(0);
            cg.CourseNumber = reader.GetInt32(1);
            cg.CourseTitle = reader.GetString(2);
            cg.Credits = reader.GetDouble(3);
            cg.Grade = reader.GetString(4);
            return cg;
        }


    }
}
