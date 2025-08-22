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
	Contac_No varchar(100) Not Null,
	Email_Id varchar(50) Not Null,
	Status bit default 1
)

Select * From Regional_Center