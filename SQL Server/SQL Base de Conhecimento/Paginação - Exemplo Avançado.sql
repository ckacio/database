USE [DCV_GERENCIAL]
GO


IF OBJECT_ID('P_OBTER_OBJETOS', 'P') IS NULL
     EXEC ('CREATE PROCEDURE [dbo].[P_OBTER_OBJETOS] AS SELECT 1')
GO

ALTER PROCEDURE [dbo].[P_OBTER_OBJETOS] 
(
	@nome				  NVARCHAR(MAX) = NULL,
	----------------------------------------------------------------------------------------------------
	--------Controle da Paginação-----------------------------------------------------------------------
	@Posicao int						= 1,  
	@RegistrosPagina INT				= 4,
	@OrderBy VARCHAR(200)				= null
)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	 ----------------------------------------------------------------------------------------------------
	 --------Controle da Paginação-----------------------------------------------------------------------
	 DECLARE
	 @Posicao_aux				int = @Posicao,  
	 @RegistrosPagina_aux		INT = @RegistrosPagina,
	 @OrderBy_aux				VARCHAR(200) = @OrderBy

	--SE A POSIÇÃO DA PAGINAÇÃO DO GRID FOR = 0, ATRIBUI 1
	IF (@POSICAO_AUX > 0)
	BEGIN
		SET @POSICAO_AUX = @POSICAO_AUX - 1
	END

		--Carrega temporária com o índice dos registros considerando a ordenação
		 SELECT 
						ROW_NUMBER() OVER (
						ORDER BY
							-- ASCENDENTE    
							
							 CASE WHEN @OrderBy_aux = 'object_id'				or @OrderBy_aux = 'object_id ASC'					THEN obj.object_id				END ASC
							,CASE WHEN @OrderBy_aux = 'name'					or @OrderBy_aux = 'name ASC'						THEN obj.name					END ASC
							,CASE WHEN @OrderBy_aux = 'type'					or @OrderBy_aux = 'type ASC'						THEN obj.type					END ASC
							,CASE WHEN @OrderBy_aux = 'type_desc'				or @OrderBy_aux = 'type_desc ASC'					THEN obj.type_desc				END ASC

							-- DESCENDENTE    
							,CASE WHEN @OrderBy_aux = 'object_id Desc'																THEN obj.object_id				END DESC
							,CASE WHEN @OrderBy_aux = 'name Desc'																	THEN obj.name					END DESC
							,CASE WHEN @OrderBy_aux = 'type Desc'																	THEN obj.type					END DESC
							,CASE WHEN @OrderBy_aux = 'type_desc Desc'																THEN obj.type_desc				END DESC
 						) indice,
		 object_id,
		 name,
		 type,
		 type_desc 
		 into #RESULT
	FROM SYS.OBJECTS obj
	WHERE	
		(@nome is null or obj.name like '%' + @nome + '%')

	--Guarda o Total de Registros
	DECLARE @QtdeRegistros int
	select @QtdeRegistros = Count(1) from #RESULT

	if @RegistrosPagina=-1
		select @RegistrosPagina_aux = @QtdeRegistros

	--Guarda os Registros Paginados
	SELECT *
	into #result2
	FROM #RESULT tmp
	where		tmp.indice BETWEEN(@Posicao_aux*@RegistrosPagina) + 1 
			AND (@Posicao_aux*@RegistrosPagina) + @RegistrosPagina_aux 
	ORDER BY INDICE		

	--Retorna para Tela os Registros de Titulos Paginados
	SELECT	*,
			@QtdeRegistros AS QtdeRegistros
	FROM #result2
	
	
END



/*

EXEC DCV_GERENCIAL..P_OBTER_OBJETOS	@nome=null,
									@Posicao = 1,  
									@RegistrosPagina = 40,
									@OrderBy = 'name'


EXEC DCV_GERENCIAL..P_OBTER_OBJETOS	@nome=null,
									@Posicao = 1,  
									@RegistrosPagina = 40,
									@OrderBy = 'name DESC'


*/