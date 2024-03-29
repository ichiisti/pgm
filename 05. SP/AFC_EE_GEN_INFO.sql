
/*
  This procedure highlights the steps to be followed for the gross margin calculation on client level.
*/
CREATE PROCEDURE [dbo].[gen_info_AFC_EE]
( 
@PERIOADA CHAR(9) 
 )
AS
BEGIN

		SET XACT_ABORT, NOCOUNT ON;

-- Basic variant calculation -------------------------------------------------------------------

EXEC dbo.master_AFC_EE_INREG_REALIZ @PERIOADA; 
EXEC dbo.master_AFC_EE_INREG_POR_CONTR @PERIOADA; 
EXEC dbo.master_AFC_EE_INREG_POR_CANT @PERIOADA;  
EXEC dbo.master_AFC_EE_INREG_POT @PERIOADA;
EXEC dbo.master_AFC_EE_INREG_SEM_CANT @PERIOADA ; 
EXEC dbo.master_AFC_EE_INREG_PRET_FURN @PERIOADA; 
EXEC dbo.master_AFC_EE_CALC_CANT_ORA @PERIOADA ; 
EXEC dbo.master_AFC_EE_CALC_SUBPOR @PERIOADA ; 
EXEC dbo.master_AFC_EE_CHECK_ACH @PERIOADA ; 
EXEC dbo.master_AFC_EE_CALC_ACH @PERIOADA ;  
EXEC dbo.master_AFC_EE_CALC_MARJA @PERIOADA ; 
EXEC dbo.master_AFC_EE_INREG_PRET_FURN_AD_HOC @PERIOADA ; 

-- Simulation Var.Segment Pricing & Supply Price ------------------------------------------------

EXEC dbo.master_AFC_EE_SIM_SEGM_PRICE @PERIOADA; -- Simulation for segment pricing
EXEC dbo.master_AFC_EE_SIM_PRET_FURN @PERIOADA; -- Simulation for supply pricing

-- Daily update for Cunsumption Curve & Sub-portfolio -------------------------------------------

DECLARE @PERIOADA_CALC CHAR(9) = '999999999';

EXEC dbo.master_AFC_EE_INREG_DATE_CURBA @PERIOADA=@PERIOADA_CALC 
EXEC dbo.master_AFC_EE_INREG_DATE_SUBPOR @PERIOADA=@PERIOADA_CALC 


-- Calculate volume deviation --------------------------------------------------------------------

DECLARE @PERIOADA_T1 CHAR(9);
DECLARE @PERIOADA_T0 CHAR(9);
DECLARE @LUNA_START INT ;
DECLARE @LUNA_FINISH INT ;
DECLARE @SURSA_DATE VARCHAR(50);

SET @PERIOADA_T1='PER100024';
SET @PERIOADA_T0='PER100024';
SET @LUNA_START=1;
SET @LUNA_FINISH=12;
SET @SURSA_DATE='CONTRACT_ACTIV'; --( 'CONTRACT_ACTIV' , 'CONTRACT_SEMNAT', 'POTENTIAL' )

EXEC dbo.sp_AFC_EE_P_DEV_CANT @PERIOADA_T1, @PERIOADA_T0, @LUNA_START, @LUNA_FINISH, @SURSA_DATE

-- Close System for the selected period ------------------------------------------------------------

EXEC sp_AFC_EE_P_OPEN_SYS @PERIOADA ;

-- Lock tables & table group -----------------------------------------------------------------------

DECLARE @BLOCAT BIT ;
DECLARE @TABEL_NUME VARCHAR(100);
SET @BLOCAT=1;
SET @TABEL_NUME='AFC_EE_INT_POR_CANT';

EXEC sp_AFC_EE_P_BLOCK_TABLE @BLOCAT, @TABEL_NUME ;

DECLARE @TBL_GROUP VARCHAR(100);
SET @BLOCAT=1;
SET @TBL_GROUP='CANTITATE MM';

EXEC sp_AFC_EE_P_BLOCK_GROUP @BLOCAT, @TBL_GROUP ;

-- Report for coefficients -------------------------------------------------------------------------

DECLARE @AN SMALLINT ;
SET @AN=2020;

EXEC sp_AFC_EE_R_COEF_ACTUAL @AN ;

-- Report for allocated quantity --------------------------------------------------------------------

EXEC sp_AFC_EE_R_CANT_ALOC @PERIOADA ;

END
GO
