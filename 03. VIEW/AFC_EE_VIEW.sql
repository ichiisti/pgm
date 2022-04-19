CREATE VIEW [dbo].[vw_AFC_EE_ACH_POR_DATA_CONS]
AS
SELECT        PERIOADA, 
IIF( ORA_CONS='3.5' ,(CAST(CONVERT(CHAR(10),DATA_REF,101)AS DATETIME)+ CAST(TIMEFROMPARTS(ORA_CONS,30,0,0,0) AS DATETIME)), (CAST(CONVERT(CHAR(10),DATA_REF,101)AS DATETIME)+ CAST(TIMEFROMPARTS(ORA_CONS,0,0,0,0) AS DATETIME))) AS DATA_CONS
FROM            dbo.AFC_EE_INT_ACH_POR
GROUP BY PERIOADA, DATA_REF, ORA_CONS
GO
/

CREATE VIEW [dbo].[vw_AFC_EE_ACH_POT_DATA_CONS]
AS
SELECT        PERIOADA, 
IIF( ORA_CONS='3.5' ,(CAST(CONVERT(CHAR(10),DATA_REF,101)AS DATETIME)+ CAST(TIMEFROMPARTS(ORA_CONS,30,0,0,0) AS DATETIME)), (CAST(CONVERT(CHAR(10),DATA_REF,101)AS DATETIME)+ CAST(TIMEFROMPARTS(ORA_CONS,0,0,0,0) AS DATETIME))) AS DATA_CONS
FROM            dbo.AFC_EE_INT_ACH_POT
GROUP BY PERIOADA, DATA_REF, ORA_CONS
GO
/


CREATE VIEW [dbo].[vw_AFC_EE_CANT_INST]
   WITH SCHEMABINDING
   AS  
    SELECT        fact.PERIOADA, fact.AN, fact.LUNA, fact.PARTENERDEAFACERI, fact.INSTALATIE, fact.NIVELDETENSIUNE, SUM(ISNULL(fact.CANT_TOTAL,0)) CANT_TOTAL, 
	              inst.SURSA_DATE,  
				  segm.GROUP_SEGM, 
				  tip.TIPCLIENT, 
				  pa.NUME_ACTUAL, 
				  per.DESCRIERE,
				  COUNT_BIG(*) [NO]
     FROM         dbo.AFC_MD_FACT fact,   dbo.AFC_MD_DIM_INST inst,  dbo.AFC_MD_DIM_PA_ACTUAL pa, dbo.AFC_MD_DIM_SEGMENT segm, dbo.AFC_MD_DIM_TIP tip, dbo.AFC_MD_DIM_PER per
	 WHERE        fact.PERIOADA = inst.PERIOADA									AND 
				  fact.AN = inst.AN												AND 
				  fact.LUNA = inst.LUNA											AND 
                  fact.INSTALATIE = inst.INSTALATIE								AND
				  fact.SEGMENTCLIENT = segm.COD									AND
				  fact.DENUMIREDISTRIBUITOR = tip.DENUMIREDISTRIBUITOR			AND
				  fact.PARTENERDEAFACERI = pa.PARTENERDEAFACERI					AND
				  fact.PERIOADA = per.PERIOADA									AND
				  fact.LUNA = per.LUNA
	 GROUP  BY    fact.PERIOADA, fact.AN, fact.LUNA, fact.PARTENERDEAFACERI, fact.INSTALATIE, fact.NIVELDETENSIUNE, 
	              inst.SURSA_DATE, 
				  segm.GROUP_SEGM, 
				  tip.TIPCLIENT, 
				  pa.NUME_ACTUAL,
				  per.DESCRIERE
	 



GO
/

CREATE VIEW [dbo].[vw_AFC_EE_CANT_SEGMENT]
AS
SELECT * FROM 
		(
			SELECT PERIOADA, AN,LUNA,STARECLIENT,SEGMENTCLIENT,SUM(CANT_TOTAL) AS CANT_TOTAL
			FROM dbo.AFC_MD_FACT
			GROUP BY PERIOADA, AN,LUNA,STARECLIENT,SEGMENTCLIENT
		) AS s
PIVOT
(
SUM(CANT_TOTAL) FOR [LUNA] IN ( [1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12] )

) AS pvt
GO
/

