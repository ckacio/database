	
	------------------------------------------------------------------------------------------------------------------
	
	IF OBJECT_ID('tempdb..#LstStrCodModalidadePropostas', 'U') IS NOT NULL DROP TABLE #LstStrCodModalidadePropostas

	DECLARE @LstStrCodModalidadePropostas NVARCHAR(400) 
 
	SELECT	@LstStrCodModalidadePropostas = '4,17,32,39,40,47'

	SELECT	CONVERT(INT,value) AS 'CodModalidadeProposta'  INTO #LstStrCodModalidadePropostas
	FROM	STRING_SPLIT(@LstStrCodModalidadePropostas, ',')  
	WHERE	RTRIM(value) <> ''

	SELECT * FROM #LstStrCodModalidadePropostas

	------------------------------------------------------------------------------------------------------------------

