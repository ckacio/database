USE MASTER
GO

-----------------------------------------------------------------------------------
--Exemplo1

DECLARE @InstrucaoSQL		AS VARCHAR(MAX)
      , @ContendoTexto VARCHAR(255) = 'kacio'

if Object_id('tempdb..#tmpResult', 'U') IS NOT NULL DROP TABLE #tmpResult
	   
CREATE TABLE #tmpResult 
(
    Banco  varchar(200)
  , Objeto varchar(200)
  , xTipo  varchar(200)
)

SET @InstrucaoSQL = 'IF ''?'' not IN (''master'',''tempdb'') '+
					--' AND ''?'' IN (''TopDeskSac5'') ' +
                    'BEGIN ' +
                        'INSERT into #tmpResult ' +
	                    'SELECT ''?''	Banco
	                          , so.name Objeto
	                          , so.xtype xTipo ' +
	                      'FROM [?].dbo.sysobjects so '+
	                     'INNER JOIN [?].dbo.syscomments sc '+
		                    'ON so.id = sc.id ' +
	                     'WHERE sc.text like ''%' + @ContendoTexto + '%'''+
	                     'ORDER BY so.name ' + 
	                 'END'
	                 
EXEC sp_MSForEachDB @InstrucaoSQL

SELECT distinct * 
  FROM #tmpResult
  
DROP TABLE #tmpResult


-----------------------------------------------------------------------------------
--Exemplo2

--Exexuta a instrução de saber o nome da base em todos os batabases
exec dbo.sp_msForEachDb @command1='SELECT DB_NAME(DB_ID(''?'')) AS DatabaseName'

