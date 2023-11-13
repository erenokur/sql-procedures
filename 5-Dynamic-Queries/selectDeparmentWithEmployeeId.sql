USE ExampleDB;
GO

CREATE PROCEDURE dbo.SelectDeparmentWithEmployeeId
    @EmployeeID INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @DynamicSQL NVARCHAR(MAX);

    SET @DynamicSQL = '
        SELECT D.DepartmentName
        FROM Employee E
        JOIN Department D ON E.Department = D.DepartmentID
        WHERE E.EmployeeID = @EmployeeID
    ';

    -- Execute dynamic SQL
    EXEC sp_executesql @DynamicSQL;
END;
