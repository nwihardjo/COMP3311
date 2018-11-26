/*************************************************************************
// TODO 01: Used in CreatePCMember.aspx.cs, CreateRefereeReport.aspx.cs,  *
//          DisplayRefereeReport.aspx.cs, DisplayReviewingStatus.aspx.cs, *
//          DisplaySubmissionPreferences.aspx.cs                          *
// Construct the SQL SELECT statement to determine if a PC code already   *
// exists in the PCMember table. The SQL statement should return 0 if the *
// PC code does not exist and 1 if it does exist.                         *
//*************************************************************************
VAR: pcCode
*/
SELECT COUNT(personId)
FROM PCMember 
WHERE pcCode = 'pcCode';

/********************************************************************
// TODO 02: Used in CreateSubmission.aspx.cs, CreatePCMember.aspx.cs *
// Construct the SQL INSERT statement to insert a value for all the  *
// attributes of the Person table.                                   *
//********************************************************************
*/
INSERT INTO Person 
VALUES ('personId', 'title', 'personName', 'institution', 'country', 'phoneNo', 'personEmail');

/*******************************************************
// TODO 03: Used in EditPCMemberInfo.aspx.cs            *
// Construct the SQL UPDATE statement to update all the *
// attributes of a person identified by a person id.    *
//*******************************************************
*/
UPDATE Person
SET title = 'title', personName = 'personName', institution = 'institution', country = 'country',
    phoneNo = 'phoneNo', personEmail = 'personEmail'
WHERE personId = 'personId';

/*******************************************************
// TODO 04: Used in CreateSubmission.aspx.cs            *
// Construct the SQL INSERT statement to insert a value *
// for all the attributes of the Submission table.      *
//*******************************************************
*/
INSERT INTO Submission
VALUES ('submissionNo', 'submissionTitle', 'submissionAbstract', 'submissionType', 'decision',
    'contactAuthor');
/****************************************************
// TODO 05: Used in CreateSubmission.aspx.cs         *
// Construct the SQL INSERT statement to insert a    *
// value for all the attributes of the Author table. *
//****************************************************
*/
INSERT INTO Author
VALUES ('personId', 'submissionNo');

/*********************************************************************************
// TODO 06: Used in FindAllAuthorSubmissions.aspx.cs                              *
// Construct the SQL SELECT statement to retrieve the submission number, title,   *
// abstract and submission type for all submissions on which a person, identified * 
// by his/her email address, is an author. Order the result by submission number. *
//*********************************************************************************
VAR: email
*/
SELECT      S.submissionNo, S.title, abstract, submissionType
FROM        Author A, Submission S, Person P
WHERE       personEmail = 'email' AND P.personId = A.personId AND A.submissionNo = S.submissionNo
ORDER BY    S.submissionNo;

/**************************************************************************
// TODO 07: Used in FindAllAuthorSubmissions.aspx.cs                       *
// Construct the SQL SELECT statement to determine if a person, identified *
// by an email address, is an author. The SQL statement should return 0 if *
// the person is not an author and 1 if he/she is an author.               *
//**************************************************************************
VAR: email
*/
SELECT COUNT (DISTINCT A.personId)
FROM Person P LEFT OUTER JOIN Author A ON P.personId = A.personId
WHERE personEmail = 'email';

/*******************************************************************************
// TODO 08: Used in FindSubmission.aspx.cs                                      *
// Construct the SQL SELECT statement to retrieve the title, name, institution, *
// country, phone number and email for all authors of a submission, identified  *
// by a submission number. If an author is the contact author, then retrieve    *
// the contact author person id; otherwise, if the author is not the contact    *
// author, then retrieve null for the contact author person id .                *
//*******************************************************************************
VAR: submissionNo
*/
SELECT P.title, personName, institution, country, phoneNo, personEmail, contactAuthor 
FROM Author A LEFT OUTER JOIN Submission S ON A.personId = S.contactAuthor AND A.submissionNo = S.submissionNo, Person P
WHERE A.submissionNo = 'submissionNo' AND A.personId = P.personId;
    

