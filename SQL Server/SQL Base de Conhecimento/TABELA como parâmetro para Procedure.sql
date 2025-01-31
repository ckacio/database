

--FONTE: https://docs.microsoft.com/pt-br/sql/relational-databases/tables/use-table-valued-parameters-database-engine?view=sql-server-2017

/* Create a table type. */
IF TYPE_ID('dbo.TP_LISTA_CodCliente') IS NOT NULL
	DROP TYPE dbo.TP_LISTA_CodCliente

CREATE TYPE dbo.TP_LISTA_CodCliente AS TABLE
(
	CodCliente	VARCHAR(9)
)

/* Create a procedure to receive data for the table-valued parameter. */
CREATE PROCEDURE [dbo].[P_TESTANDO_TP_LISTA_CodCliente]
(  
	 @TP_LISTA_CodCliente dbo.TP_LISTA_CodCliente READONLY
)
AS
BEGIN
	SELECT * FROM @TP_LISTA_CodCliente
END
GO

--INICIO

/* Declare a variable that references the type. */
DECLARE @parLISTA_CodCliente AS TP_LISTA_CodCliente
/* Add data to the table variable. */
DECLARE @X INT = 1
WHILE @X <= 10
BEGIN 
	INSERT INTO @parLISTA_CodCliente (CodCliente)
	VALUES(@X)

	SET @X = @X + 1

END

/* Pass the table variable data to a stored procedure. */
EXEC P_TESTANDO_TP_LISTA_CodCliente @parLISTA_CodCliente


USE DBContabil
GO

GRANT EXECUTE ON TYPE::dbo.TP_CLIENTES TO [SEUDOMINIO\CSH_APPSGI]
GO

--FIM

/*
**********************************************
********Exemplo de Chamada VB.NET ***********
**********************************************

        Public Shared Function Lista(ByVal pDataTable As DataTable) As DataTable
            If pDataTable.Rows.Count <= 0 Then
                Return Nothing
            End If

            Dim sqlConnection As SqlConnection = CPool.Pool.GetConnection()
            Dim dataTable As DataTable

            Try
                Dim dtCliente As New DataTable
                dtCliente.Columns.Add("CodCliente")

                For Each row As DataRow In pDataTable.Rows
                    Dim codCliente As String = row.Item("CodCliente").ToString()

                    If Not String.IsNullOrEmpty(codCliente) Then
                        dtCliente.Rows.Add(codCliente)
                    End If
                Next

                Dim sqlCommand As SqlCommand = New SqlCommand($"..P_TESTANDO_TP_LISTA_CodCliente", sqlConnection) With
                {
                    .CommandTimeout = 0,
                    .CommandType = CommandType.StoredProcedure
                }

                sqlCommand.Parameters.AddWithValue("@TP_LISTA_CodCliente", dtCliente)

                dtCliente.Dispose()
                dataTable = CAcessoDados.ExecuteDataTable(sqlCommand)

            Catch ex As Exception
                Throw
            Finally
                CPool.Pool.ReleaseConnection(sqlConnection)
            End Try

            Return dataTable

        End Function

*/

