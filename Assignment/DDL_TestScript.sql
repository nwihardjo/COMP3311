-- PERSON TABLE TESTS
    -- NORMAL INSERTION
        INSERT INTO Person VALUES (1, 'Mr', 'Stephen', 'HKUST', 'HK', 91484450, 'shawk@sql');
    -- TEST CASE: primary key uniqueness
        INSERT INTO Person VALUES (1, 'Mr', 'DoubleId', 'UST', 'HK', 12341324214, 'doubleid@sql');
    -- TEST CASE: null / not null violation
        INSERT INTO Person (personId, personName, institution, country, phoneNo, personEmail) VALUES
            (2, 'Teph', 'HKUST', 'SG', 91029384, 'nulltitle@sql');
        INSERT INTO Person (personId, title, institution, country, phoneNo, personEmail) VALUES
            (3, 'Mr', 'HKUST', 'SG', 91029384, 'nullname@sql');
        INSERT INTO Person (title, personName, institution, country, phoneNo, personEmail) VALUES
            ('Mr', 'NullId', 'HKUST', 'SG', 91029384, 'nullid@sql');
        INSERT INTO Person (personId, title, personName, country, phoneNo, personEmail) VALUES
            (4, 'Mr', 'NullInst', 'SG', 91029384, 'nullinst@sql');
        INSERT INTO Person (personId, title, personName, institution, phoneNo, personEmail) VALUES
            (5, 'Mr', 'NullCountry', 'HKUST', 91029384, 'nullcountry@sql');
        INSERT INTO Person (personId, title, personName, institution, country, personEmail) VALUES
            (6, 'Mr', 'NullPhoneNo', 'HKUST', 'SG', 'nullphoneno@sql');
        INSERT INTO Person (personId, title, personName, institution, country, phoneNo) VALUES
            (7, 'Mr', 'NullTitle', 'HKUST', 'SG', 91029384);
    -- TEST CASE: violation on title constraint values   
        INSERT INTO Person VALUES (8, 'Sir', 'TitleViol', 'CUHK', 'HK', 9102920290, 'titleviol@sql');
    -- TEST CASE: violation on phoneno not integer and boundary
        INSERT INTO Person VALUES (9, 'Mr', 'NonIntPhoneNo', 'CUHK', 'HK', '9a8712345758', 'nonintphoneno@sql');
        INSERT INTO Person VALUES (10, 'Mr', 'LowPhoneNo', 'CUHK', 'HK', '1234567', 'LowPhone@sql');
        INSERT INTO Person VALUES (11, 'Mr', 'HighPhoneNo', 'CUHK', 'HK', '1234567890123456', 'HighPhone@sql');
    -- TEST CASE: violation on email uniqueness
        INSERT INTO Person VALUES (2, 'Mr', 'DoubleId', 'HKUST', 'HK', 8129398712, 'doubleid@sql');

-- PCMEMBER TABLE TESTS
    -- NORMAL INSERTION
        INSERT INTO PCMember VALUES ('1A', 1);
        INSERT INTO PCMember VALUES ('2B', 2);
    -- TEST CASE: null / not null violation
        INSERT INTO PCMember (personId) VALUES (1);
        INSERT INTO PCMember (pcCode) VALUES ('pcNULL');
    -- TEST CASE: violation personid non null
        INSERT INTO PCMember  VALUES ('noin', '2A');
    -- TEST CASE: foreign key integrity constraint and referential integrity
        INSERT INTO PCMember VALUES ('3C', 3);
        -- manual check required
        DELETE FROM Person WHERE personId = 2;
        SELECT * FROM PCMember WHERE personId = 2;
            INSERT INTO Person (personId, personName, institution, country, phoneNo, personEmail) VALUES
            (2, 'Teph', 'HKUST', 'SG', 91029384, 'nulltitle@sql');
            INSERT INTO PCMember VALUES ('2B', 2);

-- PCCHAIR TABLE TESTS
    -- NORMAL INSERTION
        INSERT INTO PCChair VALUES ('1A');
        INSERT INTO PCChair VALUES ('2B');
    -- TEST CASE: null / not null violation
        INSERT INTO PCCHAIR VALUES (NULL);
    -- TEST CASE: referential integrity and primary key uniqueness
        INSERT INTO PCCHAIR VALUES ('1A');
        INSERT INTO PCCHAIR VALUES ('3C');
        -- manual check required 
        DELETE FROM PCMEMBER WHERE PCCODE = '2B';
        SELECT * FROM PCCHAIR WHERE PCCODE = '2B';
            INSERT INTO PCMEMBER VALUES ('2B', 2);
            INSERT INTO PCCHAIR VALUES ('2B');
            
