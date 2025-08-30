/*
	Purpose of "SP_GetSemeterResult" :- This procedure is use for checking the statistic of Student Who is enrolled for a course
										given exam. This will take student id as input and tells you in which subject semester wise
										you are Pass or Fail based on there Grades points.
	Require Parameter => Student ID
*/
Create OR Alter Procedure SP_GetSemesterResult
@Student_ID Varchar(10)
As
Begin
	--Logic to validate Student Id is exsist or Not, if exsist then Display Student ID and Name of Student
	Declare @Sid varchar(10), @Sname Varchar(50)
	Select @Sid=StudentID,@Sname=FullName From Students Where StudentID=@Student_ID And Status=1
	Print 'Student ID : '+@Sid+Char(13)+'Student Name : '+@Sname+Char(13)
	IF(@Sid IS NOT NULL)
	Begin
		
		--Logic to showing student pass/fail in subject from crossponding subject semester wise for a course
		Declare @Count int=1,@SemCount int
		Select @SemCount=Max(T.Rno) From (Select Row_Number() Over (Order By S.SemesterID) as Rno From Grades as G join Subject as S 
		ON G.Subject_ID=S.Subject_ID Where G.StudentID=@Sid Group By S.SemesterID) as T
		IF(@SemCount<>0)
		Begin
			Declare @SemName Varchar(20)
			While(@Count<=@SemCount)
			Begin
				--logic to show semester name
				Select @SemName=sm.SemesterName From Grades as G join Subject as S ON G.Subject_ID=S.Subject_ID join Semesters 
				as sm ON S.SemesterID=sm.SemesterID Where sm.SemesterID=@Count
				Print @SemName+Char(13)+'-------------------'
				
				--logic of Cursor to display Subject Name and Result(Pass/Fail)
				Declare C1 Cursor For (Select G.Subject_ID, Case When G.GradePoint>=5.0 Then 'Pass'
												Else 'Fail' End As Result From Grades as G 
										join Subject as S ON G.Subject_ID=S.Subject_ID 
										Where G.StudentID=@Sid And S.SemesterID=@Count)
				Declare @Subject Varchar(100),@Result Char(4)
				Open C1
				Fetch Next From C1 into @Subject, @Result
				While(@@FETCH_STATUS=0)
				Begin
				Print @Subject+' : '+@Result
				Fetch Next From C1 into @Subject,@Result
				End
				Close C1
				Deallocate C1
				Print ''
				SET @Count=@Count+1
			End
		End
		Else
			Raiserror('Result is not uploaded yet, Please Wait !',16,1)
	End
	Else
		Raiserror('Student ID is not exsist',16,1)
End

--Executing Procedure
Execute SP_GetSemesterResult '2504000001'

Execute SP_GetSemesterResult '2512000001'