CREATE VIEW [dbo].[vw_AFC_EE_COST_ALOC_SUBPOR]
AS
SELECT        PERIOADA, PER_DESC, AN, LUNA, SUBPOR_ACTUAL, SEGM_GROUP, CASE WHEN SUBPOR_ACTUAL = 'P4' THEN 'POT' ELSE 'POR' END [TIP_ACH], SUM(ISNULL(CANT_BANDA, 0)) CANT_ACH_CONTR, 
                         SUM(ISNULL(COST_BANDA, 0)) COST_ACH_CONTR, SUM(ISNULL(CANT_ACH_PZU, 0)) CANT_ACH_PZU, SUM(ISNULL(COST_ACH_PZU, 0)) COST_ACH_PZU, SUM(ISNULL(COST_ACH_ECH, 0)) COST_ACH_ECH, 
                         SUM(ISNULL(COST_ACH, 0)) COST_ACH, SUM(ISNULL(CANT_ALOC,0)) CANT_ALOC
FROM            AFC_MD_DATE_ORA
WHERE        SUBPOR_ACTUAL IN ('P2', 'P3')
GROUP BY PERIOADA, PER_DESC, AN, LUNA, SUBPOR_ACTUAL, SEGM_GROUP
UNION ALL
SELECT        PERIOADA, PER_DESC, AN, LUNA, SUBPOR_ACTUAL, SEGM_GROUP, CASE WHEN SUBPOR_ACTUAL = 'P4' THEN 'POT' ELSE 'POR' END [TIP_ACH], SUM(ISNULL(CANT_ACH_CONTR, 0)) CANT_ACH_CONTR, 
                         SUM(ISNULL(COST_ACH_CONTR, 0)) COST_ACH_CONTR, SUM(ISNULL(CANT_ACH_PZU, 0)) CANT_ACH_PZU, SUM(ISNULL(COST_ACH_PZU, 0)) COST_ACH_PZU, SUM(ISNULL(COST_ACH_ECH, 0)) COST_ACH_ECH, 
                         SUM(ISNULL(COST_ACH, 0)) COST_ACH, SUM(ISNULL(CANT_ALOC,0)) CANT_ALOC
FROM            AFC_MD_DATE_ORA
WHERE        SUBPOR_ACTUAL NOT IN ('P2', 'P3')
GROUP BY PERIOADA, PER_DESC, AN, LUNA, SUBPOR_ACTUAL, SEGM_GROUP
GO
/

CREATE VIEW [dbo].[vw_AFC_EE_COST_MED_ACH_STARECLIENT]
AS
SELECT        PERIOADA, STARECLIENT
FROM            dbo.AFC_EE_INT_COST_MED_ACH
GROUP BY PERIOADA, STARECLIENT
GO
/

CREATE VIEW [dbo].[vw_AFC_EE_DATA_CONS]
AS
SELECT        PERIOADA, DATA_CONS
FROM            dbo.AFC_MD_ALOC
GROUP BY PERIOADA, DATA_CONS
GO
/

CREATE VIEW [dbo].[vw_AFC_EE_DATA_CONTR]
AS
SELECT        per.GROUP_COD, fact.PERIOADA, fact.AN, fact.LUNA, fact.PARTENERDEAFACERI, fact.INSTALATIE, fact.SEGMENTCLIENT, inst.DATASFARSITCONTRACT, SUM(fact.CANT_TOTAL) AS CANT_TOTAL, fact.COST_MED_ACH
FROM            (SELECT        PERIOADA, AN, LUNA, PARTENERDEAFACERI, INSTALATIE, SEGMENTCLIENT, SUM(CANT_TOTAL) AS CANT_TOTAL, COST_MED_ACH
                          FROM            dbo.AFC_MD_FACT
                          GROUP BY PERIOADA, AN, LUNA, PARTENERDEAFACERI, INSTALATIE, SEGMENTCLIENT, COST_MED_ACH) AS fact INNER JOIN
                             (SELECT        PERIOADA, AN, LUNA, INSTALATIE, DATASFARSITCONTRACT
                               FROM            dbo.AFC_MD_DIM_INST
                               WHERE        (INSTALATIE LIKE '4%')
                               GROUP BY PERIOADA, AN, LUNA, INSTALATIE, DATASFARSITCONTRACT) AS inst ON fact.PERIOADA = inst.PERIOADA AND fact.AN = inst.AN AND fact.LUNA = inst.LUNA AND fact.INSTALATIE = inst.INSTALATIE INNER JOIN
                             (SELECT        PERIOADA, GROUP_COD
                               FROM            dbo.AFC_MD_DIM_PER
                               GROUP BY PERIOADA, GROUP_COD) AS per ON per.PERIOADA = inst.PERIOADA
