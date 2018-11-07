using System;
using System.Data;

public partial class PCMember_DisplayRefereeReport : System.Web.UI.Page
{
    private ConferenceDB myConferenceDB = new ConferenceDB();
    private Helpers myHelpers = new Helpers();
    private bool sqlError = false;
    private DataTable dtSubmissionNumbers;
    private DataTable dtSubmissionTitle;
    private DataTable dtAuthors;
    private DataTable dtRefereeReport;
    private DataTable dtDiscussion;

    private bool GetSelectedSubmissionInfo(string submissionNumber)
    {
        lblResultMessage.Visible = false;
        //***************
        // Uses TODO 11 *
        //***************
        dtSubmissionTitle = myConferenceDB.GetSubmissionTitle(submissionNumber);
        // An SQL Error occurrred if the query result is null or empty, so exit.
        if (dtSubmissionTitle == null || dtSubmissionTitle.Rows.Count == 0)
        {
            HideReportForm();
            myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 11 has an error or is incorrect.");
            return false;
        }

        //***************
        // Uses TODO 20 *
        //***************
        dtAuthors = myConferenceDB.GetSubmissionAuthors(submissionNumber);
        // An SQL Error occurrred if the query result is null or empty, so exit.
        if (dtAuthors == null || dtAuthors.Rows.Count == 0)
        {
            HideReportForm();
            myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 20 has an error or is incorrect.");
            return false;
        }

        // Set the submission title and authors for display.
        txtAuthor.Text = "";
        txtTitle.Text = dtSubmissionTitle.Rows[0]["TITLE"].ToString();
        for (int i = 0; i < dtAuthors.Rows.Count; i++)
        {
            txtAuthor.Text = txtAuthor.Text + dtAuthors.Rows[i]["PERSONNAME"].ToString();
            if (i < dtAuthors.Rows.Count - 1)
            {
                txtAuthor.Text = txtAuthor.Text + ", ";
            }
        }
        return true;
    }

    private bool GetReviews(string pcCode, string submissionNumber)
    {
        //***************
        // Uses TODO 22 * 
        //***************
        dtRefereeReport = myConferenceDB.GetRefereeReport(pcCode, submissionNumber);
        // Display the query result if it is not null or empty.
        if (dtRefereeReport != null && dtRefereeReport.Rows.Count != 0)
        {
            // Set the referee report information for display.
            txtRelevant.Text = dtRefereeReport.Rows[0]["relevant"].ToString();
            txtTechnicallyCorrect.Text = dtRefereeReport.Rows[0]["technicallyCorrect"].ToString();
            txtLengthAndContent.Text = dtRefereeReport.Rows[0]["lengthAndContent"].ToString();
            txtOriginality.Text = dtRefereeReport.Rows[0]["originality"].ToString();
            txtImpact.Text = dtRefereeReport.Rows[0]["impact"].ToString();
            txtPresentation.Text = dtRefereeReport.Rows[0]["presentation"].ToString();
            txtTechnicalDepth.Text = dtRefereeReport.Rows[0]["technicalDepth"].ToString();
            txtOverallRating.Text = dtRefereeReport.Rows[0]["overallRating"].ToString();
            txtConfidence.Text = dtRefereeReport.Rows[0]["confidence"].ToString();
            txtMainContributions.Text = dtRefereeReport.Rows[0]["mainContribution"].ToString();
            txtStrongPoints.Text = dtRefereeReport.Rows[0]["strongPoints"].ToString();
            txtWeakPoints.Text = dtRefereeReport.Rows[0]["weakPoints"].ToString();
            txtOverallSummary.Text = dtRefereeReport.Rows[0]["overallSummary"].ToString();
            txtDetailedComments.Text = dtRefereeReport.Rows[0]["detailedComments"].ToString();
            txtConfidentialComments.Text = dtRefereeReport.Rows[0]["confidentialComments"].ToString();
            pnlRefereeReport.Visible = true;
            return true;
        }
        else // An SQL error occurred.
        {
            pnlRefereeReport.Visible = false;
            myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 22 has an error or is incorrect.");
            return false;
        }
    }

