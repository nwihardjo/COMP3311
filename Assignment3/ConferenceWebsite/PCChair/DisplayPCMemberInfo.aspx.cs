using System;
using System.Data;
using System.Web.UI.WebControls;

public partial class PCChair_DisplayPCMemberInfo : System.Web.UI.Page
{
    private ConferenceDB myConferenceDB = new ConferenceDB();
    private Helpers myHelpers = new Helpers();
    private DataTable dtPCMember;

    protected void Page_Load(object sender, EventArgs e)
    {
        lblResultMessage.Visible = false;

        //***************
        // Uses TODO 17 *
        //***************
        dtPCMember = myConferenceDB.GetAllPCMembersInfo();

        // Display the result if it is not null.
        if (dtPCMember != null)
        {
            if (dtPCMember.Rows.Count != 0)
            {
                gvPCMember.DataSource = dtPCMember;
                gvPCMember.DataBind();
            }
            else //Nothing to display
            {
                myHelpers.ShowMessage(lblResultMessage, "There are no PC members.");
            }
        }
        else // An SQL error occurred.
        {
            myHelpers.ShowMessage(lblResultMessage, "*** The SQL statement of TODO 17 has an error or is incorrect.");
        }        
    }

    protected void gvPCMember_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        if (e.Row.Controls.Count == 8)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                myHelpers.RenameGridViewColumn(e, "PCCODE", "PC&nbsp;CODE");
                myHelpers.RenameGridViewColumn(e, "PERSONNAME", "NAME");
                myHelpers.RenameGridViewColumn(e, "PHONENO", "PHONE&nbsp;NO");
                myHelpers.RenameGridViewColumn(e, "PERSONEMAIL", "EMAIL");
            }
        }
    }
}