GROUP BY per.GROUP_COD, fact.PERIOADA, fact.AN, fact.LUNA, fact.PARTENERDEAFACERI, fact.INSTALATIE, fact.SEGMENTCLIENT, fact.COST_MED_ACH, inst.DATASFARSITCONTRACT
GO
/

CREATE VIEW [dbo].[vw_AFC_EE_DATE_SEGM_PRICE]
AS
SELECT        pa.PERIOADA, pa.PARTENERDEAFACERI, pa.NUME_GROUP, pa.CUI, fact.INSTALATIE
FROM            (SELECT        PERIOADA, PARTENERDEAFACERI, CUI, NUME_GROUP
                          FROM            dbo.AFC_MD_DIM_PA_ISTORIC
                          GROUP BY PERIOADA, PARTENERDEAFACERI, CUI, NUME_GROUP) AS pa INNER JOIN
                             (SELECT        PERIOADA, PARTENERDEAFACERI, INSTALATIE
                               FROM            dbo.AFC_MD_FACT
                               GROUP BY PERIOADA, PARTENERDEAFACERI, INSTALATIE) AS fact ON pa.PERIOADA = fact.PERIOADA AND pa.PARTENERDEAFACERI = fact.PARTENERDEAFACERI
GROUP BY pa.PERIOADA, pa.PARTENERDEAFACERI, pa.NUME_GROUP, pa.CUI, fact.INSTALATIE
GO
/

CREATE VIEW [dbo].[vw_AFC_EE_INT_ACH_CANT_OFERTA]
AS
SELECT        PARTENERDEAFACERI, CURBA, DATA_OFERTA, CAST(L_01 AS DECIMAL(18, 3)) AS L_01, CAST(L_02 AS DECIMAL(18, 3)) AS L_02, CAST(L_03 AS DECIMAL(18, 3)) AS L_03, CAST(L_04 AS DECIMAL(18, 3)) AS L_04, 
                         CAST(L_05 AS DECIMAL(18, 3)) AS L_05, CAST(L_06 AS DECIMAL(18, 3)) AS L_06, CAST(L_07 AS DECIMAL(18, 3)) AS L_07, CAST(L_08 AS DECIMAL(18, 3)) AS L_08, CAST(L_09 AS DECIMAL(18, 3)) AS L_09, 
                         CAST(L_10 AS DECIMAL(18, 3)) AS L_10, CAST(L_11 AS DECIMAL(18, 3)) AS L_11, CAST(L_12 AS DECIMAL(18, 3)) AS L_12, MOD_DE, MOD_TIMP
FROM            dbo.AFC_EE_INT_ACH_CANT_OFERTA
GROUP BY PARTENERDEAFACERI, CURBA, DATA_OFERTA, L_01, L_02, L_03, L_04, L_05, L_06, L_07, L_08, L_09, L_10, L_11, L_12, MOD_DE, MOD_TIMP
GO
/

CREATE VIEW [dbo].[vw_AFC_EE_INT_ACH_POR]
AS
SELECT        PERIOADA, DATA_REF, ORA_CONS, CAST(CANT_ACH_CONTR AS DECIMAL(18, 3)) AS CANT_ACH_CONTR, CAST(COST_ACH_CONTR AS DECIMAL(18, 3)) 
                         AS COST_ACH_CONTR, CAST(CANT_ACH_PZU AS DECIMAL(18, 3)) AS CANT_ACH_PZU, CAST(COST_ACH_PZU AS DECIMAL(18, 3)) AS COST_ACH_PZU, 
                         CAST(COST_MED_ACH_ECH AS DECIMAL(18, 3)) AS COST_MED_ACH_ECH, MOD_DE, MOD_TIMP
FROM            dbo.AFC_EE_INT_ACH_POR
GROUP BY PERIOADA, DATA_REF, ORA_CONS, CANT_ACH_CONTR, COST_ACH_CONTR, CANT_ACH_PZU, COST_ACH_PZU, COST_MED_ACH_ECH, MOD_DE, MOD_TIMP
GO
/