-- SUBMISSION TABLE TESTS
    -- NORMAL INSERTION
        INSERT INTO SUBMISSION VALUES (101, 'Shibe Learning', 'shibshibshib', 'demo', 'accept', 1);
    -- TEST CASE: null / not null and attribute-level constraint violation
        INSERT INTO SUBMISSION (TITLE, ABSTRACT, SUBMISSIONTYPE, DECISION, CONTACTAUTHOR)
            VALUES ('NULLSUBMISSIONNO', 'ABSTRACT', 'research', 'reject', 2);
        INSERT INTO SUBMISSION (SUBMISSIONNO, TITLE, ABSTRACT, SUBMISSIONTYPE, DECISION, CONTACTAUTHOR)
            VALUES ('a', 'NONINTSUBMISSIONNO', 'ABSTRACT', 'research', 'reject', 2);
        INSERT INTO SUBMISSION (SUBMISSIONNO,ABSTRACT, SUBMISSIONTYPE, DECISION, CONTACTAUTHOR)
            VALUES (104, 'NULL TITLE', 'research', 'reject', 2);
        INSERT INTO SUBMISSION (SUBMISSIONNO, TITLE, SUBMISSIONTYPE, DECISION, CONTACTAUTHOR)
            VALUES (105, 'NULLABSTRACT', 'research', 'reject', 2);
        INSERT INTO SUBMISSION (SUBMISSIONNO, TITLE, ABSTRACT, DECISION, CONTACTAUTHOR)
            VALUES (102, 'DefaultType', 'ABSTRACT', 'reject', 2);            
        INSERT INTO SUBMISSION (SUBMISSIONNO, TITLE, ABSTRACT, SUBMISSIONTYPE, DECISION, CONTACTAUTHOR)
            VALUES (108, 'NULLTYPE', 'ABSTRACT', NULL, 'reject', 2);            
        INSERT INTO SUBMISSION (SUBMISSIONNO, TITLE, ABSTRACT, SUBMISSIONTYPE, DECISION, CONTACTAUTHOR)
            VALUES (106, 'WRONGTYPE', 'ABSTRACT', 'research_', 'reject', 2);            
        INSERT INTO SUBMISSION (SUBMISSIONNO, TITLE, ABSTRACT, SUBMISSIONTYPE, CONTACTAUTHOR)
            VALUES (103, 'DefaultDecision', 'ABSTRACT', 'research', 2);
        INSERT INTO SUBMISSION (SUBMISSIONNO, TITLE, ABSTRACT, SUBMISSIONTYPE, DECISION, CONTACTAUTHOR)
            VALUES (108, 'WRONGDECISION', 'ABSTRACT', 'research', 'rejet_', 2);
        INSERT INTO SUBMISSION (SUBMISSIONNO, TITLE, ABSTRACT, SUBMISSIONTYPE, DECISION)
            VALUES (107, 'NULLCONTACTAUTHOR', 'ABSTRACT', 'research', 'reject');
    -- TEST CASE: referential integrity test
        -- manual check required
        DELETE FROM PERSON WHERE PERSONID = 1;
        SELECT * FROM SUBMISSION WHERE CONTACTAUTHOR = 1;
            INSERT INTO Person VALUES (1, 'Mr', 'Stephen', 'HKUST', 'HK', 91484450, 'shawk@sql');
            INSERT INTO PCMember VALUES ('1A', 1);
            INSERT INTO PCChair VALUES ('1A');
            INSERT INTO SUBMISSION VALUES (101, 'Shibe Learning', 'shibshibshib', 'demo', 'accept', 1);

-- AUTHOR TABLE TESTS
    -- NORMAL INSERTION
        INSERT INTO AUTHOR VALUES (1, 101);
        INSERT INTO AUTHOR VALUES (2, 102);
        INSERT INTO AUTHOR VALUES (2, 103);
    -- TEST CASE: null / not null and data types violation
        INSERT INTO AUTHOR (personId) VALUES (1);
        INSERT INTO AUTHOR (PERSONID) VALUES ('A');
        INSERT INTO AUTHOR (SUBMISSIONNO) VALUES (101);
        INSERT INTO AUTHOR (SUBMISSIONNO) VALUES ('AAA');
    -- TEST CASE: primary key uniqueness and referential integrity
        INSERT INTO AUTHOR VALUES (1, 101);
        INSERT INTO AUTHOR VALUES (10, 101);
        INSERT INTO AUTHOR VALUES (1, 110);
        -- manual check required
        DELETE FROM SUBMISSION WHERE SUBMISSIONNO = 101;
        SELECT * FROM AUTHOR WHERE SUBMISSIONNO = 101;
            INSERT INTO SUBMISSION VALUES (101, 'Shibe Learning', 'shibshibshib', 'demo', 'accept', 1);
            INSERT INTO AUTHOR VALUES (1, 101);
        DELETE FROM PERSON WHERE PERSONID = 1;
        SELECT * FROM AUTHOR WHERE PERSONID = 1;
            INSERT INTO Person VALUES (1, 'Mr', 'Stephen', 'HKUST', 'HK', 91484450, 'shawk@sql');
            INSERT INTO PCMember VALUES ('1A', 1);
            INSERT INTO PCChair VALUES ('1A');
            INSERT INTO SUBMISSION VALUES (101, 'Shibe Learning', 'shibshibshib', 'demo', 'accept', 1);
            INSERT INTO AUTHOR VALUES (1, 101);        

