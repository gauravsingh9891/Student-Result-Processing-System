/*
	Purpose of "SP_GetRank" Stored Procedure :-  This stored procedure is find the rank based on GPA and Gross GPA. 
	
	You can use in use as follow:-
	1) Rank based on Course in all semester wise [By Passing Only Course Name as parameter]
	2) Rank based on specific Course and semeter wise [By Passing Only Course Name and Semester as parameter]
	3) Rank based on specific semeter for all courses of all students [By Passing Only Semester as parameter]
	4) Rank Specific Course Students based on Average GPA in there particular course/programme [By Passing Course Name & in @IsRankGrossGPA value 'y'  as parameter]
	5) Rank All Course Students based on Average GPA in there particular course/programme [By Passing @IsRankGrossGPA value 'y'  as parameter]
*/

Create Or Alter Procedure SP_GetRank
@Course_ID Varchar(10)=NULL,
@Semester int=NULL,
@IsRankGrossGPA char(1)=NULL
AS
Begin
	--Logic to Rank All  Courses Students Based on Semester wise
	IF(@Course_ID IS NULL And @Semester IS NULL And @IsRankGrossGPA IS NULL)
	Begin 
		Select S.StudentID,S.FullName,S.Programme_ID,GP.SemesterID,GP.GPA,
		Dense_Rank() Over(Partition By GP.SemesterID Order By GP.GPA Desc) As Rank From GPA as GP
		Join Students as S ON GP.StudentID=S.StudentID
	End

	--Logic to Rank Only Specified Course Students based on Semester wise
	Else IF(@Course_ID IS NOT NULL And @Semester IS NULL And @IsRankGrossGPA IS NULL)
	Begin
		Select S.StudentID,S.FullName,S.Programme_ID,GP.SemesterID,GP.GPA,
		Dense_Rank() Over(Partition By GP.SemesterID Order By GP.GPA Desc) As Rank From GPA as GP
		Join Students as S ON GP.StudentID=S.StudentID Where S.Programme_ID=@Course_ID
	End

	--Logic to Rank Only Specified Course Students and Semester wise
	Else IF(@Course_ID IS NOT NULL And @Semester IS NOT NULL And @IsRankGrossGPA IS NULL)
	Begin
		Select S.StudentID,S.FullName,S.Programme_ID,GP.SemesterID,GP.GPA,
		Dense_Rank() Over(Partition By GP.SemesterID Order By GP.GPA Desc) As Rank From GPA as GP
		Join Students as S ON GP.StudentID=S.StudentID Where S.Programme_ID=@Course_ID And GP.SemesterID=@Semester
	End

	--Logic to Rank All Course Students and Specified Semester wise 
	Else IF(@Course_ID IS NULL And @Semester IS NOT NULL And @IsRankGrossGPA IS NULL)
	Begin
		Select S.StudentID,S.FullName,S.Programme_ID,GP.SemesterID,GP.GPA,
		Dense_Rank() Over(Partition By GP.SemesterID Order By GP.GPA Desc) As Rank From GPA as GP
		Join Students as S ON GP.StudentID=S.StudentID Where GP.SemesterID=@Semester
	End

	--Logic to Rank Specific Course Students based on Average GPA in there particular course/programme
	Else IF(@IsRankGrossGPA='y' AND @Course_ID IS NOT NULL And @Semester IS NULL)
	Begin 
		Select S.StudentID,S.FullName,S.Programme_ID,AVG(G.GPA) as AvgGPA,Dense_Rank() Over(Order By AVG(G.GPA) Desc) as Rank From GPA as G 
		Join Students as S ON G.StudentID=S.StudentID Where S.Programme_ID=@Course_ID Group By S.StudentID,S.FullName,S.Programme_ID 
	End

		--Logic to Rank All Course Students based on Average GPA in there particular course/programme
	Else IF(@IsRankGrossGPA='y' AND @Course_ID IS NULL And @Semester IS NULL)
	Begin
		Select S.StudentID,S.FullName,S.Programme_ID,AVG(G.GPA) as AvgGPA,Dense_Rank() Over(Order By AVG(G.GPA) Desc) as Rank 
		From GPA as G Join Students as S ON G.StudentID=S.StudentID Group By S.StudentID,S.FullName,S.Programme_ID
	End
End

--Executing Procedure

/*Case 1: Rank based on Course in all semester wise*/
Execute SP_GetRank 'BCA' 

/*Case 2: Rank based on specific Course and semeter wise*/
Execute SP_GetRank 'BCA',1

/*Case 3: Rank based on specific semeter for all courses of all students*/
Execute SP_GetRank Null,1

/*Case 4: Rank Specific Course Students based on Average GPA in there particular course/programme*/
Execute SP_GetRank 'BCA',Null,'y'

/*Case 5: Rank All Course Students based on Average GPA in there particular course/programme*/
Execute SP_GetRank Null,Null,'y'