SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.PR_APPLICATIONS_LOG') IS NULL
	CREATE TABLE [dbo].[PR_APPLICATIONS_LOG](
		[APPLICATION_ID] [INT] NULL,
		[FURNITURE_ID] [INT] NULL,
		[APPLICANT_GUID] [VARCHAR](36) NULL,
		[REASON_ID] [SMALLINT] NULL,
		[MANAGER_GUID] [VARCHAR](36) NULL,
		[RESULUTION_ID] [SMALLINT] NULL,
		[resolutionPeriod] [SMALLINT] NULL,
		[SOLUTION_ID] [SMALLINT] NULL,
		[STATUS_ID] [SMALLINT] NULL,
		[LOG_TYPE] VARCHAR(6) NULL,
		[INPUTDATETIME] DATETIME NULL CONSTRAINT [DF_PR_APPLICATIONS_LOG_INPUTDATETIME] DEFAULT (GETDATE()),
		[INPUTUSER] VARCHAR(255) NULL CONSTRAINT [DF_PR_APPLICATIONS_LOG_INPUTUSER] DEFAULT (SUSER_SNAME())
	) ON [PRIMARY]
GO
