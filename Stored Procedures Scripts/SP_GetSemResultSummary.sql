/*
	Purpose of "SP_GetSemResultSummary" Stored Procedure :-  This procedure is used to get the result summary of all students of all course 
															 at a time. It will display Name of  Student, Student ID, Course Name,
															 Semester wise [Subject Name, Marks obtained, Grades, Grades Point, Result :Pass/Fail,
															 GPA] for all student.
															 
	Parameter Required :- No  Parameter Required
*/

Create OR Alter Procedure SP_GetSemResultSummary
As
Begin
	--Logic of Cursor Created for getting No. of unique Student Id present in Grades Table & Fetching One by one Student ID
	Declare C1 Cursor For (Select distinct StudentID From Grades)
	Declare @Sid Varchar(10)
	Open C1
	Fetch Next From C1 into @Sid
	While(@@FETCH_STATUS=0)
	Begin
	   --Logic to display name of student and student Id one by one
		Declare @Sname Varchar(50)=(Select FullName From Students Where StudentID=@Sid And Status=1)
		Print 'Student ID : '+@Sid+Char(13)+'Student Name : '+@Sname+Char(13)
		Declare @Count int=1,@SemCount int
		Select @SemCount=Max(T.Rno) From (Select Row_Number() Over (Order By S.SemesterID) as Rno From Grades as G join Subject as S 
		ON G.Subject_ID=S.Subject_ID Where G.StudentID=@Sid Group By S.SemesterID) as T
		IF(@Count<=@SemCount)
		Begin
			Declare @SemName Varchar(20)
			While(@Count<=@SemCount)
			Begin
				--logic to show semester name
				Select @SemName=sm.SemesterName From Grades as G join Subject as S ON G.Subject_ID=S.Subject_ID join Semesters 
				as sm ON S.SemesterID=sm.SemesterID Where sm.SemesterID=@Count
				Print @SemName+Char(13)+'-------------------'
				
				--logic of Cursor to display Subject Name and Result(Pass/Fail)
				Declare C2 Cursor For (Select S.Subject_Name,G.MarksObtained,G.Grade,G.GradePoint, Case When G.GradePoint>=5.0 Then 'Pass'
												Else 'Fail' End As Result From Grades as G 
										join Subject as S ON G.Subject_ID=S.Subject_ID 
										Where G.StudentID=@Sid And S.SemesterID=@Count)
				Declare @SubName Varchar(100),@Marks Decimal(5,2),@Grade char(2),@GP Decimal(3,1),@Result Char(4)
				Open C2
				Fetch Next From C2 into @SubName,@Marks,@Grade,@GP,@Result
				While(@@FETCH_STATUS=0)
				Begin
				Print @SubName+' => '+'Marks : '+Cast(@Marks as Varchar)+' , Grade : '+@Grade+' , Grade Point : '+Cast(@GP as Varchar)+' , Result : '+@Result
				Fetch Next From C2 into @SubName,@Marks,@Grade,@GP,@Result
				End
				Close C2
				Deallocate C2
				
				--Logic to displaying GPA of one by one semester wise for a crossponding student id
				Declare @GPA Decimal(4,2)=(Select GPA from GPA Where StudentID=@Sid AND SemesterID=@Count)
				Print Char(13)+'Grade Point Average (GPA) : '+Cast(@GPA as varchar)+Char(13)
				SET @Count=@Count+1
			End
		End
		Fetch Next From C1 into @Sid
		SET @Count=1
		Print '******************************************************************************************************************************'
	End
	Close C1
	Deallocate C1
End

--Executing Procedure
Execute SP_GetSemResultSummary
