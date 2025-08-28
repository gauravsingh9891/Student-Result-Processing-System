/*
	Purpose :- This Stored Procedure is used to insert the Student Data in Students Table
	Required Parameter :- Course Name, Student Name, Date of Birth,Gender, Contact Number,Email ID, Enrollment Year
	Output:- Confirmation of Registration along with Student ID
*/
Create OR Alter Procedure SP_InsertStudent
@Course_Name Varchar(50),
@Student_Name Varchar(100),
@DOB Date,
@Gender Char(1),
@Contact_No Varchar(13),
@Email_ID Varchar(30)=Null,
@EnrollmentYear varchar(4)
As
Begin
	Declare @SID Varchar(10)
	Exec SP_GetEnrollmentNo @EnrollmentYear,@Course_Name,@SID OUTPUT
	Begin Try
	Begin Transaction
		Insert Into Students(StudentID,FullName,DOB,Gender,Contact_No,Email_ID,EnrollmentYear,Programme_ID) 
		Values(@SID,@Student_Name,@DOB,@Gender,@Contact_No,@Email_ID,@EnrollmentYear,@Course_Name)
	Commit Transaction
		Print 'You have successfully enrolled for the course, and your Student Id is : '+@SID
	End Try
	Begin Catch
		Print Error_Message()
	End Catch
End

Exec SP_InsertStudent 'BCA','Zeel','1996/03/26','F','7528697512','Shah.Zeel@gmail.com','2025'