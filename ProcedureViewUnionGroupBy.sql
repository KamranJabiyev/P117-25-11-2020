SELECT COUNT(Name) FROM Students

SELECT DISTINCT Name FROM Students

SELECT COUNT(DISTINCT Name) FROM Students

SELECT Name,COUNT(Name) FROM Students
GROUP BY Name
HAVING COUNT(Name)>1

CREATE TABLE OldStudents(
	Id int primary key identity,
	Name nvarchar(100) not null,
	Surname nvarchar(100)
)

SELECT Name,Surname FROM Students
UNION
SELECT Name,Surname FROM OldStudents

SELECT Name,Surname FROM Students
UNION ALL
SELECT Name,Surname FROM OldStudents

SELECT Name,Surname FROM Students
EXCEPT
SELECT Name,Surname FROM OldStudents

SELECT Name,Surname FROM OldStudents
EXCEPT
SELECT Name,Surname FROM Students

SELECT Name,Surname FROM Students
INTERSECT
SELECT Name,Surname FROM OldStudents


CREATE VIEW usv_GetStudentDetails
AS
SELECT s.Name,Surname,Email,g.Name 'Group',gt.Name 'Type',Mark,Letter FROM Students s

JOIN GroupStudents gs
ON
s.Id=gs.StudentId

JOIN Groups g
ON
gs.GroupId=g.Id

JOIN GroupTypes gt
ON
g.GroupTypesId=gt.Id

JOIN Grades gr
ON
s.Mark BETWEEN gr.MinGrade AND gr.MaxGrade

SELECT Name,Surname,Mark,Letter FROM usv_GetStudentDetails

CREATE PROCEDURE usp_GetStudentWithMark @Mark int
AS
SELECT * FROM Students
WHERE Mark>@Mark

exec usp_GetStudentWithMark 70

exec usp_GetStudentWithMark 80


CREATE PROCEDURE usp_GetStuWithMarkGroup @Mark int,@Group nvarchar(10)
AS
SELECT * FROM usv_GetStudentDetails
WHERE Mark>@Mark AND [Group]=@Group

EXEC usp_GetStuWithMarkGroup 60,'P117'

EXEC usp_GetStuWithMarkGroup @Group='M300',@Mark=60

CREATE PROCEDURE usp_GetStuWithMarkGroupDefault @Mark int=50,@Group nvarchar(10)
AS
SELECT * FROM usv_GetStudentDetails
WHERE Mark>@Mark AND [Group]=@Group

exec usp_GetStuWithMarkGroupDefault @Group='P117'



