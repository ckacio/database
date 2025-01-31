
--Fonte
--https://www.mssqltips.com/sqlservertip/1958/sql-server-cross-apply-and-outer-apply/

--Problema
--O Microsoft SQL Server 2005 introduziu o operador APPLY, que � como um join e permite unir duas express�es de tabela, ou seja, unir uma express�o de 
--tabela esquerda/externa com uma express�o de tabela direita/interna. 
--A diferen�a entre o operador join e APPLY fica evidente quando voc� tem 
--uma express�o com valor de tabela no lado direito e deseja que essa express�o com valor de tabela seja avaliada para cada linha da express�o de tabela � esquerda. 
--Nesta dica vou demonstrar o operador APPLY, como ele difere dos JOINs normais e alguns usos.

--Solu��o
--O operador APPLY permite unir duas express�es de tabela; 
--a express�o de tabela direita � processada todas as vezes para cada linha da express�o de tabela esquerda. 
--Como voc� deve ter adivinhado, a express�o da tabela esquerda � avaliada primeiro 
--e, em seguida, a express�o da tabela direita � avaliada em rela��o a cada linha da express�o da tabela esquerda para o conjunto de resultados final. 
--O conjunto de resultados final cont�m todas as colunas selecionadas da express�o de tabela esquerda seguida por todas as colunas da express�o de tabela direita.

--O operador APPLY do SQL Server tem duas variantes; CROSS APPLY e OUTER APPLY

--O operador CROSS APPLY retorna apenas as linhas da express�o de tabela � esquerda (em sua sa�da final) se corresponder � express�o de tabela � direita. 
--Em outras palavras, a express�o de tabela � direita retorna linhas apenas para a correspond�ncia de express�o de tabela � esquerda.

--O operador OUTER APPLY retorna todas as linhas da express�o de tabela esquerda, independentemente de sua correspond�ncia com a express�o de tabela direita. 
--Para as linhas para as quais n�o h� correspond�ncias correspondentes na express�o de tabela � direita, ela cont�m valores NULL nas colunas da express�o de tabela � direita.

--*******************************************************************************************************************************************************************************************************
--Ent�o voc� pode concluir, o CROSS APPLY � equivalente a um INNER JOIN (ou para ser mais preciso � como um CROSS JOIN com uma subconsulta correlacionada) com uma condi��o de jun��o impl�cita de 1 = 1, 
--enquanto o OUTER APPLY � equivalente a um LEFT JOIN
--*******************************************************************************************************************************************************************************************************

--Voc� pode estar se perguntando se o mesmo pode ser alcan�ado com uma cl�usula JOIN Normal, ent�o por que e quando voc� usa o operador APPLY? Embora o mesmo possa ser alcan�ado com um JOIN normal , 
--a necessidade de APPLY surge se voc� tiver uma express�o com valor de tabela na parte direita e em alguns casos o uso do operador APPLY aumenta o desempenho da sua consulta. 

---Script #1 - Creating some temporary objects to work on...

USE [DCV_CHECAGEM] 
GO
 
IF EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[Employee]') AND type IN (N'U')) 
BEGIN 
   DROP TABLE [Employee] 
END 
GO 

IF EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[Department]') AND type IN (N'U')) 
BEGIN 
   DROP TABLE [Department] 
END 

CREATE TABLE [Department]( 
   [DepartmentID] [int] NOT NULL PRIMARY KEY, 
   [Name] VARCHAR(250) NOT NULL, 
) ON [PRIMARY] 

INSERT [Department] ([DepartmentID], [Name])  
VALUES (1, N'Engineering') 
INSERT [Department] ([DepartmentID], [Name])  
VALUES (2, N'Administration') 
INSERT [Department] ([DepartmentID], [Name])  
VALUES (3, N'Sales') 
INSERT [Department] ([DepartmentID], [Name])  
VALUES (4, N'Marketing') 
INSERT [Department] ([DepartmentID], [Name])  
VALUES (5, N'Finance') 
GO 

CREATE TABLE [Employee]( 
   [EmployeeID] [int] NOT NULL PRIMARY KEY, 
   [FirstName] VARCHAR(250) NOT NULL, 
   [LastName] VARCHAR(250) NOT NULL, 
   [DepartmentID] [int] NOT NULL REFERENCES [Department](DepartmentID), 
) ON [PRIMARY] 
GO
 
