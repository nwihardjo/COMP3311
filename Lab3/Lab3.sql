/* COMP3311 Lab 3 Lab3.sql */

/* Start with a clean database */
drop table EnrollsIn;
drop table Facility;
drop table Department;
drop table Student;
drop table Course;


/* Create the tables */
create table Student (
	studentId		char(8) not null,
	firstName		varchar2(20) not null,
	lastName		varchar2(25) not null,
	email			varchar2(30) not null,
	phoneNo         char(8),
	cga				number(3,2),
	departmentId	char(4) not null,
	admissionYear   char(4) not null);

create table EnrollsIn (
 	studentId	char(8) not null,
	courseId	char(8));

create table Course (
	courseId		char(8) not null,
	departmentId	char(4) not null,
	courseName		varchar2(40) not null,
	instructor		varchar2(30) not null);

create table Department (
	departmentId	char(4) not null,
	departmentName	varchar2(40) not null,
	roomNo		char(4));

create table Facility ( 
  	departmentId        char(4) not null,
	departmentName      varchar2(40) not null,
	numberProjectors    int,
	numberComputers     int);

/* Populate the tables with data */
insert into Student values ('13455789','Harry','Potter','cs_potter','23581234',2.76,'COMP','2014');
insert into Student values ('15456789','Leonardo','Da Vinci','cs_davinci','23585678',2.72,'COMP','2014');
insert into Student values ('13556789','Legolas','Greenleaf','ma_greenleaf','23582468',3.36,'MATH','2015');
insert into Student values ('13456789','Ariana','Grande','cs_grande','23581234',2.83,'COMP','2015');
insert into Student values ('15678989','Maria','Callas','cs_callas','23589876',2.73,'COMP','2015');
insert into Student values ('15678901','Albert','Einstein','cs_einstein','23585678',2.56,'COMP','2014');
insert into Student values ('16789012','Robert','Redford','ma_redford','23582468',2.57,'MATH','2015');
insert into Student values ('14567890','Julius','Caesar','ee_caesar','23589876',1.90,'ELEC','2015');
insert into Student values ('99987654','Lazzy','Lazy','lz_lazy','23581357',null,'COMP','2015');
insert into Student values ('26184624','Bruce','Wayne','ee_wayne','28261057',2.48,'ELEC','2014');
insert into Student values ('26184444','Donald','Trump','bs_trump','28255057',1.49,'BUS','2016');
insert into Student values ('26186666','Warren','Buffet','bs_buffet','28266027',3.42,'BUS','2015');
insert into Student values ('66666666','Ferris','Bueller','bs_bueller','28282727',1.67,'BUS','2014');

insert into EnrollsIn values ('13455789','COMP3311');
insert into EnrollsIn values ('15456789','COMP3311');
insert into EnrollsIn values ('13556789','COMP3311');
insert into EnrollsIn values ('14567890','COMP3311');
insert into EnrollsIn values ('13456789','COMP3311');
insert into EnrollsIn values ('15678989','COMP3311');
insert into EnrollsIn values ('15678901','COMP3311');
insert into EnrollsIn values ('26184624','COMP3311');
insert into EnrollsIn values ('26184444','COMP3311');
insert into EnrollsIn values ('26186666','COMP3311');
insert into EnrollsIn values ('66666666','COMP3311');

insert into EnrollsIn values ('13455789','COMP4021');
insert into EnrollsIn values ('15456789','COMP4021');
insert into EnrollsIn values ('13556789','COMP4021');
insert into EnrollsIn values ('14567890','COMP4021');
insert into EnrollsIn values ('13456789','COMP4021');
insert into EnrollsIn values ('15678989','COMP4021');
insert into EnrollsIn values ('15678901','COMP4021');
insert into EnrollsIn values ('16789012','COMP4021');
insert into EnrollsIn values ('26184624','COMP4021');
insert into EnrollsIn values ('26186666','COMP4021');
insert into EnrollsIn values ('66666666','COMP4021');

insert into EnrollsIn values ('13455789','ELEC3100');
insert into EnrollsIn values ('15456789','ELEC3100');
insert into EnrollsIn values ('13556789','ELEC3100');
insert into EnrollsIn values ('14567890','ELEC3100');
insert into EnrollsIn values ('13456789','ELEC3100');
insert into EnrollsIn values ('15678989','ELEC3100');
insert into EnrollsIn values ('15678901','ELEC3100');
insert into EnrollsIn values ('26184624','ELEC3100');
insert into EnrollsIn values ('26184444','ELEC3100');
insert into EnrollsIn values ('26186666','ELEC3100');
insert into EnrollsIn values ('66666666','ELEC3100');

insert into EnrollsIn values ('13455789','HUMA1020');
insert into EnrollsIn values ('15456789','HUMA1020');
insert into EnrollsIn values ('13556789','HUMA1020');
insert into EnrollsIn values ('14567890','HUMA1020');
insert into EnrollsIn values ('13456789','HUMA1020');
insert into EnrollsIn values ('15678989','HUMA1020');
insert into EnrollsIn values ('66666666','HUMA1020');

insert into EnrollsIn values ('13455789','MATH2421');
insert into EnrollsIn values ('15456789','MATH2421');
insert into EnrollsIn values ('14567890','MATH2421');
insert into EnrollsIn values ('13556789','MATH2421');
insert into EnrollsIn values ('13456789','MATH2421');
insert into EnrollsIn values ('15678989','MATH2421');
insert into EnrollsIn values ('15678901','MATH2421');
insert into EnrollsIn values ('16789012','MATH2421');
insert into EnrollsIn values ('26184624','MATH2421');
insert into EnrollsIn values ('26184444','MATH2421');
insert into EnrollsIn values ('26186666','MATH2421');
insert into EnrollsIn values ('66666666','MATH2421');

insert into Course values ('COMP3311','COMP','Database Management Systems','Chen Lei');
insert into Course values ('COMP4021','COMP','Internet Computing','David Rossiter');
insert into Course values ('ELEC3100','ELEC','Signal Processing and Communications','Electronic Man');
insert into Course values ('MATH2421','MATH','Probability','Isaac Newton');
insert into Course values ('HUMA1020','HUMA','Chinese Writing and Culture','Human Man');

insert into Department values ('COMP','Computer Science',3528);
insert into Department values ('MATH','Mathematics',3461);
insert into Department values ('ELEC','Electronic Engineering',2528);
insert into Department values ('BUS','Business',4528);
insert into Department values ('HUMA','Humanities',1200);

insert into Facility values ('COMP','Computer Science',15,250);
insert into Facility values ('MATH','Mathematics',5,50);
insert into Facility values ('ELEC','Electronic Engineering',14,150);
insert into Facility values ('BUS','Business',10,130);

/* Write the data to disk */
commit;