using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PCChair_AssignSubmissionToPCMember : System.Web.UI.Page
{
    private ConferenceDB myConferenceDB = new ConferenceDB();
    private Helpers myHelpers = new Helpers();
    private DataTable dtSubmissionNumbers;
    private DataTable dtSubmissionTitle;
    private DataTable dtCurrentlyAssigned;
    private DataTable dtAvailableForAssignment;

    private void PopulateSubmissionNumberDropDownList()
    {
        //***************
        // Uses TODO 10 *
        //***************
        dtSubmissionNumbers = myConferenceDB.GetSubmissionNumbers();

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
            }
            else // Nothing to display.
            {
                myHelpers.ShowMessage(lblResultMessage, "There are no submissions.");
                pnlSelectSubmission.Visible = false;
            }
        }
        else // An SQL error occurred.
        {
            myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 10 has an error or is incorrect.");
        }
    }

    private void PopulateCurrentlyAssigned(string submissionNo)
    {
        //***************
        // Uses TODO 11 *
        //***************
        dtSubmissionTitle = myConferenceDB.GetSubmissionTitle(submissionNo);

        // Set the title for display if the query result is not null and not empty.
        if (dtSubmissionTitle != null)
        {
            if (dtSubmissionTitle.Rows.Count != 0)
            {
                lblTitle.Text = "<b>Title: </b>" + dtSubmissionTitle.Rows[0]["Title"].ToString();
                lblTitle.Visible = true;

                //***************
                // Uses TODO 12 *
                //***************
                dtCurrentlyAssigned = myConferenceDB.GetPCMembersAssignedToSubmission(submissionNo);

                // Display the query result if it is not null.
                if (dtCurrentlyAssigned != null)
                {
                    if (dtCurrentlyAssigned.Rows.Count != 0)
                    {
                        gvCurrentlyAssigned.DataSource = dtCurrentlyAssigned;
                        gvCurrentlyAssigned.DataBind();
                        ShowCurrentlyAssigned();
                    }
                    else
                    {
                        myHelpers.ShowMessage(lblResultMessage, "There are no PC members assigned to this submission.");
                        pnlCurrentlyAssigned.Visible = true;
                    }
                    pnlAvailableForAssignment.Visible = false;
                }
                else // An SQL error occurred.
                {
                    myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 12 has an error or is incorrect.");
                }
            }
            else // An SQL error occurred.
            {
                myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 11 has an error or is incorrect.");
            }
        }
        else // An SQL error occurred.
        {
            myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 11 has an error or is incorrect.");
        }
    }

    private void PopulateAvailableForAssignment(string submissionNo, string preference)
    {
        if (preference != "None")
        {
            //***************
            // Uses TODO 13 *
            //***************
            dtAvailableForAssignment = myConferenceDB.GetPCMemberAvailableForAssignmentWithSpecifiedPreference(submissionNo, preference);
        }
        else
        {
            //***************
            // Uses TODO 14 *
            //***************
            dtAvailableForAssignment = myConferenceDB.GetPCMemberAvailableForAssignmentWithNoSpecifiedPreference(submissionNo);
        }

        // Display the query result if it is not null or empty.
        if (dtAvailableForAssignment != null)
        {
            if (dtAvailableForAssignment.Rows.Count != 0)
            {
                gvAvailableForAssignment.DataSource = dtAvailableForAssignment;
                gvAvailableForAssignment.DataBind();
                for (int i = 0; i < gvAvailableForAssignment.Rows.Count; i++)
                {
                    for (int j = 0; j < gvAvailableForAssignment.Rows[i].Cells.Count; j++)
                    {
                        gvAvailableForAssignment.Rows[i].Cells[j].HorizontalAlign = HorizontalAlign.Center;
                    }
                }
                lblResultMessage.Visible = false;
                pnlAvailableForAssignment.Visible = true;
            }
            else
            {
                if (ddlMinimumPreference.SelectedValue == "None")
                {
                    myHelpers.ShowMessage(lblResultMessage, "All PC members have specified a preference for this submission.");
                }
                else
                {
                    myHelpers.ShowMessage(lblResultMessage, "There are currently no assignable PC members that have specified a preference >= "
                        + ddlMinimumPreference.SelectedValue + " for this submission.");
                }
                pnlAvailableForAssignment.Visible = false;
            }
        }
        else // An SQL error occurred
        {
            myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 13 or 13 has an error or is incorrect.");
        }
    }

    private void ShowCurrentlyAssigned()
    {
        pnlCurrentlyAssigned.Visible = true;
        ddlMinimumPreference.SelectedIndex = 0;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            PopulateSubmissionNumberDropDownList();
        }
    }

    protected void btnAssignPcMember_Click(object sender, EventArgs e)
    {
        string submissionNo = ddlSubmissionNumbers.SelectedValue;
        string pcCode = "";

        // Determine if any pc member was selected for this submission.
        foreach (GridViewRow row in gvAvailableForAssignment.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chkRow = (row.Cells[0].FindControl("chkSelected") as CheckBox);
                if (chkRow != null && chkRow.Checked)
                {
                    // Get the pc code.
                    pcCode = row.Cells[1].Text;
                    //***************
                    // Uses TODO 15 *
                    //***************
                    if (!myConferenceDB.AssignPCMemberToReviewSubmission(pcCode, submissionNo))
                    {
                        myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 15 has an error or is incorrect.");
                        return;
                    }
                }
            }
        }

        // Show result message and refresh the web form.
        if (pcCode != "")
        {
            PopulateCurrentlyAssigned(submissionNo);
            ShowCurrentlyAssigned();
            pnlAvailableForAssignment.Visible = false;
        }
        else
        {
            myHelpers.ShowMessage(lblResultMessage, "No PC member was selected for assignment.");
        }
    }

    protected void ddlSubmission_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlSubmissionNumbers.SelectedIndex != 0)
        {
            PopulateCurrentlyAssigned(ddlSubmissionNumbers.SelectedValue);
        }
        else
        {
            lblTitle.Visible = false;
            pnlCurrentlyAssigned.Visible = false;
            pnlAvailableForAssignment.Visible = false;
        }
    }

    protected void ddlMinimumPreference_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlMinimumPreference.SelectedIndex != 0)
        {
            PopulateAvailableForAssignment(ddlSubmissionNumbers.SelectedValue, ddlMinimumPreference.SelectedValue);
        }
        else
        {
            pnlAvailableForAssignment.Visible = false;
            lblResultMessage.Visible = false;
        }
    }

    protected void gvCurrentlyAssigned_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.Controls.Count == 2)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                myHelpers.RenameGridViewColumn(e, "PCCODE", "PC&nbsp;CODE");
                myHelpers.RenameGridViewColumn(e, "PERSONNAME", "NAME");
            }
        }
    }

    protected void gvAvailableForAssignment_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.Controls.Count == 4)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                myHelpers.RenameGridViewColumn(e, "PCCODE", "PC&nbsp;CODE");
                e.Row.Cells[2].Text = "PREFERENCE";
                e.Row.Cells[3].Text = "SUBMISSIONS&nbsp;ASSIGNED";
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[3].HorizontalAlign = HorizontalAlign.Center;
            }
        }
    }
}