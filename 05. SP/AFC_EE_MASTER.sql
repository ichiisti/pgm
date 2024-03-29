CREATE PROCEDURE [dbo].[master_AFC_EE_CALC_ACH]
( 
@PERIOADA CHAR(9) 
 )
AS
BEGIN

		SET XACT_ABORT, NOCOUNT ON;
	
		DECLARE @OBJECT_NAME  CHAR(100);
		SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;
		DECLARE @MSG VARCHAR(100);

		DECLARE @CHECK BIT ;
		EXEC sp_AFC_CHECK_PER @PERIOADA,@CHECK OUTPUT

			IF (SELECT CASE WHEN @CHECK IS NULL THEN 0 ELSE @CHECK  END)=1
				BEGIN

						SET  @MSG ='PERIOADA :'+@PERIOADA+''+' ESTE VALIDA !' ;
						EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'INFORMARE' ,@MSG
						PRINT @PERIOADA +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG

						DECLARE @ERROR_ACH_TRAN BIT ;
						EXEC sp_AFC_EE_VF_COST_ACH_TRANS @PERIOADA, @ERROR_ACH_TRAN OUTPUT ;

						IF @ERROR_ACH_TRAN=1
							BEGIN

								-- CALC AVG COST --------------------------------------------------------------------------------------------------------- 
								EXEC sp_AFC_EE_P_ACH_ORA @PERIOADA ;

								-- CALC P2 & P3 ----------------------------------------------------------------------------------------------------------- 
								DECLARE @SUBPOR CHAR(2);

								SET @SUBPOR='P2' ;
								EXEC dbo.sp_AFC_EE_P_ACH_PROF_FIX  @PERIOADA, @SUBPOR;

								SET @SUBPOR='P3' ;
								EXEC dbo.sp_AFC_EE_P_ACH_PROF_FIX  @PERIOADA, @SUBPOR;

								-- CALC P1 ---------------------------------------------------------------------------------------------------------------- 
								DECLARE @LUNA CHAR(2);
								SELECT  @LUNA=MIN(LUNA) FROM dbo.AFC_MD_ALOC WHERE PERIOADA=@PERIOADA;

								WHILE   @LUNA<=12
									BEGIN
										EXEC dbo.sp_AFC_EE_P_ACH_PROF_REST  @PERIOADA, 'P1', @LUNA ;
										SET @LUNA=@LUNA+1 ;
									END

								-- CALC P4 ---------------------------------------------------------------------------------------------------------------- 
								EXEC dbo.sp_AFC_EE_P_ACH_PROF_POT @PERIOADA, 'P4';

								-- INSERT / UPDATE DIM & FACT  TABLE --------------------------------------------------------------------------------------
								DECLARE @DIF FLOAT;
								SELECT  @DIF=SUM(COST_DIF) FROM fn_AFC_EE_VF_COST_ACH_DIF (@PERIOADA);

								IF ISNULL(@DIF,0) BETWEEN -20000 AND 20000
									BEGIN
										EXEC dbo.sp_AFC_EE_P_DATE_ORA @PERIOADA;
										EXEC dbo.sp_AFC_EE_P_COST_ACH  @PERIOADA;

										SELECT  @CHECK = SUM(COST_DIF) FROM dbo.fn_AFC_EE_COST_LUNA_CHECK (@PERIOADA) ;

										IF ISNULL(@CHECK,0) BETWEEN -400000 AND 400000
											BEGIN	
												EXEC dbo.sp_AFC_EE_P_KPI_EVO @PERIOADA, '1' ;
											END
										ELSE
											BEGIN
												SET   @MSG ='COSTUL DE ACHIZITIE ORAR DIFERA DE COST DE ACHIZITIE LUNAR PENTRU PERIOADA '+' '+@PERIOADA+'!';
												EXEC  sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG
												PRINT @PERIOADA +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@MSG
											END;
									END
								ELSE 
									BEGIN
										SET  @MSG ='01- COSTUL DE ACHIZITIE NU A FOST CORECT ALOCATA ' +@PERIOADA+' ! ' ;
										EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG
										PRINT @PERIOADA +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@MSG
									END
							END

							ELSE IF @ERROR_ACH_TRAN=0
							BEGIN
								SET  @MSG ='01- VA ROG SA CORECTATI ERORILE PENTRU PERIOADA ' +@PERIOADA+' ! ' ;
								EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG
								;THROW 500001,@MSG,1;
							END ;
					END
