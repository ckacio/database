 
 
  
  
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

--		UPDATE A
--		   SET CPFCNPJ = B.CGC_CPF
--		  FROM #tmp_dados AS A
--		 INNER JOIN AB_INFOBANC..CLIENTES AS B ON(B.CodCliente = A.CodCliente)

		SELECT * FROM #tmp_dados
  
 END 
 
 DECLARE @xmlCamposParametro xml = '<root><row><CodCliente>1</CodCliente><Mes>10</Mes><Ano>1975</Ano><NomeUsuario>ckacio</NomeUsuario></row>
										  <row><CodCliente>2</CodCliente><Mes>11</Mes><Ano>1976</Ano><NomeUsuario>ckacio1</NomeUsuario></row>
									</root>'

EXEC dbo.P_TESTE @CodCliente = '123', @Mes = 9, @Ano = 2000, @Usuario = 'teste', @xmlCampos = @xmlCamposParametro
  
 
  
  
  --Public Shared Function ExcluirFaturamento(ByVal connection As SqlConnection,
  --                                                ByVal CodCliente As String,
  --                                                ByVal Mes As Integer,
  --                                                ByVal Ano As Integer,
  --                                                ByVal sNomeUsuario As String,
  --                                                Optional ByVal xmlCampos As String = "") As Boolean
  --          Dim retorno As Boolean = False

  --          Try
  --              Dim command As SqlCommand = New SqlCommand(CPool.Pool.BancoPrincipal + "..P_EXCLUIR_FAT_MENSAL_ANALISE_CREDITO", connection)
  --              command.CommandTimeout = 0
  --              command.CommandType = CommandType.StoredProcedure

  --              SqlCommandBuilder.DeriveParameters(command)
  --              command.Parameters("@CodCliente").Value = CodCliente
  --              command.Parameters("@Mes").Value = Mes
  --              command.Parameters("@Ano").Value = Ano
  --              command.Parameters("@Usuario").Value = sNomeUsuario
  --              command.Parameters("@XMLcampos").Value = IIf(String.IsNullOrEmpty(xmlCampos), DBNull.Value, xmlCampos) 'BE0011 - R19 04 06615 - 11/09/2019
  --              command.ExecuteNonQuery()

  --              retorno = True
  --          Catch ex As Exception
  --              System.Diagnostics.EventLog.WriteEntry("SGI", "CFaturamento.ExcluirFaturamento: " & ex.Message, EventLogEntryType.Error)
  --              Throw ex
  --          End Try
  --          Return retorno
  --      End Function
		
	
 --<Serializable()>
 --   <XmlType("row")>
 --   Public Class Registros
 --       Private _Mes As String
 --       Private _Ano As String
 --       Private _Valor As String
 --       Private _Linha As String

 --       'PM0034 - R19 08 02322 - 02/10/2019
 --       Private _Banco As String
 --       Private _DataEndividamento As DateTime

 --       Public Property Mes As String
 --           Get
 --               Return _Mes
 --           End Get
 --           Set(value As String)
 --               _Mes = value
 --           End Set
 --       End Property

 --       Public Property Ano As String
 --           Get
 --               Return _Ano
 --           End Get
 --           Set(value As String)
 --               _Ano = value
 --           End Set
 --       End Property

 --       Public Property Valor As String
 --           Get
 --               Return _Valor
 --           End Get
 --           Set(value As String)
 --               _Valor = value
 --           End Set
 --       End Property

 --       Public Property Linha As String
 --           Get
 --               Return _Linha
 --           End Get
 --           Set(value As String)
 --               _Linha = value
 --           End Set
 --       End Property

 --       'PM0034 - R19 08 02322 - 02/10/2019
 --       Public Property Banco() As String
 --           Get
 --               Return _Banco
 --           End Get
 --           Set(ByVal value As String)
 --               _Banco = value
 --           End Set
 --       End Property

 --       Public Property DataEndividamento() As DateTime
 --           Get
 --               Return _DataEndividamento
 --           End Get
 --           Set(value As DateTime)
 --               _DataEndividamento = value
 --           End Set
 --       End Property
 --       '=====================================================================
 --       'BE0011 - R19 04 06615 - 11/09/2019
 --       Private _tipoRegistro As String
 --       Private _Acao As String
 --       Private _NomeUsuario As String
 --       Private _CodCliente As String


 --       Public Property TipoRegistro() As String
 --           Get
 --               Return _tipoRegistro
 --           End Get
 --           Set(ByVal value As String)
 --               _tipoRegistro = value
 --           End Set
 --       End Property

 --       Public Property Acao() As String
 --           Get
 --               Return _Acao
 --           End Get
 --           Set(ByVal value As String)
 --               _Acao = value
 --           End Set
 --       End Property

 --       Public Property NomeUsuario() As String
 --           Get
 --               Return _NomeUsuario
 --           End Get
 --           Set(ByVal value As String)
 --               _NomeUsuario = value
 --           End Set
 --       End Property

 --       Public Property CodCliente() As String
 --           Get
 --               Return _CodCliente
 --           End Get
 --           Set(ByVal value As String)
 --               _CodCliente = value
 --           End Set
 --       End Property
 --       '=====================================================================

 --   End Class	


            -- Dim lstIncluir As New List(Of Registros)
            --If (lst IsNot Nothing AndAlso lst.Count > 0) Then
            --    dtClientes = CType(Session(String.Concat("Clientes_", strCodCliente)), DataTable)
            --    If (dtClientes IsNot Nothing AndAlso dtClientes.Rows.Count > 0) Then
            --        For i = 0 To dtClientes.Rows.Count - 1
            --            Dim cliente As String = dtClientes.Rows(i).ItemArray(0).ToString()
            --            For Each item As Registros In lst
            --                Dim faturamento As New Registros
            --                faturamento.CodCliente = cliente
            --                faturamento.Ano = item.Ano
            --                faturamento.Mes = item.Mes
            --                faturamento.Valor = item.Valor
            --                faturamento.TipoRegistro = item.TipoRegistro
            --                faturamento.NomeUsuario = item.NomeUsuario
            --                lstIncluir.Add(faturamento)
            --            Next
            --        Next
            --    End If
            --End If

            --lst.AddRange(lstIncluir)
            --'R21 04 17011 - pm0034 - 20210526 

            --'PM0034 - R19 10 01619 - 11/05/2020
            --'Dim xmlIns As String = SerializeLista(lstRegs.ToList())
            --Dim xmlIns As String = SerializeLista(lst.ToList())

            --If xmlIns <> String.Empty Then

            --    'Exclusões
            --    Cadastros.CFaturamento.ExcluirFaturamento(xmlIns)

            --    'Inclusões
            --    Cadastros.CFaturamento.IncluirFaturamento(xmlIns)
            --    CEndividamentoFaturamentoLog.AtualizarFaturamentoHistorico(DateTime.Now, xmlIns)
            --End If
 
