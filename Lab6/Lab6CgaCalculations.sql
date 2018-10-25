/* COMP3311 Lab 6 Lab6CgaCalculations.sql */

declare
	/* Declare the variables needed for the CGA calculation */
    gradePoint decimal(3,2);
	currentStudentId Student.studentId%type;
    courseCredits Course.credits%type;
	honoursCga Student.cga%type := 3.5;
	sumCredits Course.credits%type;
	sumCreditsTimesGradePoint decimal(6,2);
	studentLowCga Student.cga%type := 2;
	studentCga Student.cga%type;
	studentName Student.firstName%type;
    
	/* Declare the cursors for the Student and EnrollsIn tables */
	cursor studentCursor is select studentId, firstName, lastName from Student;
	cursor enrollsInCursor is select courseId, grade from EnrollsIn where studentId=currentStudentId;
begin
	/* Retrieve each Student record */
	for studentRecord in studentCursor loop
		currentStudentId := studentRecord.studentId;
		/* Reset the variables used to calculate a student's CGA */
		sumCreditsTimesGradePoint := 0;
		sumCredits := 0;
				
		/* Retrieve each EnrollsIn record of the student */
		for enrollsInRecord in enrollsInCursor loop		
			/* Determine grade point from the course grade */
			gradePoint := greatest((enrollsInRecord.grade / 20) - 1, 0);
			/* Get the credits for the current course */
			select credits into courseCredits from Course where courseId=enrollsInRecord.courseId;
				
			/* Collect the data needed to calculate the current student's CGA  */
			sumCredits := sumCredits + courseCredits;
			sumCreditsTimesGradePoint := sumCreditsTimesGradePoint + courseCredits * gradePoint;
		end loop; /* For retrieving each EnrollsIn record of the current student */
			
		/* Calculate and update the current student's CGA in their Student record */
		begin
			/* Throws an exception if there is no EnrollsIn record */
            studentCga := sumCreditsTimesGradePoint / sumCredits;
			update Student set cga=studentCga where studentId=currentStudentId;
			
			/* Output honours message if needed */
			if studentCga >= honoursCga then
				dbms_output.put_line('>>> ' || studentRecord.firstName || ' ' || studentRecord.lastName || 
					' (' || currentStudentId || ') with CGA=' || studentCga || ' is an honours Student.');
			end if;
            /* Insert the current student record into the LowCga table if their 
               cga is less than or equal to 2 and output low cga message */
			if studentCga <= studentLowCga then
				insert into LowCga select * from Student where studentId=currentStudentId;

				/* TODO: Output low cga message */
                SELECT firstName||' '||lastName INTO studentName FROM Student 
                    WHERE studentId = currentStudentId;
				dbms_output.put_line('*** Low CGA alert for ' || studentName || ' (' || 
                    currentStudentId || ') with CGA=' || studentCga);
			end if;	
		exception
			/* TODO: Output no EnrollsIn record for student message */
			
            WHEN ZERO_DIVIDE THEN 
                SELECT firstName || ' ' || lastName INTO studentName FROM Student 
                    WHERE studentId = currentStudentId;
                
                dbms_output.put_line('### ' || studentName || ' (' || currentStudentId ||
                ') is not enrolled in any course.');
                update Student set cga=NULL where studentId = currentStudentId;
                
            
		end;
	end loop; /* For retrieving each Student record */
end;
/