-- ASSIGNEDTO TABLE TESTS
    -- NORMAL INSERTION
        INSERT INTO ASSIGNEDTO VALUES ('1A', 102);
        INSERT INTO ASSIGNEDTO VALUES ('1A', 103);
        INSERT INTO ASSIGNEDTO VALUES ('2B', 101);
    -- TEST CASE: null / not null and data types constraint
        INSERT INTO ASSIGNEDTO (PCCODE) VALUES ('1A');
        INSERT INTO ASSIGNEDTO VALUES ('PCNONINT', 101);
        INSERT INTO ASSIGNEDTO (SUBMISSEIONNO) VALUES (101);
        INSERT INTO ASSIGNEDTO VALUES ('1A', 'SUBNONTINT');
    -- TEST CASE: referential integrity
        INSERT INTO ASSIGNEDTO VALUES ('3C', 101);
        INSERT INTO ASSIGNEDTO VALUES ('1A', 110);
        -- manual check required
        DELETE FROM SUBMISSION WHERE SUBMISSIONNO = 101;
        SELECT * FROM ASSIGNEDTO WHERE SUBMISSIONNO = 101;
            INSERT INTO SUBMISSION VALUES (101, 'Shibe Learning', 'shibshibshib', 'demo', 'accept', 1);
            INSERT INTO AUTHOR VALUES (1, 101);
            INSERT INTO ASSIGNEDTO VALUES ('2B', 101);
        DELETE FROM PCMEMBER WHERE PCCODE = '1A';
        SELECT * FROM ASSIGNEDTO WHERE PCCODE = '1A';
            INSERT INTO PCMEMBER VALUES ('1A', 1);
            INSERT INTO PCCHAIR VALUES ('1A');
            INSERT INTO ASSIGNEDTO VALUES ('1A', 102);
            INSERT INTO ASSIGNEDTO VALUES ('1A', 103);
            
-- PREFERENCEFOR TABLE TESTS
    -- NORMAL INSERTION
    INSERT INTO PREFERENCEFOR VALUES ('1A', 102, 3);
    INSERT INTO PREFERENCEFOR VALUES ('2B', 101, 2);
    -- TEST CASES: null / not null and data types constraint
    INSERT INTO PREFERENCEFOR (PCCODE, SUBMISSIONNO) VALUES ('1A', 103);
    INSERT INTO PREFERENCEFOR (PCCODE, PREFERENCE) VALUES ('1A', 3);
    INSERT INTO PREFERENCEFOR (SUBMISSIONNO, PREFERENCE) VALUES (103, 3);
    INSERT INTO PREFERENCEFOR VALUES ('1A', 103, 6);
    INSERT INTO PREFERENCEFOR VALUES ('3C', 103, 1);
    INSERT INTO PREFERENCEFOR VALUES ('1A', 110, 1);
    -- TODO: COMPLETION OF THE REFERENTIAL INTEGRITY TESTS
    INSERT INTO PREFERENCEFOR VALUES ('1A', 103, 5);
    
