/*
	Purpose :- This stored procedure can used for following 
				1. Can show all Subjects of a Course of a student registered for [By Passing Only Student ID]
				2. Particular Subjects of a Course based on Semester Number for particular Student ID [By Passing Student ID And Semester No.]
				3. Can Show All Subjects of a Course [By Passing Only Course Name]
				4. Can Show All Subjects of a course based on particular semester no. [By Passing Course Name And Semester Number]
				5. Can Show All Subjects of All Courses Available
*/

Create OR Alter Procedure SP_GetCourseSubject
@Student_ID Varchar(10)=Null,
@CourseName Varchar(50)=Null,
@SemesterNo int=Null
AS
Begin
--Logic to Get Course Subjects based on Student ID 
IF(@Student_ID IS NOT NULL AND @SemesterNo IS NULL AND @CourseName IS NULL)
Begin
	Select S.Programme_ID,S.Subject_ID,S.Subject_Name,SM.SemesterName,S.Credits From Subject as S Join Programme as P ON S.Programme_ID=P.Programme_ID
	Join Students st ON P.Programme_ID=st.Programme_ID Join Semesters as SM ON S.SemesterID=SM.SemesterID Where st.StudentID=@Student_ID
	Order By SM.SemesterName
End

--Logic to Get Course Subjects based on Student ID And Mention Semester Number
Else IF(@Student_ID IS NOT NULL AND @SemesterNo IS NOT NULL AND @CourseName IS NULL)
Begin
   Select S.Programme_ID,S.Subject_ID,S.Subject_Name,SM.SemesterName,S.Credits From Subject as S Join Programme as P ON S.Programme_ID=P.Programme_ID
   Join Students st ON P.Programme_ID=st.Programme_ID Join Semesters as SM ON S.SemesterID=SM.SemesterID Where st.StudentID=@Student_ID
   AND S.SemesterID=@SemesterNo Order By SM.SemesterName
End

--Logic to Get Course Subject based on Course Name 
Else IF(@CourseName IS NOT NULL And @SemesterNo IS NULL)
Begin
   Select S.Programme_ID,S.Subject_ID,S.Subject_Name,SM.SemesterName,S.Credits From Subject as S Join Programme as P ON S.Programme_ID=P.Programme_ID
   Join Semesters as SM ON S.SemesterID=SM.SemesterID Where S.Programme_ID=@CourseName Order By SM.SemesterName
End

--Logic to Get Course Subject based on Course Name and Semester Number
Else IF(@CourseName IS NOT NULL And @SemesterNo IS NOT NULL)
Begin
   Select S.Programme_ID,S.Subject_ID,S.Subject_Name,SM.SemesterName,S.Credits From Subject as S Join Programme as P ON S.Programme_ID=P.Programme_ID
   Join Semesters as SM ON S.SemesterID=SM.SemesterID Where S.Programme_ID=@CourseName AND S.SemesterID=@SemesterNo
   AND S.SemesterID=@SemesterNo Order By SM.SemesterName
End
Else

--Logic to Show All Course subjects
Begin
	Select P.Programme_ID,P.Programme_Name,S.Subject_ID,S.Subject_Name,SM.SemesterName,S.Credits From Subject as S Join Programme as P ON S.Programme_ID=P.Programme_ID
   Join Semesters as SM ON S.SemesterID=SM.SemesterID Order By P.Programme_ID,SM.SemesterName
End
End

--Case 1:- Passing Only Student ID
Execute SP_GetCourseSubject '2504000001'

--Case 2:- Passing Only Student ID and Semester Number
Execute SP_GetCourseSubject '2504000001',Null,1

--Case 3:- Passing Only Course Name
Execute SP_GetCourseSubject Null,'BCA'

--Case 4:- Passing Course Name And Semester Number
Execute SP_GetCourseSubject Null,'BAG',1

--Case 5: Not Passing Anything (Will show all subject based on all courses)
Execute SP_GetCourseSubject