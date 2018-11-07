using System;
using System.Data;
using System.Web.UI.WebControls;

public partial class Author_FindSubmission : System.Web.UI.Page
{
    private ConferenceDB myConferenceDB = new ConferenceDB();
    private Helpers myHelpers = new Helpers();
    private DataTable dtSubmissions;
    private DataTable dtAuthors;

    private void HideSearchResult()
    {
        lblResultMessage.Visible = false;
        pnlSearchResult.Visible = false;
    }

    private void ShowSearchResult()
    {
        lblResultMessage.Visible = true;
        pnlSearchResult.Visible = true;
    }

    private bool GetSubmissionAuthors(string submissionNumber)
    {
        //***************
        // Uses TODO 08 *
        //***************
        dtAuthors = myConferenceDB.GetAuthorsForSubmission(submissionNumber);

        // Display the author information if the query result is not null.
        if (dtAuthors != null)
        {
            if (dtAuthors.Rows.Count != 0)
            {
                // Check if the contact author column is present in the query result.
                if (dtAuthors.Columns["contactAuthor"] != null)
                {
                    DataColumn col = dtAuthors.Columns.Add("CONTACT", typeof(string));
                    col.SetOrdinal(0);
                    foreach (DataRow row in dtAuthors.Rows)
                    {
                        if (row["contactAuthor"].ToString() != "")
                        {
                            row["CONTACT"] = "✓";
                        }
                    }
                    dtAuthors.Columns.Remove("contactAuthor");
                }
                gvAuthor.DataSource = dtAuthors;
                gvAuthor.DataBind();
                return true;
            }
            else // An SQL error occurred.
            {
                myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 08 has an error or is incorrect.");
                return false;
            }
        }
        else // An SQL error occurred.
        {
            myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 08 has an error or is incorrect.");
            return false;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSearchSubmission_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            HideSearchResult();

            // Get the submission number from the search page and check if it is an integer.
            string submissionNumber = myHelpers.CleanInput(txtSubmissionNumber.Text);

            //***************
            // Uses TODO 09 *
            //***************
            dtSubmissions = myConferenceDB.GetSubmissionDetails(submissionNumber);

            // Display the submission details if the query result is not null.
            if (dtSubmissions != null)
            {
                if (dtSubmissions.Rows.Count != 0)
                {
                    foreach (DataRow row in dtSubmissions.Rows)
                    {
                        txtTitle.Text = row[0].ToString();
                        txtAbstract.Text = row[1].ToString();
                        txtSubmissionType.Text = row[2].ToString();
                    }
                    if (GetSubmissionAuthors(submissionNumber))
                    {
                        ShowSearchResult();
                    }
                }
                else // Nothing to display.
                {
                    myHelpers.ShowMessage(lblResultMessage, "There is no submission with this submission number.");
                }
            }
            else // An SQL error occurred.
            {
                myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 09 has an error or is incorrect.");
            }
        }
    }

    protected void gvAuthor_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        if (e.Row.Controls.Count == 7)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                myHelpers.RenameGridViewColumn(e, "PERSONNAME", "NAME");
                myHelpers.RenameGridViewColumn(e, "PHONENO", "PHONE NO");
                myHelpers.RenameGridViewColumn(e, "PERSONEMAIL", "EMAIL");
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Center;
            }
        }
    }
}