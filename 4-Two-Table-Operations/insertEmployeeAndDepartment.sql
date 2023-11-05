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
    BEGIN TRAN;

    -- Insert data into the Employee table
    INSERT INTO Employee (EmployeeID, FirstName, LastName, Department)
    VALUES (@EmployeeID, @FirstName, @LastName, @Department);

    -- Insert data into the Department table
    INSERT INTO Department (DepartmentID, DepartmentName)
    VALUES (@DepartmentID, @DepartmentName);

    COMMIT;
END;
GO
