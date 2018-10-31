using System;
using System.Web.UI.WebControls;
using System.Data;

public partial class EnrollInCourse : System.Web.UI.Page
{
    UniversityDB myUniversityDB = new UniversityDB();
    Helpers myHelpers = new Helpers();

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnFindAvailableCourses_Click(object sender, EventArgs e)
    {
        pnlAvailableCourses.Visible = false;
        if (Page.IsValid)
        {
            // Hide the search result message.
            lblResultMessage.Visible = false;
            string studentId = myHelpers.CleanInput(txtStudentId.Text);

            //**************
            // Uses TODO 6 *
            //**************
            DataTable dtAvailableCourses = myUniversityDB.GetCoursesAvailableToEnroll(studentId);

            // Show the courses available to enroll in if the query result is not null and something was retrieved.
            if (dtAvailableCourses != null)
            {
                if (dtAvailableCourses.Rows.Count != 0)
                {
                    gvAvailableCourses.DataSource = dtAvailableCourses;
                    gvAvailableCourses.DataBind();
                    pnlAvailableCourses.Visible = true;
                }
                else // Display a no result message.
                {
                    lblResultMessage.Text = "There are no courses available for the student to enroll in.";
                }
            }
            else // An SQL error occurred.
            {
                myHelpers.ShowMessage(lblResultMessage, "*** There is an error in the SQL statement of TODO 6.");
            }
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        lblResultMessage.Visible = false;
        if (Page.IsValid)
        {
            string studentId = myHelpers.CleanInput(txtStudentId.Text);
            int coursesEnrolled = 0;

            // Search each row of the GridView to determine if any courses were selected.
            foreach (GridViewRow row in gvAvailableCourses.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    CheckBox chkRow = (row.Cells[0].FindControl("chkRow") as CheckBox);
                    if (chkRow != null && chkRow.Checked)
                    {
                        coursesEnrolled = coursesEnrolled + 1;
                        // Get the course id of the selected course.
                        string courseId = myHelpers.CleanInput(row.Cells[1].Text);

                        //**************
                        // Uses TODO 7 *
                        //**************
                        if (!myUniversityDB.EnrollInCourses(studentId, courseId))
                        {
                            myHelpers.ShowMessage(lblResultMessage, "*** There is an error in the SQL statement of TODO 7.");
                            return;
                        }
                    }
                }

                // Display a message indicating result of enrollment.
                if (coursesEnrolled != 0)
                {
                    if (coursesEnrolled == 1)
                    {
                        myHelpers.ShowMessage(lblResultMessage, "The student has successfully enrolled in "
                            + coursesEnrolled.ToString() + " course.");
                    }
                    else
                    {
                        myHelpers.ShowMessage(lblResultMessage, "The student has successfully enrolled in "
                            + coursesEnrolled.ToString() + " courses.");
                    }
                    pnlAvailableCourses.Visible = false;
                }
                else
                {
                    myHelpers.ShowMessage(lblResultMessage, "Please select a course to enroll in.");
                }
            }
        }
    }

    protected void cv_studentId_ServerValidate(object source, ServerValidateEventArgs args)
    {
        //**************
        // Uses TODO 2 *
        //**************
        decimal queryResult = myUniversityDB.StudentIdIsValid(myHelpers.CleanInput(txtStudentId.Text));
        if (queryResult == 0) // There is no such student id.
        {
            myHelpers.ShowMessage(lblResultMessage, "There is no student with this student id.");
            pnlAvailableCourses.Visible = false;
            args.IsValid = false;
        }
        else if (queryResult == -1 | queryResult > 1) // An SQL error occurred.
        {
            myHelpers.ShowMessage(lblResultMessage, "*** There is an error in the SQL statement of TODO 2.");
            pnlAvailableCourses.Visible = false;
            args.IsValid = false;
        }
    }
}