-- ERROR HANDLING ------------------------------------------------------------------------------------------------------------------------------------
				ELSE 
					BEGIN
						SET	 @MSG ='PERIOADA : '+@PERIOADA+' NU ESTE VALIDA, VA ROG VERIFICATI IN TABELA DE INPUT ! '
						EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG
						PRINT @PERIOADA +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@MSG
					END

END
GO
/

CREATE PROCEDURE [dbo].[master_AFC_EE_CALC_CANT_ORA]
( 
@PERIOADA CHAR(9) 
 )
AS
BEGIN

		SET XACT_ABORT, NOCOUNT ON;
	
		DECLARE @OBJECT_NAME  CHAR(100);
		SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;

		DECLARE @CHECK BIT ;
		EXEC sp_AFC_CHECK_PER @PERIOADA,@CHECK OUTPUT

			IF (SELECT CASE WHEN @CHECK IS NULL THEN 0 ELSE @CHECK  END)=1
				BEGIN
					DECLARE @MSG_1 VARCHAR(100);
					SET	@MSG_1='PERIOADA :'+@PERIOADA+''+' ESTE VALIDA !' ;
					EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'INFORMARE' ,@MSG_1
					PRINT @PERIOADA +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_1
				
						DECLARE @ERROR_M_CURBA BIT ;
						EXEC sp_AFC_EE_VF_MAPARE_CURBA @PERIOADA, @ERROR_M_CURBA OUTPUT ;

						IF @ERROR_M_CURBA=1
							BEGIN
								EXEC sp_AFC_EE_P_CURBA @PERIOADA;
								EXEC sp_AFC_EE_P_SUBPOR @PERIOADA;
								EXEC dbo.sp_AFC_EE_P_MATURITATE @PERIOADA  ;
								EXEC sp_AFC_EE_P_ALOC  @PERIOADA;

								DECLARE @CANT INT ;
								SELECT  @CANT = SUM(CANT_DIF) FROM dbo.fn_AFC_EE_CANT_ALOC_CHECK (@PERIOADA) ;

								IF ISNULL(@CANT,0)<=500
									BEGIN																					   
										EXEC sp_AFC_EE_P_DATE_ORA  @PERIOADA;
									END
								ELSE
									BEGIN
										DECLARE @MSG_2 VARCHAR(100);
										SET     @MSG_2 ='CANTITATILE NU AU FOST CORECT ALOCATE PE INTERVAL ORAR PENTRU PERIOADA '+' '+@PERIOADA+'!';
										EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG_2
										PRINT @PERIOADA +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@MSG_2
										;THROW 500001,@MSG_2,1;
									END
							END
						ELSE IF @ERROR_M_CURBA=0
							BEGIN
								DECLARE @MSG_3 VARCHAR(100);
								SET     @MSG_3='01- VA ROG SA CORECATI ERORILE PENTRU PERIOADA ' +@PERIOADA+' ! ' ;
								EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG_3
								;THROW 500001,@MSG_3,1;
							END ;
				END

			ELSE 
				BEGIN
					DECLARE @MSG_4 VARCHAR(100);
					SET	@MSG_4='PERIOADA : '+@PERIOADA+' NU ESTE VALIDA, VA ROG VERIFICATI IN TABELA DE INPUT ! '
					EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG_4
					PRINT @PERIOADA +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@MSG_4
				END

END
GO
/

CREATE PROCEDURE [dbo].[master_AFC_EE_CALC_MARJA]
( 
@PERIOADA CHAR(9) 
 )
