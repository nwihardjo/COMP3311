--NATHANIEL WIHARDJO (20315011)

drop table RefereeReport;
drop table Discussion;
drop table AssignedTo;
drop table PreferenceFor;
drop table Author;
drop table Submission;
drop table PCChair;
drop table PCMember;
drop table Person;


CREATE TABLE Person(
    personId        SMALLINT,               CONSTRAINT person_pk PRIMARY KEY (personId),
    title           CHAR(50) DEFAULT NULL,  CONSTRAINT person_title CHECK (title IN ('Mr', 'Ms', 'Miss', 'Dr', 'Prof')),
    personName      VARCHAR2(50)  NOT NULL,
    institution     VARCHAR2(100) NOT NULL,
    country         VARCHAR2(30)  NOT NULL,
    phoneNo         VARCHAR2(15)  NOT NULL, CONSTRAINT person_phone CHECK (REGEXP_LIKE(phoneNo, '^[0-9]{8,15}$')),
    personEmail     VARCHAR2(50)  NOT NULL, CONSTRAINT person_email UNIQUE (personEmail)    
    );
    
    
CREATE TABLE PCMember(
    pcCode          CHAR(4),            CONSTRAINT pcm_pk PRIMARY KEY (pcCode),
    personId        SMALLINT NOT NULL,  CONSTRAINT pcm_fk FOREIGN KEY (personId) REFERENCES Person(personId) ON DELETE CASCADE
    );
    
    
CREATE TABLE PCChair(
    pcCode          CHAR(4),    
    CONSTRAINT pcc_pk PRIMARY KEY (pcCode),
    CONSTRAINT pcc_fk FOREIGN KEY (pcCode) REFERENCES PCMember(pcCode) ON DELETE CASCADE
    );
    

CREATE TABLE Submission(
    submissionNo    INT,     CONSTRAINT pk_check CHECK (submissionNo > 0),
    CONSTRAINT submission_pk PRIMARY KEY (submissionNo),
    
    title           VARCHAR2(50)  NOT NULL,   
    abstract        VARCHAR2(300) NOT NULL,  
    submissionType  VARCHAR2(20) DEFAULT 'research' NOT NULL, 
    CONSTRAINT submission_type CHECK (submissionType IN ('research', 'demo', 'industrial')),
    
    decision        VARCHAR2(6) DEFAULT NULL, 
    CONSTRAINT submission_decision CHECK (decision IN ('accept', 'reject')),

    contactAuthor   SMALLINT NOT NULL, 
    CONSTRAINT submission_fk FOREIGN KEY (contactAuthor) REFERENCES Person(personId) ON DELETE CASCADE
    );
    
    
CREATE TABLE Author(
    personId        SMALLINT NOT NULL,   CONSTRAINT author_fk FOREIGN KEY (personId) REFERENCES Person(personId) ON DELETE CASCADE,
    submissionNo    SMALLINT NOT NULL,   CONSTRAINT author_fk2 FOREIGN KEY (submissionNo) REFERENCES Submission(submissionNo) ON DELETE CASCADE,
    CONSTRAINT author_pk PRIMARY KEY (personid, submissionNo)
    );    


CREATE TABLE AssignedTo(
    pcCode          CHAR(4) NOT NULL,    CONSTRAINT assign_fk FOREIGN KEY (pcCode) REFERENCES PCMember(pcCode) ON DELETE CASCADE,
    submissionNo    SMALLINT NOT NULL,   CONSTRAINT assign_fk2 FOREIGN KEY (submissionNo) REFERENCES Submission(submissionNo) ON DELETE CASCADE,
    CONSTRAINT assign_pk PRIMARY KEY (pcCode, submissionNo)
    );
    
    
CREATE TABLE PreferenceFor(
    pcCode          CHAR(4) NOT NULL,            CONSTRAINT pref_fk FOREIGN KEY (pcCode) REFERENCES PCMember(pcCode) ON DELETE CASCADE,
    submissionNo    SMALLINT NOT NULL,           CONSTRAINT pref_fk2 FOREIGN KEY (submissionNo) REFERENCES Submission(submissionNo) ON DELETE CASCADE,
    CONSTRAINT pref_pk PRIMARY KEY (pcCode, submissionNo),
    preference      SMALLINT NOT NULL,   CONSTRAINT pref_ CHECK (preference BETWEEN 1 AND 5)
    );
    
    
CREATE TABLE RefereeReport(
    pcCode          CHAR(4) NOT NULL,    CONSTRAINT report_fk FOREIGN KEY (pcCode) REFERENCES PCMember(pcCode) ON DELETE CASCADE,
    submissionNo    SMALLINT NOT NULL,   CONSTRAINT report_fk2 FOREIGN KEY (submissionNo) REFERENCES Submission(submissionNo) ON DELETE CASCADE,
    CONSTRAINT report_pk PRIMARY KEY (pcCode, submissionNo),
    relevant        CHAR(1) NOT NULL,    CONSTRAINT report_relevant CHECK (relevant IN ('Y', 'N', 'M')),
    technicallyCorrect  CHAR(1) NOT NULL,CONSTRAINT report_technical CHECK (technicallyCorrect IN ('Y', 'N', 'M')),
    lengthAndContent    CHAR(1) NOT NULL,CONSTRAINT report_lnc CHECK (lengthAndContent IN ('Y', 'N', 'M')),
    originality     SMALLINT NOT NULL,   CONSTRAINT report_original CHECK (originality BETWEEN 1 AND 5),
    impact          SMALLINT NOT NULL,   CONSTRAINT report_impact CHECK (impact BETWEEN 1 AND 5),
    presentation    SMALLINT NOT NULL,   CONSTRAINT report_presentation CHECK (presentation BETWEEN 1 AND 5),
    technicalDepth  SMALLINT NOT NULL,   CONSTRAINT report_depth CHECK (technicalDepth BETWEEN 1 AND 5),
    overallRating   SMALLINT NOT NULL,   CONSTRAINT report_rating CHECK (overallRating BETWEEN 1 AND 5),
    confidence      NUMBER(2,1) NOT NULL,CONSTRAINT report_confiedence CHECK (confidence BETWEEN 0.5 AND 1),
    mainContribution    VARCHAR2(300) NOT NULL,
    strongPoints    VARCHAR2(300) NOT NULL,
    weakPoints      VARCHAR2(300) NOT NULL,
    overallSummary  VARCHAR2(300) NOT NULL,
    detailedComments    VARCHAR2(1000) NOT NULL,
    confidentialComments VARCHAR2(300)
    );


CREATE TABLE Discussion(
    sequenceNo      SMALLINT NOT NULL,  CONSTRAINT pk_check_ CHECK (sequenceNo > 0),
    submissionNo    SMALLINT NOT NULL,  CONSTRAINT discussion_fk FOREIGN KEY (submissionNo) REFERENCES Submission(submissionNo) ON DELETE CASCADE,
    pcCode          CHAR(4) NOT NULL,   CONSTRAINT discussion_fk2 FOREIGN KEY (pcCode) REFERENCES PCMember(pcCode) ON DELETE CASCADE,
    CONSTRAINT discussion_pk PRIMARY KEY (sequenceNo, submissionNo, pcCode),
    comments        VARCHAR2(200) NOT NULL
    );

COMMIT;