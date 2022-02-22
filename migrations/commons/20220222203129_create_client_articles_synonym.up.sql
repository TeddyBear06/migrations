DECLARE @client_database_name nvarchar(MAX);
DECLARE @create_synonym nvarchar(MAX);

SET @client_database_name = (SELECT value FROM demo.configurations WHERE name = 'client_database_name');
SET @create_synonym = N'CREATE SYNONYM client_articles FOR '+@client_database_name+'.dbo.test;';

EXECUTE(@create_synonym);