INSERT [Employee] ([EmployeeID], [FirstName], [LastName], [DepartmentID]) 
VALUES (1, N'Orlando', N'Gee', 1 ) 
INSERT [Employee] ([EmployeeID], [FirstName], [LastName], [DepartmentID]) 
VALUES (2, N'Keith', N'Harris', 2 ) 
INSERT [Employee] ([EmployeeID], [FirstName], [LastName], [DepartmentID]) 
VALUES (3, N'Donna', N'Carreras', 3 ) 
INSERT [Employee] ([EmployeeID], [FirstName], [LastName], [DepartmentID]) 
VALUES (4, N'Janet', N'Gates', 3 )       


--SQL Server CROSS APPLY vs INNER JOIN example


--Script #2 - CROSS APPLY and INNER JOIN

SELECT * FROM Department D 
CROSS APPLY 
   ( 
   SELECT * FROM Employee E 
   WHERE E.DepartmentID = D.DepartmentID 
   ) A 
GO
 
SELECT * FROM Department D 
INNER JOIN Employee E ON D.DepartmentID = E.DepartmentID 
GO 

--Se voc� olhar para os resultados, voc� pode ver que eles s�o os mesmos.
--Al�m disso, os planos de execu��o dessas consultas s�o semelhantes e possuem um custo de consulta igual


--Exemplo de SQL Server OUTER APPLY vs LEFT OUTER JOIN


--A primeira consulta no Script #3 seleciona dados da tabela Department e usa um OUTER APPLY para avaliar a tabela Employee para cada registro da tabela Department. 
--Para as linhas para as quais n�o h� correspond�ncia na tabela Employee, essas linhas cont�m valores NULL,
--Conforme esperado, a consulta retorna todas as linhas da tabela Department, mesmo para aquelas linhas para as quais n�o h� correspond�ncia na tabela Employee.

--Script #3 - OUTER APPLY and LEFT OUTER JOIN

SELECT * FROM Department D 
OUTER APPLY 
   ( 
   SELECT * FROM Employee E 
   WHERE E.DepartmentID = D.DepartmentID 
   ) A 
GO
 
SELECT * FROM Department D 
LEFT OUTER JOIN Employee E ON D.DepartmentID = E.DepartmentID 
GO 

--Embora as duas consultas acima retornem as mesmas informa��es, o plano de execu��o � um pouco diferente. 
--Embora em termos de custo n�o haja muita diferen�a, 
--a consulta com o OUTER APPLY usa um operador Compute Scalar (com custo estimado de operador de 0,0000103 ou em torno de 0%) 
--antes do operador Nested Loops para avaliar e produzir as colunas da tabela Employee.

--Unindo fun��es e tabelas com valor de tabela usando operadores APPLY

--No Script #4, estou criando uma fun��o com valor de tabela que aceita DepartmentID como par�metro e retorna todos os funcion�rios que pertencem a esse departamento. 
--A pr�xima consulta seleciona dados da tabela Department e usa um CROSS APPLY para unir com a fun��o que criamos. 
--Ele passa o DepartmentID para cada linha da express�o de tabela externa (no nosso caso, a tabela Department) e avalia a fun��o para cada linha semelhante a uma subconsulta correlacionada . 
--A pr�xima consulta usa o OUTER APPLY no lugar do CROSS APPLY e, portanto, diferentemente do CROSS APPLY que retornou apenas dados correlacionados, 
--o OUTER APPLY tamb�m retorna dados n�o correlacionados, colocando NULLs nas colunas ausentes.


--Script #4 - APPLY with table-valued function

SELECT * 
FROM Department D
CROSS APPLY (SELECT * 
			 FROM  Employee E
			 WHERE D.DepartmentID = E.DepartmentID) AS DEP


SELECT * 
FROM Department D
OUTER APPLY (SELECT * 
			 FROM  Employee E
			 WHERE D.DepartmentID = E.DepartmentID) AS DEP



--Voc� pode estar se perguntando se podemos usar uma jun��o simples no lugar das consultas acima, a resposta � N�O. Se voc� 
--substituir o CROSS/OUTER APPLY nas consultas acima por um INNER JOIN/LEFT OUTER JOIN, especificando a cl�usula ON 
--com 1=1 e executar a consulta, voc� receber� o erro "The multi-part identifier "D.DepartmentID" could not be bound.". 
--Isso ocorre porque com JOINs o contexto de execu��o da consulta externa � diferente do contexto de execu��o da fun��o (ou uma tabela derivada ) 
--e voc� n�o pode vincular um valor/vari�vel da consulta externa � fun��o como par�metro. Portanto, o operador APPLY � necess�rio para essas consultas.


