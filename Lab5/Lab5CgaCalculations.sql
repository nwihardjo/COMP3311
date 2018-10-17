/* COMP3311 Lab 5 - Lab5CgaCalculations.sql */

declare
    /* TODO: Complete the declaration of all the variables needed for the CGA calculation */
    gradePoint decimal(3,2);
    currentStudentId Student.studentId%type;
    courseCredits Course.credits%type;
    honoursCga Student.cga%type := 3.5;
    
    studentCga Student.cga%type;
    temp decimal(7,2);
    tempCredit Course.credits%type;
   
    /* Declaration of the cursors for the Student and EnrollsIn tables */
    cursor studentCursor is select * from Student;
    /* TODO: Complete the declaration of the cursor to retrieve the EnrollsIn records for the current student */
    cursor enrollsInCursor (stdId varchar2) is select COURSEID, GRADE from EnrollsIn where STUDENTID=stdId;


begin
    /* TODO: Complete the loop to retrieve each Student record */
    for studentRecord in studentCursor loop
        currentStudentId := studentRecord.studentId;
        /* Reset the variables used to calculate a student's CGA */
        tempCredit := 0;
        temp := 0;        				
        /* TODO: Complete the loop to retrieve each EnrollsIn record of the current student */
        /* The enrollsInCursor points at an EnrollsIn record for the current student */
        for enrollsInRecord in enrollsInCursor(currentStudentId) loop
            /* Determine the grade point from the course grade */
            gradePoint := greatest((enrollsInRecord.grade / 20) - 1, 0);
            /* Get the credits for the current course */
            select credits into courseCredits from course where courseId=enrollsInRecord.courseId;
				
            /* TODO: Collect the data needed to calculate the current student's CGA */
            tempCredit := tempCredit + courseCredits;
            temp := temp + (gradePoint * courseCredits);
            end loop; /* For retrieving each EnrollsIn record of the current student */

        /* TODO: Calculate and update the current student's CGA in their Student record */
        studentCga := temp/tempCredit;
        update Student set CGA = studentCga where STUDENTID=currentStudentId;
        /* Output honours message if needed */
        if studentCga >= honoursCga then
            dbms_output.put_line('>>> ' || studentRecord.firstName || ' ' || studentRecord.lastName || 
                ' (' || currentStudentId || ') with CGA=' || studentCga || ' is an honours Student.');
        end if;
            
        /* TODO: Insert the current student record into the LowCga table if their CGA is less than or equal to 2 */
        
        if studentCga <= 2 then
            insert into LowCga values (currentStudentId, studentRecord.firstName, studentRecord.lastName,
                studentRecord.email, studentRecord.phoneNo, studentCga, studentRecord.departmentId, 
                studentRecord.admissionYear);
        end if;
        
    end loop; /* For retrieving each Student record */
end;
/