-- REFEREEREPORT TABLE TESTS
    -- NORMAL INSERTION
    INSERT INTO REFEREEREPORT VALUES ('1A', 102, 'Y', 'Y', 'Y', 3, 3, 3, 3, 3, 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('2B', 101, 'M', 'Y', 'N', 1, 2, 3, 4, 5, 0.912, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    -- TEST CASES: referential integrity constraint
    INSERT INTO REFEREEREPORT VALUES ('3C', 101, 'M', 'Y', 'N', 1, 2, 3, 4, 5, 0.912, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('2B', 110, 'M', 'Y', 'N', 1, 2, 3, 4, 5, 0.912, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    -- TODO: referential integrity test on deletion
    -- TEST CASES: null / not null and data types constraints
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'a', 'Y', 'Y', 3, 3, 3, 3, 3, 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 1, 'Y', 'Y', 3, 3, 3, 3, 3, 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'Y', 'a', 'Y', 3, 3, 3, 3, 3, 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'Y', 1, 'Y', 3, 3, 3, 3, 3, 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'Y', 'Y', 'a', 3, 3, 3, 3, 3, 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'Y', 'Y', 1, 3, 3, 3, 3, 3, 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'Y', 'Y', 'Y', 10, 3, 3, 3, 3, 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'Y', 'Y', 'Y', 3, 10, 3, 3, 3, 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'Y', 'Y', 'Y', 3, 3, 10, 3, 3, 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'Y', 'Y', 'Y', 3, 3, 3, 10, 3, 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'Y', 'Y', 'Y', 3, 3, 3, 3, 10, 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'Y', 'Y', 'Y', 3, 3, 3, 3, 3, 2, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'Y', 'Y', 'Y', 3, 3, 3, 3, 3, 0.75, null, 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'Y', 'Y', 'Y', 3, 3, 3, 3, 3, 0.75, 'CONTRIBUTION', null, 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'Y', 'Y', 'Y', 3, 3, 3, 3, 3, 0.75, 'CONTRIBUTION', 'STRONG', null, 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'Y', 'Y', 'Y', 3, 3, 3, 3, 3, 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', null, 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'Y', 'Y', 'Y', 3, 3, 3, 3, 3, 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', null, 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'Y', 'Y', 'Y', 3, 3, 3, 3, 3, 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', null);
    INSERT INTO REFEREEREPORT VALUES (null, 103, 'Y', 'Y', 'Y', 3, 3, 3, 3, 3, 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', null, 'Y', 'Y', 'Y', 3, 3, 3, 3, 3, 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, null, 'Y', 'Y', 3, 3, 3, 3, 3, 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'Y', null, 'Y', 3, 3, 3, 3, 3, 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'Y', 'Y', null, 3, 3, 3, 3, 3, 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'Y', 'Y', 'Y', null, 3, 3, 3, 3, 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'Y', 'Y', 'Y', 3, null, 3, 3, 3, 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'Y', 'Y', 'Y', 3, 3, null, 3, 3, 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'Y', 'Y', 'Y', 3, 3, 3, 3, null, 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'Y', 'Y', 'Y', 3, 3, 3, 3, 3, null, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'Y', 'Y', 'Y', 'a', 3, 3, 3, 3, 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'Y', 'Y', 'Y', 3, 'a', 3, 3, 3, 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'Y', 'Y', 'Y', 3, 3, 'a', 3, 3, 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'Y', 'Y', 'Y', 3, 3, 3, 'a', 3, 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'Y', 'Y', 'Y', 3, 3, 3, 3, 'a', 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'Y', 'Y', 'Y', 3, 3, 3, 3, 3, 'a', 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES (1, 103, 'Y', 'Y', 'Y', 3, 3, 3, 3, 3, 'a', 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', '103', 'Y', 'Y', 'Y', 3, 3, 3, 3, 3, 'a', 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    -- TEST CASES: primary key uniqueness
    INSERT INTO REFEREEREPORT VALUES ('1A', 102, 'Y', 'Y', 'Y', 3, 3, 3, 3, 3, 0.75, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');
    INSERT INTO REFEREEREPORT VALUES ('1A', 103, 'M', 'N', 'Y', 1, 2, 3, 1, 1, 0.67, 'CONTRIBUTION', 'STRONG', 'WEAK', 'SUMMARY', 'DETAILED', 'CONFI');

-- DISCUSSION TABLE TESTS
    -- NORMAL INSERTION
    INSERT INTO DISCUSSION VALUES (1, 102, '1A', 'COMMENT');
    INSERT INTO DISCUSSION VALUES (2, 101, '2B', 'COMMENT');
    -- TEST CASES: primary key uniqueness
    INSERT INTO DISCUSSION VALUES (3, 102, '1A', 'COMMENT');
    -- TEST CASES: null / not null, data types, and referential integrity constraint
    INSERT INTO DISCUSSION VALUES (3, 103, '1A', NULL);
    INSERT INTO DISCUSSION VALUES (NULL, 103, '1A', 'COMMENT');
    INSERT INTO DISCUSSION VALUES (3, NULL, '1A', 'COMMENT');
    INSERT INTO DISCUSSION VALUES (3, 103, NULL, 'COMMENT');
    INSERT INTO DISCUSSION VALUES ('A', 103, '1A', 'COMMENT');
    INSERT INTO DISCUSSION VALUES (3, '103', '1A', 'COMMENT');
    INSERT INTO DISCUSSION VALUES (NULL, 103, 1, 'COMMENT');
    INSERT INTO DISCUSSION VALUES (3, 103, '1A', 'COMMENT');
    
select * from Person;
select * from PCMember;
select * from PCChair;
select * from Submission;
select * from Author;
select * from AssignedTo;
select * from PreferenceFor;
select * from RefereeReport;
select * from Discussion;

COMMIT;