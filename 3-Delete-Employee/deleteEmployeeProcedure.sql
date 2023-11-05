USE ExampleDB;
GO

-- Create a stored procedure to delete an employee by EmployeeID
CREATE PROCEDURE DeleteEmployee
    @EmployeeID INT
AS
BEGIN
    DELETE FROM Employee
    WHERE EmployeeID = @EmployeeID;
END;
GO