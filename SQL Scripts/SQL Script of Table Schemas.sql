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
Duration varchar(30) not null,
Total_Semester int not null check(Total_Semester>0),
Medium varchar(30) not null,
Fee smallmoney check(Fee>=0),
Status bit default 1
)

Select * from Programme

