using System;
using System.Web.UI.WebControls;

/// <summary>
/// Summary description for Helpers
/// </summary>
public class Helpers
{
    UniversityDB myUniversityDB = new UniversityDB();
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

    public void ShowMessage(Label labelControl, string message)
    {
        if (message.Substring(0, 3) == "***") // Error message.
        {
            labelControl.ForeColor = System.Drawing.Color.Red;
        }
        else // Information message.
        {
            labelControl.ForeColor = System.Drawing.Color.Blue;
        }
        labelControl.Text = message;
        labelControl.Visible = true;
    }
}