AS
BEGIN
select * from AFC_EE_INT_DEF_KPI

		SET XACT_ABORT, NOCOUNT ON;
	
		DECLARE @OBJECT_NAME  CHAR(100);
		SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;

		DECLARE @CHECK BIT ;
		EXEC sp_AFC_CHECK_PER @PERIOADA,@CHECK OUTPUT

			IF (SELECT CASE WHEN @CHECK IS NULL THEN 0 ELSE @CHECK  END)=1
				BEGIN
					DECLARE @MSG_1 VARCHAR(100);
					SET     @MSG_1='PERIOADA :'+@PERIOADA+''+' ESTE VALIDA !' ;
					EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'INFORMARE' ,@MSG_1
					PRINT @PERIOADA +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_1

						DECLARE @ERROR_GM_TARGET BIT  ;
						EXEC dbo.sp_AFC_EE_VF_GM_TARGET @PERIOADA , @ERROR_GM_TARGET OUTPUT ;

						IF @ERROR_GM_TARGET=1
							BEGIN
								EXEC dbo.sp_AFC_EE_P_GM @PERIOADA ;
								EXEC dbo.master_AFC_EE_SIM_SEGM_PRICE @PERIOADA ;
								EXEC dbo.master_AFC_EE_SIM_PRET_FURN @PERIOADA ;
								EXEC dbo.sp_AFC_EE_P_KPI_EVO @PERIOADA , '1' ;
								EXEC dbo.sp_AFC_EE_P_KPI_EVO @PERIOADA , '2' ;
								EXEC dbo.sp_AFC_EE_P_KPI_EVO @PERIOADA , '3' ;
							END
						ELSE IF @ERROR_GM_TARGET=0
							BEGIN
								DECLARE @MSG_2 VARCHAR(100);
								SET     @MSG_2='01- VA ROG SA CORECATI ERORILE PENTRU PERIOADA ' +@PERIOADA+' ! ' ;
								EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG_2
								;THROW 500001,@MSG_2,1;
							END
						
				END
			ELSE 
				BEGIN
					DECLARE @MSG_3 VARCHAR(100);
					SET     @MSG_3='PERIOADA : '+@PERIOADA+' NU ESTE VALIDA, VA ROG VERIFICATI IN TABELA DE INPUT ! '
					EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG_3
					PRINT @PERIOADA +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@MSG_3
				END

END
GO
/

CREATE PROCEDURE [dbo].[master_AFC_EE_CALC_SUBPOR]
( 
@PERIOADA CHAR(9) 
 )
AS
BEGIN

		SET XACT_ABORT, NOCOUNT ON;
	
		DECLARE @OBJECT_NAME  CHAR(100);
		SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;

		DECLARE @CHECK BIT ;
		EXEC sp_AFC_CHECK_PER @PERIOADA,@CHECK OUTPUT

			IF (SELECT CASE WHEN @CHECK IS NULL THEN 0 ELSE @CHECK  END)=1
				BEGIN
					DECLARE @MSG_1 VARCHAR(100);
					SET	@MSG_1='PERIOADA :'+@PERIOADA+''+' ESTE VALIDA !' ;
					EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'INFORMARE' ,@MSG_1
					PRINT @PERIOADA +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_1
				
					EXEC dbo.sp_AFC_EE_P_DATE_SUBPOR @PERIOADA ;
					EXEC sp_AFC_EE_P_DATE_ORA  @PERIOADA;

				END

			ELSE 
				BEGIN
					DECLARE @MSG_4 VARCHAR(100);
					SET	@MSG_4='PERIOADA : '+@PERIOADA+' NU ESTE VALIDA, VA ROG VERIFICATI IN TABELA DE INPUT ! '
					EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG_4
					PRINT @PERIOADA +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@MSG_4
				END

END
GO
/

CREATE PROCEDURE [dbo].[master_AFC_EE_CHECK_ACH]
( 
@PERIOADA CHAR(9) 
 )
AS
BEGIN

		SET XACT_ABORT, NOCOUNT ON;
	
		DECLARE @OBJECT_NAME  CHAR(100);
		SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;

		DECLARE @CHECK BIT ;
		EXEC sp_AFC_CHECK_PER @PERIOADA,@CHECK OUTPUT

			IF (SELECT CASE WHEN @CHECK IS NULL THEN 0 ELSE @CHECK  END)=1
				BEGIN
					DECLARE @MSG_1 VARCHAR(100);
					SET	@MSG_1='PERIOADA :'+@PERIOADA+''+' ESTE VALIDA !' ;
					EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'INFORMARE' ,@MSG_1
					PRINT @PERIOADA +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_1

						DECLARE @ERROR_ACH_TRAN BIT ;
						EXEC sp_AFC_EE_VF_COST_ACH_TRANS @PERIOADA, @ERROR_ACH_TRAN OUTPUT ;

						IF @ERROR_ACH_TRAN=1
							BEGIN

								DECLARE @MSG_2 VARCHAR(100);
								SET     @MSG_2='01- DATELE DE ACHIZITIE SUNT VALIDE PENTRU PERIOADA ' +@PERIOADA+' ! ' ;
								EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'INFORMARE' ,@MSG_2

							END
						ELSE IF @ERROR_ACH_TRAN=0
							BEGIN
								DECLARE @MSG_3 VARCHAR(100);
								SET     @MSG_3='01- VA ROG SA CORECATI ERORILE PENTRU PERIOADA ' +@PERIOADA+' ! ' ;
								EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG_3
								;THROW 500001,@MSG_3,1;
							END ;
				END

			ELSE 
				BEGIN
					DECLARE @MSG_4 VARCHAR(100);
					SET		@MSG_4='PERIOADA : '+@PERIOADA+' NU ESTE VALIDA, VA ROG VERIFICATI IN TABELA DE INPUT ! '
					EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG_4
					PRINT @PERIOADA +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@MSG_4
				END