CREATE VIEW [dbo].[vw_AFC_EE_INT_ACH_POT]
AS
SELECT        PERIOADA, DATA_REF, ORA_CONS, CAST(CANT_ACH_CONTR AS DECIMAL(18, 3)) AS CANT_ACH_CONTR, CAST(COST_ACH_CONTR AS DECIMAL(18, 3)) 
                         AS COST_ACH_CONTR, CAST(CANT_ACH_PZU AS DECIMAL(18, 3)) AS CANT_ACH_PZU, CAST(COST_ACH_PZU AS DECIMAL(18, 3)) AS COST_ACH_PZU, 
                         CAST(COST_MED_ACH_ECH AS DECIMAL(18, 3)) AS COST_MED_ACH_ECH, MOD_DE, MOD_TIMP
FROM            dbo.AFC_EE_INT_ACH_POT
GROUP BY PERIOADA, DATA_REF, ORA_CONS, CANT_ACH_CONTR, COST_ACH_CONTR, CANT_ACH_PZU, COST_ACH_PZU, COST_MED_ACH_ECH, MOD_DE, MOD_TIMP
GO
/

CREATE VIEW [dbo].[vw_AFC_EE_INT_ACH_SUBPOR_BANDA]
AS
SELECT        PARTENERDEAFACERI, DATA_OFERTA, VALABIL_DELA, VALABIL_PANALA, CAST(CANT_BANDA_ORA AS DECIMAL(18, 3)) AS CANT_BANDA_ORA, CAST(PRET_BANDA_ORA AS DECIMAL(18, 3)) AS PRET_BANDA_ORA, MOD_DE, 
                         MOD_TIMP
FROM            dbo.AFC_EE_INT_ACH_SUBPOR_BANDA
GROUP BY PARTENERDEAFACERI, DATA_OFERTA, VALABIL_DELA, VALABIL_PANALA, CANT_BANDA_ORA, PRET_BANDA_ORA, MOD_DE, MOD_TIMP
GO
/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_AFC_EE_INT_ACH_SUBPOR_PZU]
AS
SELECT        DATA_REF, ORA_CONS, DATA_OFERTA, CAST(PRET_PZU AS DECIMAL(18, 3)) AS PRET_PZU, ID, MOD_DE, MOD_TIMP
FROM            dbo.AFC_EE_INT_ACH_SUBPOR_PZU
GROUP BY DATA_REF, ORA_CONS, DATA_OFERTA, PRET_PZU, ID, MOD_DE, MOD_TIMP
GO
/

CREATE VIEW [dbo].[vw_AFC_EE_INT_POR_CANT]
AS
SELECT        PERIOADA, INSTALATIE, CAST(L_01 AS DECIMAL(18, 3)) AS L_01, CAST(L_02 AS DECIMAL(18, 3)) AS L_02, CAST(L_03 AS DECIMAL(18, 3)) AS L_03, 
                         CAST(L_04 AS DECIMAL(18, 3)) AS L_04, CAST(L_05 AS DECIMAL(18, 3)) AS L_05, CAST(L_06 AS DECIMAL(18, 3)) AS L_06, CAST(L_07 AS DECIMAL(18, 3)) AS L_07, 
                         CAST(L_08 AS DECIMAL(18, 3)) AS L_08, CAST(L_09 AS DECIMAL(18, 3)) AS L_09, CAST(L_10 AS DECIMAL(18, 3)) AS L_10, CAST(L_11 AS DECIMAL(18, 3)) AS L_11, 
                         CAST(L_12 AS DECIMAL(18, 3)) AS L_12, ID, MOD_DE, MOD_TIMP
FROM            dbo.AFC_EE_INT_POR_CANT
GROUP BY PERIOADA, INSTALATIE, L_01, L_02, L_03, L_04, L_05, L_06, L_07, L_08, L_09, L_10, L_11, L_12, ID, MOD_DE, MOD_TIMP
GO
/

