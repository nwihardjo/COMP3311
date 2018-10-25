/* COMP3311 Lab 6: Lab6TestQueries.sql */

set serveroutput on;
set pagesize 30;
set termout off;
@Lab6
set termout on;
@Lab6DuplicateEmailCheck
@Lab6CgaCalculations
select studentId, firstName, lastName, cga from Student order by cga desc;
select studentId, firstName, lastName, cga from LowCga order by cga desc;