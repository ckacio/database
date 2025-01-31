



DECLARE @nomeProc NVARCHAR(1000)
DECLARE @idProc INT
DECLARE @textProc NVARCHAR(MAX)

SET NOCOUNT ON

DECLARE @Table TABLE(Val VARCHAR(MAX))

DECLARE @Val VARCHAR(MAX)
DECLARE @Val2 VARCHAR(MAX)

SELECT	@idProc =  MIN(a.id)
FROM	sysobjects a 
WHERE	a.type = 'P'  

WHILE @idProc IS NOT NULL
BEGIN

	DELETE  @Table

	SELECT	@nomeProc=a.name
	FROM	sysobjects a 
	WHERE	a.id = @idProc


	SELECT  @Val2 =	'IF EXISTS(SELECT * FROM SYSOBJECTS WHERE NAME LIKE ''' + @nomeProc + ''' AND TYPE=''P'')' + CHAR(13)+ CHAR(10) +	
					'BEGIN' + CHAR(13)+ CHAR(10) +	
					'		DROP PROC ' + @nomeProc + CHAR(13)+ CHAR(10) +	
					'END' + CHAR(13)+ CHAR(10) +	
					'GO' + CHAR(13)+ CHAR(10) 	

	
	INSERT INTO @Table EXEC sp_helptext @nomeProc 

	SELECT  @Val = COALESCE(@Val + ' ' + Val, Val)
	FROM    @Table

	SELECT  @Val2 AS ' ' 
	UNION ALL
	SELECT * FROM @Table
	UNION ALL
	SELECT  'GO' AS ' '


	SELECT	@idProc =  MIN(a.id)
	FROM	sysobjects a 
	WHERE	a.type = 'P'  AND
			a.id > @idProc 


END

SET NOCOUNT OFF




 