CREATE VIEW [dbo].[vw_AFC_EE_INT_POR_CANT_MOD]
AS
SELECT        PERIOADA, INSTALATIE, CAST(L_01 AS DECIMAL(18, 3)) AS L_01, CAST(L_02 AS DECIMAL(18, 3)) AS L_02, CAST(L_03 AS DECIMAL(18, 3)) AS L_03, 
                         CAST(L_04 AS DECIMAL(18, 3)) AS L_04, CAST(L_05 AS DECIMAL(18, 3)) AS L_05, CAST(L_06 AS DECIMAL(18, 3)) AS L_06, CAST(L_07 AS DECIMAL(18, 3)) AS L_07, 
                         CAST(L_08 AS DECIMAL(18, 3)) AS L_08, CAST(L_09 AS DECIMAL(18, 3)) AS L_09, CAST(L_10 AS DECIMAL(18, 3)) AS L_10, CAST(L_11 AS DECIMAL(18, 3)) AS L_11, 
                         CAST(L_12 AS DECIMAL(18, 3)) AS L_12
FROM            dbo.AFC_EE_INT_POR_CANT_MOD
GROUP BY PERIOADA, INSTALATIE, L_01, L_02, L_03, L_04, L_05, L_06, L_07, L_08, L_09, L_10, L_11, L_12
GO
/

CREATE VIEW [dbo].[vw_AFC_EE_INT_POT_BM]
AS
SELECT        PERIOADA, DIVIZIE, REGIUNE_PORTOFOLIU, TIPCLIENT, STARECLIENT, NIVELDETENSIUNE, SEGMENTCLIENT, SEGM_COM, MOTIV_MOV_IN, CAST(L_01 AS DECIMAL(18, 3)) AS L_01, CAST(L_02 AS DECIMAL(18, 3)) AS L_02, 
                         CAST(L_03 AS DECIMAL(18, 3)) AS L_03, CAST(L_04 AS DECIMAL(18, 3)) AS L_04, CAST(L_05 AS DECIMAL(18, 3)) AS L_05, CAST(L_06 AS DECIMAL(18, 3)) AS L_06, CAST(L_07 AS DECIMAL(18, 3)) AS L_07, 
                         CAST(L_08 AS DECIMAL(18, 3)) AS L_08, CAST(L_09 AS DECIMAL(18, 3)) AS L_09, CAST(L_10 AS DECIMAL(18, 3)) AS L_10, CAST(L_11 AS DECIMAL(18, 3)) AS L_11, CAST(L_12 AS DECIMAL(18, 3)) AS L_12, ID_INST, MOD_DE, 
                         MOD_TIMP
FROM            dbo.AFC_EE_INT_POT_BM
GROUP BY PERIOADA, DIVIZIE, REGIUNE_PORTOFOLIU, TIPCLIENT, STARECLIENT, NIVELDETENSIUNE, SEGMENTCLIENT, SEGM_COM, MOTIV_MOV_IN, L_01, L_02, L_03, L_04, L_05, L_06, L_07, L_08, L_09, L_10, L_11, L_12, ID_INST, 
                         MOD_DE, MOD_TIMP
GO
/

CREATE VIEW [dbo].[vw_AFC_EE_INT_POT_KA]
AS
SELECT        PERIOADA, REGIUNE_PORTOFOLIU, DIVIZIE, DENUMIREPARTENER, CUI, TIPCLIENT, STARECLIENT, NIVELDETENSIUNE, SEGMENTCLIENT, SEGM_COM, ENERGOINTENSIV, IDMANAGER, MOTIV_MOV_IN, 
                         CAST(L_01 AS DECIMAL(18, 3)) AS L_01, CAST(L_02 AS DECIMAL(18, 3)) AS L_02, CAST(L_03 AS DECIMAL(18, 3)) AS L_03, CAST(L_04 AS DECIMAL(18, 3)) AS L_04, CAST(L_05 AS DECIMAL(18, 3)) AS L_05, 
                         CAST(L_06 AS DECIMAL(18, 3)) AS L_06, CAST(L_07 AS DECIMAL(18, 3)) AS L_07, CAST(L_08 AS DECIMAL(18, 3)) AS L_08, CAST(L_09 AS DECIMAL(18, 3)) AS L_09, CAST(L_10 AS DECIMAL(18, 3)) AS L_10, 
                         CAST(L_11 AS DECIMAL(18, 3)) AS L_11, CAST(L_12 AS DECIMAL(18, 3)) AS L_12, ID_INST, MOD_DE, MOD_TIMP
