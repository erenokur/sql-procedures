-- Create a new database (if it doesn't already exist)
CREATE DATABASE ExampleDB;
GO

-- Use the newly created database
USE ExampleDB;
GO

-- Create a new table named "Employee"
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Department NVARCHAR(50)
);
GO

-- Create a new table named "Department"
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName NVARCHAR(50)
);
GO


