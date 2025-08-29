--Creating database
Create database College_DB

--Using database
Use College_DB

-- Students Table
CREATE TABLE Students (
    StudentID Varchar(10) PRIMARY KEY,
    FullName Varchar(100) Not Null Check(Len(FullName)>=3),
	DOB Date Not Null Check(Datediff(YY,DOB,Getdate())>15),
	Gender Char(1) Not Null Check(Gender IN ('M','F','T')),
	Contact_No Varchar(13) Not Null Check(Len(Contact_No)>=10 And Len(Contact_No)<=13),
	Email_ID Varchar(30),
    EnrollmentYear varchar(4) Default Cast(Year(Getdate()) As Varchar),
	Programme_ID Varchar(50) references Programme(Programme_ID),
	Status bit Default 1
);


Select * From Students

--Programme Entity
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

Select * From Programme

-- Semesters Table
CREATE TABLE Semesters (
    SemesterID INT PRIMARY KEY,
    SemesterName VARCHAR(50)
);

--Insert Command
INSERT INTO Semesters VALUES (1, 'Semester 1'), (2, 'Semester 2'),(3, 'Semester 1'), (4, 'Semester 2'),(5, 'Semester 1'), (6, 'Semester 2');

Select * From Semesters

/*Subject Entity*/
Create Table Subject
(
Subject_ID varchar(50) primary key,	
Subject_Name varchar(100) not null,	
SemesterID INT references Semesters(SemesterID),
Credits int Not Null,
Programme_ID varchar(50) references Programme(Programme_ID),
Status bit default 1
)

--Creating Sequence for Auto-generated Grade ID
Select * From Subject
Create Sequence Grade_Seq
Start With 1
Increment By 1
Maxvalue 999999
Minvalue 1
Cycle

-- Grades Table
CREATE TABLE Grades (
    GradeID Varchar(6) PRIMARY KEY Default 'GD-'+Right('0'+Cast((Next Value for Grade_Seq) as Varchar),2),
    StudentID Varchar(10) REFERENCES Students(StudentID),
    Subject_ID varchar(50) REFERENCES Subject(Subject_ID),
    MarksObtained DECIMAL(5,2),
    Grade CHAR(2),
    GradePoint DECIMAL(3,1)
);

-- GPA Table
CREATE TABLE GPA (
    StudentID Varchar(10) REFERENCES Students(StudentID),
    SemesterID INT references Semesters(SemesterID),
    GPA DECIMAL(4,2),
    PRIMARY KEY (StudentID, SemesterID)
);