FROM            dbo.AFC_EE_INT_POT_KA
GROUP BY PERIOADA, REGIUNE_PORTOFOLIU, DIVIZIE, DENUMIREPARTENER, CUI, TIPCLIENT, STARECLIENT, NIVELDETENSIUNE, SEGMENTCLIENT, SEGM_COM, ENERGOINTENSIV, IDMANAGER, MOTIV_MOV_IN, L_01, L_02, L_03, 
                         L_04, L_05, L_06, L_07, L_08, L_09, L_10, L_11, L_12, ID_INST, MOD_DE, MOD_TIMP
GO
/

CREATE VIEW [dbo].[vw_AFC_EE_INT_PRET_FURN]
AS
SELECT        PERIOADA, INSTALATIE, VALABIL_DELA, CAST(PRET_FURN AS DECIMAL(18, 3)) AS PRET_FURN, ID, MOD_DE, MOD_TIMP
FROM            dbo.AFC_EE_INT_PRET_FURN
GROUP BY PERIOADA, INSTALATIE, VALABIL_DELA, PRET_FURN, ID, MOD_DE, MOD_TIMP
GO
/

CREATE VIEW [dbo].[vw_AFC_EE_INT_PRET_FURN_AD_HOC]
AS
SELECT        PERIOADA, INSTALATIE, CAST(L_01 AS DECIMAL(18, 3)) AS L_01, CAST(L_02 AS DECIMAL(18, 3)) AS L_02, CAST(L_03 AS DECIMAL(18, 3)) AS L_03, CAST(L_04 AS DECIMAL(18, 3)) AS L_04, CAST(L_05 AS DECIMAL(18, 3)) 
                         AS L_05, CAST(L_06 AS DECIMAL(18, 3)) AS L_06, CAST(L_07 AS DECIMAL(18, 3)) AS L_07, CAST(L_08 AS DECIMAL(18, 3)) AS L_08, CAST(L_09 AS DECIMAL(18, 3)) AS L_09, CAST(L_10 AS DECIMAL(18, 3)) AS L_10, 
                         CAST(L_11 AS DECIMAL(18, 3)) AS L_11, CAST(L_12 AS DECIMAL(18, 3)) AS L_12, ID, MOD_DE, MOD_TIMP
FROM            dbo.AFC_EE_INT_PRET_FURN_AD_HOC
GROUP BY PERIOADA, INSTALATIE, L_01, L_02, L_03, L_04, L_05, L_06, L_07, L_08, L_09, L_10, L_11, L_12, ID, MOD_DE, MOD_TIMP
GO
/

CREATE VIEW [dbo].[vw_AFC_EE_INT_PRET_FURN_MOD]
AS
SELECT        PERIOADA, INSTALATIE, VALABIL_DELA, CAST(PRET_FURN AS DECIMAL(18, 3)) AS PRET_FURN, MOD_DE
FROM            dbo.AFC_EE_INT_PRET_FURN_MOD
GROUP BY PERIOADA, INSTALATIE, VALABIL_DELA, PRET_FURN, MOD_DE
GO
/

CREATE VIEW [dbo].[vw_AFC_EE_INT_SEM_CANT]
AS
SELECT        PERIOADA, REGIUNE_PORTOFOLIU, DIVIZIE, DENUMIREPARTENER, CUI, TIPCLIENT, STARECLIENT, NIVELDETENSIUNE, SEGMENTCLIENT, SEGM_COM, ENERGOINTENSIV, IDMANAGER, MOTIV_MOV_IN, 
                         DATAINCEPUTCONTRACT, DATASFARSITCONTRACT, CAST(L_01 AS DECIMAL(18, 3)) AS L_01, CAST(L_02 AS DECIMAL(18, 3)) AS L_02, CAST(L_03 AS DECIMAL(18, 3)) AS L_03, CAST(L_04 AS DECIMAL(18, 3)) AS L_04, 
                         CAST(L_05 AS DECIMAL(18, 3)) AS L_05, CAST(L_06 AS DECIMAL(18, 3)) AS L_06, CAST(L_07 AS DECIMAL(18, 3)) AS L_07, CAST(L_08 AS DECIMAL(18, 3)) AS L_08, CAST(L_09 AS DECIMAL(18, 3)) AS L_09, 
                         CAST(L_10 AS DECIMAL(18, 3)) AS L_10, CAST(L_11 AS DECIMAL(18, 3)) AS L_11, CAST(L_12 AS DECIMAL(18, 3)) AS L_12, MOD_DE, ID_INST, MOD_TIMP
