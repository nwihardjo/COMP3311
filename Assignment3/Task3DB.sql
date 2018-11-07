/* COMP 3311: Conference Submission Review Management System - Task3DB.sql */

/* Start with a clean database. */
drop table AssignedTo;
drop table Discussion;
drop table PreferenceFor;
drop table RefereeReport;
drop table PCChair;
drop table Author;
drop table Submission;
drop table PCMember;
drop table Person;

/* Create the tables */
create table Person (
	personId    int primary key,
	title       char(5) default null check (title in ('Mr', 'Ms', 'Miss', 'Dr', 'Prof', null)),
	personName  varchar2(50) not null,
	institution varchar2(100) not null,
	country     varchar2(30) not null,
    phoneNo     varchar2(15) not null check (regexp_like(phoneNo, '^[0-9]{8,15}$')),
    personEmail varchar2(50) not null unique);

create table PCMember (
	pcCode      char(4) primary key,
	personId    int references Person(personId) on delete cascade);
    
create table Submission (
	submissionNo    int primary key,
	title           varchar2(50) not null,
    abstract        varchar2(300) not null,
	submissionType  varchar2(20) default 'research' not null check (submissionType in ('research', 'demo', 'industrial')),
	decision        varchar2(6) check (decision in ('accept', 'reject', null)),
    contactAuthor   int references Person(personId) on delete cascade);

create table AssignedTo (
	pcCode          char(4) references PCMember(pcCode) on delete cascade,
	submissionNo    int references Submission(submissionNo) on delete cascade,
	primary key(pcCode, submissionNo));
    
create table Author (
	personId        int references Person(personId) on delete cascade,
	submissionNo    int references Submission(submissionNo) on delete cascade,
	primary key(personId, submissionNo));

create table Discussion (
	sequenceNo      int,
	pcCode          char(4) references PCMember(pcCode) on delete cascade,
	submissionNo    int references Submission(submissionNo) on delete cascade,
	comments        varchar2(200) not null,
	primary key(sequenceNo, pcCode, submissionNo));

create table PCChair(
	pcCode char(4) primary key references PCMember(pcCode) on delete cascade);

create table PreferenceFor (
	pcCode          char(4) references PCMember(pcCode) on delete cascade,
	submissionNo    int references Submission(submissionNo) on delete cascade,
	preference      int not null check (preference in (1, 2, 3, 4, 5)),
	primary key(pcCode, submissionNo));

create table RefereeReport (
	pcCode                  char(4) references PCMember(pcCode) on delete cascade,
	submissionNo            int references Submission(submissionNo) on delete cascade,
	relevant                char(1) not null check(relevant in ('Y', 'N', 'M')),
	technicallyCorrect      char(1) not null check(technicallyCorrect in ('Y', 'N', 'M')),
	lengthAndContent        char(1) not null check(lengthAndContent in ('Y', 'N', 'M')),
	originality             int not null check(originality between 1 and 5),
	impact                  int not null check(impact between 1 and 5),
	presentation            int not null check(presentation between 1 and 5),
	technicalDepth          int not null check(technicalDepth between 1 and 5),
	overallRating           int not null check(overallRating between 1 and 5),
	confidence              number(2,1) not null check(confidence between 0.5 and 1),
	mainContribution        varchar2(300) not null,
	strongPoints            varchar2(300) not null,
	weakPoints              varchar2(300) not null,
	overallSummary          varchar2(300) not null,
	detailedComments        varchar2(1000),
	confidentialComments    varchar2(300),
	primary key(pcCode, submissionNo));


/* Populate the database */

