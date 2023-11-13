USE ExampleDB;
GO

-- Insert data into the Employee table and the Department table
CREATE PROCEDURE InsertEmployeeAndDepartment
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

        -- Insert data into the Employee table
        INSERT INTO Employee (EmployeeID, FirstName, LastName, Department)
        VALUES (@EmployeeID, @FirstName, @LastName, @Department);

        -- Insert data into the Department table
        INSERT INTO Department (DepartmentID, DepartmentName)
        VALUES (@DepartmentID, @DepartmentName);

        COMMIT;
    END TRY
    BEGIN CATCH
		ROLLBACK;
        PRINT 'An error occurred while inserting data into data tables Employee and Departments. Message:' + ERROR_MESSAGE();
	END CATCH;
END;
GO