END
GO
/

CREATE PROCEDURE [dbo].[master_AFC_EE_INREG_DATE_CURBA]
(
@PERIOADA CHAR(9) = '999999999'
)
AS
BEGIN

		SET XACT_ABORT, NOCOUNT ON;

		DECLARE @OBJECT_NAME  CHAR(100);
		SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;
			
		DECLARE @ERROR_D_CURBA BIT ;
		EXEC sp_AFC_EE_VF_DATE_CURBA @PERIOADA, @ERROR_D_CURBA OUTPUT ;

		IF @ERROR_D_CURBA=1
			BEGIN
				EXEC sp_AFC_EE_P_ID_CURBA @PERIOADA;
				EXEC sp_AFC_EE_P_COEF_CURBA  @PERIOADA;
			END
		ELSE IF @ERROR_D_CURBA=0
			BEGIN
				DECLARE @MSG_2 VARCHAR(100);
				SET     @MSG_2='01- VA ROG SA CORECATI ERORILE !';
				EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG_2
				;THROW 500001,@MSG_2,1;
			END ;


END
GO
/

CREATE PROCEDURE [dbo].[master_AFC_EE_INREG_DATE_SUBPOR]
(
@PERIOADA CHAR(9) = '999999999'
)
AS
BEGIN

		SET XACT_ABORT, NOCOUNT ON;

		DECLARE @OBJECT_NAME  CHAR(100);
		SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;


---------------------- Check the valadity of sub-portfolio ------------------------------------------------------------------------------------------------

		TRUNCATE TABLE AFC_EE_VF_DATE_SUBPOR ; 

		DECLARE @EROR NVARCHAR(100)='VALABILITATEA NU POATE SA FIE DE TIP 9999';
		DECLARE @SIR_CONT NVARCHAR(MAX);
      
			WITH src AS  (	
						SELECT DISTINCT PARTENERDEAFACERI FROM dbo.AFC_EE_INT_ACH_SUBPOR_BANDA WHERE  (DATEPART(YEAR,VALABIL_PANALA)=(9999))
						)

		SELECT @SIR_CONT = CONCAT_WS(',',@SIR_CONT ,src.PARTENERDEAFACERI) FROM src ;

		INSERT INTO dbo.AFC_EE_VF_DATE_SUBPOR ( MESAJ_EROARE )
		SELECT  @EROR +' : '+@SIR_CONT ;

---------------------- If valadity has errors -----------------------------------------------------------------------------------------------------------

		DECLARE @COUNT FLOAT;							
					
		SELECT @COUNT= COUNT(*) FROM dbo.AFC_EE_VF_DATE_SUBPOR WHERE MESAJ_EROARE IS NOT NULL ;

		IF @COUNT>0
					BEGIN

							DECLARE @MSG_1 VARCHAR(100);
							SET     @MSG_1='01-  '+cast(@COUNT as varchar(255)) + ' DE ERORI AU FOST IDENTIFICATE !';

							EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG_1
							PRINT @PERIOADA +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@MSG_1
					END
---------------------- If valadity is w/o errors ------------------------------------------------------------------------------------------------------

		ELSE IF @COUNT=0
					BEGIN	
					
						DECLARE @ERROR_SUBPOR BIT ;
						EXEC sp_AFC_EE_VF_DATE_SUBPOR @PERIOADA, @ERROR_SUBPOR OUTPUT ;

						IF @ERROR_SUBPOR=1
							BEGIN
								EXEC sp_AFC_EE_P_ID_SUBPOR @PERIOADA;
								EXEC sp_AFC_EE_P_ID_BANDA @PERIOADA;
								EXEC sp_AFC_EE_P_COST_SUBPOR_NOU @PERIOADA;
							END
						ELSE IF @ERROR_SUBPOR=0
							BEGIN
								DECLARE @MSG_2 VARCHAR(100);
								SET     @MSG_2='01- VA ROG SA CORECATI ERORILE !';
								EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG_2
								;THROW 500001,@MSG_2,1;
							END ;

					END


