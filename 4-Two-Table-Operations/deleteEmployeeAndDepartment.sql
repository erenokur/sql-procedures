USE ExampleDB;
GO

-- Delete data from the Employee table and the Department table
CREATE PROCEDURE DeleteEmployeeAndDepartment
    @EmployeeID INT,
    @DepartmentID INT
AS
BEGIN
    -- Suppress the "xx rows affected" message that SQL Server returns
    SET NOCOUNT ON
    BEGIN TRY
        BEGIN TRAN;

        -- Delete data from the Employee table
        DELETE FROM Employee
        WHERE EmployeeID = @EmployeeID;

        -- Delete data from the Department table
        DELETE FROM Department
        WHERE DepartmentID = @DepartmentID;

        COMMIT;
    END TRY
    BEGIN CATCH
	    ROLLBACK;
	    PRINT 'An error occurred while deleting data from data tables Employee and Departments. Message:' + ERROR_MESSAGE();
    END CATCH;
END;
GO