/*************************************************************************
// TODO 09: Used in FindSubmission.aspx.cs                                *
// Construct the SQL SELECT statement to retrieve the title, abstract     *
// and submission type of a submission identified by a submission number. *
//*************************************************************************
VAR: submissionNumber 
*/
SELECT title, abstract, submissionType
FROM Submission
WHERE submissionNo = 'submissionNumber';

/******************************************************
// TODO 10: Used in AssignSubmissionToPCMember.aspx.cs *
// Construct the SQL SELECT statement to retrieve the  *
// submission numbers of all submissions.              *
//*****************************************************
*/
SELECT DISTINCT submissionNo
FROM Submission;

/***************************************************************************
// TODO 11: Used in AssignSubmissionToPCMember.aspx.cs,                     *
//          CreateRefereeReport.aspx.cs, DisplayRefereeReport.aspx.cs       *
// Construct the SQL SELECT statement to retrieve the title of a submission *
// identified by a submission number.                                       *
//***************************************************************************
VAR: submissionNo
*/
SELECT title
FROM Submission
WHERE submissionNo = 'submissionNo';

/********************************************************************
// TODO 12: Used in AssignSubmissionToPCMember.aspx.cs               *
// Construct the SQL SELECT statement to retrieve the PC code and PC *
// member name of the PC members already assigned to a submission    *
// identified by a submission number. Order the result by PC code.   *
//********************************************************************
VAR: submissionNo
*/
SELECT A.pcCode, personName
FROM AssignedTo A, Person P, PCMember PC
WHERE A.submissionNo = 'submissionNo' AND A.pcCode = PC.pcCode AND PC.personId = P.personId
ORDER BY A.pcCode;

/**********************************************************************************
// TODO 13: Used in AssignSubmissionToPCMember.aspx.cs                             *
// Construct the SQL SELECT statement to retrieve the PC code, the preference for  *
// a submission, identified by a submission number, and the number of submissions  *
// to which he/she is already assigned for the PC members available for assignment *
// to the submission WHO HAVE SPECIFIED A PREFERENCE for the submission greater    * 
// than or equal to a specified preference. Order the result by PC code.           *
//**********************************************************************************
VAR: submissionNo, preference
*/
WITH temp AS (
    SELECT pcCode, preference
    FROM PreferenceFor P 
    WHERE submissionNo = 'submissionNo' AND preference >= 'preference' AND 
        pcCode NOT IN ( SELECT pcCode FROM AssignedTo WHERE submissionNo = 'submissionNo'))
SELECT pcCode, preference, count(*)
FROM temp NATURAL JOIN AssignedTo
GROUP BY pcCode, preference
ORDER BY pcCode;

/***********************************************************************************************
// TODO 14: Used in AssignSubmissionToPCMember.aspx.cs                                          *
// Construct the SQL SELECT statement to retrieve the PC code, the preference for a submission, *
// identified by a submission number, set as null and the number of submissions to which he/she *
// is already assigned for the PC members available for assignment to the submission WHO HAVE   *
// NOT SPECIFIED ANY PREFERENCE for the submission. Order the result by PC code.                *
//***********************************************************************************************
VAR: submissionNo
*/
SELECT P.pcCode, null, count(A.pcCode)
FROM PCMember P LEFT OUTER JOIN AssignedTo A ON P.pcCode = A.pcCode
WHERE P.pcCode NOT IN (SELECT pcCode FROM AssignedTo WHERE submissionNo = 'submissionNo') AND
    P.pcCode NOT IN (SELECT pcCode from PreferenceFor WHERE submissionNo = 'submissionNo')
GROUP BY P.pcCode, null
ORDER BY P.pcCode;


/***********************************************************************************
// TODO 15: Used in AssignSubmissionToPCMember.aspx.cs                              *
// Construct the SQL INSERT statement to assign a PC member to review a submission. *
//***********************************************************************************
VAR: pcCode, submissionNo
*/
INSERT INTO AssignedTo
VALUES ('pcCode', 'submissionNo');

