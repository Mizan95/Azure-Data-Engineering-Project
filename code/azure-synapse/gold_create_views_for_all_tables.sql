-- This whole statement is Dynamic SQL which can make tables, views into variables and not just column names
-- To overcome normal SQL execution engine pattern, it writes out a SQL command as a string format which then gets executed at a later stage
USE gold_db
GO
-- This creates a variable called view name with a name maxing out at 100 characters
CREATE OR ALTER PROC CreateSQLServerlessView_gold @ViewName nvarchar(100)
AS
BEGIN
-- This is the SQL statement that is initially a string but turns into a SQL command upon EXEC (@statement)
    DECLARE @statement NVARCHAR(MAX)
    SET @statement = N'CREATE OR ALTER VIEW ' + @ViewName + ' AS
        SELECT 
            * 
        FROM 
            OPENROWSET(
                BULK ''https://intechstorage.dfs.core.windows.net/gold/SalesLT/' + @ViewName + '/'',
                FORMAT = ''DELTA''
            ) AS [result]'
-- As best practice, this prints the above SQL statement in the messages window
-- The next line executes the statement
    PRINT @statement   
    EXEC (@statement)
END
GO




