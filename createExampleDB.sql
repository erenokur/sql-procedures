-- Create a new database (if it doesn't already exist) if it doesn't already exist
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'ExampleDB')
BEGIN
    CREATE DATABASE ExampleDB;
END
GO

-- Use the newly created database
USE ExampleDB;
GO

-- Create a new table named "Employee" if it doesn't already exist
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Employee')
BEGIN
    CREATE TABLE Employee (
        EmployeeID INT PRIMARY KEY,
        FirstName NVARCHAR(10),
        LastName NVARCHAR(10),
        Department INT
    );
END
GO

-- Create a new table named "Department" if it doesn't already exist
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Employee')
BEGIN
    CREATE TABLE Department (
        DepartmentID INT PRIMARY KEY,
        DepartmentName NVARCHAR(10)
    );
END
GO


