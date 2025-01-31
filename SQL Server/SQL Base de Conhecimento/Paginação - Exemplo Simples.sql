



-----------------------------------
--SQL PAGINAÇÃO - EXEMPLO SIMPLES--
-----------------------------------
DECLARE @PageNumber INT = 1
DECLARE @PageSize INT = 100


SELECT  *
FROM    ( SELECT ROW_NUMBER() OVER ( ORDER BY 
			id --TableID
		  ) AS RowNum, *
          FROM 
			sysobjects --Table
        ) AS SourceResult
WHERE   RowNum >= ((@PageSize * @PageNumber) - @PageSize ) + 1
    AND RowNum <= (@PageSize * @PageNumber)
ORDER BY RowNum


SELECT  *
FROM    ( SELECT ROW_NUMBER() OVER ( ORDER BY 
			CodProposta --TableID
		  ) AS RowNum, *
          FROM 
			DCV_GERENCIAL..PROPOSTA --Table
        ) AS SourceResult
WHERE   RowNum >= ((@PageSize * @PageNumber) - @PageSize ) + 1
    AND RowNum <= (@PageSize * @PageNumber)
ORDER BY RowNum