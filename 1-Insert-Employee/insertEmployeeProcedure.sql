USE ExampleDB;
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