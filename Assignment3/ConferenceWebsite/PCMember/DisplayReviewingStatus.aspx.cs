using System;
using System.Data;
using System.Web.UI.WebControls;

public partial class PCMember_DisplayReviewingStatus : System.Web.UI.Page
{
    private ConferenceDB myConferenceDB = new ConferenceDB();
    private Helpers myHelpers = new Helpers();
    private bool sqlError = false;
    private DataTable dtSubmissions;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    private string GetSubmissionsReviewed(string pcCode)
    {
        //***************
        // Uses TODO 26 *
        //***************
        dtSubmissions = myConferenceDB.GetAssignedSubmissionsReviewed(pcCode);

        // Display the submissions assigned and reviewed if the query result is not null.
        if (dtSubmissions != null)
        {
            if (dtSubmissions.Rows.Count != 0)
            {
                gvAssignmentsReviewed.DataSource = dtSubmissions;
                gvAssignmentsReviewed.DataBind();
                pnlSubmissionsReviewed.Visible = true;
                return "some";
            }
            else // No submissions reviewed.
            {
                pnlSubmissionsReviewed.Visible = false;
                return "none";
            }
        }
        else // An SQL error occurred.
        {
            myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 26 has an error or is incorrect.");
            return "error";
        }
    }

    private string GetSubmissionsNotReviewed(string pcCode)
    {
        //***************
        // Uses TODO 27 *
        //***************
        dtSubmissions = myConferenceDB.GetAssignedSubmissionsNotReviewed(pcCode);

        // Display the submissions assigned but not yet reviewed if the query result is not null.
        if (dtSubmissions != null)
        {
            if (dtSubmissions.Rows.Count != 0)
            {
                gvAssignmentsNotReviewed.DataSource = dtSubmissions;
                gvAssignmentsNotReviewed.DataBind();
                pnlSubmissionsNotReviewed.Visible = true;
                return "some";
            }
            else // No submissions to review.
            {
                pnlSubmissionsNotReviewed.Visible = false;
                return "none";
            }
        }
        else // An SQL error occurred.
        {
            myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 27 has an error or is incorrect.");
            return "error";
        }
    }

    protected void btnGetAssignments_Click(object sender, EventArgs e)
    {
        Page.Validate("PCCodeValidation");
        if (Page.IsValid && !sqlError)
        {
            lblResultMessage.Visible = false;
            string pcCode = myHelpers.CleanInput(txtPCCode.Text);
            string reviewedResult = GetSubmissionsReviewed(pcCode);
            string notReviewedResult = GetSubmissionsNotReviewed(pcCode);

            // No submissions assigned for review.
            if (reviewedResult == "none" && notReviewedResult == "none")
            {
                myHelpers.ShowMessage(lblResultMessage, "No submissions have been assigned to you for review.");
            }
            // Submissions assigned; no reviews completed.
            else if (reviewedResult == "none" && notReviewedResult == "some")
            {
                myHelpers.ShowMessage(lblResultMessage, "No submissions assigned to you have been reviewed.");
            }
            // Submissions assigned; all reviews completed.
            else if (reviewedResult == "some" && notReviewedResult == "none")
            {
                myHelpers.ShowMessage(lblResultMessage, "All submissions assigned to you have been reviewed.");
            }
            // Submissions assigned; not all reviews completed.
        }
    }

    protected void cvPCCodeValidate_ServerValidate(object source, System.Web.UI.WebControls.ServerValidateEventArgs args)
    {
        if (Page.IsValid)
        {
            //***************
            // Uses TODO 01 *
            //***************
            decimal queryResult = myConferenceDB.IsPCCodeValid(myHelpers.CleanInput(txtPCCode.Text));
            if (queryResult == 0) // Nonexistent PC code.
            {
                args.IsValid = false;
            }
            else if (queryResult == -1) // An SQL error occurred.
            {
                sqlError = true;
                myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 01 has an error or is incorrect.");
            }
        }
    }

    protected void gvAssignmentsReviewed_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
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

    protected void gvAssignmentsNotReviewed_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
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
}