END


GO
/

CREATE PROCEDURE [dbo].[master_AFC_EE_INREG_POR_CANT]
( 
@PERIOADA CHAR(9) 
 )
AS
BEGIN

		SET XACT_ABORT, NOCOUNT ON;
	
		DECLARE @OBJECT_NAME  CHAR(100);
		SET          @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;

		DECLARE @CHECK BIT ;
		EXEC sp_AFC_CHECK_PER @PERIOADA,@CHECK OUTPUT

			IF (SELECT CASE WHEN @CHECK IS NULL THEN 0 ELSE @CHECK  END)=1
				BEGIN
					DECLARE @MSG_1 VARCHAR(100);
					SET     @MSG_1='PERIOADA :'+@PERIOADA+''+' ESTE VALIDA !' ;
					EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'INFORMARE' ,@MSG_1
					PRINT @PERIOADA +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_1

						EXEC sp_AFC_EE_INT_POR_CANT_MOD @PERIOADA ;

						DECLARE @ERROR_POR_CANT BIT  ;
						EXEC sp_AFC_EE_VF_POR_CANT @PERIOADA , @ERROR_POR_CANT OUTPUT ;

						IF @ERROR_POR_CANT=1
							BEGIN
								EXEC sp_AFC_EE_P_POR_CANT @PERIOADA 
								EXEC dbo.sp_AFC_EE_P_KPI_EVO @PERIOADA, '1' ;
							END
						ELSE IF @ERROR_POR_CANT=0
							BEGIN
								DECLARE @MSG_2 VARCHAR(100);
								SET     @MSG_2='01- VA ROG SA CORECATI ERORILE PENTRU PERIOADA ' +@PERIOADA+' ! ' ;
								EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG_2
								;THROW 500001,@MSG_2,1;
							END
				END
			ELSE 
				BEGIN
					DECLARE @MSG_3 VARCHAR(100);
					SET     @MSG_3='PERIOADA : '+@PERIOADA+' NU ESTE VALIDA, VA ROG VERIFICATI IN TABELA DE INPUT ! '
					EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG_3
					PRINT @PERIOADA +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@MSG_3
				END

END
GO
/

CREATE PROCEDURE [dbo].[master_AFC_EE_INREG_POR_CONTR]
( 
@PERIOADA CHAR(9) 
 )
AS
BEGIN

		SET XACT_ABORT, NOCOUNT ON;
	
		DECLARE @OBJECT_NAME  CHAR(100);
		SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;

		DECLARE @CHECK BIT ;
		EXEC sp_AFC_CHECK_PER @PERIOADA,@CHECK OUTPUT

			IF (SELECT CASE WHEN @CHECK IS NULL THEN 0 ELSE @CHECK  END)=1
				BEGIN
					DECLARE @MSG_1 VARCHAR(100);
					SET     @MSG_1='PERIOADA :'+@PERIOADA+''+' ESTE VALIDA !' ;
					EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'INFORMARE' ,@MSG_1
					PRINT @PERIOADA +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_1

						EXEC sp_AFC_EE_INT_POR_CONTR_MOD @PERIOADA ;
						EXEC sp_AFC_EE_INT_POR_CONTR_REZ @PERIOADA ;

						DECLARE @ERROR_POR_CONTR BIT  ;
						EXEC sp_AFC_EE_VF_POR_CONTR @PERIOADA , @ERROR_POR_CONTR OUTPUT ;

						IF @ERROR_POR_CONTR=1
							BEGIN
								EXEC sp_AFC_EE_P_POR_CONTR @PERIOADA 
							END
						ELSE IF @ERROR_POR_CONTR=0
							BEGIN
								DECLARE @MSG_2 VARCHAR(100);
								SET     @MSG_2='01- VA ROG SA CORECATI ERORILE PENTRU PERIOADA ' +@PERIOADA+' ! ' ;
								EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG_2
								;THROW 500001,@MSG_2,1;
							END
				END
			ELSE 
				BEGIN
					DECLARE @MSG_3 VARCHAR(100);
					SET     @MSG_3='PERIOADA : '+@PERIOADA+' NU ESTE VALIDA, VA ROG VERIFICATI IN TABELA DE INPUT ! '
					EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG_3
					PRINT @PERIOADA +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@MSG_3
				END

END
GO
/

