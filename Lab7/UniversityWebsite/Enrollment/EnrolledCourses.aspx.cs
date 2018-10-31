using System;
using System.Data;

public partial class EnrolledCourses : System.Web.UI.Page
{
    UniversityDB myUniversityDB = new UniversityDB();
    Helpers myHelpers = new Helpers();

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnFindEnrolledCourses_Click(object sender, EventArgs e)
    {
        pnlEnrolledCourses.Visible = false;
        if (Page.IsValid)
        {
            // Hide the search result.
            lblResultMessage.Visible = false;
            string studentId = myHelpers.CleanInput(txtStudentId.Text);

            //**************
            // Uses TODO 5 *
            //**************
            DataTable dtEnrolledCourses = myUniversityDB.GetEnrolledCourses(studentId);

            // Show the enrolled courses if the query result is not null and something was retrieved.
            if (dtEnrolledCourses != null)
            {
                if (dtEnrolledCourses.Rows.Count != 0)
                {
                    gvEnrolledCourses.DataSource = dtEnrolledCourses;
                    gvEnrolledCourses.DataBind();
                    pnlEnrolledCourses.Visible = true;
                }
                else // Display a no result message.
                {
                    myHelpers.ShowMessage(lblResultMessage, "Student " + studentId + " is not enrolled in any courses.");
                }
            }
            else //An SQL error occurred.
            {
                myHelpers.ShowMessage(lblResultMessage, "*** There is an error in the SQL statement of TODO 5.");
            }
        }
    }

    protected void cvStudentId_ServerValidate(object source, System.Web.UI.WebControls.ServerValidateEventArgs args)
    {
        //**************
        // Uses TODO 2 *
        //**************
        decimal queryResult = myUniversityDB.StudentIdIsValid(myHelpers.CleanInput(txtStudentId.Text));
        if (queryResult == 0) // There is no such student id.
        {
            myHelpers.ShowMessage(lblResultMessage, "There is no student with this student id.");
            args.IsValid = false;
        }
        else if (queryResult == -1 | queryResult > 1) // An SQL error occurred.
        {
            myHelpers.ShowMessage(lblResultMessage, "*** There is an error in the SQL statement of TODO 2.");
            args.IsValid = false;
        }
    }
}