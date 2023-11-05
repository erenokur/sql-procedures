USE ExampleDB;
GO

-- Delete a department and all employees in that department
CREATE PROCEDURE DeleteDepartmentAndEmployees
    @DepartmentID INT
AS
BEGIN
    BEGIN TRAN;

    -- Delete all employees in the specified department
    DELETE FROM Employee
    WHERE Department = (SELECT DepartmentName FROM Department WHERE DepartmentID = @DepartmentID);

    -- Delete the department
    DELETE FROM Department
    WHERE DepartmentID = @DepartmentID;

    COMMIT;
END;
GO
