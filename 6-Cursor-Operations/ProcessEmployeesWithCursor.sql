USE ExampleDB;
GO

-- EXEC dbo.ProcessEmployeesWithCursor;
CREATE PROCEDURE dbo.ProcessEmployeesWithCursor
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRAN;

        DECLARE @EmployeeId INT;

        DECLARE EmployeeCursor CURSOR FOR
        SELECT EmployeeID FROM Employee;

        OPEN EmployeeCursor;

        FETCH NEXT FROM EmployeeCursor INTO @EmployeeId;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Process each employee (perform operations)
            -- For example, you can print the employee information
            PRINT 'Processing EmployeeID: ' + CAST(@EmployeeId AS NVARCHAR(10));

            -- Perform additional operations here

            FETCH NEXT FROM EmployeeCursor INTO @EmployeeId;
        END

        CLOSE EmployeeCursor;
        DEALLOCATE EmployeeCursor;

        COMMIT; -- Commit the transaction if everything is successful
    END TRY
    BEGIN CATCH
        -- An error occurred, roll back the transaction
        IF @@TRANCOUNT > 0
            ROLLBACK;

        PRINT 'An error occurred during ProcessEmployeesWithCursor operation. Message:' + ERROR_MESSAGE();
    END CATCH;
END;

