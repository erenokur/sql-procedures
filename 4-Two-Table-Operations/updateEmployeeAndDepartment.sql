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
    -- Suppress the "xx rows affected" message that SQL Server returns
    SET NOCOUNT ON
    BEGIN TRY
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
    END TRY
    BEGIN CATCH
		ROLLBACK;
        PRINT 'An error occurred while updating data tables Employee and Departments. Message: ' + ERROR_MESSAGE();
	END CATCH;
END;
GO