/* COMP3311 Lab 4 - Lab4Constraints.sql */

/********************************************************************************************************
/* For each line beginning with the text "--alter table", complete the specification of the constraint  *
/* by replacing the text ">>> COMPLETE THE CONSTRAINT SPECIFICATION <<<" with your own constraint code. *
/* To make a constraint executable, remove the comment symbols "--" at the beginning of the line.       *
/********************************************************************************************************


/* Referential integrity constraints */

set heading off
select '*** ADD REFERENTIAL INTEGRITY CONSTRAINTS ***' from dual;
set heading on

-- Student table: Add referential integrity constraints for the Student table by editing the comment below.
alter table Student modify (departmentId references Department (departmentId));

-- Course table: Add referential integrity constraints for the Course table by editing the comment below.
alter table Course modify (departmentId references Department (departmentId));

-- Facility table: Add referential integrity constraints for the Facility table by editing the comment below.
alter table Facility modify (departmentId references Department (departmentId));

-- EnrollsIn table: Add referential integrity constraints for the EnrollsIn table by editing the comments below.
alter table EnrollsIn modify (courseId references Course (courseId));
alter table EnrollsIn modify (studentId references Student (studentId) on delete cascade);
/* Check constraints */

set heading off
select '*** ADD CHECK CONSTRAINTS ***' from dual;
set heading on

-- Department table: Add a constraint to check that departmentId has only a value in the set {BUS, COMP, ELEC, HUMA, MATH}.
alter table Department add constraint CHK_departmentId check (departmentId in ('BUS', 'COMP', 'ELEC', 'HUMA', 'MATH'));

-- Student table: Add a constraint to enforce the uniqueness of email values.
alter table Student add constraint CHK_email unique (email);

-- Student table: Add a constraint to check that studentId has exactly 8 digits only.
alter table Student add constraint CHK_studentId check (REGEXP_LIKE(studentId, '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'));

-- Student table: Add a constraint to check that phoneNo has exactly 8 digits only.
alter table Student add constraint CHK_phoneNo check (LENGTHB(phoneNo) = 8);

-- Student table: Add a constraint to check that cga has a value between 0 and 4.
alter table Student add constraint CHK_cga check (cga between 0 and 4);

-- Student table: Add a constraint to check that admissionYear begins with a 2 and has exactly 4 digits only.
alter table Student add constraint CHK_admissionYear check (REGEXP_LIKE(admissionYear, '^2[0-9][0-9][0-9]'));

-- Course table: Add a constraint to check that course id follows the pattern of exactly four letters followed by exactly four digits.
alter table Course add constraint CHK_courseId check (REGEXP_LIKE(courseId, '[A-Z][A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9]'));

-- EnrollsIn table: Add a constraint to check that grade has a value between 0 and 100.
alter table EnrollsIn add constraint CHK_grade check (grade between 0 and 100);

commit;