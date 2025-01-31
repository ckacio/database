


--Tamanho de cada tabela do meu banco de dados
--USE [COLOCAR_A_BASE_ANALISADA]
--GO

if Object_id('tempdb..#tmpResult', 'U') IS NOT NULL DROP TABLE #tmpResult

CREATE TABLE #tmpResult 
(
    name varchar(200)
  , rows int
  , reserved varchar(200)
  ,	data varchar(200)
  ,index_size varchar(200)
  ,unused varchar(200)
)

INSERT INTO #tmpResult
EXEC sp_MSforeachtable 'EXEC sp_spaceused ''?''' 

SELECT * FROM #tmpResult ORDER BY rows DESC


/*

name					rows		reserved	data		index_size	unused
[dbo].[TbTituloRegra]	217792220	18053624 KB	10647040 KB	7401496 KB	5088 KB

		 reserved		data		unused		index_size
SELECT	(18053624  -	10647040) -	5088	=	7401496
					

*/