using ConferenceWebSite;
using Microsoft.AspNet.Identity;
using System;
using System.Linq;
using System.Web.UI.WebControls;
using System.Windows.Forms;

/// <summary>
/// Helpers for the Fan Club Website
/// </summary>
public class Helpers
{
    OracleDBAccess myOracleDBAccess = new OracleDBAccess();
    ConferenceDB myConferenceDB = new ConferenceDB();
    private string sql;

    public Helpers()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public string CleanInput(string input)
    {
        // Replace single quote by two quotes and remove leading and trailing spaces.
        return input.Replace("'", "''").Trim();
    }

    public bool IsInteger(string number)
    {
        int n;
        return int.TryParse(number, out n);
    }

    public int GetColumnIndexByName(GridViewRowEventArgs e, string columnName)
    {
        for (int i = 0; i < e.Row.Controls.Count; i++)
            if (e.Row.Cells[i].Text.ToLower().Trim() == columnName.ToLower().Trim())
            {
                return i;
            }
        return -1;
    }

    public decimal GetNextTableId(string tableName, string idName)
    {
        sql = "select max(" + idName + ") from " + tableName;
        return myOracleDBAccess.GetAggregateValue(sql) + 1;
    }

    public void RenameGridViewColumn(GridViewRowEventArgs e, string fromName, string toName)
    {
        int col = GetColumnIndexByName(e, fromName);
        // If the column is not found, ignore renaming.
        if (col != -1)
        {
            e.Row.Cells[col].Text = toName;
        }
    }

    public void ShowMessage(System.Web.UI.WebControls.Label labelControl, string message)
    {
        if (message.Substring(0, 3) == "***") // Error message.
        {
            labelControl.ForeColor = System.Drawing.Color.Red;
        }
        else // Information message.
        {
            labelControl.ForeColor = System.Drawing.Color.Blue; // "#FF0000FF"
        }
        labelControl.Text = message;
        labelControl.Visible = true;
    }

    public bool UserEmailIsValid(string previousUserEmail, string newUserEmail)
    {
        if (previousUserEmail != newUserEmail)
        {
            sql = "select count(*) from Person where personEmail='" + newUserEmail + "'";
            if (myOracleDBAccess.GetAggregateValue(sql) != 0)
            {
                return false;
            }
        }
        return true;
    }
}