/*** Person - 29 tuples ***/
insert into Person values (1, null, 'Michael J. Cafarella', 'University of Michigan', 'USA', '16084343702', 'michjc@umich.edu');
insert into Person values (2, 'Prof', 'H. V. Jagadish', 'University of Michigan', 'USA', '16084343923', 'jag@umich.edu');
insert into Person values (3, 'Mr', 'Aditya Parameswaran', 'Stanford University', 'USA', '16507237766', 'adityagp@cs.stanford.edu');
insert into Person values (4, 'Dr', 'Nilesh Dalvi', 'Yahoo! Research', 'USA', '14155893029', 'ndalvi@yahooinc.com');
insert into Person values (5, 'Prof', 'Hector Garcia-Molina', 'Stanford University', 'USA', '16507230685', 'hector@cs.stanford.edu');
insert into Person values (6, 'Dr', 'Rajeev Rastogi', 'Yahoo! Research', 'USA', '14155893045', 'rrastogi@yahooinc.com');
insert into Person values (7, 'Dr', 'Eric Crestan', 'Yahoo! Labs', 'USA', '14156786654', 'ecrestan@yahoo-inc.com');
insert into Person values (8, 'Dr', 'Patrick Pantel', 'Yahoo! Labs', 'USA', '14156782345', 'ppantel@yahoo-inc.com');
insert into Person values (9, 'Prof', 'Vladimir Zadorozhny', 'University of Pittsburgh', 'USA', '16573342102', 'vladimir@sis.pitt.edu');
insert into Person values (10, 'Mr', 'Ying-Feng Hsu', 'University of Pittsburgh', 'USA', '16573342105', 'yfhsu@sis.pitt.edu');
insert into Person values (11, 'Prof', 'Tim Weninger', 'University of Notre Dame', 'USA', '15746316770', 'tweninge@nd.edu');
insert into Person values (12, 'Prof', 'William H. Hsu', 'Kansas State University', 'USA', '17855327905', 'bhsu@cis.ksu.edu');
insert into Person values (13, 'Prof', 'Jiawei Han', 'University of Illinois at Urbana-Champaign', 'USA', '12173336903', 'hanj@cs.uiuc.edu');
insert into Person values (14, 'Mr', 'Rajasekar Krishnamurthy', 'IBM Research - Almaden', 'USA', '14159091190', 'rajase@us.ibm.com');
insert into Person values (15, 'Mr', 'Jeffrey Naughton', 'University of Wisconsin', 'USA', '16082628737', 'naughton@cs.wisc.edu');
insert into Person values (16, 'Prof', 'Frank Lo', 'Hong Kong University of Science and Technology', 'China', '85223586996', 'flo@cse.ust.hk');
insert into Person values (17, 'Mr', 'Ju Fan', 'National University of Singapore', 'Singapore', '6565165672', 'jfan@comp.nus.edu.sg');
insert into Person values (18, 'Prof', 'Beng Chin Ooi', 'National University of Singapore', 'Singapore', '6565166465', 'ooibc@comp.nus.edu.sg');
insert into Person values (19, 'Mr', 'Garret Swart', 'Oracle Corporation', 'USA', '14159358846', 'garret.swart@oracle.com');
insert into Person values (20, 'Mr', 'Nelson Ray', 'Metamarkets Group, Inc.', 'USA', '14158141788', 'ncray86@gmail.com');
insert into Person values (21, 'Dr', 'Mohamed A. Soliman', 'Pivotal Inc.', 'USA', '16508461647', 'Soliman@pivotal.io');
insert into Person values (22, 'Prof', 'Lei Chen', 'Hong Kong University of Science and Technology', 'China', '85223586980', 'leichen@cse.ust.hk');
insert into Person values (23, 'Prof', 'Elke Rundensteiner', 'Worcester Polytechnic Institute', 'USA', '15088315815', 'rundenst@cs.wpi.edu');
insert into Person values (24, 'Prof', 'Jeffrey Yu', 'Chinese University of Hong Kong', 'China', '85239438309', 'yu@se.cuhk.edu.hk');
insert into Person values (25, 'Dr', 'Paul Larson', 'Microsoft Research', 'USA', '14257036260', 'palarson@microsoft.com');
insert into Person values (26, null, 'Anil Shanbhag', 'MIT CSAI', 'USA', '16172586644', 'anil@csail.mit.edu');
insert into Person values (27, 'Dr', 'Alekh Jinda', 'Microsoft Research', 'USA', '14257035454', 'aljindal@microsoft.com');
insert into Person values (28, null, 'Yi Lu', 'MIT CSAI', 'USA', '16172586644', 'yilu@csail.mit.edu');
insert into Person values (29, 'Prof', 'Samuel Madden', 'MIT CSAI', 'USA', '16172586643', 'madden@csail.mit.edu');

/*** PCMember - 10 tuples ***/
insert into PCMember values ('hj01', 2);
insert into PCMember values ('ec01', 7);
insert into PCMember values ('pp01', 8);
insert into PCMember values ('jh01', 13);
insert into PCMember values ('fl01', 16);
insert into PCMember values ('bo01', 18);
insert into PCMember values ('lc01', 22);
insert into PCMember values ('er01', 23);
insert into PCMember values ('jy01', 24);
insert into PCMember values ('pl01', 25);

/*** PCChair - 1 tuple ***/
insert into PCChair values ('fl01');

