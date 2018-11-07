using System;
using System.Data;
using System.Web.UI.WebControls;

public partial class Author_FindAllAuthorSubmissions : System.Web.UI.Page
{
    private ConferenceDB myConferenceDB = new ConferenceDB();
    private Helpers myHelpers = new Helpers();
    private DataTable dtSubmission;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSearchPaper_Click(object sender, EventArgs e)
    {
        lblResultMessage.Visible = false;
        if (Page.IsValid)
        {
            pnlSearchResult.Visible = false;

            // Get the email from the search page and check if valid.
            string email = myHelpers.CleanInput(txtEmail.Text);

            //***************
            // Uses TODO 06 *
            //***************
            dtSubmission = myConferenceDB.GetSubmissionsForAuthor(email);

            // Display the query result if it is not null.
            if (dtSubmission != null)
            {
                if (dtSubmission.Rows.Count != 0)
                {
                    gvSubmission.DataSource = dtSubmission;
                    gvSubmission.DataBind();
                    pnlSearchResult.Visible = true;
                }
                else // There are no submissions.
                {
                    myHelpers.ShowMessage(lblResultMessage, "You do not have any submissions.");
                }
            }
            else  // An SQL error occurred.
            {
                myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 06 has an error or is incorrect.");
            }
        }
    }

    protected void gvSubmission_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        if (e.Row.Controls.Count == 4)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                myHelpers.RenameGridViewColumn(e, "SUBMISSIONNO", "SUBMISSION");
                myHelpers.RenameGridViewColumn(e, "SUBMISSIONTYPE", "TYPE");
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Center;
            }
        }
    }

    protected void cvEmail_ServerValidate(object source, ServerValidateEventArgs args)
    {
        //***************
        // Uses TODO 07 *
        //***************
        if (myConferenceDB.IsAuthor(myHelpers.CleanInput(txtEmail.Text)) != 1)
        {
            args.IsValid = false;
            pnlSearchResult.Visible = false;
        }
    }
}