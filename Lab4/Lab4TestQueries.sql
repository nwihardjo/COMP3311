/* COMP3311 Lab 4 - Lab4TestQueries.sql */

set linesize 150;

/* Display average grade for each student */
with StudentAvgGrade as
(select studentId, trunc(avg(grade), 2) as avgGrade
 from EnrollsIn
 group by studentId)
 
select studentId, firstName, lastName, avgGrade
from Student natural join StudentAvgGrade
where avgGrade > 80
order by avgGrade desc;


/* Test for referential integrity constrainst */
set heading off
select '*** REFERENTIAL INTEGRITY CONSTRAINTS VIOLATED ***' from dual;
set heading on

/* Student table referential integrity tests */
-- No matching departmentId in Department table
insert into Student values ('22222222', '*** Student ***', 'RI: No matching dept id', 'afong', '22223334', 0.00, 'PHYS', '2016');
-- Department id cannot be null
insert into Student values ('33333333', '*** Student ***', 'RI: Dept id cannot be null', 'jchan', '23321334', 0.00, null, '2016');
-- Cascade delete on Student table
set heading off
select '*** Cascade delete test on Student table should succeed with 1 row deleted and no rows selected ***' from dual;
set heading on
delete from Student where studentId = '26184444';
select * from EnrollsIn where studentId = '26184444';

/* Course table referential integrity tests */
-- No matching department id in Department table
insert into Course values ('PHYS4311', '*** ', '*** Course ***', 'RI: No matching dept id');

/* Facility table referential integrity tests */
-- No matching department id in Department table
insert into Facility values ('CHEM', '*** Facility *** RI: No matching dept id', 2, 5);

/* EnrollsIn table referential integrity tests */
-- No matching course id in Course table
insert into EnrollsIn values ('13456789', 'PHYS4311', 80.6);
-- No matching student id in Student table
insert into EnrollsIn values ('99999999', 'COMP3311', 75.6);


/* Tests for check constraints */
set heading off
select '*** CHECK CONSTRAINTS VIOLATED ***' from dual;
set heading on

-- Department table: departmentId must be one of BUS, COMP, ELEC, HUMA or MATH
insert into Department values ('DEPT','*** Department table: Dept id invalid','0000');

-- Student table: email must be unique
insert into Student values ('44444444', '*** Student table:', 'CHK: Email not unique', 'cs_grande', '22223334', 0.00, 'COMP', '2016');

-- Student table: studentId is not all digits
insert into Student values ('234567*9', '*** Student table:', 'CHK: Student id invalid', 'afong', '22223334', 0.00, 'COMP', '2016');

-- Student table: cga not in allowed range
insert into Student values ('55555555', '*** Student table:', 'CHK: CGA out of range', 'ali', '25524334', 4.50, 'COMP', '2016');

-- Course table: course id follows the pattern of exactly four letters followed by exactly four number
insert into course values ('comp3311','COMP','** Course Table: CHK: invalid course id','Test Man'); 

-- EnrollsIn table: grade not in allowed range
insert into EnrollsIn values ('99987654', 'COMP3311', 100.1);

