


DECLARE @VrOriginal XML

SET @VrOriginal = (
	SELECT 	*
	FROM   sys.objects
	WHERE object_id = 3 for xml auto
)

SELECT @VrOriginal


SELECT * FROM TbLog



--------------------------------------------------------


DECLARE @ehRemessaDescontoDigital BIT = 0
--Verifica se a Remessa é DescontoDigital
SELECT TOP 1 @ehRemessaDescontoDigital = R.CodRemessa
FROM	REMESSA_CLIENTE R
WHERE	CodRemessa = 2411620 AND 
		(CodProposta IS NOT NULL AND CodProposta > 0)

SELECT @ehRemessaDescontoDigital


SELECT @ehRemessaDescontoDigital AS 'ehRemessaDescontoDigital' 
INTO #LogVariaveis

DECLARE @VrOriginal XML

SET @VrOriginal = (
	SELECT 	*
	FROM  #LogVariaveis for xml auto
)

SELECT @VrOriginal

--------------------------------------------------------


--XML para Guardar o Log dos valores da Tabela antes de Atualizar
--DECLARE @VrOriginal XML

--SET @VrOriginal = (
--	SELECT 	*
--	FROM REMESSA_CLIENTE 
--	WHERE CodRemessa = 2411623 for xml auto
--)

--SELECT @VrOriginal

--<REMESSA_CLIENTE CodRemessa="2411623" CodCliente="000021300" NomeRemessa="FND_08091.TXT" Situacao="LIB" PrazoMedio="74.00" IdLayout="A" TipoLayout="REM" CodBancoLayout="707  " DataHoraRegistro="2022-09-08T16:09:35.777" NomeUsuario="ROBO_TRANSFER" DtLibCobranca="2022-09-08T16:10:43.967" NmUsuLibCobranca="ServicoConsultaBurea" DtFimJulgamento="2022-09-08T16:11:52.713" DtLibChecagem="2022-09-08T16:18:24.440" NmUsuLibChecagem="nf0001" NmUsuAutorizador="nf0001" CodProposta="21243925" />


--EXEC P_INCLUIR_LOG_AUDITORIA 
--		'REMESSA_CLIENTE', 
--		@VrOriginal,
--		'U',
--		@IpUsuario,
--		@NmUsuario


--ALTER PROCEDURE [dbo].[P_INCLUIR_LOG_AUDITORIA](
--	@NmTabela			VARCHAR(50),
--	@VrOriginal			XML,
--	@TpOperacao			CHAR(1),
--	@IpOrigem			VARCHAR(15),
--	@NmUsuario			VARCHAR(20)
--)
--AS
--BEGIN

--	SET NOCOUNT ON
--	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

--	INSERT INTO TbLog
--	(
--		NmTabela,
--		VrOriginal,
--		TpOperacao,
--		IpOrigem,
--		NmUsuario,
--		DtLog
--	)
--	VALUES 
--	(
--		@NmTabela,
--		@VrOriginal,
--		@TpOperacao,
--		@IpOrigem,
--		@NmUsuario,
--		GETDATE()
--	)
--END



--CREATE TABLE [dbo].[TbLog](
--	[CdLog] [int] IDENTITY(1,1) NOT NULL,
--	[NmTabela] [varchar](50) NULL,
--	[VrOriginal] [xml] NULL,
--	[TpOperacao] [char](1) NULL,
--	[IpOrigem] [varchar](15) NULL,
--	[NmUsuario] [varchar](20) NULL,
--	[DtLog] [datetime] NULL,
--PRIMARY KEY CLUSTERED 
--(
--	[CdLog] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
--) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
--GO

--ALTER TABLE [dbo].[TbLog]  WITH CHECK ADD  CONSTRAINT [CK1_TbLog] CHECK  (([TpOperacao]='D' OR [TpOperacao]='U' OR [TpOperacao]='I'))
--GO

--ALTER TABLE [dbo].[TbLog] CHECK CONSTRAINT [CK1_TbLog]
--GO