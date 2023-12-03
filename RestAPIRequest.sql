-- Enable Ole Automation Procedures
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'Ole Automation Procedures', 1;
RECONFIGURE;

DECLARE @url NVARCHAR(1000) = 'https://turkey-public-holidays1.p.rapidapi.com';
DECLARE @response NVARCHAR(MAX);

-- Use sp_OACreate, sp_OAMethod, and sp_OAGetProperty to make HTTP request
DECLARE @httpRequest INT;
DECLARE @status INT;

EXEC sp_OACreate 'MSXML2.ServerXMLHTTP', @httpRequest OUT;

EXEC sp_OAMethod @httpRequest, 'open', NULL, 'GET', @url, 'false';

-- Add custom headers (replace with your actual header values)
EXEC sp_OAMethod @httpRequest, 'setRequestHeader', NULL, 'Content-Type', 'application/json';
EXEC sp_OAMethod @httpRequest, 'setRequestHeader', NULL, 'Accept', '*/*';
EXEC sp_OAMethod @httpRequest, 'setRequestHeader', NULL, 'Host', 'turkey-public-holidays1.p.rapidapi.com';
EXEC sp_OAMethod @httpRequest, 'setRequestHeader', NULL, 'Accept-Encoding', 'gzip, deflate, br';
EXEC sp_OAMethod @httpRequest, 'setRequestHeader', NULL, 'Connection', 'keep-alive';

EXEC sp_OAMethod @httpRequest, 'setRequestHeader', NULL, 'X-RapidAPI-Key', '5adfc03ca2mshaf1381e74586fdcp16d553jsn8c395ea3c6b1';
EXEC sp_OAMethod @httpRequest, 'setRequestHeader', NULL, 'X-RapidAPI-Host', 'turkey-public-holidays1.p.rapidapi.com';

EXEC sp_OAMethod @httpRequest, 'send';

-- Get the HTTP status code
EXEC sp_OAMethod @httpRequest, 'status', @status OUT;

-- Check if the status code is 200 (OK)
IF @status = 200
BEGIN
    -- Parse and store the response (example uses PRINT for demonstration)
    EXEC sp_OAGetProperty @httpRequest, 'responseText', @response OUT;

    -- Parse JSON and extract holiday information
    DECLARE @holidayTable TABLE (
        [gun] NVARCHAR(100),
        [en] NVARCHAR(100),
        [haftagunu] NVARCHAR(100),
        [tarih] DATE,
        [uzuntarih] NVARCHAR(100)
    );

    INSERT INTO @holidayTable
    SELECT
        [gun],
        [en],
        [haftagunu],
        TRY_CAST([tarih] AS DATE),
        [uzuntarih]
    FROM OPENJSON(@response, '$.resmitatiller') 
    WITH (
        [gun] NVARCHAR(100),
        [en] NVARCHAR(100),
        [haftagunu] NVARCHAR(100),
        [tarih] NVARCHAR(10),
        [uzuntarih] NVARCHAR(100)
    );

    -- Debugging: Print the extracted holiday information
    SELECT * FROM @holidayTable;

    -- Debugging: Print full response
    PRINT 'Full Response: ' + ISNULL(@response, 'N/A');

    -- Parse JSON and extract page create date
    DECLARE @pageCreateDate NVARCHAR(50);
    SELECT @pageCreateDate = JSON_VALUE(@response, '$.pagecreatedate');

    PRINT 'Page Create Date: ' + ISNULL(@pageCreateDate, 'N/A');
END
ELSE
BEGIN
    -- Handle the case where the request did not return a 200 status
    PRINT 'Error: HTTP request did not return 200 OK status.';
    PRINT 'Status Code: ' + CONVERT(NVARCHAR(10), @status);
END

-- Clean up
EXEC sp_OADestroy @httpRequest;

-- Disable Ole Automation Procedures
EXEC sp_configure 'Ole Automation Procedures', 0;
RECONFIGURE;
