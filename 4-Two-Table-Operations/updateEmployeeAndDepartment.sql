USE ExampleDB;
GO

-- Update data in the Employee table and the Department table
CREATE PROCEDURE UpdateEmployeeAndDepartment
    @EmployeeID INT,
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Department NVARCHAR(50),
    @DepartmentID INT,
    @DepartmentName NVARCHAR(50)
AS
BEGIN
    BEGIN TRAN;

    -- Update data in the Employee table
    UPDATE Employee
    SET FirstName = @FirstName,
        LastName = @LastName,
        Department = @Department
    WHERE EmployeeID = @EmployeeID;

    -- Update data in the Department table
    UPDATE Department
    SET DepartmentName = @DepartmentName
    WHERE DepartmentID = @DepartmentID;

    COMMIT;
END;
GO