-- CREATE PROCEDURE dbo.P_EXCLUIR_FAT_MENSAL_ANALISE_CREDITO(@CodCliente VARCHAR(9) = null,  
--                                                          @Mes INT = null,  
--                                                          @Ano INT = null,
--                                                          @Usuario       VARCHAR(20) = null,
--                                                          @xmlCampos xml = null) 
														  
--AS  
--BEGIN  

--	/*      
--		  Procedure: P_EXCLUIR_FAT_MENSAL_ANALISE_CREDITO      
--		  Objetivo : Incluir Balanco Lucro Presumido.      
--		  Analista : Victor Miranda Barros   
--		  Data     : 27/09/2016  
--		  ========================================================================================
--		  Histórico de Alterações
--		  ========================================================================================
--		  Item		Data				Analista					Descrição      

--		  ========================================================================================
--	*/
--	 SET NOCOUNT ON   
--	 SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;  


--	--#02
--	IF @xmlCampos IS NULL BEGIN

--		--==============================================================
--		--Validação de preenchimento dos campos
--		IF @CodCliente IS NULL BEGIN  
--			RAISERROR ('Código cliente é obrigatório.', 16, 1)  
--		END 

--		IF @Mes IS NULL BEGIN  
--			RAISERROR ('Mês é obrigatório.', 16, 1)  
--		END

--		IF @Ano IS NULL BEGIN  
--			RAISERROR ('Ano é obrigatório.', 16, 1)  
--		END

--		IF @Usuario IS NULL BEGIN  
--			RAISERROR ('Usuário é obrigatório.', 16, 1)  
--		END
--		--==============================================================

--		IF OBJECT_ID('TempDB.dbo.#TMP_FAT') IS NOT NULL
--		DROP TABLE #TMP_FAT

--		IF @Mes < 1 OR @Mes > 12 BEGIN  
--			RAISERROR ('Número do mês inválido.', 16, 1)  
--		END 
		
--		IF @Ano < 2000 BEGIN  
--			RAISERROR ('Número do ano inválido.', 16, 1)  
--		END
		
--		DECLARE @MesAno VARCHAR(10)   
--		SET @MesAno = '01/' +   
--		RIGHT('00' + CAST(@Mes AS VARCHAR(2)),2) +   
--		'/' +   
--		RIGHT('0000' + CAST(@Ano AS VARCHAR(4)),4)  

--		DELETE FROM DCV_GERENCIAL.dbo.FAT_ANALISE_CREDITO   
--		WHERE CodCliente = @CodCliente  
--		AND MesAno = CONVERT(DATETIME,@MesAno,103)  
                
                
--		-- #1# Atualizar balanço do lucro presumido apenas na CodRubrica 10
--		DECLARE @CPFCNPJ VARCHAR(14) = (SELECT CGC_CPF FROM AB_INFOBANC..CLIENTES WHERE CODCLIENTE = @CodCliente)
--		IF (@CPFCNPJ IS NOT NULL) BEGIN
--			SELECT
--				TOP 12 valor
--			INTO #TMP_FAT   
--			FROM 
--				dbo.FAT_ANALISE_CREDITO  
--			WHERE 
--				CodCliente = @CodCliente 
--			ORDER BY MesAno DESC
       
