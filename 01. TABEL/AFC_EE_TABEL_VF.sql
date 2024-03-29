CREATE TABLE [dbo].[AFC_EE_VF_COST_ACH_TRANS](
	[PERIOADA] [char](9) NULL,
	[MESAJ_EROARE] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/

CREATE TABLE [dbo].[AFC_EE_VF_DATE_CURBA](
	[MESAJ_EROARE] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/

CREATE TABLE [dbo].[AFC_EE_VF_DATE_SUBPOR](
	[MESAJ_EROARE] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/

CREATE TABLE [dbo].[AFC_EE_VF_GM_TARGET](
	[PERIOADA] [char](9) NULL,
	[MESAJ_EROARE] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/

CREATE TABLE [dbo].[AFC_EE_VF_ID_SUBPOR](
	[MESAJ_EROARE] [varchar](255) NULL,
	[PARTENERDEAFACERI] [char](10) NULL,
	[COD] [char](2) NULL,
	[MOD_DE] [varchar](20) NULL,
	[MOD_TIMP] [datetime] NULL
) ON [PRIMARY]
GO
/

CREATE TABLE [dbo].[AFC_EE_VF_MAPARE_CURBA](
	[MESAJ_EROARE] [varchar](255) NULL,
	[INSTALATIE] [char](10) NULL,
	[COD] [char](50) NULL,
	[MOD_DE] [varchar](20) NULL,
	[MOD_TIMP] [datetime] NULL
) ON [PRIMARY]
GO
/

CREATE TABLE [dbo].[AFC_EE_VF_MAPARE_SUBPOR](
	[MESAJ_EROARE] [varchar](255) NULL,
	[PARTENERDEAFACERI] [char](10) NULL,
	[COD] [char](2) NULL,
	[MOD_DE] [varchar](20) NULL,
	[MOD_TIMP] [datetime] NULL
) ON [PRIMARY]
GO
/

CREATE TABLE [dbo].[AFC_EE_VF_POR_CANT](
	[MESAJ_EROARE] [varchar](255) NULL,
	[PERIOADA] [char](9) NULL,
	[INSTALATIE] [varchar](255) NULL,
	[L_01] [float] NULL,
	[L_02] [float] NULL,
	[L_03] [float] NULL,
	[L_04] [float] NULL,
	[L_05] [float] NULL,
	[L_06] [float] NULL,
	[L_07] [float] NULL,
	[L_08] [float] NULL,
	[L_09] [float] NULL,
	[L_10] [float] NULL,
	[L_11] [float] NULL,
	[L_12] [float] NULL,
	[ID] [decimal](18, 0) NULL,
	[MOD_DE] [varchar](20) NULL,
	[MOD_TIMP] [datetime] NULL
) ON [PRIMARY]
GO
/

CREATE TABLE [dbo].[AFC_EE_VF_POR_CONTR](
	[MESAJ_EROARE] [varchar](255) NULL,
	[PERIOADA] [char](9) NULL,
	[REGIUNE_PORTOFOLIU] [varchar](255) NULL,
	[PARTENERDEAFACERI] [varchar](255) NULL,
	[DENUMIREPARTENER] [varchar](255) NULL,
	[NUME_GROUP] [varchar](255) NULL,
	[IDMANAGER] [varchar](255) NULL,
	[CUI] [varchar](255) NULL,
	[INSTALATIE] [char](10) NULL,
	[DIVIZIE] [varchar](255) NULL,
	[CAEN] [varchar](255) NULL,
	[CATEGORIETARIF] [varchar](255) NULL,
	[NIVELDETENSIUNE] [varchar](255) NULL,
	[DENUMIREDISTRIBUITOR] [varchar](255) NULL,
	[SEGMENTCLIENT] [varchar](255) NULL,
	[SEGM_COM] [varchar](255) NULL,
	[SUBSEGMENT] [varchar](255) NULL,
	[POD] [varchar](255) NULL,
	[DATAINCEPUTCONTRACT] [varchar](255) NULL,
	[DATASFARSITCONTRACT] [varchar](255) NULL,
	[ENERGOINTENSIV] [varchar](255) NULL,
	[DATA_REZ] [varchar](255) NULL,
	[ID] [decimal](18, 0) NULL,
	[MOD_DE] [varchar](20) NULL,
	[MOD_TIMP] [datetime] NULL
) ON [PRIMARY]
GO
/

CREATE TABLE [dbo].[AFC_EE_VF_POT_BM](
	[MESAJ_EROARE] [varchar](255) NULL,
	[PERIOADA] [char](9) NULL,
	[DIVIZIE] [varchar](255) NULL,
	[REGIUNE_PORTOFOLIU] [varchar](255) NULL,
	[TIPCLIENT] [varchar](255) NULL,
	[STARECLIENT] [varchar](255) NULL,
	[NIVELDETENSIUNE] [varchar](255) NULL,
	[SEGMENTCLIENT] [varchar](255) NULL,
	[SEGM_COM] [varchar](255) NULL,
	[MOTIV_MOV_IN] [varchar](255) NULL,
	[L_01] [float] NULL,
	[L_02] [float] NULL,
	[L_03] [float] NULL,
	[L_04] [float] NULL,
	[L_05] [float] NULL,
	[L_06] [float] NULL,
	[L_07] [float] NULL,
	[L_08] [float] NULL,
	[L_09] [float] NULL,
	[L_10] [float] NULL,
	[L_11] [float] NULL,
	[L_12] [float] NULL,
	[ID_INST] [char](10) NULL,
	[MOD_DE] [varchar](20) NULL,
	[MOD_TIMP] [datetime] NULL
) ON [PRIMARY]
GO
/

CREATE TABLE [dbo].[AFC_EE_VF_POT_KA](
	[MESAJ_EROARE] [varchar](255) NULL,
	[PERIOADA] [char](9) NULL,
	[REGIUNE_PORTOFOLIU] [varchar](255) NULL,
	[DIVIZIE] [varchar](255) NULL,
	[DENUMIREPARTENER] [varchar](255) NULL,
	[CUI] [varchar](255) NULL,
	[TIPCLIENT] [varchar](255) NULL,
	[STARECLIENT] [varchar](255) NULL,
	[NIVELDETENSIUNE] [varchar](255) NULL,
	[SEGMENTCLIENT] [varchar](255) NULL,
	[SEGM_COM] [varchar](255) NULL,
	[ENERGOINTENSIV] [varchar](255) NULL,
	[IDMANAGER] [varchar](255) NULL,
	[MOTIV_MOV_IN] [varchar](255) NULL,
	[L_01] [float] NULL,
	[L_02] [float] NULL,
	[L_03] [float] NULL,
	[L_04] [float] NULL,
	[L_05] [float] NULL,
	[L_06] [float] NULL,
	[L_07] [float] NULL,
	[L_08] [float] NULL,
	[L_09] [float] NULL,
	[L_10] [float] NULL,
	[L_11] [float] NULL,
	[L_12] [float] NULL,
	[ID_INST] [char](10) NULL,
	[MOD_DE] [varchar](20) NULL,
	[MOD_TIMP] [datetime] NULL
) ON [PRIMARY]
GO
/

CREATE TABLE [dbo].[AFC_EE_VF_PRET_FURN](
	[MESAJ_EROARE] [varchar](255) NULL,
	[PERIOADA] [char](9) NULL,
	[INSTALATIE] [char](10) NULL,
	[VALABIL_DELA] [char](10) NULL,
	[PRET_FURN] [float] NULL,
	[ID] [decimal](18, 0) NULL,
	[MOD_DE] [varchar](20) NULL,
	[MOD_TIMP] [datetime] NULL
) ON [PRIMARY]
GO
/

CREATE TABLE [dbo].[AFC_EE_VF_PRET_FURN_AD_HOC](
	[PERIOADA] [char](9) NULL,
	[INSTALATIE] [char](10) NULL,
	[MESAJ_EROARE] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/

CREATE TABLE [dbo].[AFC_EE_VF_SEM_CANT](
	[MESAJ_EROARE] [varchar](255) NULL,
	[PERIOADA] [char](9) NULL,
	[REGIUNE_PORTOFOLIU] [varchar](255) NULL,
	[DIVIZIE] [varchar](255) NULL,
	[DENUMIREPARTENER] [varchar](255) NULL,
	[CUI] [varchar](255) NULL,
	[TIPCLIENT] [varchar](255) NULL,
	[STARECLIENT] [varchar](255) NULL,
	[NIVELDETENSIUNE] [varchar](255) NULL,
	[SEGMENTCLIENT] [varchar](255) NULL,
	[SEGM_COM] [varchar](255) NULL,
	[ENERGOINTENSIV] [varchar](255) NULL,
	[IDMANAGER] [varchar](255) NULL,
	[MOTIV_MOV_IN] [varchar](255) NULL,
	[DATAINCEPUTCONTRACT] [varchar](255) NULL,
	[DATASFARSITCONTRACT] [varchar](255) NULL,
	[L_01] [float] NULL,
	[L_02] [float] NULL,
	[L_03] [float] NULL,
	[L_04] [float] NULL,
	[L_05] [float] NULL,
	[L_06] [float] NULL,
	[L_07] [float] NULL,
	[L_08] [float] NULL,
	[L_09] [float] NULL,
	[L_10] [float] NULL,
	[L_11] [float] NULL,
	[L_12] [float] NULL,
	[ID_INST] [char](10) NULL,
	[MOD_DE] [varchar](20) NULL,
	[MOD_TIMP] [datetime] NULL
) ON [PRIMARY]
GO
/

CREATE TABLE [dbo].[AFC_EE_VF_TARIF_DISTR](
	[MESAJ_EROARE] [nvarchar](255) NULL,
	[PERIOADA] [char](9) NULL,
	[DENUMIREDISTRIBUITOR] [varchar](255) NULL,
	[NIVELDETENSIUNE] [char](2) NULL,
	[VALABIL_DELA] [date] NULL,
	[TARIF_DISTR] [decimal](38, 5) NULL,
	[ID] [decimal](18, 0) NULL,
	[MOD_DE] [varchar](20) NULL,
	[MOD_TIMP] [datetime] NULL
) ON [PRIMARY]
GO
