-- DROP ANY EXISTING CONSTRAINTS AND TABLES
select 'alter table '||u.table_name||' drop constraint '||c.constraint_name  
from user_tables u, user_constraints c
where u.table_name=c.table_name;
drop table EnrollsIn;drop table Facility;drop table Student;drop table Course;drop table Department;drop table LowCga;
drop table Submission;drop table Person;drop table PCMember;drop table PCChair;drop table AssignedTo;drop table PreferenceFor;
drop table RefereeReport;drop table Discussion;drop table Author;


CREATE TABLE Submission(
    submissionNo    INT             PRIMARY KEY,
    title           VARCHAR2(50),
    abstract        VARCHAR2(300),
    submissionType  VARCHAR2(20)    DEFAULT 'research' CHECK (submissionType IN ('research', 'demo', 'industrial')),
    decision        VARCHAR2(6)     DEFAULT NULL CHECK (decision IN ('accept', 'reject')),
    -- BELOW ATTRIBUTE FOR HASCONTACT
    contactAuthor   SMALLINT        REFERENCES Author(personId) ON DELETE CASCADE 
    );

CREATE TABLE Person(
    personId        SMALLINT        PRIMARY KEY,
    title           CHAR(50)        DEFAULT NULL CHECK (title IN ('Mr', 'Ms', 'Miss', 'Dr', 'Prof')),
    personName      VARCHAR2(50),
    institution     VARCHAR2(100),
    country         VARCHAR2(30),
    -- TODO: PHONENO SHOULD BE 8 TO 15 DIGITS ONLY
    phoneNo         VARCHAR2(15)    CHECK (phoneNo BETWEEN 10000000 AND 999999999999999),
    personEmail     VARCHAR2(50)    UNIQUE
    );

CREATE TABLE PCMember(
    pcCode          CHAR(4)         PRIMARY KEY,
    personId        SMALLINT        REFERENCES Person(personId) ON DELETE CASCADE
    );
    
CREATE TABLE PCChair(
    pcCode          CHAR(4)         PRIMARY KEY REFERENCES PCMember(pcCode) ON DELETE CASCADE
    );
    
CREATE TABLE AssignedTo(
    -- TODO: CHECK THE REFERENTIAL INTEGRITY ACTION FOR RELATIONSHIP ENTITY
    pcCode          CHAR(4)         REFERENCES PCMember(pcCode) ON DELETE SET NULL,
    submissionNo    SMALLINT        REFERENCES Submission(submissionNo) ON DELETE SET NULL,
    PRIMARY KEY (pcCode, submissionNo)
    );
    
CREATE TABLE PreferenceFor(
    -- TODO: CHECK THE REFERENTIAL INTEGRITY ACTION FOR RELATIONSHIP ENTITY
    pcCode          CHAR(4)         REFERENCES PCMember(pcCode) ON DELETE SET NULL,
    submissionNo    SMALLINT        REFERENCES Submission(submissionNo) ON DELETE SET NULL,
    PRIMARY KEY (pcCode, submissionNo),
    preference      SMALLINT        CHECK (preference BETWEEN 1 AND 5)
    );
    
CREATE TABLE RefereeReport(
    pcCode          CHAR(4)         REFERENCES PCMember(pcCode) ON DELETE CASCADE,
    submissionNo    SMALLINT        REFERENCES Submission(submissionNo) ON DELETE CASCADE,
    PRIMARY KEY (pcCode, submissionNo),
    relevant        CHAR(1)         CHECK (relevant IN ('Y', 'N', 'M')),
    technicallyCorrect  CHAR(1)     CHECK (technicallyCorrect IN ('Y', 'N', 'M')),
    lengthAndContent    CHAR(1)     CHECK (lengthAndContent IN ('Y', 'N', 'M')),
    originality     SMALLINT        CHECK (originality BETWEEN 1 AND 5),
    impact          SMALLINT        CHECK (impact BETWEEN 1 AND 5),
    presentation    SMALLINT`       CHECK (presentation BETWEEN 1 AND 5),
    technicalDepth  SMALLINT        CHECK (technicalDepth BETWEEN 1 AND 5),
    overallRating   SMALLINT        CHECK (overallRating BETWEEN 1 AND 5),
    confidence      NUMBER(2,1)     CHECK (confidence BETWEEN 0.5 AND 1),
    mainContribution    VARCHAR2(300),
    strongPoints    VARCHAR2(300),
    weakPoints      VARCHAR2(300),
    overallSummary  VARCHAR2(300),
    detailedComments    VARCHAR2(1000),
    confidentialComments VARCHAR2(300)
    );

CREATE TABLE Discussion(
    sequenceNo      SMALLINT,
    submissionNo    SMALLINT        REFERENCES Submission(submissionNo) ON DELETE CASCADE,
    pcCode          CHAR(4)         REFERENCES PCMember(pcCode) ON DELETE CASCADE,
    PRIMARY KEY (sequenceNo, submissionNo, pcCode),
    comments        VARCHAR2(200)
    );

CREATE TABLE Author(
    personId        SMALLINT        REFERENCES Person(personId) ON DELETE CASCADE,
    -- TODO: CHECK WHICH RELATION OF BELOW ATTRIBUTES (HASAUTHOR / HASCONTACT) OF DELETE
    -- "EVERY AUTHOR HAS TO AT LEAST AUTHOR ONE"
    submissionNo    SMALLINT        REFERENCES Submission(submissionNo) ON DELETE SET NULL,
    PRIMARY KEY (personId, submissionNo)
    );

commit