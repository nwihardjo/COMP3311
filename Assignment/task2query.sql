--NATHANIEL WIHARDJO (20315011)

/*  
    For each submission that has at least 3 PC members assigned to it, find the title, submission type,
    contact author name and contact author email. Order the result by contact author name 
*/
SELECT  S.title, submissionType, P.personName, P.personEmail
FROM    Submission S, Author A, Person P
WHERE   S.contactAuthor = A.personId AND A.personId = P.personId AND
        S.submissionNo IN ( SELECT submissionNo 
                            FROM AssignedTo
                            GROUP BY submissionNo
                            HAVING COUNT(pcCode) >= 3)
ORDER BY P.personName
;
  
    
/*
    Find the author names and submission title for those submissions that have only PC members as authors
*/
WITH Combine (title, personId, authorName) AS (
    SELECT  S.title, A.personId, P.personName
    FROM    Submission S, Author A, Person P
    WHERE   A.submissionNo = S.submissionNo AND A.personId = P.personId )
SELECT  authorName, title
FROM    Combine C LEFT OUTER JOIN PCMember PCM ON C.personId = PCM.personId
WHERE   PCM.personId IS NOT NULL
;


/*
    Find the submission number, title and submission type of those submissions for which no PC member has indicated a 
        preference. Order the result by submission number
*/
SELECT  S.submissionNo, title, submissionType
FROM    Submission S LEFT OUTER JOIN PreferenceFor P ON S.submissionNo = P.submissionNo 
WHERE   P.pcCode IS NULL 
ORDER BY S.submissionNo
;


/* 
    For those PC members who have indicated a preference of 3 or greater for less than 2 submissions,
        find the PC member name as well as the submission number, title and preference of the 
        submission for which they have indicated a preference. Order the result first by PC member 
        name in ascending order and then by prefe rence for a submission in descending order
*/
WITH temp (pcCode) AS (
    SELECT      pcCode
    FROM        PreferenceFor
    WHERE       preference >= 3
    GROUP BY    pcCode
    HAVING      COUNT(*) < 2 )
SELECT      P.personName, PF.submissionNo, S.title, preference
FROM        temp T, Person P, PCMember PM, Submission S, PreferenceFor PF
WHERE       T.pcCode = PM.pcCode AND PM.personId = P.personId AND 
            T.pcCode = PF.pcCode AND preference >= 3 AND PF.submissionNo = S.submissionNo
ORDER BY    P.personName ASC, preference DESC
;


/*
    For each submission that has at least three reviews, find the submission number, title, 
        submission type, PC member names, overall ratings and spread where the spread is 1 or greater.
        Order the result by submission number
*/
WITH temp (submissionNo, spread) AS (
    SELECT submissionNo, max(overallRating) - min(overallRating)
    FROM RefereeReport
    GROUP BY submissionNo
    HAVING COUNT (*) > 3 AND max(overallRating)-min(overallRating) >= 1)
SELECT  T.submissionNo, S.title, submissionType, P.personName, overallRating, spread
FROM    temp T, RefereeReport R, Submission S, PCMember PM, Person P
WHERE   S.submissionNo = T.submissionNo AND T.submissionNo = R.submissionNo AND
        PM.pcCode = R.pcCode AND P.personId = PM.personId
ORDER BY R.submissionNo
;