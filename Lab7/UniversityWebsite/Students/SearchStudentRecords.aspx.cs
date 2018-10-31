using System;
using System.Data;

public partial class SearchStudentRecords : System.Web.UI.Page
{
    UniversityDB myUniversityDB = new UniversityDB();
    Helpers myHelpers = new Helpers();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            pnlSearch.Visible = false;
            //**************
            // Uses TODO 4 *
            //**************
            DataTable dtDepartments = myUniversityDB.GetDepartments();
            // Populate the department dropdown list.
            if (dtDepartments != null)
            {
                if (dtDepartments.Rows.Count != 0)
                {
                    ddlDepartments.DataSource = dtDepartments;
                    ddlDepartments.DataValueField = "DEPARTMENTID";
                    ddlDepartments.DataTextField = "DEPARTMENTNAME";
                    ddlDepartments.DataBind();
                    ddlDepartments.Items.Insert(0, "-- Select --");
                    ddlDepartments.Items.FindByText("-- Select --").Value = "none selected";
                    ddlDepartments.SelectedIndex = 0;
                    pnlSearch.Visible = true;
                }
                else
                {
                    myHelpers.ShowMessage(lblResultMessage, "There are no departments.");
                }
            }
            else // An SQL error occurred.
            {
                myHelpers.ShowMessage(lblResultMessage, "*** There is an error in the SQL statement of TODO 4.");
            }
        }
    }

    protected void btnFindStudentRecords_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            // Reset the page.
            lblResultMessage.Visible = false;
            pnlSearchResult.Visible = false;

            // Get the department id from the dropdown list.
            string departmentId = ddlDepartments.SelectedItem.Value;

            //**************
            // Uses TODO 3 *
            //**************
            DataTable dtStudentRecords = myUniversityDB.GetDepartmentStudentRecords(departmentId);

            // Show the student records if the query result is not null and something was retrieved.
            if (dtStudentRecords != null)
            {
                if (dtStudentRecords.Rows.Count != 0)
                {
                    gvFindStudentRecordsResult.DataSource = dtStudentRecords;
                    gvFindStudentRecordsResult.DataBind();
                    pnlSearchResult.Visible = true;
                }
                else // Display a no result message.
                {
                    myHelpers.ShowMessage(lblResultMessage, "There are no students in the " + ddlDepartments.SelectedItem.Text + " department.");
                }
            }
            else // An SQL error occurred.
            {
                myHelpers.ShowMessage(lblResultMessage, "*** There is an error in the SQL statement of TODO 3.");
            }
        }
    }
}