USE master
IF EXISTS (SELECT * FROM sys.databases WHERE NAME = 'Autorepairshop')
BEGIN
DROP DATABASE Autorepairshop
END
GO
CREATE DATABASE Autorepairshop
GO
USE Autorepairshop
SET DATEFORMAT dmy;

-- --------------------------------------------------------

CREATE TABLE Customers (
  customerID INT IDENTITY (1,1) PRIMARY KEY,
  firstName VARCHAR(255) NOT NULL,
  lastName VARCHAR(255) NOT NULL,
  homeAddress VARCHAR(255) NOT NULL,
  tlf INT NOT NULL,
  creationDate DATE default getdate()
)

CREATE TABLE Cars (
  numberplate VARCHAR(255) PRIMARY KEY,
  brand VARCHAR(255) NOT NULL,
  model VARCHAR(255) NOT NULL,
  serialNr VARCHAR(255) NOT NULL,  
  customerID INT FOREIGN KEY REFERENCES Customers(customerID) NOT NULL,
  firstSeen date default getdate()
)

CREATE TABLE CarServicings (
  visitNr INT IDENTITY(1,1) PRIMARY KEY,
  arrival DATE default getdate(),
  numberplate VARCHAR(255) FOREIGN KEY REFERENCES Cars(numberplate) NOT NULL,
  price MONEY NOT NULL,
  issueDescription text NOT NULL,
  mechanicsNotes text
)
GO

-- --------------------------------------------------------
INSERT INTO Customers(firstName,lastName,homeAddress,tlf) VALUES('hans','sørensen','testvej 28',25863259),('Gerda', 'Hansen','testvej 29',28394056),('Gerda', 'Mortensen','testvej 30',72749586),('hans','sørensen','testvej 28',25863259),('Gerda', 'Hansen','testvej 29',28394056),('Po', 'Mortensen','testvej 30',72749586)
INSERT INTO Cars(numberplate,brand,model,serialNr,customerID) VALUES('AX 12 345','Suzuki','Balingo','g84kg8s8tla54fig2',1),('AZ 12 345','Lamborghini','Muchielago','g84kg8s8tla54fig2',1),('BZ 12 345','Suzuki','Balingo','g84kg8s8tla54fig2',1),('BX 12 345','Lamborghini','Muchielago','g84kg8s8tla54fig2',1)
INSERT INTO CarServicings(numberplate,price,issueDescription,mechanicsNotes) VALUES('AX 12 345',200.32,'der er et kæmpe problem hjælp mig','glem det den skal skrottes'),('AZ 12 345',200.32,'der er et kæmpe problem hjælp mig','glem det den skal skrottes')
GO

-- --------------------------------------------------------

if SUSER_ID('nimdA') is null--kontrollere om kontoen allerede eksistere og hvis den ikke gør laver vi den og en bruger til den med det samme
begin
create login nimdA-- laver selve login kontoen men du kan ikke logge ind med den alene da du også skal bruge en bruger
with password = 'Changeme123';--koden til login kontoen
create user nimdA for login nimdA;--fortæller programmet den skal lave en ny bruger til login kontoen
end
GO

select * from Customers
select * from Cars
select * from CarServicings