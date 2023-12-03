USE ExampleDB;
GO

-- EXEC dbo.CountAttendance;
CREATE PROCEDURE dbo.CountAttendance
	@StartDate DATE,
	@EndDate DATE
AS
BEGIN
	DECLARE @WorkDaysCount INT;

	WITH CTE AS (
	  SELECT @StartDate AS WorkDate
	  UNION ALL
	  SELECT DATEADD(DAY, 1, WorkDate)
	  FROM CTE
	  WHERE DATEADD(DAY, 1, WorkDate) <= @EndDate
	)
	SELECT @WorkDaysCount = COUNT(*) 
	FROM CTE
	WHERE DATEPART(WEEKDAY, WorkDate) NOT IN (1, 7) 
	  AND WorkDate NOT IN (
		SELECT HolidayDate
		FROM HolidayTable
		WHERE HolidayDate BETWEEN @StartDate AND @EndDate
	  );

	SELECT 
		EmployeeID,
		E.FirstName,
		E.LastName,
		D.DepartmentName,
		COUNT(DISTINCT CAST(A.AttendanceDateTime AS DATE)) AS DaysPresent,
		@WorkDaysCount AS TotalDays
	FROM Attendance AS A
	JOIN Employee as E ON A.EmployeeID = E.EmployeeID
	JOIN Department AS D ON E.DepartmentID = D.DepartmentID
	WHERE AttendanceDateTime >= @StartDate AND AttendanceDateTime <= @EndDate
	AND DATEPART(WEEKDAY, AttendanceDateTime) NOT IN (1, 7) -- Exclude weekends
	AND date_column NOT IN (SELECT holiday_date FROM holidays_table) -- Exclude holidays
	GROUP BY employee_name, E.FirstName, E.LastName, D.DepartmentName, TotalDays;
	
END;