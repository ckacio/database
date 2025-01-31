--Pega o Resultado de uma Procedure e joga numa tabela

CREATE PROC P_TESTE
AS
BEGIN

	SELECT	'14722449821' AS NossoNumero, 
			'15485465685' AS SeuNumero,
			'Isso é um teste ' AS DsObservacao,
			1 AS CdSituacao,
			'Normal' AS DsSituacao,
			'ckacio' AS NmUsuario,
			GETDATE() AS DtInclusao
	UNION
	SELECT	'5148485121' AS NossoNumero, 
			'00000001' AS SeuNumero,
			'Isso é um teste 2 ' AS DsObservacao,
			2 AS CdSituacao,
			'Erro' AS DsSituacao,
			'ckacio' AS NmUsuario,
			GETDATE() AS DtInclusao

END


--------------------------------------------------


IF OBJECT_ID('tempdb..#PROC_RESULT') IS NOT NULL 
BEGIN 
	DROP TABLE #PROC_RESULT
END	

CREATE TABLE #PROC_RESULT(
NossoNumero		VARCHAR(11), 
SeuNumero		VARCHAR(15),
DsObservacao	VARCHAR(8000),
CdSituacao		INT,
DsSituacao		VARCHAR(50),
NmUsuario		VARCHAR(20),
DtInclusao		DATETIME)

INSERT INTO #PROC_RESULT (NossoNumero, SeuNumero, DsObservacao, CdSituacao, DsSituacao, NmUsuario, DtInclusao)
EXEC P_TESTE


SELECT * FROM #PROC_RESULT

--------------------------------------------------


