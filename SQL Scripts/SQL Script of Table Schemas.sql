--Creating Database with name CollegeDB
Create Database College

--Using Database
use CollegeDB

/* Regional_Center Entity */
Create Table Regional_Center
(
	RC_Code	int Primary key,
	Name Varchar(50) Not Null,
	Location Varchar(500) Not Null,
	Contact_No varchar(100) Not Null,
	Email_Id varchar(50) Not Null,
	Status bit default 1
)

Select * From Regional_Center


/*Programme Entity*/
Create Table Programme
(
Programme_ID Varchar(50) Primary Key,
Programme_Name varchar(100) not null,
Level varchar(50) not null,
Programme_Code int identity(1,1),
Duration varchar(30) not null,
Total_Semester int not null check(Total_Semester>0),
Medium varchar(30) not null,
Fee smallmoney check(Fee>=0),
Status bit default 1
)

Select * from Programme

/*Subject Entity*/
Create Table Subject
(
Subject_ID varchar(50) primary key,	
Subject_Name varchar(100) not null,	
Semester int not null check(Semester>0),
Programme_ID varchar(50) references Programme(Programme_ID),
Exam_Fee int default 250,
Status bit default 1
)

Select * From Subject

/* Department Entity*/
Create Table Department
(
Dept_ID varchar(20) Primary key,
Dept_Name varchar(100) not null,
Dean varchar(80) not null,
Contact_No varchar(100) not null,
Status bit default 1
)

Select * From Department

/* Faculty Entity*/
Create Table Faculty
(
 Faculty_ID VARCHAR(20) Primary Key,
 Name varchar(50) not null check(Len(Name)>3),
 Designation Varchar(60) not null,
 Dept_Id varchar(20) references Department(Dept_Id),
 Contact_No varchar(30) not null,
 Status bit default 1
)

Select * From Faculty


/* Student Entity */
Create Table Student
(
	Enrollment_No Varchar(10) Primary Key Check(Len(Enrollment_No)=9 OR Len(Enrollment_No)=10),
	Name Varchar(50) Not Null,
	DOB Date Not Null Check(DateDiff(YY,DOB,Format(Getdate(),'yyyy-MM-dd'))>15),
	Gender Char(1) Check(Gender IN ('M','F','T')),
	Email varchar(30),
	Phone varchar(14) Unique,
	Address varchar(300) Not Null,
	Programme_ID varchar(50) references Programme(Programme_ID),
	DOA Date default Getdate(),
	Status bit default 1
)

Select * From Student

/*Exam Entity*/
Create Table Exam
(
 Exam_ID Varchar(17) Primary Key,
 Exam_Type Varchar(10) Check(Exam_Type IN ('Term-End','Assignment','Practical')),
 Date date not null,
 Semester Numeric(1) Check(Semester>0 AND Semester<=6),
 Session Varchar(8) not null CHECK(Session IN ('June','DECEMBER')),
 Programme_ID varchar(50) references Programme(Programme_ID)
)

Select * From Exam

/* Assignment Entity */
Create Table Assignment
(
Assignment_ID Varchar(35) Primary Key,
Subject_ID varchar(50) references Subject(Subject_ID),
Assignment_Type Varchar(10) CHECK(Assignment_Type IN ('Assignment', 'Project')),
LastSubmission_Date Date Not Null,
Max_Marks Tinyint Check(Max_Marks IN (50,100))
)

Select * From Assignment

/* Assignment_Result Entity */
Create Table Assignment_Result
(
 Assignment_ID Varchar(35) references Assignment(Assignment_ID),
 Enrollment_No Varchar(10) references Student(Enrollment_No),
 Faculty_ID VARCHAR(20) references Faculty(Faculty_ID),
 Marks_Obtained Tinyint Not Null Check(Marks_Obtained<=100),
 Submission_Date Date Not Null
)

Select * From Assignment_Result

/* Payment Entity */
Create Table Payment
(
Payment_ID Varchar(23) Primary Key,
AccHolder_Name Varchar(50) Not Null,
Amount Smallmoney Not Null Check(Amount>0),
P_Mode Varchar(30) Not Null,
P_DateTime DateTime default Getdate(),
P_Status Varchar(20) Check(P_Status IN ('Pending','Paid','Cancelled'))
)

Select * From Payment

/*Exam_Registration Entity*/
Create Table Exam_Registration
(
 ExamReg_ID Varchar(35) Primary Key,
 Enrollment_No Varchar(10) references Student(Enrollment_No),
 Exam_ID Varchar(17) references Exam(Exam_ID),
 Subject_ID varchar(50) references Subject(Subject_ID),
 Payment_ID Varchar(23) references Payment(Payment_ID),
)

Select * From Exam_Registration

/* Registration Entity */
Create Table Registration
(
 Reg_ID Varchar(43) Primary Key,
 Enrollment_No Varchar(10) references Student(Enrollment_No),
 Programme_ID varchar(50) references Programme(Programme_ID),
 DOR Date Default Getdate(),
 Semester Numeric(1) Not Null Check(Semester>0 And Semester<=6),
 Payment_ID Varchar(23) references Payment(Payment_ID),
)

Select * From Registration


--Creating Sequenc for Grade_Id
CREATE Sequence Grade_Seq
Start with 1
Increment By 1
MAXVALUE 6
MINVALUE 1
CYCLE

/* Grading_System Entity */
Create Table Grading_System
(
Grade_ID Varchar(4) Primary Key Default 'GD-'+Cast((Next Value For Grade_Seq) AS Varchar),
Grade Char(1) Check(Grade Between 'A' And 'F') Not Null,
Description Varchar(15) Not Null,
Min_Marks Tinyint Not Null CHECK(Min_Marks>=0),
Max_Marks Tinyint Not Null CHECK(Max_Marks>0)
)

Select * From Grading_System

/* Result Entity */
Create Table Result
(
Result_ID Varchar(31) Primary Key,
Enrollment_No Varchar(10) references Student(Enrollment_No),
Exam_ID Varchar(17) references Exam(Exam_ID),
Subject_ID varchar(50) references Subject(Subject_ID),
Faculty_ID VARCHAR(20) references Faculty(Faculty_ID),
Marks tinyint Check(Marks>0),
Grade char(1) Check( Grade Between 'A' And 'F') Not Null
)

Select * From Result