SELECT * 
FROM Department D
inner join (SELECT * 
			 FROM  Employee E
			 WHERE D.DepartmentID = E.DepartmentID) AS DEP
ON
	1=1

--Deixe-me mostrar outra consulta com uma fun��o de gerenciamento din�mico (DMF) . 
--O script #5 retorna todas as consultas do usu�rio atualmente em execu��o, exceto as que est�o sendo executadas pela sess�o atual. 
--Como voc� pode ver no script abaixo, a exibi��o de gerenciamento din�mico sys.dm_exec_requests est� sendo CROSS APPLY'ed 
--com a fun��o de gerenciamento din�mico sys.dm_exec_sql_text que aceita um "handle de plano" para a consulta e o "handle de plano" 
--est� sendo passado de a express�o esquerda/externa para a fun��o para retornar os dados.

--Script #5 - APPLY with Dynamic Management Function (DMF)

USE master 
GO
 
SELECT DB_NAME(r.database_id) AS [Database], st.[text] AS [Query], r.statement_start_offset ,r.statement_end_offset
FROM sys.dm_exec_requests r 
CROSS APPLY sys.dm_exec_sql_text(r.plan_handle) st 
WHERE r.session_Id > 50           -- Consider spids for users only, no system spids. 
AND r.session_Id NOT IN (@@SPID)  -- Don't include request from current spid. 

--https://www.mssqltips.com/sqlservertip/1811/find-current-running-sql-statement-in-sql-server/




	SELECT	DISTINCT
			REMESSAS.CodRemessa,
			REMESSAS.NomeRemessa,
			REMESSAS.RaizCpfCnpjSacado,
			REMESSAS.DtLibChecagem,
			REMESSAS.DtFimJulgamento,
			SACADOS_BLOQUEADOS.DataBloqueio
	FROM	( 	--Remessas que foram  depois da GMUD subida 04/09/2019
				SELECT	REMESSA.CodRemessa,
						REMESSA.NomeRemessa,
						TITULO.CodTitulo,
						TITULO.RaizCpfCnpjSacado,
						REMESSA.DtFimJulgamento,
						REMESSA.DtLibChecagem
				FROM 	REMESSA_CLIENTE REMESSA
				INNER JOIN
						REMESSA_TITULO  TITULO 
				ON 
						REMESSA.CodRemessa = TITULO.CodRemessa
				WHERE	
						REMESSA.Situacao = 'LIB' AND
						REMESSA.DtFimJulgamento > '20190905' 
			)	AS REMESSAS
	CROSS APPLY
			(	--Ultimo registro de Sacados que possuem registros de bloqueio tipo Banco e est�o bloqueados
				SELECT	DISTINCT RaizCnpj,
						MAX(DataBloqueio) AS DataBloqueio
				FROM	DCV_CHECAGEM..BloqueioCedenteBanco BCB
				INNER JOIN
						DCV_CHECAGEM..TbPessoa P
				ON		
						BCB.RaizCnpj = P.NuRaizCpfCnpj
				WHERE		BCB.TipoBloqueio IN(3,4) --Banco / Cedente/Banco
						AND BCB.CodCliente = 0
						AND P.FlBloqueado = 1
						AND P.CdTipoRestricao=3 
				GROUP BY
						CodigoPessoa,
						RaizCnpj		
			)	AS SACADOS_BLOQUEADOS
	OUTER APPLY
			(
				SELECT	REGRA.NmRegra
				FROM 	TbTituloRegra TITULOREGRA 
				INNER JOIN 
						TbRegra REGRA ON TITULOREGRA.CdRegra = REGRA.CdRegra
				WHERE	REGRA.NmRegra in ('RN15a') AND
						TITULOREGRA.CodTitulo = REMESSAS.CodTitulo
						
			)	NAO_CAIU_NA_REGRA
	WHERE
			SACADOS_BLOQUEADOS.RaizCnpj = REMESSAS.RaizCpfCnpjSacado
		AND SACADOS_BLOQUEADOS.DataBloqueio <= REMESSAS.DtFimJulgamento
		AND NmRegra IS NULL