CREATE PROCEDURE [dbo].[master_AFC_EE_INREG_POT]
( 
@PERIOADA CHAR(9) 
 )
AS
BEGIN

		SET XACT_ABORT, NOCOUNT ON;
	
		DECLARE @OBJECT_NAME  CHAR(100);
		SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;

		DECLARE @CHECK BIT ;
		EXEC sp_AFC_CHECK_PER @PERIOADA,@CHECK OUTPUT

			IF (SELECT CASE WHEN @CHECK IS NULL THEN 0 ELSE @CHECK  END)=1
				BEGIN
					DECLARE @MSG_1 VARCHAR(100);
					SET     @MSG_1='PERIOADA :'+@PERIOADA+''+' ESTE VALIDA !' ;
					EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'INFORMARE' ,@MSG_1
					PRINT @PERIOADA +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_1

						DECLARE @ERROR_POT_BM BIT  ;
						DECLARE @ERROR_POT_KA BIT  ;
						EXEC sp_AFC_EE_VF_POT_BM @PERIOADA , @ERROR_POT_BM OUTPUT ;
						EXEC sp_AFC_EE_VF_POT_KA @PERIOADA , @ERROR_POT_KA OUTPUT ;

						IF @ERROR_POT_BM=1 AND @ERROR_POT_KA=1
							BEGIN
								EXEC sp_AFC_EE_P_POT @PERIOADA 
								EXEC dbo.sp_AFC_EE_P_KPI_EVO @PERIOADA, '1' ;
							END
						ELSE IF @ERROR_POT_BM=0 AND @ERROR_POT_KA=0
							BEGIN
								DECLARE @MSG_2 VARCHAR(100);
								SET     @MSG_2='01- VA ROG SA CORECATI ERORILE PENTRU PERIOADA ' +@PERIOADA+' ! ' ;
								EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG_2
								;THROW 500001,@MSG_2,1;
							END
				END
			ELSE 
				BEGIN
					DECLARE @MSG_3 VARCHAR(100);
					SET     @MSG_3='PERIOADA : '+@PERIOADA+' NU ESTE VALIDA, VA ROG VERIFICATI IN TABELA DE INPUT ! '
					EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG_3
					PRINT @PERIOADA +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@MSG_3
				END

END
GO
/


CREATE PROCEDURE [dbo].[master_AFC_EE_INREG_PRET_FURN]
( 
@PERIOADA CHAR(9) 
 )
AS
BEGIN

		SET XACT_ABORT, NOCOUNT ON;
	
		DECLARE @OBJECT_NAME  CHAR(100);
		SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;

		DECLARE @CHECK BIT ;
		EXEC sp_AFC_CHECK_PER @PERIOADA,@CHECK OUTPUT

			IF (SELECT CASE WHEN @CHECK IS NULL THEN 0 ELSE @CHECK  END)=1
				BEGIN
					DECLARE @MSG_1 VARCHAR(100);
					SET     @MSG_1='PERIOADA :'+@PERIOADA+''+' ESTE VALIDA !' ;
					EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'INFORMARE' ,@MSG_1
					PRINT @PERIOADA +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_1

						EXEC dbo.sp_AFC_EE_INT_PRET_FURN_MOD @PERIOADA ;

						DECLARE @ERROR_PRET_FURN BIT  ;
						EXEC sp_AFC_EE_VF_PRET_FURN @PERIOADA , @ERROR_PRET_FURN OUTPUT ;

						IF @ERROR_PRET_FURN=1
							BEGIN
								EXEC dbo.sp_AFC_EE_P_PRET_FURN @PERIOADA ;
								EXEC dbo.sp_AFC_EE_P_KPI_EVO @PERIOADA, '1' ;

							END
						ELSE IF @ERROR_PRET_FURN=0
							BEGIN
								DECLARE @MSG_2 VARCHAR(100);
								SET     @MSG_2='01- VA ROG SA CORECATI ERORILE PENTRU PERIOADA ' +@PERIOADA+' ! ' ;
								EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG_2
								;THROW 500001,@MSG_2,1;
							END
				END
			ELSE 
				BEGIN
					DECLARE @MSG_3 VARCHAR(100);
					SET     @MSG_3='PERIOADA : '+@PERIOADA+' NU ESTE VALIDA, VA ROG VERIFICATI IN TABELA DE INPUT ! '
					EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG_3
					PRINT @PERIOADA +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@MSG_3
				END

END
GO
/

