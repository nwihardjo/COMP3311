--NATHANIEL WIHARDJO (20315011)

-- TODO : DELETE FOLLOWING LINE UPON SUBMISSION
@task2_dropconstraint

drop table RefereeReport;
drop table Discussion;
drop table AssignedTo;
drop table PreferenceFor;
drop table Submission;
drop table Author;
drop table PCChair;
drop table PCMember;
drop table Person;


CREATE TABLE Person(
    personId        SMALLINT,               CONSTRAINT person_pk PRIMARY KEY (personId),
    title           CHAR(50) DEFAULT NULL,  CONSTRAINT person_title CHECK (title IN ('Mr', 'Ms', 'Miss', 'Dr', 'Prof')),
    personName      VARCHAR2(50),
    institution     VARCHAR2(100),
    country         VARCHAR2(30),
    -- TODO : PHONENO SHOULD BE 8 TO 15 DIGITS ONLY, WHETHER CAN BE INSERTED LETTER OR NOT
    phoneNo         VARCHAR2(15),           CONSTRAINT person_phone CHECK (phoneNo BETWEEN 10000000 AND 999999999999999),
    personEmail     VARCHAR2(50),           CONSTRAINT person_email UNIQUE (personEmail)    
    );
    
    
CREATE TABLE PCMember(
    pcCode          CHAR(4),    CONSTRAINT pcm_pk PRIMARY KEY (pcCode),
    personId        SMALLINT,   CONSTRAINT pcm_fk FOREIGN KEY (personId) REFERENCES Person(personId) ON DELETE CASCADE
    );
    
    
CREATE TABLE PCChair(
    pcCode          CHAR(4),    
    CONSTRAINT pcc_pk PRIMARY KEY (pcCode),
    CONSTRAINT pcc_fk FOREIGN KEY (pcCode) REFERENCES PCMember(pcCode) ON DELETE CASCADE
    );
    
    
CREATE TABLE Author(
    personId        SMALLINT,   CONSTRAINT author_fk FOREIGN KEY (personId) REFERENCES Person(personId) ON DELETE CASCADE,
    submissionNo    SMALLINT,
    -- TODO : CHECK WHICH RELATION OF BELOW ATTRIBUTES (HASAUTHOR / HASCONTACT) OF DELETE
    -- "EVERY AUTHOR HAS TO AT LEAST AUTHOR ONE"   
    CONSTRAINT author_pk PRIMARY KEY (personid, submissionNo)
    );


CREATE TABLE Submission(
    submissionNo    INT,     
    CONSTRAINT submission_pk PRIMARY KEY (submissionNo),
    
    title           VARCHAR2(50),   
    abstract        VARCHAR2(300),  
    submissionType  VARCHAR2(20) DEFAULT 'research', 
    CONSTRAINT submission_type CHECK (submissionType IN ('research', 'demo', 'industrial')),
    
    decision        VARCHAR2(6) DEFAULT NULL, 
    CONSTRAINT submission_decision CHECK (decision IN ('accept', 'reject')),
    
    -- BELOW ATTRIBUTE FOR HASCONTACT
    -- TODO : CHECK WHETHER THE FOREIGN KEY CONSTRAINT IS CORRECT
    contactAuthor   SMALLINT, 
    CONSTRAINT submission_fk FOREIGN KEY (contactAuthor, submissionNo) REFERENCES Author(personId, submissionNo) ON DELETE CASCADE 
    );
    
    
ALTER TABLE Author ADD CONSTRAINT author_fk2 FOREIGN KEY (submissionNo) REFERENCES Submission(submissionNo) ON DELETE CASCADE;


CREATE TABLE AssignedTo(
    -- TODO : CHECK THE REFERENTIAL INTEGRITY ACTION FOR RELATIONSHIP ENTITY
    pcCode          CHAR(4),    CONSTRAINT assign_fk FOREIGN KEY (pcCode) REFERENCES PCMember(pcCode) ON DELETE CASCADE,
    submissionNo    SMALLINT,   CONSTRAINT assign_fk2 FOREIGN KEY (submissionNo) REFERENCES Submission(submissionNo) ON DELETE CASCADE,
    CONSTRAINT assign_pk PRIMARY KEY (pcCode, submissionNo)
    );
    
    
CREATE TABLE PreferenceFor(
    -- TODO : CHECK THE REFERENTIAL INTEGRITY ACTION FOR RELATIONSHIP ENTITY
    pcCode          CHAR(4),    CONSTRAINT pref_fk FOREIGN KEY (pcCode) REFERENCES PCMember(pcCode) ON DELETE CASCADE,
    submissionNo    SMALLINT,   CONSTRAINT pref_fk2 FOREIGN KEY (submissionNo) REFERENCES Submission(submissionNo) ON DELETE CASCADE,
    CONSTRAINT pref_pk PRIMARY KEY (pcCode, submissionNo),
    preference      SMALLINT,   CONSTRAINT pref_ CHECK (preference BETWEEN 1 AND 5)
    );
    
    
CREATE TABLE RefereeReport(
    pcCode          CHAR(4),    CONSTRAINT report_fk FOREIGN KEY (pcCode) REFERENCES PCMember(pcCode) ON DELETE CASCADE,
    submissionNo    SMALLINT,   CONSTRAINT report_fk2 FOREIGN KEY (submissionNo) REFERENCES Submission(submissionNo) ON DELETE CASCADE,
    CONSTRAINT report_pk PRIMARY KEY (pcCode, submissionNo),
    relevant        CHAR(1),    CONSTRAINT report_relevant CHECK (relevant IN ('Y', 'N', 'M')),
    technicallyCorrect  CHAR(1),CONSTRAINT report_technical CHECK (technicallyCorrect IN ('Y', 'N', 'M')),
    lengthAndContent    CHAR(1),CONSTRAINT report_lnc CHECK (lengthAndContent IN ('Y', 'N', 'M')),
    originality     SMALLINT,   CONSTRAINT report_original CHECK (originality BETWEEN 1 AND 5),
    impact          SMALLINT,   CONSTRAINT report_impact CHECK (impact BETWEEN 1 AND 5),
    presentation    SMALLINT,   CONSTRAINT report_presentation CHECK (presentation BETWEEN 1 AND 5),
    technicalDepth  SMALLINT,   CONSTRAINT report_depth CHECK (technicalDepth BETWEEN 1 AND 5),
    overallRating   SMALLINT,   CONSTRAINT report_rating CHECK (overallRating BETWEEN 1 AND 5),
    confidence      NUMBER(2,1),CONSTRAINT report_confiedence CHECK (confidence BETWEEN 0.5 AND 1),
    mainContribution    VARCHAR2(300),
    strongPoints    VARCHAR2(300),
    weakPoints      VARCHAR2(300),
    overallSummary  VARCHAR2(300),
    detailedComments    VARCHAR2(1000),
    confidentialComments VARCHAR2(300)
    );


CREATE TABLE Discussion(
    sequenceNo      SMALLINT,
    submissionNo    SMALLINT,   CONSTRAINT discussion_fk FOREIGN KEY (submissionNo) REFERENCES Submission(submissionNo) ON DELETE CASCADE,
    pcCode          CHAR(4),    CONSTRAINT discussion_fk2 FOREIGN KEY (pcCode) REFERENCES PCMember(pcCode) ON DELETE CASCADE,
    CONSTRAINT discussion_pk PRIMARY KEY (sequenceNo, submissionNo, pcCode),
    comments        VARCHAR2(200)
    );

COMMIT;