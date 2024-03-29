CREATE PROCEDURE [dbo].[sp_AFC_EE_R_ACH_CANT_OFERTA]
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'PARTENERDEAFACERI',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.vw_AFC_EE_INT_ACH_CANT_OFERTA WHERE (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.vw_AFC_EE_INT_ACH_CANT_OFERTA WHERE (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( PARTENERDEAFACERI like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( PARTENERDEAFACERI like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.vw_AFC_EE_INT_ACH_CANT_OFERTA )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_ACH_POR]
@perioada varchar(9),
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'DATA_REF',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.vw_AFC_EE_INT_ACH_POR WHERE PERIOADA=@perioada and (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.vw_AFC_EE_INT_ACH_POR WHERE PERIOADA=@perioada AND (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( PERIOADA like ''%'+@search+'%'' or DATA_REF like ''%'+@search+'%'' or ORA_CONS like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( PERIOADA like ''%'+@search+'%'' or DATA_REF like ''%'+@search+'%'' or ORA_CONS like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.vw_AFC_EE_INT_ACH_POR WHERE PERIOADA=@perioada )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_ACH_POT]
@perioada varchar(9),
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'DATA_REF',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.vw_AFC_EE_INT_ACH_POT WHERE PERIOADA=@perioada and (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.vw_AFC_EE_INT_ACH_POT WHERE PERIOADA=@perioada AND (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( PERIOADA like ''%'+@search+'%'' or DATA_REF like ''%'+@search+'%'' or ORA_CONS like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( PERIOADA like ''%'+@search+'%'' or DATA_REF like ''%'+@search+'%'' or ORA_CONS like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.vw_AFC_EE_INT_ACH_POT WHERE PERIOADA=@perioada )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_ACH_SUBPOR_BANDA]
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'PARTENERDEAFACERI',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.vw_AFC_EE_INT_ACH_SUBPOR_BANDA WHERE (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.vw_AFC_EE_INT_ACH_SUBPOR_BANDA WHERE (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( PARTENERDEAFACERI like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( PARTENERDEAFACERI like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.vw_AFC_EE_INT_ACH_SUBPOR_BANDA )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_ACH_SUBPOR_PZU]
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'DATA_OFERTA',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.vw_AFC_EE_INT_ACH_SUBPOR_PZU WHERE (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.vw_AFC_EE_INT_ACH_SUBPOR_PZU WHERE (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( DATA_OFERTA like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( DATA_OFERTA like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.vw_AFC_EE_INT_ACH_SUBPOR_PZU )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/


CREATE PROCEDURE [dbo].[sp_AFC_EE_R_ALOC_ORAR]
(
@PERIOADA CHAR(9),
@LUNA SMALLINT 
)
AS
BEGIN ;

		SET XACT_ABORT , NOCOUNT ON;

		DECLARE @PARAMDEFINITON NVARCHAR(2000);
		DECLARE @SQLQUERY NVARCHAR(MAX);

		SET @PARAMDEFINITON =N'@PERIOADA CHAR(9), @LUNA SMALLINT ';

		SET @SQLQUERY= N'SELECT * FROM AFC_MD_ALOC WHERE PERIOADA=@PERIOADA AND LUNA=@LUNA' ;

		Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITON, @PERIOADA, @LUNA ;

END;






GO
/


CREATE PROCEDURE [dbo].[sp_AFC_EE_R_CANT_ALOC]
(
@PERIOADA CHAR(9)
)
AS
BEGIN ;
				SET XACT_ABORT , NOCOUNT ON;


	BEGIN TRY ;

			BEGIN TRAN ;

				CREATE TABLE #Cant_aloc (
											PERIOADA CHAR(9) NOT NULL,
											DATA_CONS DATETIME NOT NULL,
											CURBA VARCHAR(50) NOT NULL,
											CANT_ALOC FLOAT
											) ;

				DECLARE @START SMALLINT = 1;

				WHILE @START <= 12

				BEGIN

					INSERT INTO #Cant_aloc ( PERIOADA, DATA_CONS, CURBA, CANT_ALOC )
					SELECT PERIOADA, DATA_CONS, CURBA_ACTUAL, SUM(CANT_ALOC) 
					FROM   AFC_MD_ALOC
					WHERE  PERIOADA=@PERIOADA AND LUNA=@START
					GROUP BY PERIOADA, DATA_CONS, CURBA_ACTUAL  

					SET @START+=1 

				END

				DECLARE @SQLQUERY NVARCHAR(MAX),
						@PVT_COL_NUME NVARCHAR(MAX),
						@PVT_SEL_COL_NUME NVARCHAR(MAX) ;

				SELECT @PVT_COL_NUME= ISNULL(@PVT_COL_NUME + ',','') + QUOTENAME(CURBA) FROM (SELECT CURBA FROM #Cant_aloc GROUP BY CURBA) AS cat

				SELECT @PVT_SEL_COL_NUME = ISNULL(@PVT_SEL_COL_NUME + ',','') + 'ISNULL(' + QUOTENAME(CURBA) + ', 0) AS ' + QUOTENAME(CURBA) FROM (SELECT CURBA FROM #Cant_aloc GROUP BY CURBA) AS cat


				SET @SQLQUERY = N'
								SELECT PERIOADA, DATA_CONS, ' + @PVT_SEL_COL_NUME + '
								FROM #Cant_aloc
								pivot(sum(CANT_ALOC) for CURBA in (' + @PVT_COL_NUME + ')) as pvt
								ORDER BY DATA_CONS
								';

				EXEC sp_executesql @SQLQUERY

			COMMIT TRAN;			
-- => ERROR HANDLING
	END TRY 

		BEGIN CATCH ;
			IF @@TRANCOUNT>0
			ROLLBACK TRAN ;

			DECLARE @ERROR_MESSAGE VARCHAR(1000);
			SET @ERROR_MESSAGE=ERROR_MESSAGE() ;

			PRINT @ERROR_MESSAGE

		END CATCH ;
END;


GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_CANT_PA]
@PERIOADA varchar(9),
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'CODCLIENT',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM fn_AFC_EE_R_CANT_PA (@perioada) WHERE (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM fn_AFC_EE_R_CANT_PA (@perioada) WHERE (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( NUMEPERIOADA like ''%'+@search+'%'' or CODCLIENT like ''%'+@search+'%'' or NUMECLIENT like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( NUMEPERIOADA like ''%'+@search+'%'' or CODCLIENT like ''%'+@search+'%'' or NUMECLIENT like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM fn_AFC_EE_R_CANT_PA (@perioada) )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_CANT_POR]
@perioada varchar(9),
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'INSTALATIE',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM fn_AFC_EE_R_CANT_POR (@perioada) WHERE (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM fn_AFC_EE_R_CANT_POR (@perioada) WHERE (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( NUMEPERIOADA like ''%'+@search+'%'' or CODCLIENT like ''%'+@search+'%'' or NUMECLIENT like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( NUMEPERIOADA like ''%'+@search+'%'' or CODCLIENT like ''%'+@search+'%'' or NUMECLIENT like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM fn_AFC_EE_R_CANT_POR (@perioada) )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_CANT_POT]
@perioada varchar(9),
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'INSTALATIE',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM fn_AFC_EE_R_CANT_POT (@perioada) WHERE (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM fn_AFC_EE_R_CANT_POT (@perioada) WHERE (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( NUMEPERIOADA like ''%'+@search+'%'' or CODCLIENT like ''%'+@search+'%'' or NUMECLIENT like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( NUMEPERIOADA like ''%'+@search+'%'' or CODCLIENT like ''%'+@search+'%'' or NUMECLIENT like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM fn_AFC_EE_R_CANT_POT (@perioada) )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_CANT_TOP]
@perioada varchar(9),
@top int,
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'CODCLIENT',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM fn_AFC_EE_R_CANT_TOP (@perioada , @top ) WHERE (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM fn_AFC_EE_R_CANT_TOP (@perioada, @top) WHERE (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( NUMEPERIOADA like ''%'+@search+'%'' or CODCLIENT like ''%'+@search+'%'' or NUMECLIENT like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( NUMEPERIOADA like ''%'+@search+'%'' or CODCLIENT like ''%'+@search+'%'' or NUMECLIENT like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@perioada varchar(9), 
				@top int,
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @perioada, @top, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@perioada varchar(9), 
				@top int,
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @perioada, @top, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM fn_AFC_EE_R_CANT_TOP (@perioada, @top) )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/


CREATE PROCEDURE [dbo].[sp_AFC_EE_R_COEF_ACTUAL]
(
@AN SMALLINT
)
AS
BEGIN ;
				SET XACT_ABORT , NOCOUNT ON;


	BEGIN TRY ;

			BEGIN TRAN ;

				CREATE TABLE #COEF_actual (
											DATA_CONS DATETIME NOT NULL,
											CURBA VARCHAR(50) NOT NULL,
											COEF FLOAT
											) ;

				DECLARE @START SMALLINT = 1;

				WHILE @START <= 12

				BEGIN

					INSERT INTO #COEF_actual ( DATA_CONS, CURBA, COEF )
					SELECT DATA_CONS, CURBA, COEF 
					FROM   AFC_MD_DIM_COEF
					WHERE  MOD_ID = 1 AND AN=@AN AND LUNA=@START
					GROUP BY DATA_CONS, CURBA, COEF 

					SET @START+=1 

				END

				DECLARE @SQLQUERY NVARCHAR(MAX),
						@PVT_COL_NUME NVARCHAR(MAX),
						@PVT_SEL_COL_NUME NVARCHAR(MAX) ;

				SELECT @PVT_COL_NUME= ISNULL(@PVT_COL_NUME + ',','') + QUOTENAME(CURBA) FROM (SELECT CURBA FROM #COEF_actual GROUP BY CURBA) AS cat

				SELECT @PVT_SEL_COL_NUME = ISNULL(@PVT_SEL_COL_NUME + ',','') + 'ISNULL(' + QUOTENAME(CURBA) + ', 0) AS ' + QUOTENAME(CURBA) FROM (SELECT CURBA FROM #COEF_actual GROUP BY CURBA) AS cat


				SET @SQLQUERY = N'
								SELECT DATA_CONS, ' + @PVT_SEL_COL_NUME + '
								FROM #COEF_actual
								pivot(sum(COEF) for CURBA in (' + @PVT_COL_NUME + ')) as pvt
								ORDER BY DATA_CONS
								';

				EXEC sp_executesql @SQLQUERY

			COMMIT TRAN;			
-- => ERROR HANDLING
	END TRY 

		BEGIN CATCH ;
			IF @@TRANCOUNT>0
			ROLLBACK TRAN ;

			DECLARE @ERROR_MESSAGE VARCHAR(1000);
			SET @ERROR_MESSAGE=ERROR_MESSAGE() ;

			PRINT @ERROR_MESSAGE

		END CATCH ;
END;


GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_COEF_CURBA]
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'COD',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.AFC_EE_INT_COEF_CURBA WHERE (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.AFC_EE_INT_COEF_CURBA WHERE (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( COD like ''%'+@search+'%'' or DATA_CONS like ''%'+@search+'%'' or ORA_CONS like ''%'+@search+'%''  or INTERVAL_CONS like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( COD like ''%'+@search+'%'' or DATA_CONS like ''%'+@search+'%'' or ORA_CONS like ''%'+@search+'%''  or INTERVAL_CONS like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.AFC_EE_INT_COEF_CURBA )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_INTERV_ORA]
@an char(4),
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'DATA_CONS',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.AFC_EE_INT_INTERV_ORA WHERE AN=@an and (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.AFC_EE_INT_INTERV_ORA WHERE AN=@an AND (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( AN like ''%'+@search+'%'' or DATA_CONS like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( AN like ''%'+@search+'%'' or DATA_CONS like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@an char(4), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @an, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@an char(4), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @an, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.AFC_EE_INT_INTERV_ORA WHERE AN=@an )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_MAPARE_CURBA]
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'INSTALATIE',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.AFC_EE_INT_MAPARE_CURBA WHERE (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.AFC_EE_INT_MAPARE_CURBA WHERE (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( COD like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( COD like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.AFC_EE_INT_MAPARE_CURBA )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_MAPARE_CURBA_ERORI]
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'INSTALATIE',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.AFC_EE_VF_MAPARE_CURBA WHERE (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.AFC_EE_VF_MAPARE_CURBA WHERE (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( COD like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( COD like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.AFC_EE_VF_MAPARE_CURBA )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_MAPARE_SUBPOR]
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'PARTENERDEAFACERI',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.AFC_EE_INT_MAPARE_SUBPOR WHERE (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.AFC_EE_INT_MAPARE_SUBPOR WHERE (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( COD like ''%'+@search+'%'' or PARTENERDEAFACERI like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( COD like ''%'+@search+'%'' or PARTENERDEAFACERI like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.AFC_EE_INT_MAPARE_SUBPOR )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_MAPARE_SUBPOR_ERORI]
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'PARTENERDEAFACERI',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.AFC_EE_VF_MAPARE_SUBPOR WHERE (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.AFC_EE_VF_MAPARE_SUBPOR WHERE (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( COD like ''%'+@search+'%'' or PARTENERDEAFACERI like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( COD like ''%'+@search+'%'' or PARTENERDEAFACERI like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.AFC_EE_VF_MAPARE_SUBPOR )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_POR_CANT]
@perioada varchar(9),
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'INSTALATIE',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
    SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.vw_AFC_EE_INT_POR_CANT WHERE PERIOADA=@perioada and (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.vw_AFC_EE_INT_POR_CANT WHERE PERIOADA=@perioada AND (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( PERIOADA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( PERIOADA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.vw_AFC_EE_INT_POR_CANT WHERE PERIOADA=@perioada )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_POR_CANT_ERORI]
@perioada varchar(9),
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'INSTALATIE',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.AFC_EE_VF_POR_CANT WHERE PERIOADA=@perioada and (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.AFC_EE_VF_POR_CANT WHERE PERIOADA=@perioada AND (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( PERIOADA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( PERIOADA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.AFC_EE_VF_POR_CANT WHERE PERIOADA=@perioada )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_POR_CANT_MOD]
@perioada varchar(9),
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'INSTALATIE',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.vw_AFC_EE_INT_POR_CANT_MOD WHERE PERIOADA=@perioada and (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.vw_AFC_EE_INT_POR_CANT_MOD WHERE PERIOADA=@perioada and (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( PERIOADA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( PERIOADA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	' 
				@perioada varchar(9),
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.vw_AFC_EE_INT_POR_CANT_MOD WHERE PERIOADA=@perioada )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_POR_CONTR]
@perioada varchar(9),
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'INSTALATIE',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.AFC_EE_INT_POR_CONTR WHERE PERIOADA=@perioada and (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.AFC_EE_INT_POR_CONTR WHERE PERIOADA=@perioada AND (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( PERIOADA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'' or PARTENERDEAFACERI like ''%'+@search+'%'' or DENUMIREPARTENER like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( PERIOADA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'' or PARTENERDEAFACERI like ''%'+@search+'%'' or DENUMIREPARTENER like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.AFC_EE_INT_POR_CONTR WHERE PERIOADA=@perioada )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_POR_CONTR_ERORI]
@perioada varchar(9),
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'INSTALATIE',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.AFC_EE_VF_POR_CONTR WHERE PERIOADA=@perioada and (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.AFC_EE_VF_POR_CONTR WHERE PERIOADA=@perioada AND (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( PERIOADA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'' or PARTENERDEAFACERI like ''%'+@search+'%'' or DENUMIREPARTENER like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( PERIOADA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'' or PARTENERDEAFACERI like ''%'+@search+'%'' or DENUMIREPARTENER like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.AFC_EE_VF_POR_CONTR WHERE PERIOADA=@perioada )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_POR_CONTR_MOD]
@perioada varchar(9),
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'INSTALATIE',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.AFC_EE_INT_POR_CONTR_MOD WHERE PERIOADA=@perioada and (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.AFC_EE_INT_POR_CONTR_MOD WHERE PERIOADA=@perioada AND (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( PERIOADA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'' or PARTENERDEAFACERI like ''%'+@search+'%'' or DENUMIREPARTENER like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( PERIOADA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'' or PARTENERDEAFACERI like ''%'+@search+'%'' or DENUMIREPARTENER like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.AFC_EE_INT_POR_CONTR_MOD WHERE PERIOADA=@perioada )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_POR_CONTR_REZ]
@perioada varchar(9),
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'INSTALATIE',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.AFC_EE_INT_POR_CONTR_REZ WHERE PERIOADA=@perioada and (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.AFC_EE_INT_POR_CONTR_REZ WHERE PERIOADA=@perioada AND (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( PERIOADA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( PERIOADA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.AFC_EE_INT_POR_CONTR_REZ WHERE PERIOADA=@perioada )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_POT_BM]
@perioada varchar(9),
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'SEGMENTCLIENT',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.vw_AFC_EE_INT_POT_BM WHERE PERIOADA=@perioada and (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.vw_AFC_EE_INT_POT_BM WHERE PERIOADA=@perioada AND (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( PERIOADA like ''%'+@search+'%'' or SEGMENTCLIENT like ''%'+@search+'%'' or REGIUNE_PORTOFOLIU like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( PERIOADA like ''%'+@search+'%'' or SEGMENTCLIENT like ''%'+@search+'%'' or REGIUNE_PORTOFOLIU like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.vw_AFC_EE_INT_POT_BM WHERE PERIOADA=@perioada )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_POT_BM_ERORI]
@perioada varchar(9),
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'SEGMENTCLIENT',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.AFC_EE_VF_POT_BM WHERE PERIOADA=@perioada and (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.AFC_EE_VF_POT_BM WHERE PERIOADA=@perioada AND (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( PERIOADA like ''%'+@search+'%'' or SEGMENTCLIENT like ''%'+@search+'%'' or REGIUNE_PORTOFOLIU like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( PERIOADA like ''%'+@search+'%'' or SEGMENTCLIENT like ''%'+@search+'%'' or REGIUNE_PORTOFOLIU like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.AFC_EE_VF_POT_BM WHERE PERIOADA=@perioada )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_POT_KA]
@perioada varchar(9),
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'SEGMENTCLIENT',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.vw_AFC_EE_INT_POT_KA WHERE PERIOADA=@perioada and (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.vw_AFC_EE_INT_POT_KA WHERE PERIOADA=@perioada AND (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( PERIOADA like ''%'+@search+'%'' or SEGMENTCLIENT like ''%'+@search+'%'' or REGIUNE_PORTOFOLIU like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( PERIOADA like ''%'+@search+'%'' or SEGMENTCLIENT like ''%'+@search+'%'' or REGIUNE_PORTOFOLIU like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.vw_AFC_EE_INT_POT_KA WHERE PERIOADA=@perioada )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_POT_KA_ERORI]
@perioada varchar(9),
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'SEGMENTCLIENT',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.AFC_EE_VF_POT_KA WHERE PERIOADA=@perioada and (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.AFC_EE_VF_POT_KA WHERE PERIOADA=@perioada AND (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( PERIOADA like ''%'+@search+'%'' or SEGMENTCLIENT like ''%'+@search+'%'' or REGIUNE_PORTOFOLIU like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( PERIOADA like ''%'+@search+'%'' or SEGMENTCLIENT like ''%'+@search+'%'' or REGIUNE_PORTOFOLIU like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.AFC_EE_VF_POT_KA WHERE PERIOADA=@perioada )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_PRET_FURN]
@perioada varchar(9),
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'INSTALATIE',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.vw_AFC_EE_INT_PRET_FURN WHERE PERIOADA=@perioada and (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.vw_AFC_EE_INT_PRET_FURN WHERE PERIOADA=@perioada AND (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( PERIOADA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( PERIOADA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.vw_AFC_EE_INT_PRET_FURN WHERE PERIOADA=@perioada )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_PRET_FURN_AD_HOC]
@perioada varchar(9),
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'INSTALATIE',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
    SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.vw_AFC_EE_INT_PRET_FURN_AD_HOC WHERE PERIOADA=@perioada and (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.vw_AFC_EE_INT_PRET_FURN_AD_HOC WHERE PERIOADA=@perioada AND (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( PERIOADA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( PERIOADA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.vw_AFC_EE_INT_PRET_FURN_AD_HOC WHERE PERIOADA=@perioada )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_PRET_FURN_AD_HOC_ERORI]
@perioada varchar(9),
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'INSTALATIE',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.AFC_EE_VF_PRET_FURN_AD_HOC WHERE PERIOADA=@perioada and (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.AFC_EE_VF_PRET_FURN_AD_HOC WHERE PERIOADA=@perioada AND (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( PERIOADA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( PERIOADA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.AFC_EE_VF_PRET_FURN_AD_HOC WHERE PERIOADA=@perioada )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_PRET_FURN_DATE]
@perioada varchar(9),
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'INSTALATIE',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM fn_AFC_EE_R_PRET_FURN (@perioada) WHERE (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM fn_AFC_EE_R_PRET_FURN (@perioada) WHERE (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( NUMEPERIOADA like ''%'+@search+'%'' or CODCLIENT like ''%'+@search+'%'' or NUMECLIENT like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( NUMEPERIOADA like ''%'+@search+'%'' or CODCLIENT like ''%'+@search+'%'' or NUMECLIENT like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM fn_AFC_EE_R_PRET_FURN (@perioada) )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_PRET_FURN_ERORI]
@perioada varchar(9),
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'INSTALATIE',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.AFC_EE_VF_PRET_FURN WHERE PERIOADA=@perioada and (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.AFC_EE_VF_PRET_FURN WHERE PERIOADA=@perioada AND (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( PERIOADA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( PERIOADA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.AFC_EE_VF_PRET_FURN WHERE PERIOADA=@perioada )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_PRET_FURN_MOD]
@perioada varchar(9),
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'INSTALATIE',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.vw_AFC_EE_INT_PRET_FURN_MOD WHERE PERIOADA=@perioada and (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.vw_AFC_EE_INT_PRET_FURN_MOD WHERE PERIOADA=@perioada AND (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( PERIOADA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( PERIOADA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.vw_AFC_EE_INT_PRET_FURN_MOD WHERE PERIOADA=@perioada )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_SEM_CANT]
@perioada varchar(9),
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'SEGMENTCLIENT',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.vw_AFC_EE_INT_SEM_CANT WHERE PERIOADA=@perioada and (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.vw_AFC_EE_INT_SEM_CANT WHERE PERIOADA=@perioada AND (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( PERIOADA like ''%'+@search+'%'' or SEGMENTCLIENT like ''%'+@search+'%'' or REGIUNE_PORTOFOLIU like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( PERIOADA like ''%'+@search+'%'' or SEGMENTCLIENT like ''%'+@search+'%'' or REGIUNE_PORTOFOLIU like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.vw_AFC_EE_INT_SEM_CANT WHERE PERIOADA=@perioada )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_SEM_CANT_ERORI]
@perioada varchar(9),
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'SEGMENTCLIENT',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.AFC_EE_VF_SEM_CANT WHERE PERIOADA=@perioada and (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.AFC_EE_VF_SEM_CANT WHERE PERIOADA=@perioada AND (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( PERIOADA like ''%'+@search+'%'' or SEGMENTCLIENT like ''%'+@search+'%'' or REGIUNE_PORTOFOLIU like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( PERIOADA like ''%'+@search+'%'' or SEGMENTCLIENT like ''%'+@search+'%'' or REGIUNE_PORTOFOLIU like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.AFC_EE_VF_SEM_CANT WHERE PERIOADA=@perioada )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_TARIF_DISTR]
@perioada varchar(9),
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'DENUMIREDISTRIBUITOR',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.vw_AFC_EE_INT_TARIF_DISTR WHERE PERIOADA=@perioada and (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.vw_AFC_EE_INT_TARIF_DISTR WHERE PERIOADA=@perioada AND (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( PERIOADA like ''%'+@search+'%'' or DENUMIREDISTRIBUITOR like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( PERIOADA like ''%'+@search+'%'' or DENUMIREDISTRIBUITOR like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.vw_AFC_EE_INT_TARIF_DISTR WHERE PERIOADA=@perioada )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_AFC_EE_R_TARIF_DISTR_ERORI]
@perioada varchar(9),
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'DENUMIREDISTRIBUITOR',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.AFC_EE_VF_TARIF_DISTR WHERE PERIOADA=@perioada and (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.AFC_EE_VF_TARIF_DISTR WHERE PERIOADA=@perioada AND (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( PERIOADA like ''%'+@search+'%'' or DENUMIREDISTRIBUITOR like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( PERIOADA like ''%'+@search+'%'' or DENUMIREDISTRIBUITOR like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@perioada varchar(9), 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @perioada, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.AFC_EE_VF_TARIF_DISTR WHERE PERIOADA=@perioada )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/
CREATE PROCEDURE [dbo].[sp_AFC_FCAPP_CODCOMPANIE_ADD]	
	@COD varchar(9),
	@NUME varchar(50),
	@MOD_DE varchar(20),
	@result_status as smallint OUTPUT,-- 1 - ERROR, 0 - OK
	@result_message as nvarchar(1000) OUTPUT
AS
BEGIN

	SET NOCOUNT ON;
	DECLARE @nr_count AS smallint
	DECLARE @ErrorMessage NVARCHAR(1000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

	BEGIN TRY

		SELECT @nr_count = COUNT(COD) FROM AFC_INT_CODCOMPANIE WHERE upper(COD) = upper(@COD);

		IF @nr_count = 0
		BEGIN
			insert into AFC_INT_CODCOMPANIE(COD, NUME, MOD_DE)
			values(@COD, @NUME, @MOD_DE);

			SELECT @result_message = 'Elementul a fost adaugat cu succes', @result_status = 0
		END
		else
		begin		
			SELECT @result_message = 'Elementul exista in baza de date, nu se poate adauga altul cu acelasi cod', @result_status = 0
		end;			
		
		
	END TRY
	BEGIN CATCH
			SELECT @ErrorMessage = ERROR_MESSAGE(),
           @ErrorSeverity = ERROR_SEVERITY(),
           @ErrorState = ERROR_STATE();

		   			RAISERROR (@ErrorMessage, -- Message text.
						   @ErrorSeverity, -- Severity.
						   @ErrorState -- State.
						   )
	END CATCH

RETURNP:

END
GO



