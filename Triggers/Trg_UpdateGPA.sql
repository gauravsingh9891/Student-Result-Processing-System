/*
	Purpose of Trg_UpdateGPA Trigger :- When you insert the Student Marks based on Student Id and Subjects of Course 
	                                    in which he/she enrolled by using SP_InsertGrade Stored Procedure then this 
										trigger will automatically calculate GPA and also auto update the GPA when new 
										subject marks enter or updated based on Semester and Student ID wise and insert
										or update the GPA in GPA Table
*/
Create OR Alter Trigger Trg_UpdateGPA
ON Grades
AFTER Insert,Update,delete
As
Begin
	SET NOCOUNT ON;
	Merge GPA As Target Using (
		Select G.StudentID,S.SemesterID,Round(SUM(G.GradePoint*S.Credits)/Sum(S.Credits),2) AS GPA
		From Grades as G join Subject as S ON G.Subject_ID=S.Subject_ID Group By G.StudentID,S.SemesterID
	) As Source ON Target.StudentID=Source.StudentID AND Target.SemesterID=Source.SemesterID
	When Matched Then
		Update SET GPA=Source.GPA
	When Not Matched Then
		Insert(StudentID,SemesterID,GPA) Values(Source.StudentID,Source.SemesterID,Source.GPA);
End;