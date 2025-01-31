 
 
  
  
 CREATE PROCEDURE dbo.P_TESTE(  @CodCliente VARCHAR(9) = null,  
                                @Mes INT = null,  
                                @Ano INT = null,
                                @Usuario       VARCHAR(20) = null,
                                @xmlCampos xml = null) 
														  
AS  
BEGIN   
  
  		IF Object_id('tempdb..#tmp_dados', 'U') IS NOT NULL DROP TABLE #tmp_dados

		--Recuperando todos os dados que serão trabalhados
		select  
			col.value('data(CodCliente[1])', 'varchar(200)') as CodCliente
		   ,col.value('data(Mes[1])', 'int') as Mes
		   ,col.value('data(Ano[1])', 'int') as Ano
		   ,col.value('data(NomeUsuario[1])', 'varchar(200)') as NomeUsuario
		   ,CONVERT(varchar(10),null) as MesAno
		   ,CONVERT(varchar(20),null) as CPFCNPJ
		into #tmp_dados
		from    
			@XmlCampos.nodes('/root/row') tbl(col)


		SELECT * FROM #tmp_dados
  
 END 
GO


 
 DECLARE @xmlCamposParametro xml = '<root><row><CodCliente>1</CodCliente><Mes>10</Mes><Ano>1975</Ano><NomeUsuario>ckacio</NomeUsuario></row>
										  <row><CodCliente>2</CodCliente><Mes>11</Mes><Ano>1976</Ano><NomeUsuario>ckacio1</NomeUsuario></row>
									</root>'

EXEC dbo.P_TESTE @CodCliente = '123', @Mes = 9, @Ano = 2000, @Usuario = 'teste', @xmlCampos = @xmlCamposParametro
  
 
  
 