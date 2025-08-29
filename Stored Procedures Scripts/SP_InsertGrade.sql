/* For Checking Table Data*/
Select * From Students
Select * From Subject Where Programme_ID='MCA' And SemesterID=5
Select * From Grades

/*
	Purpose :- This Stored procedure is used to insert the record of Student as per student id in Grades Table 
	Parameter Required:- Student ID, Subject ID, Marks Obtained
*/
Create OR Alter procedure SP_InsertGrade
@StudentID varchar(10),
@Subject_ID varchar(50),
@MarksObtained decimal(5,2)
As
Begin
	Declare @Grade Char(2), @GradePoint Decimal(3,1) 
	Declare @SID Varchar(10)=(Select StudentID From Students Where StudentID=@StudentID)
	IF (@SID IS NOT NULL)
	Begin

		--Declaring the variables to checking the Course entered for a program is valid or not
		Declare @Stud_Prog Varchar(10)=(Select Programme_ID From Students Where StudentID=@StudentID)
		Declare @Entered_CourseProg Varchar(10)=(Select Programme_ID From Subject Where Subject_ID=@Subject_ID)
		
		--If Valid Course then recording will inserted
		IF(@Stud_Prog=@Entered_CourseProg)
		Begin
			Begin Try
				--Grade Calculation Logic
				IF @MarksObtained>=90.0
				Begin
					SET @Grade='A+'
					SET @GradePoint=10.0
				End
				Else IF @MarksObtained>=80
				Begin
					SET @Grade='A'
					SET @GradePoint=9.0
				End
				Else IF @MarksObtained>=70
				Begin
					SET @Grade='B+'
					SET @GradePoint=8.0
				End
				Else IF @MarksObtained>=60
				Begin
					SET @Grade='B'
					SET @GradePoint=7.0
				End
				Else IF @MarksObtained>=50
				Begin
					SET @Grade='C'
					SET @GradePoint=6.0
				End
				Else IF @MarksObtained>=40
				Begin
					SET @Grade='D'
					SET @GradePoint=5.0
				End
				Else
				Begin
					SET @Grade='F'
					SET @GradePoint=0.0
				End

				--Insert Data into Grades Table
				Begin Transaction
					INSERT INTO Grades(StudentID,Subject_ID,MarksObtained,Grade,GradePoint)
					Values(@StudentID,@Subject_ID,@MarksObtained,@Grade,@GradePoint)
				Declare @GradeID Varchar(6)=(Select Max(GradeId) From Grades)
				Print 'Grade has been recorded, and Grade ID is : '+@GradeID
				commit
			End Try
			Begin Catch
			    Rollback
				Print ERROR_MESSAGE()
			End Catch
		End
		Else
		Begin
			Declare @Msg varchar(200)='Subject Id is not exsist for '+@Stud_Prog+' Course'
			Raiserror(@Msg,17,1)
		End
	End
	Else
		Raiserror('Student ID is not exsist!',17,1)
End 

--Executing Stored Procedure

/* For BCA Course */
--Semester 1
Execute SP_InsertGrade '2504000001','BCS-011',95
Execute SP_InsertGrade '2504000001','BCS-012',75
Execute SP_InsertGrade '2504000001','BCSL-013',90
Execute SP_InsertGrade '2504000001','ECO-01',85
Execute SP_InsertGrade '2504000001','FEG-02',68

--Semester 2
Execute SP_InsertGrade '2504000001','BCSL-021',88
Execute SP_InsertGrade '2504000001','BCSL-022',78
Execute SP_InsertGrade '2504000001','ECO-02',65
Execute SP_InsertGrade '2504000001','MCS-011',73
Execute SP_InsertGrade '2504000001','MCS-012',86
Execute SP_InsertGrade '2504000001','MCS-013',72
Execute SP_InsertGrade '2504000001','MCS-015',96

--Semester 3
Execute SP_InsertGrade '2504000001','BCS-031',82
Execute SP_InsertGrade '2504000001','BCSL-032',79
Execute SP_InsertGrade '2504000001','BCSL-033',62
Execute SP_InsertGrade '2504000001','BCSL-034',73
Execute SP_InsertGrade '2504000001','MCS-014',75
Execute SP_InsertGrade '2504000001','MCS-021',66
Execute SP_InsertGrade '2504000001','MCS-023',88

--Semester 4
Execute SP_InsertGrade '2504000001','BEGAE-182',82  --Invalid Course for BCA

Execute SP_InsertGrade '2504000001','BCS-040',80
Execute SP_InsertGrade '2504000001','BCS-041',63
Execute SP_InsertGrade '2504000001','BCS-042',55
Execute SP_InsertGrade '2504000001','BCSL-043',100
Execute SP_InsertGrade '2504000001','BCSL-044',75
Execute SP_InsertGrade '2504000001','BCSL-045',83
Execute SP_InsertGrade '2504000001','MCS-024',47
Execute SP_InsertGrade '2504000001','MCSL-016',98

----Semester 5
Execute SP_InsertGrade '2504000001','BCS-051',77
Execute SP_InsertGrade '2504000001','BCS-052',84
Execute SP_InsertGrade '2504000001','BCS-053',85
Execute SP_InsertGrade '2504000001','BCS-054',94
Execute SP_InsertGrade '2504000001','BCS-055',75
Execute SP_InsertGrade '2504000001','BCSL-056',79
Execute SP_InsertGrade '2504000001','BCSL-057',87

--Semester 6
Execute SP_InsertGrade '2504000001','BCS-061',97


/*For MCA Course*/
--Semester 1
Execute SP_InsertGrade '2512000001','MCS-211',74
Execute SP_InsertGrade '2512000001','MCS-212',85
Execute SP_InsertGrade '2512000001','MCS-213',56
Execute SP_InsertGrade '2512000001','MCS-214',77
Execute SP_InsertGrade '2512000001','MCS-215',70
Execute SP_InsertGrade '2512000001','MCSL-216',83
Execute SP_InsertGrade '2512000001','MCSL-217',90

--Semester 2
Execute SP_InsertGrade '2512000001','MCS-218',45
Execute SP_InsertGrade '2512000001','MCS-219',53
Execute SP_InsertGrade '2512000001','MCS-220',74
Execute SP_InsertGrade '2512000001','MCS-221',66
Execute SP_InsertGrade '2512000001','MCSL-222',62
Execute SP_InsertGrade '2512000001','MCSL-223',74

--Semester 3
Execute SP_InsertGrade '2512000001','MCS-224',82
Execute SP_InsertGrade '2512000001','MCS-225',81
Execute SP_InsertGrade '2512000001','MCS-226',83
Execute SP_InsertGrade '2512000001','MCS-227',85
Execute SP_InsertGrade '2512000001','MCSL-228',87
Execute SP_InsertGrade '2512000001','MCSL-229',80

--Semester 4
Execute SP_InsertGrade '2512000001','MCS-230',70
Execute SP_InsertGrade '2512000001','MCS-231',71
Execute SP_InsertGrade '2512000001','MCSP-232',74


