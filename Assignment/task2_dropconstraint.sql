--CONSTRAINTS DELETION
begin
    for r in ( select table_name, constraint_name
               from user_constraints
               where constraint_type = 'R' )
    loop
        execute immediate 'alter table '||r.table_name
                          ||' drop constraint '||r.constraint_name;
    end loop;
end loop;
