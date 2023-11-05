USE ExampleDB;
GO

-- Remove all triggers
DECLARE @ProcedureName NVARCHAR(128);
DECLARE procedure_cursor CURSOR FOR
SELECT name
FROM sys.procedures;

OPEN procedure_cursor;

FETCH NEXT FROM procedure_cursor INTO @ProcedureName;

WHILE @@FETCH_STATUS = 0
BEGIN
    DECLARE @DropProcedureSQL NVARCHAR(MAX);
    SET @DropProcedureSQL = 'DROP PROCEDURE ' + QUOTENAME(@ProcedureName);
    EXEC sp_executesql @DropProcedureSQL;
    FETCH NEXT FROM procedure_cursor INTO @ProcedureName;
END;

CLOSE procedure_cursor;
DEALLOCATE procedure_cursor;
GO

-- Delete all table data and reset identity values
EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'
EXEC sp_MSforeachtable 'DELETE FROM ?'
EXEC sp_MSforeachtable 'ALTER TABLE ? CHECK CONSTRAINT ALL'