select * from Student where DEPARTMENTID = 'COMP' order by CGA desc;

select FIRSTNAME from Student where regexp_like (FIRSTNAME, '^..r', 'c');

select LASTNAME from Student where regexp_like (LASTNAME, '[cz]', 'c');

select FIRSTNAME, LASTNAME from Student where 
    regexp_like(FIRSTNAME, '([a-za-z])\1', 'c') or regexp_like(LASTNAME, '([a-za-z])\1', 'c');
    
select STUDENTID, FIRSTNAME, LASTNAME, CGA, Department.DEPARTMENTNAME
    from Student, Department 
    where Student.DEPARTMENTID = Department.DEPARTMENTID and
    Student.DEPARTMENTID in ('COMP', 'ELEC') and CGA not between 2.4 and 2.8
    order by LASTNAME asc;