/*
  Purpose:- Stored Procedure is used to create "Student 10 Digit Enrollment Number"
  ----------------------------------------------------------------------------------
  Name of Stored Procedure => SP_GetEnrollmentNo
  Required Parameters => Admission Date, Programme Name, Regional Center Code
  Returns => 10 Digit Enrollment Number
*/
Create OR  Alter Procedure SP_GetEnrollmentNo
@Admission_DT Date,
@Programme Varchar(10),
@RC_Name Varchar(20),
@NewEnrollNo Varchar(10) OUTPUT
AS
Begin

	--Logic to get last 2 digit of year
	IF(@Admission_DT IS NOT NULL)
	Begin
		Declare @YearCode varchar(2)
		SET @YearCode=Right(Cast(YEAR(@Admission_DT) AS varchar),2)
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
		
	--Logic to get Regional Center Code in 2 digit
	Declare @temp2 varchar(3)=(SELECT CAST(RC_Code as varchar) From Regional_Center Where Name=@RC_Name)
	IF(@temp2 IS NOT NULL)
	Begin
		Declare @RC_Code Varchar(2)
		SET @RC_Code=RIGHT('0'+@temp2,2)
	End
	ELSE
	Begin
		Raiserror('Regional Center Name is not exsist!',16,1)
	End

	--Logic to Merging Year Code, Program Code, and Regional Center Code (6 Digit Initial Code)
	Declare @Prefix varchar(6)
	SET @Prefix=@YearCode+@PC_Code+@RC_Code

	--Logic To Generate 10 Digit Enrollment Number
	DECLARE @LastSeq int
	SET @LastSeq=(SELECT ISNULL(Max(CAST(Right(Enrollment_No,4) AS int)),0) From Student Where Left(Enrollment_No,6)=@Prefix)+1
	SET @NewEnrollNo=(@Prefix+Right('0000'+Cast(@LastSeq AS Varchar),4))
End

--Executing Procedure
Declare @Enroll varchar(10)
Execute SP_GetEnrollmentNo '2025/08/26','BCA','Noida',@Enroll OUTPUT
Print @Enroll