--		DECLARE @SOMVALOR MONEY = 0

--		IF (NOT (SELECT SUM(valor) FROM #TMP_FAT) IS NULL)
--			SET @SOMVALOR  = (SELECT SUM(valor) FROM #TMP_FAT)
   		  
   		   
--		UPDATE BALANCO_LUCRO_PRESUMIDO 
--		   SET VALOR = @SOMVALOR, 
--		       DATAATUALIZACAO = GETDATE()
--		 WHERE 
--				CNPJ = @CPFCNPJ
--		   AND	CODRUBRICA = 10
		   
--		END
   
--		IF OBJECT_ID('TempDB.dbo.#TMP_FAT') IS NOT NULL
--			DROP TABLE #TMP_FAT   
--	END
    
--	--#02
--	IF @xmlCampos IS NOT NULL BEGIN


--		--Recuperando todos os dados que serão trabalhados
--		select  
--			col.value('data(CodCliente[1])', 'varchar(200)') as CodCliente
--		   ,col.value('data(Mes[1])', 'int') as Mes
--		   ,col.value('data(Ano[1])', 'int') as Ano
--		   ,col.value('data(NomeUsuario[1])', 'varchar(200)') as NomeUsuario
--		   ,CONVERT(varchar(10),null) as MesAno
--		   ,CONVERT(varchar(20),null) as CPFCNPJ
--		into #tmp_dados
--		from    
--			@XmlCampos.nodes('/root/row') tbl(col)

		

--		--Validações
--		IF EXISTS(SELECT 1 FROM #tmp_dados WHERE Mes < 1 OR Mes > 12) BEGIN
--			RAISERROR ('Um dos registros possui número do mês inválido.', 16, 1)
--		END

--		IF EXISTS(SELECT 1 FROM #tmp_dados WHERE Ano  < 2000) BEGIN
--			RAISERROR ('Um dos registros possui número do ano inválido.', 16, 1)
--		END

--		--Atualizando campo MesAno
--		UPDATE #tmp_dados SET MesAno = '01/' + RIGHT('00' + CAST(Mes AS VARCHAR(2)),2) + '/' + RIGHT('0000' + CAST(Ano AS VARCHAR(4)),4)

--		--Excluindo faturamentos de analise de credito
--		DELETE A
--		  FROM DCV_GERENCIAL.dbo.FAT_ANALISE_CREDITO AS A
--		  INNER JOIN #tmp_dados AS B ON (B.CodCliente = A.CodCliente AND CONVERT(DATETIME,B.MesAno,103) = A.MesAno)

--		--Atualizando documento dos clientes
--		UPDATE A
--		   SET CPFCNPJ = B.CGC_CPF
--		  FROM #tmp_dados AS A
--		 INNER JOIN AB_INFOBANC..CLIENTES AS B ON(B.CodCliente = A.CodCliente)
		 
--		--Atualizando documentos dos que ficaram sem CNPJ
--		UPDATE A
--		   SET CPFCNPJ = B.CGC_CPF
--		  FROM #tmp_dados AS A
--		 INNER JOIN DCV_GERENCIAL..PROSPECTO AS B ON(B.CodCliente = A.CodCliente)
--		 WHERE A.CPFCNPJ IS NULL

--		--Atualizar balanço do lucro presumido apenas na CodRubrica 10
--		IF EXISTS(SELECT 1 FROM #tmp_dados WHERE CPFCNPJ IS NOT NULL) BEGIN
			
--			SELECT DISTINCT
--				 CPFCNPJ
--				,(SELECT SUM(x.Valor) FROM(SELECT TOP 12 B.valor FROM DCV_GERENCIAL..FAT_ANALISE_CREDITO AS B WHERE B.CodCliente = A.CodCliente ORDER BY B.MesAno DESC) AS x ) AS TotFat
--			 INTO #tmp_fatcli
--			 FROM
--				(SELECT DISTINCT CODCLIENTE, CPFCNPJ FROM #tmp_dados) AS A

--			--Atualizando
--			UPDATE A
--			   SET A.VALOR = B.TotFat, 
--				   A.DATAATUALIZACAO = GETDATE()
--			  FROM BALANCO_LUCRO_PRESUMIDO AS A
--			INNER JOIN #tmp_fatcli AS B ON (B.CPFCNPJ = A.CNPJ)
--			 WHERE A.CODRUBRICA = 10

--		END

--	END --@xmlCampos IS NOT NULL

--END  		


--SELECT * FROM DCV_GERENCIAL.dbo.FAT_ANALISE_CREDITO_MEDIA