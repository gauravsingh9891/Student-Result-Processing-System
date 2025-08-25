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
	Student_Id Varchar(10) Primary Key Check(Len(Student_ID)=9 OR Len(Student_ID)=10),
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