CREATE PROCEDURE [dbo].[master_AFC_EE_INREG_PRET_FURN_AD_HOC]
( 
@PERIOADA CHAR(9) 
 )
AS
BEGIN

		SET XACT_ABORT, NOCOUNT ON;
	
		DECLARE @OBJECT_NAME  CHAR(100);
		SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;

		DECLARE @CHECK BIT ;
		EXEC sp_AFC_CHECK_PER @PERIOADA,@CHECK OUTPUT

			IF (SELECT CASE WHEN @CHECK IS NULL THEN 0 ELSE @CHECK  END)=1
				BEGIN
					DECLARE @MSG_1 VARCHAR(100);
					SET     @MSG_1='PERIOADA :'+@PERIOADA+''+' ESTE VALIDA !' ;
					EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'INFORMARE' ,@MSG_1
					PRINT @PERIOADA +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_1

						DECLARE @ERROR_PRET_FURN_AD_HOC BIT  ;
						EXEC sp_AFC_EE_VF_PRET_FURN_AD_HOC @PERIOADA , @ERROR_PRET_FURN_AD_HOC OUTPUT ;

						IF @ERROR_PRET_FURN_AD_HOC=1
							BEGIN
								EXEC dbo.sp_AFC_EE_P_PRET_FURN_AD_HOC @PERIOADA ;
								EXEC dbo.sp_AFC_EE_P_KPI_EVO @PERIOADA, '4' ;

							END
						ELSE IF @ERROR_PRET_FURN_AD_HOC=0
							BEGIN
								DECLARE @MSG_2 VARCHAR(100);
								SET     @MSG_2='01- VA ROG SA CORECATI ERORILE PENTRU PERIOADA ' +@PERIOADA+' ! ' ;
								EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG_2
								;THROW 500001,@MSG_2,1;
							END
				END
			ELSE 
				BEGIN
					DECLARE @MSG_3 VARCHAR(100);
					SET     @MSG_3='PERIOADA : '+@PERIOADA+' NU ESTE VALIDA, VA ROG VERIFICATI IN TABELA DE INPUT ! '
					EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG_3
					PRINT @PERIOADA +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@MSG_3
				END

END
GO
/

CREATE PROCEDURE [dbo].[master_AFC_EE_INREG_REALIZ]
( 
@PERIOADA CHAR(9) 
 )
AS
BEGIN

		SET XACT_ABORT, NOCOUNT ON;
	
		DECLARE @OBJECT_NAME  CHAR(100);
		SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;

		DECLARE @CHECK BIT ;
		EXEC sp_AFC_CHECK_PER @PERIOADA,@CHECK OUTPUT

			IF (SELECT CASE WHEN @CHECK IS NULL THEN 0 ELSE @CHECK  END)=1
				BEGIN
					DECLARE @MSG_1 VARCHAR(100);
					SET     @MSG_1='PERIOADA :'+@PERIOADA+''+' ESTE VALIDA !' ;

					EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'INFORMARE' ,@MSG_1
					PRINT @PERIOADA +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_1

					EXEC sp_AFC_EE_P_OPEN_SYS @PERIOADA ;
					EXEC sp_AFC_EE_P_REALIZ @PERIOADA ;
					EXEC sp_AFC_EE_P_KPI_EVO @PERIOADA, '1' ;
					EXEC sp_AFC_EE_P_MATURITATE @PERIOADA ;

				END
			ELSE 
				BEGIN
					DECLARE @MSG_2 VARCHAR(100);
					SET     @MSG_2='PERIOADA : '+@PERIOADA+' NU ESTE VALIDA, VA ROG VERIFICATI IN TABELA DE INPUT ! '
					EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG_2
					PRINT @PERIOADA +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@MSG_2
				END

END

GO
/

CREATE PROCEDURE [dbo].[master_AFC_EE_INREG_SEM_CANT]
( 
@PERIOADA CHAR(9) 
 )
