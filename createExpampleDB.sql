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

-- Create a stored procedure to insert data into the Employee table
CREATE PROCEDURE InsertEmployee
    @EmployeeID INT,
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Department NVARCHAR(50)
AS
BEGIN
    INSERT INTO Employee (EmployeeID, FirstName, LastName, Department)
    VALUES (@EmployeeID, @FirstName, @LastName, @Department);
END;
GO
