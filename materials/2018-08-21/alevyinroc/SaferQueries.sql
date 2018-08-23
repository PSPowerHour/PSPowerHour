USE [master];
DROP DATABASE IF EXISTS PowerHappyHour;
GO
CREATE DATABASE [PowerHappyHour];
GO
USE [PowerHappyHour];
CREATE TABLE Establishments
([LocId]        INT IDENTITY(1, 1),
 [FunctionUsed] NVARCHAR(50) NOT NULL,
 [Name]         NVARCHAR(100) NOT NULL,
 CONSTRAINT PK_Establishments PRIMARY KEY CLUSTERED(LocId)
);

select * from PowerHappyHour.dbo.Establishments