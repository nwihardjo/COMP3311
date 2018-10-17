SET HEADING OFF
select 'Query 1: The minimum, maximum, average and total number of computers over all departments. ' from dual;
SET HEADING ON
select min(NUMBERCOMPUTERS) as MINIMUM, max(NUMBERCOMPUTERS) as MAXIMUM, 
    avg(NUMBERCOMPUTERS) as AVERAGE, sum(NUMBERCOMPUTERS) as TOTAL
from Facility;

SET HEADING OFF
select 'Query 2: The students in the COMP department with the highest cga.' from dual;
select FIRSTNAME || ' ' || LASTNAME || ' with student id ' || STUDENTID
    || ' has the highest CGA in ' || DEPARTMENTID || '.'
from Student 
where DEPARTMENTID='COMP' AND CGA=(select max(CGA) from Student);

select 'Query 3: The average cga of the students enrolled in each course.' from dual;
SET HEADING ON
select COURSEID, trunc(AVG(CGA), 2) as "AVG CGA"
from EnrollsIn NATURAL JOIN Student 
group by COURSEID
order by "AVG CGA" desc;

SET HEADING OFF
select 'Query 4: The students with the highest cga in each course' from dual;
SET HEADING ON
select COURSEID, LASTNAME, FIRSTNAME, DEPARTMENTID as DEPA, S.CGA
from (select COURSEID, MAX(CGA) as cga_ 
    FROM EnrollsIn NATURAL JOIN Student 
    group by COURSEID) base, STUDENT s
where base.cga_ = s.CGA
order by DEPA asc;

SET HEADING OFF 
select 'Query 5: The number of courses in which each student is enrolled.' from dual;
SET HEADING ON
select FIRSTNAME, LASTNAME, DEPARTMENTID as DEPA, count(COURSEID) as "Number of courses"
from Student s left outer join EnrollsIn e
on s.STUDENTID = e.STUDENTID
group by FIRSTNAME, LASTNAME, DEPARTMENTID
order by "Number of courses" asc;