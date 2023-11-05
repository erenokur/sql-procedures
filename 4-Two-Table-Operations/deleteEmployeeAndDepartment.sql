USE ExampleDB;
GO

-- Delete data from the Employee table and the Department table
CREATE PROCEDURE DeleteEmployeeAndDepartment
    @EmployeeID INT,
    @DepartmentID INT
AS
BEGIN
    BEGIN TRAN;

    -- Delete data from the Employee table
    DELETE FROM Employee
    WHERE EmployeeID = @EmployeeID;

    -- Delete data from the Department table
    DELETE FROM Department
    WHERE DepartmentID = @DepartmentID;

    COMMIT;
END;
GO