/*** Submission - 11 tuples ***/
insert into Submission values (1, 'Example-Driven Schema Mapping', 'End-users increasingly find the need to perform light-weight, customized data integration. State-of-the-art tools usually require an in-depth understanding of the semantics of multiple schemas. We propose a system, MWeaver, that facilitates data integration for end-users.', 'research', null, 1);
insert into Submission values (2, 'Optimal Schemes for Robust Web Extraction', 'We consider the problem of constructing robust wrappers for web information extraction. We consider two models to study robustness formally: the adversarial model and probabilistic model. We demonstrate that our algorithms can reduce wrapper breakage by up to 500% over existing techniques.', 'research', null, 5);
insert into Submission values (3, 'Web-Scale Knowledge Extraction', 'We propose a classification algorithm and a rich feature set for automatically recognizing layout tables and attribute/value tables. In 79% of our Web tables, our method finds the correct protagonist in its top three returned candidates.', 'research', null, 7);
insert into Submission values (4, 'Efficient Fusion of Historical Data', 'Historical data may include severe data conflicts that prevent researchers from obtaining the correct answers to queries on an integrated historical database. We consider an efficient approach to large-scale historical data fusion.', 'research', null, 9);
insert into Submission values (5, 'CETR - Content Extraction via Tag Ratios', 'Content Extraction via Tag Ratios (CETR) is a method to extract content text from diverse webpages using the HTML document''s tag ratios. We evaluate our approach against a large set of alternative methods, which shows that CETR achieves better content extraction performance than existing methods.', 'research', null, 13);
insert into Submission values (6, 'Towards User-Friendly Entity Resolution', 'We explore the possibility of treating user input as an integral part of the entity resolution process. We design a simple two-stage approach that separates merging and splitting records into two separate stages.', 'research', null, 14);
insert into Submission values (7, 'TsingNUS: A Location-based Service System', 'TsingNUS aims to provide users with more user-friendly location-aware search experiences. TsingNUS incorporates continuous search to efficiently support continuously moving queries in a client-server system thereby reducing the communication cost between the client and server.', 'demo', null, 17);
insert into Submission values (8, 'A Java Stream Computational Model for Big Data', 'The addition of lambda expressions and a Stream API in Java 8 provide a powerful and expressive query language. We build on Java 8 Stream and add a DistributableStream abstraction that supports federated query execution over an extensible set of distributed compute engines.', 'industrial', null, 19);
insert into Submission values (9, 'Druid: A Real-time Analytical Data Store', 'Druid is an open source data store designed for real-time exploratory analytics on large data sets. It combines column-oriented storage layout, distributed, shared-nothing architecture, and advanced indexing to allow for the arbitrary exploration of billion-row tables with sub-second latencies.', 'industrial', null, 21);
insert into Submission values (10, 'Orca: A Modular Query Optimizer', 'Orca, a new query optimizer for all Pivotal data management products, is a comprehensive development uniting state-of-the-art query optimization technology with original research resulting in a modular and portable optimizer architecture.', 'industrial', null, 21);
insert into Submission values (11, 'Amoeba: A Shape Changing, Big Data Storage System', 'Amoeba is a distributed storage system which uses adaptive multi-attribute data partitioning to efficiently support ad-hoc as well as  recurring  queries.', 'demo', null, 29);

/**** Author - 25 tuples ***/
insert into Author values (1, 1);
insert into Author values (2, 1);
insert into Author values (3, 2);
insert into Author values (4, 2);
insert into Author values (5, 2);
insert into Author values (6, 2);
insert into Author values (7, 3);
insert into Author values (8, 3);
insert into Author values (9, 4);
insert into Author values (10, 4);
insert into Author values (11, 5);
insert into Author values (12, 5);
insert into Author values (13, 5);
insert into Author values (14, 6);
insert into Author values (15, 6);
insert into Author values (17, 7);
insert into Author values (19, 8);
insert into Author values (20, 9);
insert into Author values (21, 9);
insert into Author values (21, 10);
insert into Author values (26, 11);
insert into Author values (27, 11);
insert into Author values (28, 11);
insert into Author values (29, 11);