FROM            dbo.AFC_EE_INT_SEM_CANT
GROUP BY PERIOADA, REGIUNE_PORTOFOLIU, DIVIZIE, DENUMIREPARTENER, CUI, TIPCLIENT, STARECLIENT, NIVELDETENSIUNE, SEGMENTCLIENT, SEGM_COM, ENERGOINTENSIV, IDMANAGER, MOTIV_MOV_IN, 
                         DATAINCEPUTCONTRACT, DATASFARSITCONTRACT, L_01, L_02, L_03, L_04, L_05, L_06, L_07, L_08, L_09, L_10, L_11, L_12, MOD_DE, ID_INST, MOD_TIMP
GO
/

CREATE VIEW [dbo].[vw_AFC_EE_INT_TARIF_DISTR]
AS
SELECT        PERIOADA, DENUMIREDISTRIBUITOR, NIVELDETENSIUNE, VALABIL_DELA, CAST(TARIF_DISTR AS DECIMAL(18, 3)) AS TARIF_DISTR, ID, MOD_DE, MOD_TIMP
FROM            dbo.AFC_EE_INT_TARIF_DISTR
GRO
GO
/

CREATE VIEW [dbo].[vw_AFC_EE_R_CANT]
AS
SELECT        dbo.AFC_MD_DIM_PER.PERIOADA, dbo.AFC_MD_DIM_PER.AN, dbo.AFC_MD_DIM_PER.LUNA, dbo.AFC_MD_DIM_PER.DESCRIERE, 
                         dbo.AFC_MD_FACT.PARTENERDEAFACERI, dbo.AFC_MD_FACT.INSTALATIE, dbo.AFC_MD_FACT.NIVELDETENSIUNE, dbo.AFC_MD_FACT.SEGMENTCLIENT, 
                         dbo.AFC_MD_FACT.CATEGORIETARIF, dbo.AFC_MD_FACT.DENUMIREDISTRIBUITOR, dbo.AFC_MD_FACT.STARECLIENT, dbo.AFC_MD_FACT.CANT_TOTAL, 
                         dbo.AFC_MD_DIM_PA_ISTORIC.NUME_ISTORIC, dbo.AFC_MD_DIM_PA_ISTORIC.CUI, dbo.AFC_MD_DIM_PA_ISTORIC.IDMANAGER, 
                         dbo.AFC_MD_DIM_PA_ISTORIC.SUBSEGMENT, dbo.AFC_MD_DIM_PA_ISTORIC.REGIUNE_PORTOFOLIU, dbo.AFC_MD_DIM_INST.DIVIZIE, 
                         dbo.AFC_MD_DIM_INST.CODINDUSTRIE, dbo.AFC_MD_DIM_INST.DENUMIREDISTRIBUITOR AS Expr1
FROM            dbo.AFC_MD_FACT INNER JOIN
                         dbo.AFC_MD_DIM_INST ON dbo.AFC_MD_FACT.PERIOADA = dbo.AFC_MD_DIM_INST.PERIOADA INNER JOIN
                         dbo.AFC_MD_DIM_PA_ISTORIC ON dbo.AFC_MD_FACT.PERIOADA = dbo.AFC_MD_DIM_PA_ISTORIC.PERIOADA INNER JOIN
                         dbo.AFC_MD_DIM_PER ON dbo.AFC_MD_FACT.PERIOADA = dbo.AFC_MD_DIM_PER.PERIOADA
GO
/

CREATE VIEW [dbo].[vw_AFC_EE_REALIZ]
AS
SELECT        fact.AN, fact.LUNA, fact.CATEGORIETARIF, fact.PARTENERDEAFACERI, fact.INSTALATIE, fact.NIVELDETENSIUNE, fact.SEGMENTCLIENT, fact.DELADATA, fact.PANALADATA, fact.DENUMIREDISTRIBUITOR, fact.STARECLIENT, 
                         SUM(fact.CANT_TOTAL) AS CANT_TOTAL, SUM(fact.VALOAREFARACV_FACT) AS VENIT, SUM(fact.COST_DISTR) AS COST_DISTR, SUM(fact.COST_TRANS) AS COST_TRANS, SUM(fact.COST_ACH_PROFILAT_FINAL) AS COST_ACH, 
                         SUM(fact.GROSS_MARGIN) AS GROSS_MARGIN, pa.DENUMIREPARTENER, pa.CUI, pa.SUBSEGMENT, pa.IDMANAGER, pa.DENUMIREMANAGER, pa.REGIUNE_PORTOFOLIU, inst.DIVIZIE, inst.CODINDUSTRIE, 
                         inst.DESCRIERECODINDUSTRIE, tip.TIPCLIENT, fact.CURBA_ACTUAL, fact.SUBPOR_ACTUAL, pa.ENERGOINTENSIV