AS
BEGIN

		SET XACT_ABORT, NOCOUNT ON;
	
		DECLARE @OBJECT_NAME  CHAR(100);
		SET          @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;

		DECLARE @CHECK BIT ;
		EXEC sp_AFC_CHECK_PER @PERIOADA,@CHECK OUTPUT

			IF (SELECT CASE WHEN @CHECK IS NULL THEN 0 ELSE @CHECK  END)=1
				BEGIN
					DECLARE @MSG_1 VARCHAR(100);
					SET     @MSG_1='PERIOADA :'+@PERIOADA+''+' ESTE VALIDA !' ;
					EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'INFORMARE' ,@MSG_1
					PRINT @PERIOADA +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_1

						DECLARE @ERROR_SEM_CANT BIT  ;
						EXEC sp_AFC_EE_VF_SEM_CANT @PERIOADA , @ERROR_SEM_CANT OUTPUT ;

						IF @ERROR_SEM_CANT=1
							BEGIN
								EXEC sp_AFC_EE_P_SEM_CANT @PERIOADA ;
								EXEC dbo.sp_AFC_EE_P_KPI_EVO @PERIOADA, '1' ;
							END
						ELSE IF @ERROR_SEM_CANT=0
							BEGIN
								DECLARE @MSG_2 VARCHAR(100);
								SET     @MSG_2='01- VA ROG SA CORECATI ERORILE PENTRU PERIOADA ' +@PERIOADA+' ! ' ;
								EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG_2
								;THROW 500001,@MSG_2,1;
							END
				END
			ELSE 
				BEGIN
					DECLARE @MSG_3 VARCHAR(100);
					SET	@MSG_3='PERIOADA : '+@PERIOADA+' NU ESTE VALIDA, VA ROG VERIFICATI IN TABELA DE INPUT ! '
					EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG_3
					PRINT @PERIOADA +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@MSG_3
				END

END
GO
/

CREATE PROCEDURE [dbo].[master_AFC_EE_SIM_PRET_FURN]
( 
@PERIOADA CHAR(9) 
 )
AS
BEGIN

		SET XACT_ABORT, NOCOUNT ON;
	
		DECLARE @OBJECT_NAME  CHAR(100);
		SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;
		DECLARE @MSG VARCHAR(100);

		DECLARE @CHECK BIT ;
		EXEC sp_AFC_CHECK_PER @PERIOADA,@CHECK OUTPUT

			IF (SELECT CASE WHEN @CHECK IS NULL THEN 0 ELSE @CHECK  END)=1
				BEGIN

						SET  @MSG ='PERIOADA :'+@PERIOADA+''+' ESTE VALIDA !' ;
						EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'INFORMARE' ,@MSG
						PRINT @PERIOADA +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG

						EXEC sp_AFC_EE_P_SIM_PF_DATE @PERIOADA;
						EXEC sp_AFC_EE_P_SIM_PF_FW @PERIOADA;
						EXEC sp_AFC_EE_P_SIM_PF_MRJ_TARGET @PERIOADA;
						EXEC sp_AFC_EE_P_SIM_PF_CALC @PERIOADA;
						EXEC sp_AFC_EE_P_SIM_PF_MRJ @PERIOADA ;

				END
-- ERROR ------------------------------------------------------------------------------------------------------------------
				ELSE 
					BEGIN
						SET	 @MSG ='PERIOADA : '+@PERIOADA+' NU ESTE VALIDA, VA ROG VERIFICATI IN TABELA DE INPUT ! '
						EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG
						PRINT @PERIOADA +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@MSG
					END

END
GO
/

CREATE PROCEDURE [dbo].[master_AFC_EE_SIM_SEGM_PRICE]
( 
@PERIOADA CHAR(9) 
 )
AS
BEGIN

		SET XACT_ABORT, NOCOUNT ON;
	
		DECLARE @OBJECT_NAME  CHAR(100);
		SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;

		DECLARE @CHECK BIT ;
		EXEC sp_AFC_CHECK_PER @PERIOADA,@CHECK OUTPUT

			IF (SELECT CASE WHEN @CHECK IS NULL THEN 0 ELSE @CHECK  END)=1
				BEGIN
					DECLARE @MSG_1 VARCHAR(100);
					SET     @MSG_1='PERIOADA :'+@PERIOADA+''+' ESTE VALIDA !' ;
					EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'INFORMARE' ,@MSG_1
					PRINT @PERIOADA +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_1

					EXEC sp_AFC_EE_P_SEGM_PRICE @PERIOADA;
				END
			ELSE 
				BEGIN
					DECLARE @MSG_3 VARCHAR(100);
					SET     @MSG_3='PERIOADA : '+@PERIOADA+' NU ESTE VALIDA, VA ROG VERIFICATI IN TABELA DE INPUT ! '
					EXEC sp_AFC_RECORD_LOG @PERIOADA, @OBJECT_NAME, 'EROARE' ,@MSG_3
					PRINT @PERIOADA +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@MSG_3
				END

END
GO
