/*
  Purpose:- Stored Procedure is used to create "Student 10 Digit Enrollment Number"
  ----------------------------------------------------------------------------------
  Name of Stored Procedure => SP_GetEnrollmentNo
  Required Parameters => Admission Date, Programme Name
  Returns => 10 Digit Enrollment Number
*/
Create OR  Alter Procedure SP_GetEnrollmentNo
@Admission_DT varchar(4),
@Programme Varchar(10),
@NewEnrollNo Varchar(10) OUTPUT
AS
Begin

	--Logic to get last 2 digit of year
	IF(@Admission_DT IS NOT NULL)
	Begin
		Declare @YearCode varchar(2)=Right(@Admission_DT,2)
	End
	Else
	Begin
		Raiserror('Admission Date is mandatory !',16,1)
	End

	--Logic to get Program Code in 2 digit
	Declare @temp1 varchar(3)=(SELECT CAST(Programme_Code as varchar) From Programme Where Programme_ID=@Programme)
	IF(@temp1 IS NOT NULL)
	Begin
		Declare @PC_Code varchar(2)
		SET @PC_Code=RIGHT('0'+@temp1,2)
	End
	Else
	Begin
		Raiserror('Programme is not exsist!',16,1)
	End

	--Logic to Merging Year Code, Program Code, and Regional Center Code (6 Digit Initial Code)
	Declare @Prefix varchar(4)
	SET @Prefix=@YearCode+@PC_Code

	--Logic To Generate 10 Digit Enrollment Number
	DECLARE @LastSeq int
	SET @LastSeq=Cast((SELECT ISNULL(Max(CAST(Right(StudentID,6) AS int)),0) From Students Where Left(StudentID,4)='2504') As int)
	SET @LastSeq=@LastSeq+1
	SET @NewEnrollNo=(@Prefix+Right('00000'+Cast(@LastSeq AS Varchar),6))
End

--Executing Procedure
Declare @Enroll varchar(10)
Execute SP_GetEnrollmentNo '2025','BCA',@Enroll OUTPUT
Print @Enroll