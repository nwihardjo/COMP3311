/* COMP3311 Lab 6: lab6DuplicateEmailCheck.sql */

/* TODO: Check whether a unique index exists on the email attribute of the Student table */
declare
begin
	/* Insert a record with a duplicate email */
    INSERT INTO student VALUES (20315012, 'Fake', 'Wihardjo', 'nwihardjo',
        91484450, null, 'COMP', 2015);    
exception
    /* Output a message if an exception is raised */
    WHEN DUP_VAL_ON_INDEX THEN
        dbms_output.put_line ('### Tried to insert duplicate email into the Student table.');
end;
/