/*** PreferenceFor - 25 tuples ***/
insert into PreferenceFor values ('hj01', 1, 2);
insert into PreferenceFor values ('hj01', 3, 3);
insert into PreferenceFor values ('hj01', 5, 4);
insert into PreferenceFor values ('ec01', 1, 3);
insert into PreferenceFor values ('ec01', 2, 4);
insert into PreferenceFor values ('pp01', 4, 1);
insert into PreferenceFor values ('pp01', 5, 4);
insert into PreferenceFor values ('pp01', 6, 4);
insert into PreferenceFor values ('jh01', 7, 3);
insert into PreferenceFor values ('jh01', 8, 3);
insert into PreferenceFor values ('bo01', 5, 1);
insert into PreferenceFor values ('bo01', 9, 2);
insert into PreferenceFor values ('lc01', 1, 1);
insert into PreferenceFor values ('lc01', 2, 2);
insert into PreferenceFor values ('lc01', 3, 1);
insert into PreferenceFor values ('lc01', 4, 2);
insert into PreferenceFor values ('lc01', 6, 3);
insert into PreferenceFor values ('er01', 7, 4);
insert into PreferenceFor values ('er01', 8, 3);
insert into PreferenceFor values ('jy01', 9, 1);
insert into PreferenceFor values ('jy01', 8, 2);
insert into PreferenceFor values ('jy01', 3, 4);
insert into PreferenceFor values ('jy01', 4, 5);
insert into PreferenceFor values ('pl01', 9, 4);
insert into PreferenceFor values ('pl01', 7, 4);

/*** AssignedTo - 30 tuples ***/
insert into AssignedTo values ('hj01', 3);
insert into AssignedTo values ('hj01', 5);
insert into AssignedTo values ('hj01', 10);
insert into AssignedTo values ('ec01', 1);
insert into AssignedTo values ('ec01', 2);
insert into AssignedTo values ('ec01', 4);
insert into AssignedTo values ('pp01', 5);
insert into AssignedTo values ('pp01', 6);
insert into AssignedTo values ('pp01', 10);
insert into AssignedTo values ('jh01', 7);
insert into AssignedTo values ('jh01', 8);
insert into AssignedTo values ('jh01', 1);
insert into AssignedTo values ('fl01', 2);
insert into AssignedTo values ('fl01', 6);
insert into AssignedTo values ('fl01', 9);
insert into AssignedTo values ('lc01', 6);
insert into AssignedTo values ('lc01', 4);
insert into AssignedTo values ('lc01', 8);
insert into AssignedTo values ('er01', 7);
insert into AssignedTo values ('er01', 8);
insert into AssignedTo values ('er01', 1);
insert into AssignedTo values ('jy01', 3);
insert into AssignedTo values ('jy01', 4);
insert into AssignedTo values ('jy01', 2);
insert into AssignedTo values ('pl01', 9);
insert into AssignedTo values ('pl01', 7);
insert into AssignedTo values ('pl01', 10);

