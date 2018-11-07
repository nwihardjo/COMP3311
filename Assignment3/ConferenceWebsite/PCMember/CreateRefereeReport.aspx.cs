using System;
using System.Data;

public partial class PCMember_CreateRefereeReport : System.Web.UI.Page
{
    private ConferenceDB myConferenceDB = new ConferenceDB();
    private Helpers myHelpers = new Helpers();
    private bool sqlError = false;
    private DataTable dtSubmissionNumbers;
    private DataTable dtSubmissionTitle;
    private DataTable dtAuthors;

    private void PopulateSubmissionNumberDropDownList()
    {
        lblResultMessage.Visible = false;
        pnlSubmissionNumbers.Visible = false;
        pnlSubmissionInformation.Visible = false;
        pnlRefereeReport.Visible = false;

        // Get the pc code.
        string pcCode = myHelpers.CleanInput(txtPCCode.Text);

        //***************
        // Uses TODO 19 *
        //***************
        dtSubmissionNumbers = myConferenceDB.GetAssignedSubmissionsWithNoReport(pcCode);
        // Display the query result if it is not null.
        if (dtSubmissionNumbers != null)
        {
            if (dtSubmissionNumbers.Rows.Count != 0)
            {
                ddlSubmissionNumbers.DataSource = dtSubmissionNumbers;
                ddlSubmissionNumbers.DataValueField = "submissionNo";
                ddlSubmissionNumbers.DataTextField = "submissionNo";
                ddlSubmissionNumbers.DataBind();
                ddlSubmissionNumbers.Items.Insert(0, "Select");
                pnlSubmissionNumbers.Visible = true;

            }
            else // Nothing to display.
            {
                myHelpers.ShowMessage(lblResultMessage, "There are no submissions for you to review.");
                pnlInputPCCode.Visible = false;
            }
        }
        else // An SQL error occurred.
        {
            myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 19 has an error or is incorrect.");
            pnlSubmissionInformation.Visible = false;
            pnlRefereeReport.Visible = false;
        }
    }

    private void GetSelectedSubmissionInfo(string submissionNumber)
    {
        lblResultMessage.Visible = false;
        pnlSubmissionInformation.Visible = true;
        pnlRefereeReport.Visible = true;

        //***************
        // Uses TODO 11 *
        //***************
        dtSubmissionTitle = myConferenceDB.GetSubmissionTitle(submissionNumber);
        // Exit if there is an SQL error.
        if (dtSubmissionTitle == null)
        {
            myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 11 has an error or is incorrect.");
            pnlRefereeReport.Visible = false;
            return;
        }

        //***************
        // Uses TODO 20 * 
        //***************
        dtAuthors = myConferenceDB.GetSubmissionAuthors(submissionNumber);
        // Display the query result if it is not null or empty.
        if (dtAuthors != null && dtAuthors.Rows.Count != 0)
        {
            txtAuthor.Text = "";
            txtTitle.Text = dtSubmissionTitle.Rows[0]["title"].ToString();
            for (int i = 0; i < dtAuthors.Rows.Count; i++)
            {
                txtAuthor.Text = txtAuthor.Text + dtAuthors.Rows[i]["personName"].ToString();
                if (i < dtAuthors.Rows.Count - 1)
                {
                    txtAuthor.Text = txtAuthor.Text + ", ";
                }
            }
        }
        else // An SQL error occurred.
        {
            myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 20 has an error or is incorrect.");
            pnlRefereeReport.Visible = false;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnGetSubmission_Click(object sender, EventArgs e)
    {
        Page.Validate("PCCodeValidation");
        if (Page.IsValid && !sqlError)
        {
            PopulateSubmissionNumberDropDownList();
        }
    }

    protected void btnSubmitReport_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            // Collect the information required to add a review.
            string pcCode = myHelpers.CleanInput(txtPCCode.Text);
            string submissionNumber = ddlSubmissionNumbers.SelectedValue;
            string relevant = ddlRelevant.SelectedValue;
            string technicallyCorrect = ddlTechnicallyCorrect.SelectedValue;
            string lengthAndContent = ddlLengthAndContent.SelectedValue;
            string originality = ddlOriginality.SelectedValue;
            string impact = ddlImpact.SelectedValue;
            string presentation = ddlPresentation.SelectedValue;
            string technicalDepth = ddlTechnicalDepth.SelectedValue;
            string overallRating = ddlOverallRating.SelectedValue;
            string confidence = ddlConfidence.SelectedValue;
            string mainContribution = myHelpers.CleanInput(txtMainContributions.Text);
            string strongPoints = myHelpers.CleanInput(txtStrongPoints.Text);
            string weakPoints = myHelpers.CleanInput(txtWeakPoints.Text);
            string overallSummary = myHelpers.CleanInput(txtOverallSummary.Text);
            string detailedComments = myHelpers.CleanInput(txtDetailedComments.Text);
            string confidentialComments = myHelpers.CleanInput(txtConfidentialComments.Text);

            //***************
            // Uses TODO 21 *
            //***************
            if (myConferenceDB.CreateRefereeReport(pcCode, submissionNumber, relevant, technicallyCorrect, lengthAndContent,
                originality, impact, presentation, technicalDepth, overallRating, confidence, mainContribution, strongPoints,
                weakPoints, overallSummary, detailedComments, confidentialComments))
            {
                myHelpers.ShowMessage(lblResultMessage, "Your referee report for submission number " + submissionNumber + " has been successfully submitted.");
                pnlSubmissionNumbers.Visible = false;
                pnlSubmissionInformation.Visible = false;
                pnlRefereeReport.Visible = false;
            }
            else // An SQL error occurred.
            {
                myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 21 has an error or is incorrect.");
            }
        }
    }

    protected void ddlSubmissionNumber_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlSubmissionNumbers.SelectedIndex != 0)
        {
            GetSelectedSubmissionInfo(ddlSubmissionNumbers.SelectedValue);
        }
        else
        {
            myHelpers.ShowMessage(lblResultMessage, "Please select a submission.");
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
                pnlSubmissionInformation.Visible = false;
                pnlRefereeReport.Visible = false;
                pnlSubmissionNumbers.Visible = false;
            }
        }
    }

    protected void txtPCCode_TextChanged(object sender, EventArgs e)
    {
        pnlSubmissionNumbers.Visible = false;
        pnlSubmissionInformation.Visible = false;
        pnlRefereeReport.Visible = false;
    }
}