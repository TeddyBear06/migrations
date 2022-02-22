DECLARE @client_database_name nvarchar(MAX)
DECLARE @synonym_str nvarchar(MAX)

SET @client_database_name = (SELECT value FROM demo.configurations WHERE name = 'client_database_name')
SET @synonym_str = N'CREATE SYNONYM client_articles FOR '+@client_database_name+'.dbo.test;'

EXECUTE(@synonym_str)