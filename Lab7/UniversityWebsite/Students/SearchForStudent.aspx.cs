using System;
using System.Data;

public partial class SearchForStudent : System.Web.UI.Page
{
    UniversityDB myUniversityDB = new UniversityDB();
    Helpers myHelpers = new Helpers();

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnFindStudent_Click(object sender, EventArgs e)
    {
        // Reset the page.
        lblResultMessage.Visible = false;
        pnlStudentRecord.Visible = false;
        if (Page.IsValid)
        {
            string studentId = myHelpers.CleanInput(txtStudentId.Text);

            //**************
            // Uses TODO 1 *
            //**************
            DataTable dtStudentRecord = myUniversityDB.GetStudentRecord(studentId);

            // Show the student record if the query result is not null and something was retrieved.
            if (dtStudentRecord != null)
            {
                // Display a no result message if nothing was retrieved from the database.
                if (dtStudentRecord.Rows.Count != 0)
                {
                    gvStudentRecord.DataSource = dtStudentRecord;
                    gvStudentRecord.DataBind();
                    pnlStudentRecord.Visible = true;
                }
                else // Display a no result message.
                {
                    myHelpers.ShowMessage(lblResultMessage, "No record for the student was found.");
                }
            }
            else // An SQL error occurred.
            {
                myHelpers.ShowMessage(lblResultMessage, "*** There is an error in the SQL statement of TODO 1.");
            }
        }
    }
}