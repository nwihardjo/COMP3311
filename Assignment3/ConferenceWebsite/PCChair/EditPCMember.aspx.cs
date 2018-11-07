using System;
using System.Data;

public partial class PCChair_EditPCMember : System.Web.UI.Page
{
    private ConferenceDB myConferenceDB = new ConferenceDB();
    private Helpers myHelpers = new Helpers();
    private bool viewStateError = false;
    private DataTable dtPersons;

    private bool PCMemberInfoIsChanged(string newTitle, string newName, string newInstitution, string newCountry, string newPhoneNo, string newEmail)
    {
        if (ViewState["currentTitle"].ToString() == newTitle & ViewState["currentName"].ToString() == newName &
            ViewState["currentInstitution"].ToString() == newInstitution & ViewState["currentCountry"].ToString() == newCountry &
            ViewState["currentPhoneNo"].ToString() == newPhoneNo & ViewState["currentEmail"].ToString() == newEmail)
        {
            return false;
        }
        else
        {
            return true;
        }
    }

    private void PopulatePCMemberInformation()
    {
        string pcCode = Request["pcCode"];
        //***************
        // Uses TODO 18 *
        //***************
        dtPersons = myConferenceDB.GetPCMemberInfo(pcCode);

        // Display the result if it is not null.
        if (dtPersons != null)
        {
            if (dtPersons.Rows.Count != 0)
            {
                txtPCCode.Text = pcCode;
                ViewState["personId"] = dtPersons.Rows[0]["PERSONID"].ToString().Trim();
                ViewState["currentTitle"] = ddlTitle.SelectedValue = dtPersons.Rows[0]["TITLE"].ToString().Trim();
                ViewState["currentName"] = txtName.Text = dtPersons.Rows[0]["PERSONNAME"].ToString().Trim();
                ViewState["currentInstitution"] = txtInstitution.Text = dtPersons.Rows[0]["INSTITUTION"].ToString().Trim();
                ViewState["currentCountry"] = txtCountry.Text = dtPersons.Rows[0]["COUNTRY"].ToString().Trim();
                ViewState["currentPhoneNo"] = txtPhoneNo.Text = dtPersons.Rows[0]["PHONENO"].ToString().Trim();
                ViewState["currentEmail"] = txtEmail.Text = dtPersons.Rows[0]["PERSONEMAIL"].ToString().Trim();
            }
            else //Nothing to display; should not happen!
            {
                myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 18 has an error or is incorrect.");
            }
        }
        else // An SQL error occurred.
        {
            myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 18 has an error or is incorrect.");
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            PopulatePCMemberInformation();
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        if (Page.IsValid && !viewStateError)
        {
            lblResultMessage.Visible = false;
            // Collect the PC member information for updating.
            string personId = ViewState["personId"].ToString();
            string newTitle = ddlTitle.SelectedValue;
            string newName = myHelpers.CleanInput(txtName.Text);
            string newInstitution = myHelpers.CleanInput(txtInstitution.Text);
            string newCountry = myHelpers.CleanInput(txtCountry.Text);
            string newPhoneNo = myHelpers.CleanInput(txtPhoneNo.Text);
            string newEmail = myHelpers.CleanInput(txtEmail.Text);
            string resultMessage = "You have not changed any information.";

            // Update the PC member information if it has changed.
            if (PCMemberInfoIsChanged(newTitle, newName, newInstitution, newCountry, newPhoneNo, newEmail))
            {
                //***************
                // Uses TODO 03 *
                //***************
                if (myConferenceDB.UpdatePerson(personId, newTitle, newName, newInstitution, newCountry, newPhoneNo, newEmail))
                {
                    PopulatePCMemberInformation();
                    resultMessage = "The PC Member information has been updated.";
                }
                else // An SQL error occurred.
                {
                    resultMessage = "*** The SQL statement of TODO 03 has an error or is incorrect.";
                }
            }
            myHelpers.ShowMessage(lblResultMessage, resultMessage);
        }
    }

    protected void cvEmail_ServerValidate(object source, System.Web.UI.WebControls.ServerValidateEventArgs args)
    {
        if (ViewState["currentEmail"] != null)
        {
            if (!myHelpers.UserEmailIsValid(ViewState["currentEmail"].ToString(), myHelpers.CleanInput(txtEmail.Text)))
            {
                args.IsValid = false;
            }
        }
        else
        {
            viewStateError = true;
        }
    }
}