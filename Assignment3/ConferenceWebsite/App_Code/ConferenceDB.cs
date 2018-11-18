using Oracle.DataAccess.Client;
using System.Data;

/// <summary>
/// Student name: 
/// Student number: 
/// 
/// NOTE: This is an individual task. By submitting this file you certify that this
/// code is the result of your individul effort and that it has not been developed
/// in collaoration with or copied from any other person. If this is not the case,
/// then you must identify by name all the persons with whom you collaborated or
/// from whom you copied code below.
/// 
/// Collaborators: 
/// </summary>

public class ConferenceDB
{
    //******************************** IMPORTANT NOTE **********************************
    // For the web pages to display a query result correctly, the attribute names in   *
    // the query result table must be EXACTLY the same as that in the database tables. *
    //**********************************************************************************

    private OracleDBAccess myOracleDBAccess = new OracleDBAccess();
    private string sql;

    public decimal IsPCCodeValid(string pcCode)
    {
        //*************************************************************************
        // TODO 01: Used in CreatePCMember.aspx.cs, CreateRefereeReport.aspx.cs,  *
        //          DisplayRefereeReport.aspx.cs, DisplayReviewingStatus.aspx.cs, *
        //          DisplaySubmissionPreferences.aspx.cs                          *
        // Construct the SQL SELECT statement to determine if a PC code already   *
        // exists in the PCMember table. The SQL statement should return 0 if the *
        // PC code does not exist and 1 if it does exist.                         *
        //*************************************************************************
        sql = "SELECT COUNT(personId) FROM PCMember WHERE pcCode = '" + pcCode + "'; ";
        return myOracleDBAccess.GetAggregateValue(sql);
    }

    #region SQL statements for Person
    public bool CreatePerson(string personId, string title, string personName, string institution,
    string country, string phoneNo, string personEmail, OracleTransaction trans)
    {
        //********************************************************************
        // TODO 02: Used in CreateSubmission.aspx.cs, CreatePCMember.aspx.cs *
        // Construct the SQL INSERT statement to insert a value for all the  *
        // attributes of the Person table.                                   *
        //********************************************************************
        sql = "INSERT INTO Person VALUES('" + personId + "', '" + title + "', '" + 
            personName + "', '" + institution + "', '" + phoneNo + "', '" + 
            personEmail + "'); ";
        if (!myOracleDBAccess.SetData(sql, trans)) { myOracleDBAccess.DisposeTransaction(trans); return false; }
        return true;
    }

    public bool UpdatePerson(string personId, string title, string personName, 
        string institution, string country, string phoneNo, string personEmail)
    {
        //*******************************************************
        // TODO 03: Used in EditPCMemberInfo.aspx.cs            *
        // Construct the SQL UPDATE statement to update all the *
        // attributes of a person identified by a person id.    *
        //*******************************************************
        sql = "UPDATE Person SET title = '" + title + "', personName = '" + 
            personName + "', institution = '" + institution + "', country = '" + 
            country + "', phoneNo = '" + phoneNo + "', personEmail = '" + 
            personEmail + "' WHERE personId = '" + personId + "'; ";
        return SetData(sql);
    }

    #endregion SQL Statements for Person

    #region SQL statements for Author Functions