/****************************************************************************************
// TODO 16: Used in CreatePCMember.aspx.cs                                               *
// Construct the SQL statement to INSERT all the attribute values of the PCMember table. *
//****************************************************************************************
VAR: personId, title, personName, institution, country, phoneNo, personEmail, pcCode
*/
INSERT INTO PCMember
VALUES ('pcCode', 'personId');

/************************************************************************
// TODO 17: Used in DisplayPCMemberInfo.aspx.cs                          *
// Construct the SQL SELECT statement to retrieve the PC code, title,    *
// name, institution, country, phone number and email of all PC members. *
// Order the result by PC code.                                          *
//************************************************************************
*/
SELECT pcCode, title, personName, institution, country, phoneNo, personEmail
FROM PCMember NATURAL JOIN Person 
ORDER BY pcCode;

/*********************************************************
// TODO 18: Used in EditPCMemberInfo.aspx.cs              *
// Construct the SQL SELECT statement to retrieve all the *
// attributes of a PC member identified by a PC code.     *
//*********************************************************
VAR: pcCode
*/
SELECT pcCode, personId, title, personName, institution, country, phoneNo, personEmail
FROM PCMember NATURAL JOIN Person
WHERE pcCode = 'pcCode'
ORDER BY pcCode;

/*************************************************************************
// TODO 19: Used in CreateRefereeReport.aspx.cs                           *
// Construct the SQL SELECT statement to retrieve the submission numbers  *
// for the submissions that have been assigned to a PC member, identified *
// by a PC code, and for which the PC member HAS NOT submitted a referee  *
// report. Order the result by submission number.                         *
//*************************************************************************
VAR: pcCode
*/
SELECT submissionNo
FROM AssignedTo
WHERE pcCode = 'pcCode' AND (pcCode, submissionNo) NOT IN (
    SELECT pcCode, submissionNo FROM RefereeReport )
ORDER BY submissionNo;

/*****************************************************************************
// TODO 20: Used in CreateRefereeReport.aspx.cs, DisplayRefereeReport.aspx.cs *
// Construct the SQL SELECT statement to retrieve the names of the authors of * 
// a submission identified by a submission number. Order the result by name.  *
//*****************************************************************************
VAR: submissionNumber
*/
SELECT personName
FROM Author NATURAL JOIN Person
WHERE submissionNo = 'submissionNumber'
ORDER BY personName;

/*********************************************************************************
// TODO 21: Used in CreateRefereeReport.aspx.cs                                   *
// Construct the SQL INSERT statement to insert a referee report for a PC member, *
// identified by a PC code, for a submission, identified by a submission number.  *
//*********************************************************************************
VAR: pcCode, submissionNumber, relevant, technicallyCorrect, lengthAndContent, originality, impact, presentation,
    technicalDepth, overallRating, confidence, mainContribution, strongPoints, weakPoints, overallSummary, detailedComments,
    confidentialComments
*/
INSERT INTO RefereeReport
VALUES ('pcCode', 'submissionNumber', 'relevant', 'technicallyCorrect', 'lengthAndContent', 
    'originality', 'impact', 'presentation', 'technicalDepth', 'overallRating', 'confidence', 
    'mainContribution', 'strongPoints', 'weakPoints', 'overallSummary', 'detailedComments', 
    'confidentialComments');

/********************************************************************
// TODO 22: Used in DisplayRefereeReport.aspx.cs                     *
// Construct the SQL SELECT statement to retrieve all the attributes * 
// for a referee report for a PC member, identified by a PC code and *
// submission, identified by a submission number.                    *
//********************************************************************
VAR: pcCode, submissionNumber
*/
SELECT * 
FROM RefereeReport
WHERE pcCode = 'pcCode' AND submissionNo = 'submissionNumber';

/*********************************************************************
// TODO 23: Used in DisplayRefereeReport.aspx.cs                      *
// Construct the SQL statement to retrieve the PC code and discussion *
// comments for a submission identified by a submission number.       *
// Order the comments from earliest to latest.                        *
//*********************************************************************
VAR: submissionNumber
*/
SELECT pcCode, comments
FROM Discussion
WHERE submissionNo = 'submissionNumber'
ORDER BY sequenceNo ASC;

