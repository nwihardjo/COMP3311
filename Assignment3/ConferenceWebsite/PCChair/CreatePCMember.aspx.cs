using System;

public partial class PCChair_CreatePCMember : System.Web.UI.Page
{
    private ConferenceDB myConferenceDB = new ConferenceDB();
    private Helpers myHelpers = new Helpers();
    private bool sqlError = false;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (Page.IsValid && !sqlError)
        {
            lblResultMessage.Visible = false;
            // Get the PC member information from the web page.
            string pcCode = myHelpers.CleanInput(txtPCCode.Text);
            string title = ddlTitle.SelectedValue;
            string name = myHelpers.CleanInput(txtName.Text);
            string institution = myHelpers.CleanInput(txtInstitution.Text);
            string country = myHelpers.CleanInput(txtCountry.Text);
            string phoneNo = myHelpers.CleanInput(txtPhoneNo.Text);
            string email = myHelpers.CleanInput(txtEmail.Text);

            // Get the next person id.
            string personId = myHelpers.GetNextTableId("Person", "personId").ToString();

            //*******************
            // Uses TODO 02, 16 *
            //*******************
            if (myConferenceDB.CreatePCMember(personId, title, name, institution, country, phoneNo, email, pcCode))
            {
                myHelpers.ShowMessage(lblResultMessage, "The PC member with PC code " + pcCode + " has been successfully added.");
                pnlInputInfo.Visible = false;
            }
            else // AN SQL error occurred.
            {
                myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 02 or 15 has an error or is incorrect.");
            }
        }
    }

    protected void cvPCCode_ServerValidate(object source, System.Web.UI.WebControls.ServerValidateEventArgs args)
    {
        //***************
        // Uses TODO 01 *
        //***************
        decimal queryResult = myConferenceDB.IsPCCodeValid(myHelpers.CleanInput(txtPCCode.Text));

        if (queryResult >= 1) // Duplicate PC code.
        {
            args.IsValid = false;
        }
        else if (queryResult == -1) // An SQL error occured.
        {
            sqlError = true;
            myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 01 has an error or is incorrect.");
        }
    }

    protected void cvEmail_ServerValidate(object source, System.Web.UI.WebControls.ServerValidateEventArgs args)
    {
        if (!myHelpers.UserEmailIsValid("", myHelpers.CleanInput(txtEmail.Text)))
        {
            args.IsValid = false;
        }
    }
}