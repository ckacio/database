-------------------------------------
--VERIFICA DISPONIBILIDADE DE BASES-- 
-------------------------------------

USE MASTER
GO

DECLARE @ID INT
DECLARE @BASE VARCHAR(100)
DECLARE @BASES TABLE (ID INT IDENTITY,BASE VARCHAR(100),[STATUS] VARCHAR(150),PERMISSOES VARCHAR(3))

INSERT INTO @BASES(BASE) VALUES('DBContabil')
INSERT INTO @BASES(BASE) VALUES('DBTesouraria')


SELECT	@ID = MIN(ID)
FROM	@BASES 

WHILE @ID IS NOT NULL
BEGIN

	SELECT	@BASE = BASE
	FROM	@BASES 
	WHERE	ID = @ID

	IF EXISTS (SELECT TOP 1 1 FROM  sys.databases WHERE NAME=@BASE)
	BEGIN
	
		UPDATE	@BASES SET [STATUS] = ISNULL(CONVERT(VARCHAR,DATABASEPROPERTYEX(@BASE, 'status')),'')
		WHERE	ID = @ID

		BEGIN TRY
			IF EXISTS(SELECT TOP 1 1 FROM @BASES WHERE [STATUS]='ONLINE')
			BEGIN
				--VERIFICA SE AS PERMISS ES FORAM DADAS
				DECLARE @outputParam INT;
				DECLARE @sql NVARCHAR(MAX) =
				N'SELECT TOP 1 @id_out = 1 FROM ' + @BASE + '..SYSOBJECTS'

				EXEC sys.sp_executesql @sql, N'@id_out INT OUT', @outputParam OUT;
				--SELECT @outputParam OutParamValue

				IF @outputParam = 1
				BEGIN
					UPDATE	@BASES SET PERMISSOES = 'OK'
					WHERE	ID = @ID
				END
			END
		END TRY
		BEGIN CATCH
			DECLARE @MSG VARCHAR(150) =  SUBSTRING(ERROR_MESSAGE(),0,150)

			UPDATE	@BASES SET [STATUS] = @MSG,PERMISSOES = 'NOK'
			WHERE	ID = @ID
		END CATCH

	END

	SELECT	@ID = MIN(ID)
	FROM	@BASES 
	WHERE	ID > @ID
END

SELECT * FROM @BASES


------------------------------


--Para saber as permiss es de determinado usu rio do SQL.

--USE DBContabil
--GO

--SELECT *
--FROM sys.database_permissions dp
--JOIN sys.objects o ON dp.major_id = o.object_id
--WHERE USER_NAME(dp.grantee_principal_id) = 'USER_CKACIO'


--SELECT USER_NAME()
--SELECT CURRENT_USER



