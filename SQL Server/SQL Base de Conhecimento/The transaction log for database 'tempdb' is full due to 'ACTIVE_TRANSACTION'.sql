
--https://stackoverflow.com/questions/45290016/the-transaction-log-for-database-tempdb-is-full-due-to-active-transaction

DECLARE @NomeTable VARCHAR(1000)
DECLARE @ID INT

BEGIN TRANSACTION


SELECT	@ID = MIN(ID)
FROM	tempdb..sysobjects 
WHERE	TYPE='U'

WHILE @ID IS NOT NULL
BEGIN

	SELECT  @NomeTable = NAME
	FROM	tempdb..sysobjects 
	WHERE
			ID=@ID

	EXEC('DROP TABLE ''' + @NomeTable + '')

	SELECT	@ID = MIN(ID)
	FROM	tempdb..sysobjects 
	WHERE	TYPE='U' AND 
			LEFT(NAME,1)='#' AND
			ID > @ID

END

COMMIT TRANSACTION

