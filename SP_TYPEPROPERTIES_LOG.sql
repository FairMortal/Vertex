SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.SP_TYPEPROPERTIES_LOG') IS NULL
	CREATE TABLE [dbo].[SP_TYPEPROPERTIES_LOG](
		[TYPE_ID] [SMALLINT] NULL,
		[TYPE_NAME] [VARCHAR](255) NULL,
		[TYPE_SNAME] [VARCHAR](100) NULL,
		[LOG_TYPE] VARCHAR(6) NULL,
		[INPUTDATETIME] DATETIME NULL CONSTRAINT [DF_SP_TYPEPROPERTIES_LOG_INPUTDATETIME] DEFAULT (GETDATE()),
		[INPUTUSER] VARCHAR(255) NULL CONSTRAINT [DF_SP_TYPEPROPERTIES_LOG_INPUTUSER] DEFAULT (SUSER_SNAME())
	) ON [PRIMARY]
GO


