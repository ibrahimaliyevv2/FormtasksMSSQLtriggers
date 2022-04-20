CREATE DATABASE Academy

USE Academy

CREATE TABLE Groups
(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(20) UNIQUE
)

CREATE TABLE Students
(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(20),
	Surname NVARCHAR(20),
	GroupId INT FOREIGN KEY REFERENCES Groups(Id)
)


ALTER TABLE Students 
ADD Grade INT

INSERT INTO Groups
VALUES
('BP202'),
('BP201')

INSERT INTO Students
VALUES
('Fariz', 'Hesenov', 1),
('Asif', 'Ellezov', 2),
('Huseyn', 'Alizadeh', 2),
('Revan', 'Memmedov', 2)

SELECT * FROM Students WHERE GroupId=1

CREATE VIEW vw_showstudents
AS
SELECT Students.Name, Students.Surname, Students.Grade, (SELECT Groups.Name AS 'GroupName' FROM Groups WHERE Groups.Id = Students.GroupId) FROM Students


SELECT Groups.Name, (SELECT COUNT(Students.Id) FROM Students WHERE Students.GroupId = Groups.Id) FROM Groups

CREATE PROCEDURE usp_showhigher
@grade INT
AS
SELECT Students.Name + ' ' + Students.Surname AS 'Student FullName', Students.Grade, 
(SELECT Groups.Name AS 'GroupName' FROM Groups WHERE Groups.Id = Students.GroupId) FROM Students WHERE (SELECT Students.Grade FROM Students)>@grade

CREATE FUNCTION FilterStudentCount(@gradeCou INT)
RETURNS INT
AS
BEGIN
	DECLARE @gradeCou INT
	SELECT @gradeCou = COUNT(*) FROM Students WHERE Grade > @grade
	RETURN @gradeCou
END


SELECT dbo.FilterStudentCount(15)

