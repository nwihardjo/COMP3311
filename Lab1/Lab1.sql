/* COMP3311 Lab 1 Lab1.sql */

/* Start with a clean database */
drop table Student;

/* Create the Student table */
create table Student (
	studentId   char(8) not null,
	firstName   varchar2(20) not null,
	lastName    varchar2(25) not null,
	email       varchar2(30) not null,
	phoneNo     char(8),
	cga         number(4,2));

/* Populate the Student table with data */
insert into Student values ('13455789','Harry','Potter','cs_potter','23581234',2.76);
insert into Student values ('15456789','Leonardo','Da Vinci','cs_davinci','23585678',2.72);
insert into Student values ('13556789','Legolas','Greenleaf','ma_greenleaf','23582468',3.36);
insert into Student values ('13456789','Ariana','Grande','cs_grande','23581234',2.83);
insert into Student values ('15678989','Maria','Callas','cs_callas','23589876',2.73);
insert into Student values ('15678901','Albert','Einstein','cs_einstein','23585678',2.56);
insert into Student values ('16789012','Robert','Redford','ma_redford','23582468',2.57);
insert into Student values ('14567890','Julius','Caesar','ee_caesar','23589876',1.90);
insert into Student values ('99987654','Lazzy','Lazy','lz_lazy','23581357',null);
insert into Student values ('26184624','Bruce','Wayne','ee_wayne','28261057',2.48);
insert into Student values ('26184444','Donald','Trump','bs_trump','28255057',1.49);
insert into Student values ('26186666','Warren','Buffet','bs_buffet','28266027',3.42);
insert into Student values ('66666666','Ferris','Bueller','bs_bueller','28282727',1.67);

/* Write the data to disk */
commit;