/************************************************************************
// TODO 24: Used in DisplayRefereeReport.aspx.cs                         *
// Construct the SQL SELECT statement to retrieve the submission numbers *
// for which a PC member, identified by a PC code, has already submitted *
// a referee report. Order the result by submission number.              *
//************************************************************************
VAR: pcCode
*/
SELECT submissionNo
FROM RefereeReport
WHERE pcCode = 'pcCode'
ORDER BY submissionNo;

/****************************************************
// TODO 25: Used in DisplayRefereeReport.aspx.cs     *
// Construct the SQL INSERT statement to insert      *
// all the attribute values of the Discussion table. *
//****************************************************
VAR: sequenceNumber, pcCode, submissionNo, comments
*/
INSERT INTO Discussion
VALUES ('sequenceNumber', 'pcCode', 'submissionNo', 'comments');

/************************************************************************
// TODO 26: Used in DisplayReviewingStatus.aspx.cs                  *
// Construct the SQL SELECT statement to retrieve the submission number, *
// title, abstract and submission type for the submissions that have     *
// been assigned to a PC member, identified by a PC code for review and  *
// for which the PC member HAS SUBMITTED a referee report.               *
// Order the result by submission number.                                *
//************************************************************************
VAR: pcCode
*/
SELECT submissionNo, title, abstract, submissionType
FROM AssignedTo A NATURAL JOIN Submission S 
WHERE pcCode = 'pcCode' AND (pcCode, submissionNo) IN (
    SELECT pcCode, submissionNo
    FROM RefereeReport )
ORDER BY submissionNo;

/************************************************************************
// TODO 27: Used in DisplayReviewingStatus.aspx.cs                  *
// Construct the SQL SELECT statement to retrieve the submission number, *
// title, abstract and submission type for the submissions that have     *
// been assigned to a PC member, identified by a PC code for review and  *
// for which the PC member HAS NOT SUBMITTED a referee report.           *
// Order the result by submission number.                                *
//************************************************************************
VAR: pcCode
*/
SELECT submissionNo, title, abstract, submissionType
FROM AssignedTo A NATURAL JOIN Submission S 
WHERE pcCode = 'pcCode' AND (pcCode, submissionNo) NOT IN (
    SELECT pcCode, submissionNo
    FROM RefereeReport )
ORDER BY submissionNo;

/**************************************************************************
// TODO 28:Used in DisplaySubmissionsAndPreferences.aspx.cs                *
// Construct the SQL SELECT statement to retrieve the submission number,   *
// title, abstract, submission type and preference for ONLY those          *
// submissions for which a PC member, identified by a PC code, HAS ALREADY *
// SPECIFIED A PREFERENCE. Order the result by submission number.          *
//**************************************************************************
VAR: pcCode
*/
SELECT submissionNo, title, abstract, submissionType, preference
FROM PreferenceFor NATURAL JOIN Submission 
WHERE pcCode = 'ec01'
ORDER BY submissionNo;

/************************************************************************
// TODO 29: Used in DisplaySubmissionsAndPreferences.aspx.cs             *
// Construct the SQL SELECT statement to retrieve the submission number, *
// title, abstract and submission type for ONLY those submissions for    *
// which a PC member, identified by a PC code, HAS NOT SPECIFIED A       *
// PREFERENCE. Order the result by submission number.                    *
//************************************************************************
VAR: pcCode
*/
SELECT submissionNo, title, abstract, submissionType
FROM Submission 
WHERE submissionNo NOT IN (
    SELECT submissionNo
    FROM PreferenceFor
    WHERE pcCode = 'pcCode' )
ORDER BY submissionNo;

/*******************************************************************************
// TODO 30: Used in DisplaySubmissionsAndPreferences.aspx.cs                    *
// Construct the SQL INSERT statement to insert a preference for a PC member,   *
// identified by a PC code and a submission, identified by a submission number. *
//******************************************************************************
VAR: pcCode, submissionNo, preference
*/

INSERT INTO PreferenceFor
VALUES ('pcCode', 'submissionNo', 'preference');