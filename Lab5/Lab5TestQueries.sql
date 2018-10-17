/* COMP3311 Lab 5 - Lab5TestQueries.sql */
set serveroutput on;
set pagesize 30;
set termout off;
@Lab5
set termout on;
@Lab5CgaCalculations
select studentId, firstName, lastName, cga from Student order by cga desc;
select studentId, firstName, lastName, cga from Lowcga order by cga desc;