FROM            dbo.EE_NOM_R_MARIMI AS fact INNER JOIN
                         dbo.EE_NOM_R_MAPARI_PA AS pa ON fact.PARTENERDEAFACERI = pa.PARTENERDEAFACERI AND fact.DELADATA = pa.DELADATA AND fact.PANALADATA = pa.PANALADATA INNER JOIN
                         dbo.EE_NOM_R_MAPARI_INST AS inst ON fact.INSTALATIE = inst.INSTALATIE AND fact.DELADATA = inst.DELADATA AND fact.PANALADATA = inst.PANALADATA INNER JOIN
                         dbo.EE_NOM_R_MAPARI_TIPCLIENT AS tip ON fact.DENUMIREDISTRIBUITOR = tip.DENUMIREDISTRIBUITOR
WHERE        (fact.SEGMENTCLIENT IN ('BMS', 'BMM', 'BML', 'KAS', 'KAM', 'KAT'))
GROUP BY fact.AN, fact.LUNA, fact.CATEGORIETARIF, fact.PARTENERDEAFACERI, fact.INSTALATIE, fact.NIVELDETENSIUNE, fact.SEGMENTCLIENT, fact.DELADATA, fact.PANALADATA, fact.DENUMIREDISTRIBUITOR, fact.STARECLIENT, 
                         pa.DENUMIREPARTENER, pa.CUI, pa.SUBSEGMENT, pa.IDMANAGER, pa.DENUMIREMANAGER, pa.REGIUNE_PORTOFOLIU, inst.DIVIZIE, inst.CODINDUSTRIE, inst.DESCRIERECODINDUSTRIE, tip.TIPCLIENT, 
                         fact.CURBA_ACTUAL, fact.SUBPOR_ACTUAL, pa.ENERGOINTENSIV
GO
/

CREATE VIEW [dbo].[vw_AFC_EE_STARECLIENT]
AS
SELECT        PERIOADA, STARECLIENT
FROM            dbo.AFC_MD_FACT
GROUP BY PERIOADA, STARECLIENT
GO
/

CREATE VIEW [dbo].[vw_AFC_EE_TARIF_TRANS_STARECLIENT]
AS
SELECT        PERIOADA, STARECLIENT
FROM            dbo.AFC_EE_INT_TARIF_TRANS
GROUP BY PERIOADA, STARECLIENT
GO
/

CREATE VIEW [dbo].[vw_AFC_EE_VAL_COEF]
AS
SELECT        DATEPART(YEAR, CONVERT(CHAR(10), DATA_CONS, 101)) AS AN, DATEPART(MONTH, CONVERT(CHAR(10), DATA_CONS, 101)) AS LUNA, COD, SUM(COEF) AS COEF
FROM            dbo.AFC_EE_INT_COEF_CURBA
GROUP BY DATA_CONS, COD
GO
/

CREATE VIEW [dbo].[vw_AFC_MD_DEV_CANT_TOTAL]
AS
SELECT COMPARATIE, DESCRIERE_T0 AS MOTIV,  SUM(ISNULL(CANT_T0,0)) AS CANT
FROM  AFC_MD_DEV_CANT
GROUP BY COMPARATIE, DESCRIERE_T0
UNION ALL
SELECT COMPARATIE, MOTIV,  SUM(CANT_DIF) AS CANT
FROM  AFC_MD_DEV_CANT
GROUP BY COMPARATIE, MOTIV
UNION ALL
SELECT COMPARATIE, DESCRIERE_T1 AS MOTIV,  SUM(ISNULL(CANT_T1,0)) AS CANT
FROM  AFC_MD_DEV_CANT
GROUP BY COMPARATIE, DESCRIERE_T1  
GO