    private void GetDiscussion()
    {
        string submissionNumber = ddlSubmissionNumber.SelectedValue;

        //***************
        // Uses TODO 23 *
        //***************
        dtDiscussion = myConferenceDB.GetDiscussion(submissionNumber);
        // Display the query result if it is not null.
        if (dtDiscussion != null)
        {
            if (dtDiscussion.Rows.Count != 0)
            {
                gvDiscussion.DataSource = dtDiscussion;
                gvDiscussion.DataBind();
                pnlDiscussion.Visible = true;
            }
            else
            {
                myHelpers.ShowMessage(lblResultMessage, "There is no discussion for submission " + submissionNumber + ".");
            }
            pnlAddNewDiscussion.Visible = true;
        }
        else // An SQL error occurred.
        {
            myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 23 has an error or is incorrect.");
            pnlAddNewDiscussion.Visible = false;
        }
    }

    private void HideReportForm()
    {
        pnlRefereeReport.Visible = false;
        pnlDiscussion.Visible = false;
        pnlAddNewDiscussion.Visible = false;
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnGetRefereeReports_Click(object sender, EventArgs e)
    {
        Page.Validate("PCCodeValidation");
        if (Page.IsValid && !sqlError)
        {
            lblResultMessage.Visible = false;

            // Get the pc code.
            string pcCode = myHelpers.CleanInput(txtPCCode.Text);

            //***************
            // Uses TODO 24 *
            //***************
            dtSubmissionNumbers = myConferenceDB.GetAssignedSubmissionsWithReport(pcCode);
            if (dtSubmissionNumbers != null)
            {
                if (dtSubmissionNumbers.Rows.Count != 0)
                {
                    ddlSubmissionNumber.DataSource = dtSubmissionNumbers;
                    ddlSubmissionNumber.DataValueField = "submissionNo";
                    ddlSubmissionNumber.DataTextField = "submissionNo";
                    ddlSubmissionNumber.DataBind();
                    ddlSubmissionNumber.Items.Insert(0, "Select");
                    pnlSubmissionNumber.Visible = true;
                }
                else // Nothing to display.
                {
                    myHelpers.ShowMessage(lblResultMessage, "You have not submitted any referee reports.");
                    HideReportForm();
                }
            }
            else // An SQL error occurred.
            {
                myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 24 has an error or is incorrect.");
                HideReportForm();
            }
        }
    }


    protected void btnViewDiscussion_Click(object sender, EventArgs e)
    {
        GetDiscussion();
    }

    protected void btnAddToDiscussion_Click(object sender, EventArgs e)
    {
        lblResultMessage.Visible = false;
        // Collect the information needed to insert a new discussion.
        string submissionNumber = ddlSubmissionNumber.SelectedValue;
        string pcCode = myHelpers.CleanInput(txtPCCode.Text);
        string comments = myHelpers.CleanInput(txtNewDiscussion.Text);
        if (comments == "")
        {
            myHelpers.ShowMessage(lblResultMessage, "The comments are empty; nothing was added to the discussion.");
            return;
        }
        string sequenceNumber = myHelpers.GetNextTableId("Discussion", "sequenceNo").ToString();

        //***************
        // Uses TODO 25 *
        //***************
        if (myConferenceDB.CreateDiscusssion(sequenceNumber, pcCode, submissionNumber, comments))
        {
            // Refresh the discussion and reset the new discussion textbox.
            GetDiscussion();
            txtNewDiscussion.Text = "";
        }
        else // AN SQL error occurred.
        {
            myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 25 has an error or is incorrect.");
        }
    }

    protected void ddlSubmissionNumber_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlSubmissionNumber.SelectedIndex != 0)
        {
            if (GetSelectedSubmissionInfo(ddlSubmissionNumber.SelectedValue))
            {
                if (GetReviews(txtPCCode.Text.Trim(), ddlSubmissionNumber.SelectedValue))
                {
                    pnlDiscussion.Visible = false;
                    pnlAddNewDiscussion.Visible = false;
                }
            }
        }
        else
        {
            myHelpers.ShowMessage(lblResultMessage, "Please select a submission.");
            pnlRefereeReport.Visible = false;
            pnlDiscussion.Visible = false;
            pnlAddNewDiscussion.Visible = false;
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
                HideReportForm();
            }
        }
    }

    protected void txtPCCode_TextChanged(object sender, EventArgs e)
    {
        pnlSubmissionNumber.Visible = false;
        HideReportForm();
    }
}