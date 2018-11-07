using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Author_CreateSubmission : System.Web.UI.Page
{
    private ConferenceDB myConferenceDB = new ConferenceDB();
    private Helpers myHelpers = new Helpers();
    private DataTable dtPersons;

    private DataTable SetContactAuthor(DataTable dtPersons)
    {
        int dtRow = 0;
        // Determine if any author is set as contact author.
        foreach (GridViewRow row in gvAuthors.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                dtPersons.Rows[dtRow]["contactAuthor"] = null;
                CheckBox chkRow = (row.Cells[0].FindControl("chkContactAuthor") as CheckBox);
                if (chkRow != null & chkRow.Checked)
                {
                    dtPersons.Rows[dtRow]["contactAuthor"] = "Y";
                }
            }
            dtRow++;
        }
        return dtPersons;
    }

    private string GetContactAuthor(DataTable dtPersons)
    {
        dtPersons = SetContactAuthor(dtPersons);
        string contactAuthor = "";
        // Determine if any author was selected as the contact author.
        foreach (DataRow row in dtPersons.Rows)
        {
            if ((row["contactAuthor"]).ToString() == "Y")
            {
                // Get the contact author person id.
                contactAuthor = row["personId"].ToString();
            }
        }
        return contactAuthor;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        // Create a DataTable to store author information collected from the interface.
        if (!Page.IsPostBack)
        {
            dtPersons = new DataTable();
            dtPersons.Columns.Add("personId");
            dtPersons.Columns.Add("TITLE");
            dtPersons.Columns.Add("NAME");
            dtPersons.Columns.Add("INSTITUTION");
            dtPersons.Columns.Add("COUNTRY");
            dtPersons.Columns.Add("PHONE NO");
            dtPersons.Columns.Add("EMAIL");
            dtPersons.Columns.Add("contactAuthor");
            // The author DataTable is stored in ViewState.
            ViewState["PersonsDataTable"] = dtPersons;
        }
        else
        {
            dtPersons = (DataTable)ViewState["PersonsDataTable"];
        }
    }

    protected void btnAddAuthor_Click(object sender, EventArgs e)
    {
        Page.Validate("SubmissionValidation");
        Page.Validate("AuthorValidation");
        if (Page.IsValid)
        {
            lblResultMessage.Visible = false;
            pnlAuthors.Visible = true;
            decimal personId;
            // Add the author information to the list of authors.
            DataRow dr = dtPersons.NewRow();
            // Get the next person id.
            if (dtPersons.Rows.Count == 0)
            {
                personId = myHelpers.GetNextTableId("Person", "personId");
                ViewState["personId"] = personId;
            }
            else
            {
                personId = (decimal)ViewState["personId"] + 1;
                ViewState["personId"] = personId;
            }
            dr["personId"] = personId.ToString();
            dr["Title"] = ddlTitle.SelectedItem.Value;
            dr["Name"] = txtAuthorName.Text.Trim();
            dr["Institution"] = txtInstitution.Text.Trim();
            dr["Country"] = txtCountry.Text.Trim();
            dr["Phone No"] = txtPhoneNumber.Text.Trim();
            dr["Email"] = txtEmail.Text.Trim();
            dtPersons.Rows.Add(dr);

            // Set/reset the contact author
            dtPersons = SetContactAuthor(dtPersons);

            gvAuthors.DataSource = dtPersons;
            gvAuthors.DataBind();
            ViewState["PersonsDataTable"] = dtPersons;

            // Reset the author input form.
            ddlTitle.SelectedIndex = 0;
            txtAuthorName.Text = "";
            txtInstitution.Text = "";
            txtCountry.Text = "";
            txtEmail.Text = "";
            txtPhoneNumber.Text = "";
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        Page.Validate("SubmissionValidation");
        if (Page.IsValid)
        {
            lblResultMessage.Visible = false;
            // Check if contact author specified.
            dtPersons = ViewState["PersonsDataTable"] as DataTable;
            string contactAuthor = GetContactAuthor(dtPersons);
            if (contactAuthor != "")
            {
                // Set the submission information for insertion from the web form controls.
                string submissionNumber = myHelpers.GetNextTableId("Submission", "submissionNo").ToString();
                string submissionTitle = myHelpers.CleanInput(txtTitle.Text);
                string submissionAbstract = myHelpers.CleanInput(txtAbstract.Text);
                string submissionType = ddlSubmissionType.SelectedValue;

                //***********************
                // Uses TODO 02, 04, 05 *
                //***********************
                if (myConferenceDB.CreateSubmission(submissionNumber, submissionTitle, submissionAbstract, submissionType, "", contactAuthor, dtPersons))
                {
                    myHelpers.ShowMessage(lblResultMessage, "Your submission '" + submissionTitle + "' with submission number " + submissionNumber + " has been successfully submitted.");
                }
                else // An SQL error occurred.
                {
                    myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 02, 04 or 05 has an error or is incorrect.");
                }
                pnlSubmissionInfo.Visible = false;
                pnlAuthors.Visible = false;
            }
            else // No contact author specified.
            {
                myHelpers.ShowMessage(lblResultMessage, "Please specify a contact author.");
            }
        }
    }

    protected void gvAuthors_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        if (e.Row.Controls.Count == 9)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.Controls[1].Visible = false;
                e.Row.Controls[8].Visible = false;
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Controls[1].Visible = false;
                e.Row.Controls[8].Visible = false;

                // Keep the checked row checked.
                CheckBox chkRow = (e.Row.FindControl("chkContactAuthor") as CheckBox);
                if (chkRow != null & e.Row.Cells[0].Text == "Y")
                {
                    chkRow.Checked = true;
                }
                else
                {
                    chkRow.Checked = false;
                }
            }
        }
    }

    protected void cvPersonEmail_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (!myHelpers.UserEmailIsValid("", myHelpers.CleanInput(txtEmail.Text)))
        {
            args.IsValid = false;
        }
    }
}