/*** RefereeReport - 10 tuples ***/
insert into RefereeReport values ('ec01', 1, 'Y', 'Y', 'Y', 5, 4, 5, 4, 5, 1.0, 'The paper proposes a new way to do schema mappings that involve the user providing example instances of the result data. The system then constructs the schema mapping "behind the scenes" from the provided examples.', 'The described example-based schema mapping is novel in that it has not been used before specifically for the schema mapping problem.', 'The user study is fairly small-scale. It is not clear that any statistical significance can be drawn from such a small-scale study, though the results do look promising for the given example.', 'An excellent paper.', null, null);
insert into RefereeReport values ('jh01', 1, 'Y', 'Y', 'Y', 4, 3, 3, 4, 4, 0.9, 'The paper proposes a new way to do schema mappings.', 'The technique is novel and technique is efficient. ', 'Applicable only to small-scale schema mappings.', 'An interesting technique to do schema mappings.', null, null);
insert into RefereeReport values ('er01', 1, 'Y', 'N', 'Y', 3, 1, 4, 4, 2, 1.0, 'The paper proposes a new way to do schema mappings, but the algorithm is incorrect.', 'None really.', 'The algorithm is incorrect.', 'Should be rejected as it is technically not correct.', null, null);
insert into RefereeReport values ('ec01', 2, 'Y', 'Y', 'Y', 2, 1, 1, 2, 2, 0.8, 'This paper focuses on robust wrapper construction. In particular, two models are studied: the adversarial model and the probabilistic model.', 'A new approach, which has been proved to be the optimal for wrapper robustness, is proposed.', 'The paper is presented in a way which is very difficult to understand. I would like to see some examples to help explain the models.', 'This paper requires further work to make it acceptable for inclusion in the conference.', null, null);
insert into RefereeReport values ('jy01', 2, 'Y', 'Y', 'Y', 2, 2, 3, 3, 3, 0.8, 'A provable most robust wrapper is proposed for the two models. Experiments show the robustness of the wrapper. The paper is presented clearly and each part is well motivated.', 'Two models, adversarial model and probabilistic model, are proposed. For each model, an extraction confidence is provided.', 'The two models could be better motivated.', 'A well written paper on an interesting and timely topic that is very relevant to the conference.', null, null);
insert into RefereeReport values ('fl01', 2, 'Y', 'Y', 'Y', 3, 3, 3, 3, 3, 0.8, 'A robust wrapper is proposed that is shown to be robust. The paper is clearly presented and well motivated.', 'An adversarial and a probabilistic model are proposed.', 'The two models care well motivated.', 'A good paper on a timely topic.', null, null);
insert into RefereeReport values ('jy01', 4, 'Y', 'Y', 'Y', 3, 4, 4, 3, 4, 0.8, 'This paper discusses three types of conflicts: temporal conflicts, due to overlapping time intervals, spatial conflicts, due to overlapping locations and name conflicts, due to the use of different names that refer to the same concept.', 'Dealing with conflicts in historical data is an important and interesting problem.', 'The assumptions in Section 4.2.1 on which the conflict resolution method and experiments are based are not adequately justified.', 'The paper is acceptable for the conference.', null, null);
insert into RefereeReport values ('ec01', 4, 'Y', 'Y', 'Y', 4, 3, 3, 4, 4, 0.9, 'When integrating data from several documents, several types of conflicts may arise in the data. These conflicts may result in inaccurate query results due to over- or under-estimation. This paper discusses three types of conflicts.', 'The paper clearly defines each of the three types of conflicts with examples and how they may affect the results of queries.', 'No convincing validation of the method on real historical data is provided.', 'The paper is suitable for the conference.', null, null);
insert into RefereeReport values ('lc01', 4, 'Y', 'Y', 'Y', 4, 3, 4, 3, 4, 1.0, 'This paper discusses three types of conflicts that may arise when integrating data from several documents.', 'A method for dealing with this problem for temporal conflicts is proposed.', 'There are some technical errors in the paper (see the detailed comments).', 'The paper is OK for the conference.', 'In Section 4.1 the equation for RO(t1,t2) seems to be wrong. Since you are taking the absolute value of the sum and overlap, when there is a (non-zero) time gap between two time intervals, the value for RO will still be greater than 0.', null);
insert into RefereeReport values ('pp01', 6, 'N', 'Y', 'Y', 1, 2, 2, 2, 2, 1.0, 'This paper focuses on user feedback during the entity resolution (ER) process. It identifies a set of properties for making the ER methods transparent such that users can easily evaluate the results during the resolution process.', 'Considering user feedback to improve ER result seems very useful.', 'Although the paper describes what the user would do to improve the final result, it does not mention how the user does it. Does the user check all the intermediate results or choose part of the results? Is there any way to check whether new rules are applicable or not?', 'This approach does not seem to be practical in practice.', null, null);
insert into RefereeReport values ('lc01', 6, 'N', 'Y', 'Y', 3, 3, 2, 2, 3, 0.9, 'The paper proposes a two-stage ER approach in which users can incrementally check, debug or improve the intermediate results. During the stages, this approach can improve precision and recall separately.', 'The idea of improving precision and recall separately is interesting.', 'The experiments only involve two datasets. A lack of experiments on more datasets and other domains, make the work less convincing.', 'While the ideas proposed in this paper are interesting, more experiments are needed to verify the practicality of this proposed ER method.', null, null);

/*** Discussion - 8 tuples ***/
insert into Discussion values (1, 'ec01', 1, 'On a more careful reading I agree with er01''s assessment that the algorithm is incorrect. I also have some problems with the paper''s ''liberal'' use of other people''s text.');
insert into Discussion values (2, 'jh01', 1, 'Yes, I agree that the paper is technically incorrect and is possibly repetitive of other papers. For my part, I am willing to lower my overall score to 3.');
insert into Discussion values (3, 'ec01', 1, 'I have also decided to reduce my overall score for this paper to 3.');
insert into Discussion values (4, 'er01', 1, 'It seems that with the revised overall score this paper will not be accepted.');
insert into Discussion values (5, 'ec01', 1, 'OK I am happy with this result. I guess we are done discussing this paper.');
insert into Discussion values (1, 'jh01', 2, 'I feel that with some minor rewriting, the paper would be acceptable for inclusion in the conference. I would really like to see this paper accepted.');
insert into Discussion values (2, 'ec01', 2, 'Yes, adding some examples would make the paper much clearer and easier to understand. I am willing to change my overall score to 7 if you are willing to oversee the revision of the paper.');
insert into Discussion values (3, 'jh01', 2, 'OK I am willing to oversee the revision of the paper.');

/* Write the data to the database */
commit;