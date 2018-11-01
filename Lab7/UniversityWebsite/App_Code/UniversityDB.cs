// Nathaniel Wihardjo (20315011)
using Oracle.DataAccess.Client;
using System.Data;

/// <summary>
/// Student name: 
/// Student id: 
/// </summary>

public class UniversityDB
{
    OracleDBAccess myOracleDBAccess = new OracleDBAccess();
    private string sql;

    #region SQL statements for students
    public DataTable GetStudentRecord(string studentId)
    {
        //******************************************************************
        // TODO 1: Used in SearchForStudent.aspx.cs                        *
        // Construct the SELECT statement to find the record (i.e., return *
        // all the attributes) of a student identified by a studentId.     *
        //******************************************************************
        sql = "select * from Student where studentId='" + studentId + "'";
        return myOracleDBAccess.GetData(sql);
    }

    public decimal StudentIdIsValid(string studentId)
    {
        //*******************************************************************
        // TODO 2: Use in EnrolledCourses.aspx.cs, EnrollsInCourses.aspx.cs *
        // Determine if the student id exists in the database.              *
        // Returns 0 - does not exist; 1 - exists; -1 - SQL error.          *
        //*******************************************************************
        sql = "select count(*) from Student where studentId='" + studentId + "'";
        return myOracleDBAccess.GetAggregateValue(sql);
    }

    public DataTable GetDepartmentStudentRecords(string departmentId)
    {
        //************************************************************************
        // TODO 3: Used in SearchStudentRecords.aspx.cs                          *
        // Construct the SELECT statement to find the id, last name, first name  *
        // and cga of the students in a department identified by a departmentId. *
        //************************************************************************
        sql = "select studentId, lastName, firstName, CGA from Student where departmentId='"
            + departmentId + "'";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetDepartments()
    {
        //*************************************************
        // TODO 4: Used in SearchStudentRecords.aspx.cs   *
        // Construct the SELECT statement to retrieve the *
        // department id and name of all departments.     *
        //*************************************************
        sql = "select departmentId, departmentName from Department";
        return myOracleDBAccess.GetData(sql);
    }

    #endregion SQL statements for students

    #region SQL statements for enrolling in courses
    public DataTable GetEnrolledCourses(string studentId)
    {
        //******************************************************************************
        // TODO 5: Used in EnrolledCourses.aspx.cs                                     *
        // Construct the SELECT statement to find the id, name, credits and instructor *
        // of the courses in which a student, identified by a studentiId, is enrolled. *
        //******************************************************************************
        sql = "select E.courseId, courseName, credits, instructor from EnrollsIn E, Course C " +
            "where E.courseId=C.courseId and studentId='" + studentId + "'";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetCoursesAvailableToEnroll(string studentId)
    {
        //*********************************************************************************
        // TODO 6: Used in EnrollInCourses.aspx.cs                                        *
        // Construct the SELECT statement to find the id, name, credits and instructor of *
        // the courses that a student, identified by a studentiId, is NOT enrolled in.    *
        //*********************************************************************************
        sql = "with temp (courseId) as ((select courseId from Course) minus "+
            "(select courseId from EnrollsIn where studentId='"+studentId+"')) "+
            "select T.courseId, courseName, credits, instructor from temp T, Course C "+
            "where T.courseId = C.courseId";
        return myOracleDBAccess.GetData(sql);
    }

    public bool EnrollInCourses(string studentId, string courseId)
    {
        //**********************************************************************************
        // TODO 7: Used in EnrollInCourses.aspx.cs                                         *
        // Construct the INSERT statement to enroll a student in his/her selected courses. *
        //**********************************************************************************
        sql = "insert into EnrollsIn values ('"+studentId+"', '"+courseId+"',null)";
        return UpdateData(sql);
    }

    #endregion SQL statement for enrolling in courses

    #region *** DO NOT CHANGE THE METHOD BELOW THIS LINE. IT IS NOT A TODO!!! ***!
    private bool UpdateData(string sql)
    {
        OracleTransaction trans = myOracleDBAccess.BeginTransaction();
        if (trans == null) { return false; }  // Error creating the transaction.
        if (myOracleDBAccess.SetData(sql, trans))
        { myOracleDBAccess.CommitTransaction(trans); return true; } // The update succeeded.
        else
        { myOracleDBAccess.DisposeTransaction(trans); return false; } // The update failed.
    }
    #endregion
}