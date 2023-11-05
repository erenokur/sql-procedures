USE ExampleDB;
GO

-- Create a stored procedure to update an employee's information
CREATE PROCEDURE UpdateEmployee
    @EmployeeID INT,
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Department NVARCHAR(50)
AS
BEGIN
    UPDATE Employee
    SET FirstName = @FirstName,
        LastName = @LastName,
        Department = @Department
    WHERE EmployeeID = @EmployeeID;
END;
GO