    public bool CreateSubmission(string submissionNo, string submissionTitle, string submissionAbstract,
    string submissionType, string decision, string contactAuthor, DataTable dtPersons)
    {
        // First, create an Oracle transaction.
        OracleTransaction trans = myOracleDBAccess.BeginTransaction();
        if (trans == null) { return false; }

        // Second, create the Person records for the submission. 
        foreach (DataRow row in dtPersons.Rows)
        {
            //***************
            // Uses TODO 02 *
            //***************
            if (!CreatePerson(row["personId"].ToString(), row["Title"].ToString(),
                row["Name"].ToString(), row["Institution"].ToString(), row["Country"].ToString(),
                row["Phone No"].ToString(), row["Email"].ToString(), trans))
            { return false; }
        }

        // Third, create the submission record.
        //*******************************************************
        // TODO 04: Used in CreateSubmission.aspx.cs            *
        // Construct the SQL INSERT statement to insert a value *
        // for all the attributes of the Submission table.      *
        //*******************************************************
        sql = "INSERT INTO Submission VALUES('" + submissionNo + "', '" + 
            submissionTitle + "', '" + submissionAbstract + "', '" + submissionType + 
            "', '" + decision + "', '" + contactAuthor + "'); ";
        if (!myOracleDBAccess.SetData(sql, trans)) { myOracleDBAccess.DisposeTransaction(trans); return false; }

        // Finally, create the author records for the submission.
        foreach (DataRow row in dtPersons.Rows)
        {
            //***************
            // Uses TODO 05 *
            //***************
            if (!CreateAuthor(row["personId"].ToString(), submissionNo, trans))
            { return false; }
        }
        myOracleDBAccess.CommitTransaction(trans);
        return true;
    }

    public bool CreateAuthor(string personId, string submissionNo, OracleTransaction trans)
    {
        //****************************************************
        // TODO 05: Used in CreateSubmission.aspx.cs         *
        // Construct the SQL INSERT statement to insert a    *
        // value for all the attributes of the Author table. *
        //****************************************************
        sql = "INSERT INTO Author VALUES('" + personId + "', '" + submissionNo + "'); ";
        if (!myOracleDBAccess.SetData(sql, trans)) { myOracleDBAccess.DisposeTransaction(trans); return false; }
        return true;
    }

    public DataTable GetSubmissionsForAuthor(string email)
    {
        //*********************************************************************************
        // TODO 06: Used in FindAllAuthorSubmissions.aspx.cs                              *
        // Construct the SQL SELECT statement to retrieve the submission number, title,   *
        // abstract and submission type for all submissions on which a person, identified * 
        // by his/her email address, is an author. Order the result by submission number. *
        //*********************************************************************************
        sql = "SELECT S.submissionNo, S.title, abstract, submissionType FROM Author A, " +
            "Submission S, Person P WHERE personEmail = '" + email + "' AND P.personId " +
            "= A.personId AND A.submissionNo = S.submissionNo ORDER BY S.submissionNo; ";
        return myOracleDBAccess.GetData(sql);
    }

    public decimal IsAuthor(string email)
    {
        //**************************************************************************
        // TODO 07: Used in FindAllAuthorSubmissions.aspx.cs                       *
        // Construct the SQL SELECT statement to determine if a person, identified *
        // by an email address, is an author. The SQL statement should return 0 if *
        // the person is not an author and 1 if he/she is an author.               *
        //**************************************************************************

        sql = "SELECT COUNT (DISTINCT A.personId) FROM Person P LEFT OUTER JOIN " + 
            "Author A ON P.personId = A.personId WHERE personEmail = '" + email + "'; ";
        return myOracleDBAccess.GetAggregateValue(sql);
    }

