@task2create

select * from Person;
select * from PCMember;
select * from PCChair;
select * from Submission;
select * from Author;
select * from AssignedTo;
select * from PreferenceFor;
select * from RefereeReport;
select * from Discussion;

INSERT INTO PERSON VALUES (1, 'Prof', 'StephenPC', 'Harvard', 'US', 914810293834, 'steph@sql');
INSERT INTO PERSON VALUES (2, 'Ms', 'DalePC', 'Oxford', 'UK', 1298719282, 'dale@sql');
INSERT INTO PERSON VALUES (3, 'Mr', 'CarnegiePC', 'Cambridge', 'UK', 12398182, 'carng@sql');
INSERT INTO PERSON VALUES (4, 'Dr', 'HawkingNONPC', 'MIT', 'US', 1230947610, 'hawk@sql');
INSERT INTO PERSON VALUES (5, 'Prof', 'MalcolmPC', 'Harvard', 'US', 988762021, 'malc@sql');

INSERT INTO PCMEMBER VALUES ('1A', 1); INSERT INTO PCCHAIR VALUES ('1A');
INSERT INTO PCMEMBER VALUES ('2B', 2); INSERT INTO PCCHAIR VALUES ('2B');
INSERT INTO PCMEMBER VALUES ('3C', 3);
INSERT INTO PCMEMBER VALUES ('5E', 5);

INSERT INTO SUBMISSION VALUES (101, 'Brief History of Time', 'abstract', 'research', null, 1);
INSERT INTO SUBMISSION VALUES (102, 'Style Guide', 'abstract', 'demo', null, 1);
INSERT INTO SUBMISSION VALUES (201, 'Think Fast', 'abstract', 'industrial', null, 2);
INSERT INTO SUBMISSION VALUES (202, 'Memories', 'abstract', 'industrial', null, 2);
INSERT INTO SUBMISSION VALUES (301, 'Think Slow', 'abstract', 'research', null, 3);
INSERT INTO SUBMISSION VALUES (401, 'What the Dog Saw', 'abstract', 'demo', null, 4);
INSERT INTO SUBMISSION VALUES (402, 'Outliers', 'abstract', 'industrial', null, 4);

INSERT INTO AUTHOR VALUES (1, 101); INSERT INTO AUTHOR VALUES (2, 101);
INSERT INTO AUTHOR VALUES (1, 102);
INSERT INTO AUTHOR VALUES (2, 201); INSERT INTO AUTHOR VALUES (1, 201);
INSERT INTO AUTHOR VALUES (2, 202); INSERT INTO AUTHOR VALUES (1, 202); INSERT INTO AUTHOR VALUES (3, 202);
INSERT INTO AUTHOR VALUES (3, 301);
INSERT INTO AUTHOR VALUES (4, 401); INSERT INTO AUTHOR VALUES (4,402);

INSERT INTO ASSIGNEDTO VALUES ('1A', 401); INSERT INTO ASSIGNEDTO VALUES ('2B', 401); 
INSERT INTO ASSIGNEDTO VALUES ('3C', 401);
INSERT INTO ASSIGNEDTO VALUES ('1A', 402); INSERT INTO ASSIGNEDTO VALUES ('2B', 402); 
INSERT INTO ASSIGNEDTO VALUES ('3C', 402);
INSERT INTO ASSIGNEDTO VALUES ('2B', 301);
INSERT INTO ASSIGNEDTO VALUES ('3C', 101);

INSERT INTO PREFERENCEFOR VALUES ('1A', 401, 5); INSERT INTO PREFERENCEFOR VALUES ('2B', 401, 3);
INSERT INTO PREFERENCEFOR VALUES ('3C', 401, 1);
INSERT INTO PREFERENCEFOR VALUES ('1A', 402, 1); INSERT INTO PREFERENCEFOR VALUES ('2B', 402, 2);
INSERT INTO PREFERENCEFOR VALUES ('1A', 102, 2);
INSERT INTO PREFERENCEFOR VALUES ('3C', 402, 2);
INSERT INTO PREFERENCEFOR VALUES ('2B', 301, 4);
INSERT INTO PREFERENCEFOR VALUES ('3C', 101, 3);

INSERT INTO REFEREEREPORT VALUES ('1A', 401, 'Y', 'Y', 'Y', 3, 2, 1, 4, 5, 0.75, 'contribution', 'strong', 'weak', 'summary', 'detailed', 'confidential');
INSERT INTO REFEREEREPORT VALUES ('2B', 401, 'M', 'N', 'Y', 5, 1, 3, 2, 4, 0.84, 'contribution', 'strong', 'weak', 'summary', 'detailed', 'confidential');
INSERT INTO REFEREEREPORT VALUES ('3C', 401, 'N', 'Y', 'N', 2, 4, 5, 1, 1, 0.6, 'contribution', 'strong', 'weak', 'summary', 'detailed', 'confidential');
INSERT INTO REFEREEREPORT VALUES ('1A', 402, 'Y', 'Y', 'Y', 3, 2, 1, 4, 2, 1, 'contribution', 'strong', 'weak', 'summary', 'detailed', 'confidential');
INSERT INTO REFEREEREPORT VALUES ('2B', 402, 'M', 'N', 'Y', 5, 1, 3, 2, 2, 0.5, 'contribution', 'strong', 'weak', 'summary', 'detailed', 'confidential');
INSERT INTO REFEREEREPORT VALUES ('3C', 402, 'N', 'Y', 'N', 2, 4, 5, 1, 2, 0.7, 'contribution', 'strong', 'weak', 'summary', 'detailed', 'confidential');
INSERT INTO REFEREEREPORT VALUES ('2B', 301, 'N', 'Y', 'N', 2, 4, 5, 1, 1, 0.6, 'contribution', 'strong', 'weak', 'summary', 'detailed', 'confidential');
INSERT INTO REFEREEREPORT VALUES ('3C', 101, 'N', 'Y', 'N', 2, 4, 5, 1, 1, 0.6, 'contribution', 'strong', 'weak', 'summary', 'detailed', 'confidential');

INSERT INTO DISCUSSION VALUES (1, 401, '1A', 'comment'); INSERT INTO DISCUSSION VALUES (2, 401, '2B', 'comment');
INSERT INTO DISCUSSION VALUES (3, 401, '1A', 'comment'); INSERT INTO DISCUSSION VALUES (4, 401, '3C', 'comment');
INSERT INTO DISCUSSION VALUES (2, 301, '2B', 'comment');

UPDATE SUBMISSION SET DECISION = 'accept' WHERE SUBMISSIONNO = 101;
UPDATE SUBMISSION SET DECISION = 'reject' WHERE SUBMISSIONNO = 301;
UPDATE SUBMISSION SET DECISION = 'accept' WHERE SUBMISSIONNO = 401;
UPDATE SUBMISSION SET DECISION = 'reject' WHERE SUBMISSIONNO = 402;
UPDATE SUBMISSION SET DECISION = null WHERE SUBMISSIONNO = 101;
UPDATE SUBMISSION SET DECISION = 'accept' WHERE SUBMISSIONNO = 101;