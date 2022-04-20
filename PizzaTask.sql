CREATE DATABASE PizzaDB

USE PizzaDB

CREATE TABLE Pizzas
(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(20),
	Image NVARCHAR(20)
)

INSERT INTO Pizzas
VALUES
('Pizza1', 'Image1'),
('Pizza2', 'Image2'),
('Pizza3', 'Image3'),
('Pizza4', 'Image4')

CREATE TABLE Sizes
(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(20)
)

INSERT INTO Sizes
VALUES
('Small'),
('Medium'),
('Large')

CREATE TABLE PizzasSizes
(
	Id INT PRIMARY KEY IDENTITY,
	Price MONEY,
	PizzaId INT,
	SizeId INT
)

INSERT INTO PizzasSizes
VALUES
(12, 1, 3),
(14, 2, 1),
(16, 3, 3),
(18, 4, 2)

CREATE TABLE Ingridients
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(20)
)

INSERT INTO Ingridients
VALUES
('Tomato'),
('Cheese'),
('Onion'),
('Pepperoni'),
('Ananas')


CREATE TABLE PizzasIngridients
(
	Id INT PRIMARY KEY IDENTITY,
	PizzaId INT,
	IngridientId INT
)

INSERT INTO PizzasIngridients
VALUES
(1,1),
(1,2),
(1,3),
(2,4),
(2,5),
(2,3),
(3,1),
(3,2),
(3,3),
(4,4),
(4,5),
(4,3)

CREATE TABLE Sliders
(
	Id INT PRIMARY KEY IDENTITY,
	[Image] NVARCHAR(20)
)

INSERT INTO Sliders
VALUES
('Slider1'),
('Slider2'),
('Slider3')

CREATE TABLE DeletedSliders
(
	Id INT PRIMARY KEY IDENTITY,
	[Image] NVARCHAR(20),
	SliderId INT
)

DROP TABLE DeletedSliders

ALTER TRIGGER t_deleteOp
ON Sliders
AFTER DELETE
AS
BEGIN
INSERT INTO DeletedSliders(SliderId, [Image]) SELECT Id, Image FROM deleted
END

DELETE FROM Sliders WHERE Id=2

SELECT * FROM DeletedSliders

ALTER VIEW vw_showSliders
AS
SELECT Sliders.Image AS 'Exist'FROM Sliders
UNION ALL
SELECT DeletedSliders.Image AS 'Deleted' FROM DeletedSliders

SELECT * FROM vw_showSliders