/*
	Purpose of SP_GPA Stored Procedure :- This procedure is used to View the GPA of a crossponding Student ID per semester wise
	Require Parameter :- Student ID
	Output: -  The output will be
				Student ID   : 250410569
				Student Name : Gaurav Kumar
				Semester 1 : 10.9
				Semester 2 : 20.9				
*/

Create OR Alter procedure SP_GPA
@Student_ID Varchar(10)
AS
Begin
	Declare @Student_Name Varchar(50)=(Select FullName From Students Where StudentID=@Student_ID)
	IF(@Student_ID IS NOT NULL)
	Begin
	   Declare @count  int=(Select Count(*) From GPA Where StudentId=@Student_ID)
	   IF(@Count>0)
	   Begin
			--Logic to Display Student ID & Student Name
			Print 'Student ID : '+@Student_Id+Char(13)+'Student Name : '+@Student_Name
			
			--Logic to Display Semester & GPA crossponding to semester
			Declare @Total_Sem int=(Select P.Total_Semester From Students as S Join Programme as P 
			ON S.Programme_ID=P.Programme_ID Where S.StudentID=@Student_ID)
			Declare @SemCount int=1
			While(@SemCount<=@Total_Sem)
			Begin   
				Declare @Sem_Name Varchar(20), @GPA Decimal(4,2)
				Select @Sem_Name=S.SemesterName,@GPA=G.GPA From GPA as G join Semesters as S 
				ON G.SemesterID=S.SemesterID Where G.StudentID=@Student_ID And G.SemesterID=@SemCount
				Print @Sem_Name+' : '+Cast(@GPA as Varchar)
				SET @SemCount=@SemCount+1
			End
	   End
	   Else
		Raiserror('Marks is not updated yet !',16,1)
	End
	Else
		Raiserror('Student is not exsist !',16,1)	
End

--Executing Procedure
Exec SP_GPA '2504000001'