    public DataTable GetAuthorsForSubmission(string submissionNo)
    {
        //*******************************************************************************
        // TODO 08: Used in FindSubmission.aspx.cs                                      *
        // Construct the SQL SELECT statement to retrieve the title, name, institution, *
        // country, phone number and email for all authors of a submission, identified  *
        // by a submission number. If an author is the contact author, then retrieve    *
        // the contact author person id; otherwise, if the author is not the contact    *
        // author, then retrieve null for the contact author person id .                *
        //*******************************************************************************
        sql = "SELECT P.title, personName, institution, country, phoneNo, personEmail, " +
            "contactAuthor FROM Author A LEFT OUTER JOIN Submission S ON A.personId = " + 
            "S.contactAuthor AND A.submissionNo = S.submissionNo, Person P WHERE " + 
            "A.submissionNo = '" + submissionNo + "' AND A.personId = P.personId;";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetSubmissionDetails(string submissionNumber)
    {
        //*************************************************************************
        // TODO 09: Used in FindSubmission.aspx.cs                                *
        // Construct the SQL SELECT statement to retrieve the title, abstract     *
        // and submission type of a submission identified by a submission number. *
        //*************************************************************************
        sql = "SELECT title, abstract, submissionType FROM Submission WHERE submissionNo " +
            "= '" + submissionNumber + "'; ";
        return myOracleDBAccess.GetData(sql);
    }

    #endregion SQL statements for Author Functions

    #region SQL statements for PC Chair Functions

    public DataTable GetSubmissionNumbers()
    {
        //******************************************************
        // TODO 10: Used in AssignSubmissionToPCMember.aspx.cs *
        // Construct the SQL SELECT statement to retrieve the  *
        // submission numbers of all submissions.              *
        //******************************************************
        sql = "SELECT DISTINCT submissionNo FROM Submission; ";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetSubmissionTitle(string submissionNo)
    {
        //***************************************************************************
        // TODO 11: Used in AssignSubmissionToPCMember.aspx.cs,                     *
        //          CreateRefereeReport.aspx.cs, DisplayRefereeReport.aspx.cs       *
        // Construct the SQL SELECT statement to retrieve the title of a submission *
        // identified by a submission number.                                       *
        //***************************************************************************
        sql = "SELECT title FROM Submission WHERE submissionNo = '" + submissionNo + "'; ";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetPCMembersAssignedToSubmission(string submissionNo)
    {
        //********************************************************************
        // TODO 12: Used in AssignSubmissionToPCMember.aspx.cs               *
        // Construct the SQL SELECT statement to retrieve the PC code and PC *
        // member name of the PC members already assigned to a submission    *
        // identified by a submission number. Order the result by PC code.   *
        //********************************************************************
        sql = "SELECT A.pcCode, personName FROM AssignedTo A, Person P, PCMember PC " +
            "WHERE A.submissionNo = '" + submissionNo + "' AND A.pcCode = PC.pcCode " +
            "AND PC.personId = P.personId ORDER BY A.pcCode; ";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetPCMemberAvailableForAssignmentWithSpecifiedPreference(string submissionNo, string preference)
    {
        //**********************************************************************************
        // TODO 13: Used in AssignSubmissionToPCMember.aspx.cs                             *
        // Construct the SQL SELECT statement to retrieve the PC code, the preference for  *
        // a submission, identified by a submission number, and the number of submissions  *
        // to which he/she is already assigned for the PC members available for assignment *
        // to the submission WHO HAVE SPECIFIED A PREFERENCE for the submission greater    * 
        // than or equal to a specified preference. Order the result by PC code.           *
        //**********************************************************************************
        sql = "SELECT pcCode, preference FROM PreferenceFor WHERE submissionNo = '" + 
            submissionNo + "' AND preference >= '" + preference + "'; ";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetPCMemberAvailableForAssignmentWithNoSpecifiedPreference(string submissionNo)
    {
        //***********************************************************************************************
        // TODO 14: Used in AssignSubmissionToPCMember.aspx.cs                                          *
        // Construct the SQL SELECT statement to retrieve the PC code, the preference for a submission, *
        // identified by a submission number, set as null and the number of submissions to which he/she *
        // is already assigned for the PC members available for assignment to the submission WHO HAVE   *
        // NOT SPECIFIED ANY PREFERENCE for the submission. Order the result by PC code.                *
        //***********************************************************************************************
        sql = "";
        return myOracleDBAccess.GetData(sql);
    }

    public bool AssignPCMemberToReviewSubmission(string pcCode, string submissionNo)
    {
        //***********************************************************************************
        // TODO 15: Used in AssignSubmissionToPCMember.aspx.cs                              *
        // Construct the SQL INSERT statement to assign a PC member to review a submission. *
        //***********************************************************************************
        sql = "INSERT INTO AssignedTo VALUES('" + pcCode + "', '" + submissionNo + "'); ";
        return SetData(sql);
    }

    public bool CreatePCMember(string personId, string title, string personName, string institution,
    string country, string phoneNo, string personEmail, string pcCode)
    {
        // First, create an Oracle transaction.
        OracleTransaction trans = myOracleDBAccess.BeginTransaction();
        if (trans == null) { return false; }

        // Second, create the Person record for the PC member. 
        //***************
        // Uses TODO 02 *
        //***************
        if (!CreatePerson(personId, title, personName, institution, country, phoneNo, personEmail, trans))
        { return false; }

        // Finally, create the PCMember record.
        //****************************************************************************************
        // TODO 16: Used in CreatePCMember.aspx.cs                                               *
        // Construct the SQL statement to INSERT all the attribute values of the PCMember table. *
        //****************************************************************************************
        sql = "INSERT INTO PCMember VALUES('" + pcCode + "', '" + personId + "'); ";
        if (!myOracleDBAccess.SetData(sql, trans))
        { myOracleDBAccess.DisposeTransaction(trans); return false; }

        myOracleDBAccess.CommitTransaction(trans);
        return true;
    }

    public DataTable GetAllPCMembersInfo()
    {
        //************************************************************************
        // TODO 17: Used in DisplayPCMemberInfo.aspx.cs                          *
        // Construct the SQL SELECT statement to retrieve the PC code, title,    *
        // name, institution, country, phone number and email of all PC members. *
        // Order the result by PC code.                                          *
        //************************************************************************
        sql = "SELECT pcCode, title, personName, institution, country, phoneNo, " + 
            "personEmail FROM PCMember NATURAL JOIN Person ORDER BY pcCode; ";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetPCMemberInfo(string pcCode)
    {
        //*********************************************************
        // TODO 18: Used in EditPCMemberInfo.aspx.cs              *
        // Construct the SQL SELECT statement to retrieve all the *
        // attributes of a PC member identified by a PC code.     *
        //*********************************************************
        sql = "SELECT pcCode, title, personName, institution, country, phoneNo, " + 
            "personEmail FROM PCMember NATURAL JOIN Person WHERE pcCode = '" + pcCode + 
            "' ORDER BY pcCode; ";
        return myOracleDBAccess.GetData(sql);
    }

    #endregion SQL statements for PC Chair Functions

    #region SQL statements for PC Member Functions

    public DataTable GetAssignedSubmissionsWithNoReport(string pcCode)
    {
        //*************************************************************************
        // TODO 19: Used in CreateRefereeReport.aspx.cs                           *
        // Construct the SQL SELECT statement to retrieve the submission numbers  *
        // for the submissions that have been assigned to a PC member, identified *
        // by a PC code, and for which the PC member HAS NOT submitted a referee  *
        // report. Order the result by submission number.                         *
        //*************************************************************************
        sql = "SELECT submissionNo FROM AssignedTo WHERE pcCode = '" + pcCode + 
            "' AND(pcCode, submissionNo) NOT IN ( SELECT pcCode, submissionNo FROM " + 
            "RefereeReport) ORDER BY submissionNo; ";

        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetSubmissionAuthors(string submissionNumber)
    {
        //*****************************************************************************
        // TODO 20: Used in CreateRefereeReport.aspx.cs, DisplayRefereeReport.aspx.cs *
        // Construct the SQL SELECT statement to retrieve the names of the authors of * 
        // a submission identified by a submission number. Order the result by name.  *
        //*****************************************************************************
        sql = "SELECT personName FROM Author NATURAL JOIN Person WHERE submissionNo = '" +
            submissionNumber + "' ORDER BY personName; ";
        return myOracleDBAccess.GetData(sql);
    }

    public bool CreateRefereeReport(string pcCode, string submissionNumber, string relevant, string technicallyCorrect,
        string lengthAndContent, string originality, string impact, string presentation, string technicalDepth,
        string overallRating, string confidence, string mainContribution, string strongPoints, string weakPoints,
        string overallSummary, string detailedComments, string confidentialComments)
    {
        //*********************************************************************************
        // TODO 21: Used in CreateRefereeReport.aspx.cs                                   *
        // Construct the SQL INSERT statement to insert a referee report for a PC member, *
        // identified by a PC code, for a submission, identified by a submission number.  *
        //*********************************************************************************
        sql = "INSERT INTO RefereeReport VALUES('" + pcCode + "', '" + submissionNumber + 
            "', '" + relevant + "', '" + technicallyCorrect + "', '" + lengthAndContent +
            "', '" + originality + "', '" + impact + "', '" + presentation + "', '" + 
            technicalDepth + "', '" + overallRating + "', '" + confidence + "', '" + 
            mainContribution + "', '" + strongPoints + "', '" + weakPoints + "', '" + 
            overallSummary + "', '" + detailedComments + "', '" + confidentialComments + 
            "'); ";
        return SetData(sql);
    }

    public DataTable GetRefereeReport(string pcCode, string submissionNumber)
    {
        //********************************************************************
        // TODO 22: Used in DisplayRefereeReport.aspx.cs                     *
        // Construct the SQL SELECT statement to retrieve all the attributes * 
        // for a referee report for a PC member, identified by a PC code and *
        // submission, identified by a submission number.                    *
        //********************************************************************
        sql = "SELECT * FROM RefereeReport WHERE pcCode = '" + pcCode + 
            "' AND submissionNo = '" + submissionNumber + "'; ";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetDiscussion(string submissionNumber)
    {
        //*********************************************************************
        // TODO 23: Used in DisplayRefereeReport.aspx.cs                      *
        // Construct the SQL statement to retrieve the PC code and discussion *
        // comments for a submission identified by a submission number.       *
        // Order the comments from earliest to latest.                        *
        //*********************************************************************
        sql = "SELECT pcCode, comments FROM Discussion WHERE submissionNo = '" + 
            submissionNumber + "' ORDER BY sequenceNo ASC; ";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetAssignedSubmissionsWithReport(string pcCode)
    {
        //************************************************************************
        // TODO 24: Used in DisplayRefereeReport.aspx.cs                         *
        // Construct the SQL SELECT statement to retrieve the submission numbers *
        // for which a PC member, identified by a PC code, has already submitted *
        // a referee report. Order the result by submission number.              *
        //************************************************************************
        sql = "SELECT submissionNo FROM RefereeReport WHERE pcCode = '" + pcCode + 
            "' ORDER BY submissionNo; ";
        return myOracleDBAccess.GetData(sql);
    }

    public bool CreateDiscusssion(string sequenceNumber, string pcCode, string submissionNumber, string comments)
    {
        //****************************************************
        // TODO 25: Used in DisplayRefereeReport.aspx.cs     *
        // Construct the SQL INSERT statement to insert      *
        // all the attribute values of the Discussion table. *
        //****************************************************
        sql = "INSERT INTO Discussion VALUES('" + sequenceNumber + "', '" + pcCode + 
            "', '" + submissionNo + "', '" + comments + "'); ";
        return SetData(sql);
    }

    public DataTable GetAssignedSubmissionsReviewed(string pcCode)
    {
        //************************************************************************
        // TODO 26: Used in DisplayReviewingStatus.aspx.cs                  *
        // Construct the SQL SELECT statement to retrieve the submission number, *
        // title, abstract and submission type for the submissions that have     *
        // been assigned to a PC member, identified by a PC code for review and  *
        // for which the PC member HAS SUBMITTED a referee report.               *
        // Order the result by submission number.                                *
        //************************************************************************

        sql = "SELECT submissionNo, title, abstract, submissionType FROM AssignedTo A " + 
            "NATURAL JOIN Submission S WHERE pcCode = '" + pcCode + "' AND(pcCode, " + 
            "submissionNo) IN( SELECT pcCode, submissionNo FROM RefereeReport) ORDER " +
            "BY submissionNo; ";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetAssignedSubmissionsNotReviewed(string pcCode)
    {
        //************************************************************************
        // TODO 27: Used in DisplayReviewingStatus.aspx.cs                  *
        // Construct the SQL SELECT statement to retrieve the submission number, *
        // title, abstract and submission type for the submissions that have     *
        // been assigned to a PC member, identified by a PC code for review and  *
        // for which the PC member HAS NOT SUBMITTED a referee report.           *
        // Order the result by submission number.                                *
        //************************************************************************

        sql = "SELECT submissionNo, title, abstract, submissionType FROM AssignedTo A " +
            "NATURAL JOIN Submission S WHERE pcCode = '" + pcCode + "' AND(pcCode, " + 
            "submissionNo) NOT IN ( SELECT pcCode, submissionNo FROM RefereeReport) " +
            "ORDER BY submissionNo; ";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetSubmissionsWithPreference(string pcCode)
    {
        //**************************************************************************
        // TODO 28:Used in DisplaySubmissionsAndPreferences.aspx.cs                *
        // Construct the SQL SELECT statement to retrieve the submission number,   *
        // title, abstract, submission type and preference for ONLY those          *
        // submissions for which a PC member, identified by a PC code, HAS ALREADY *
        // SPECIFIED A PREFERENCE. Order the result by submission number.          *
        //**************************************************************************
        sql = "SELECT submissionNo, title, abstract, submissionType, preference FROM " +
            "PreferenceFor NATURAL JOIN Submission WHERE pcCode = '" + pcCode + "'ORDER" +
            "BY submissionNo; ";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetSubmissionsWithoutPreference(string pcCode)
    {
        //************************************************************************
        // TODO 29: Used in DisplaySubmissionsAndPreferences.aspx.cs             *
        // Construct the SQL SELECT statement to retrieve the submission number, *
        // title, abstract and submission type for ONLY those submissions for    *
        // which a PC member, identified by a PC code, HAS NOT SPECIFIED A       *
        // PREFERENCE. Order the result by submission number.                    *
        //************************************************************************
        sql = "SELECT submissionNo, title, abstract, submissionType FROM Submission " +
            "WHERE submissionNo NOT IN (SELECT submissionNo FROM PreferenceFor WHERE " +
            "pcCode = '" + pcCode + "' ) ORDER BY submissionNo; ";
        return myOracleDBAccess.GetData(sql);
    }

    public bool CreatePreferenceForSubmission(string pcCode, string submissionNo, string preference)
    {
        //*******************************************************************************
        // TODO 30: Used in DisplaySubmissionsAndPreferences.aspx.cs                    *
        // Construct the SQL INSERT statement to insert a preference for a PC member,   *
        // identified by a PC code and a submission, identified by a submission number. *
        //*******************************************************************************
        sql = "INSERT INTO PreferenceFor VALUES('" + pcCode + "', '" + submissionNo +
            "', '" + preference + "'); ";
        return SetData(sql);
    }

    #endregion SQL statements for PC Member Functions

    #region *** DO NOT CHANGE THE METHOD BELOW THIS LINE. IT IS NOT A TODO!!! ***!
    public bool SetData(string sql)
    {
        OracleTransaction trans = myOracleDBAccess.BeginTransaction();
        if (trans == null) { return false; }
        if (myOracleDBAccess.SetData(sql, trans))
        { myOracleDBAccess.CommitTransaction(trans); return true; } // The insert/update/delete succeeded.
        else
        { myOracleDBAccess.DisposeTransaction(trans); return false; } // The insert/update/delete failed.
    }
    #endregion
}