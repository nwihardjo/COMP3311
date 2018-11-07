using System;
using System.Data;
using System.Web.UI.WebControls;

public partial class PCMember_DisplaySubmissionPreferences : System.Web.UI.Page
{
    private ConferenceDB myConferenceDB = new ConferenceDB();
    private Helpers myHelpers = new Helpers();
    private bool sqlError = false;
    private DataTable dtSubmissionPreferences;

    private void LoadPapers()
    {
        lblResultMessage.Visible = false;
        string pcCode = myHelpers.CleanInput(txtPCCode.Text);

        DisplaySubmissionsWithPreference(pcCode);
        DisplaySubmissionsWithoutPreference(pcCode);
    }

    private void DisplaySubmissionsWithPreference(string pcCode)
    {
        //***************
        // Uses TODO 28 *
        //***************
        dtSubmissionPreferences = myConferenceDB.GetSubmissionsWithPreference(pcCode);
        // Display the query result if it is not null.
        if (dtSubmissionPreferences != null)
        {
            if (dtSubmissionPreferences.Rows.Count != 0)
            {
                pnlPreferencesSpecified.Visible = true;
                gvPreferenceSpecified.DataSource = dtSubmissionPreferences;
                gvPreferenceSpecified.DataBind();
            }
            else // Nothing to display.
            {
                pnlPreferencesSpecified.Visible = false;
                myHelpers.ShowMessage(lblResultMessage, "You have not specified a preference for any submission.");
            }
        }
        else // An SQL error occurred
        {
            pnlPreferencesSpecified.Visible = false;
            myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 28 has an error or is incorrect.");
        }
    }

    private void DisplaySubmissionsWithoutPreference(string pcCode)
    {
        //***************
        // Uses TODO 29 *
        //***************
        dtSubmissionPreferences = myConferenceDB.GetSubmissionsWithoutPreference(pcCode);
        // Display the query result if it is not null.
        if (dtSubmissionPreferences != null)
        {
            if (dtSubmissionPreferences.Rows.Count != 0)
            {
                gvNoPreferenceSpecified.DataSource = dtSubmissionPreferences;
                gvNoPreferenceSpecified.DataBind();
                pnlPreferencesNotSpecified.Visible = true;
            }
            else // Nothing to display.
            {
                pnlPreferencesNotSpecified.Visible = false;
                myHelpers.ShowMessage(lblResultMessage, "There are no submissions for which you can specify a preference.");
            }
        }
        else // An SQL error occurred.
        {
            pnlPreferencesNotSpecified.Visible = false;
            myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 29 has an error or is incorrect.");
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnGetSubmissions_Click(object sender, EventArgs e)
    {
        Page.Validate("PCCodeValidation");
        if (Page.IsValid && !sqlError)
        {
            LoadPapers();
        }
    }

    protected void btnUpdatePreferences_Click(object sender, EventArgs e)
    {
        string pcCode = myHelpers.CleanInput(txtPCCode.Text);
        string submissionNo = "";
        string preference = "";

        // For each submission for which a preference has been specified, get the preference and insert it into the database.
        for (int i = 0; i < gvNoPreferenceSpecified.Rows.Count; i++)
        {
            DropDownList listPreference = ((DropDownList)gvNoPreferenceSpecified.Rows[i].FindControl("ddlPreference"));
            submissionNo = gvNoPreferenceSpecified.Rows[i].Cells[1].Text;
            if (listPreference.SelectedIndex != 0)
            {
                preference = listPreference.SelectedItem.Value;

                //***************
                // Uses TODO 30 *
                //***************
                if (!myConferenceDB.CreatePreferenceForSubmission(pcCode, submissionNo, preference))
                {
                    // An SQL error occurred. Exit the insert.
                    myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 30 has an error or is incorrect.");
                    return;
                }
            }
        }

        // Show result message and refresh the web form.
        myHelpers.ShowMessage(lblResultMessage, "Your preferences have been successfully updated.");
        LoadPapers();
    }

    protected void gvPreferenceSpecified_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.Controls.Count == 5)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                myHelpers.RenameGridViewColumn(e, "SUBMISSIONNO", "SUBMISSION");
                myHelpers.RenameGridViewColumn(e, "SUBMISSIONTYPE", "TYPE");
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[4].HorizontalAlign = HorizontalAlign.Center;
            }
        }
    }

    protected void gvNoPreferenceSpecified_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.Controls.Count == 5)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                myHelpers.RenameGridViewColumn(e, "SUBMISSIONNO", "SUBMISSION");
                myHelpers.RenameGridViewColumn(e, "SUBMISSIONTYPE", "TYPE");
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[1].HorizontalAlign = HorizontalAlign.Center;
            }
        }
    }

    protected void cvPCCodeValidate_ServerValidate(object source, ServerValidateEventArgs args)
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
}