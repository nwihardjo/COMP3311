INSERT INTO Person VALUES (1, 'Mr', 'Stephen', 'HKUST', 'HK', 91484450, 'shawk@sql');
INSERT INTO Person VALUES (2, NULL, 'Hawking', 'HKUST', 'HK', 456900077040, 'shawk1@sql');

select * from Person P1 NATURAL JOIN PERSON 
where title is not null;
--
--
drop table sub; drop table pers;
create table pers (pid int, ref_sid int);
create table sub (sid_ int, ref_pid int);
create table temp(pid int);
insert into temp values (1);
insert into pers values (1, 10);
insert into pers values (2, 10);
insert into sub values (10, 1);
select * from temp;
with combine (sid_, ref_pid, pid, ref_sid) as (
    select * from sub, pers 
    where pers.ref_sid = sub.sid_ )
select *
from combine c left outer join temp T on c.pid=T.pid
where T.pid is not null;
--
--


INSERT INTO Author VALUES(1, 10);

INSERT INTO Submission VALUES (10, 'Big Dater', 'Very big big dater', 'research', NULL, 1);