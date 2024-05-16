SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.PR_APPLICATIONS') IS NULL
	CREATE TABLE [dbo].[PR_APPLICATIONS](
		[APPLICATION_ID] [INT] IDENTITY(1,1) NOT NULL,
		[FURNITURE_ID] [INT] NULL,
		[APPLICANT_GUID] [VARCHAR](36) NULL,
		[REASON_ID] [SMALLINT] NULL,
		[MANAGER_GUID] [VARCHAR](36) NULL,
		[RESULUTION_ID] [SMALLINT] NULL,
		[resolutionPeriod] [SMALLINT] NULL,
		[SOLUTION_ID] [SMALLINT] NULL,
		[STATUS_ID] [SMALLINT] NULL,
		[INPUTDATETIME] DATETIME NULL CONSTRAINT [DF_PR_APPLICATIONS_INPUTDATETIME] DEFAULT (GETDATE()),
		CONSTRAINT [PK_SP_APPLICATIONS] PRIMARY KEY CLUSTERED 
		(
			[APPLICATION_ID] ASC
		) ON [PRIMARY]
	) ON [PRIMARY]
GO

IF OBJECT_ID('dbo.FK_PR_APPLICATIONS_SP_PROPERTIES_REASON') IS NULL
	ALTER TABLE [dbo].[PR_APPLICATIONS]  WITH CHECK ADD  CONSTRAINT [FK_PR_APPLICATIONS_SP_PROPERTIES_REASON] FOREIGN KEY([REASON_ID])
	REFERENCES [dbo].[SP_PROPERTIES] ([PROPERTY_ID])
GO

IF OBJECT_ID('dbo.FK_PR_APPLICATIONS_SP_PROPERTIES_REASON') IS NULL
	ALTER TABLE [dbo].[PR_APPLICATIONS]  WITH CHECK ADD  CONSTRAINT [FK_PR_APPLICATIONS_SP_PROPERTIES_RESULUTION] FOREIGN KEY([RESULUTION_ID])
	REFERENCES [dbo].[SP_PROPERTIES] ([PROPERTY_ID])
GO

IF OBJECT_ID('dbo.FK_PR_APPLICATIONS_SP_PROPERTIES_SOLUTION') IS NULL
	ALTER TABLE [dbo].[PR_APPLICATIONS]  WITH CHECK ADD  CONSTRAINT [FK_PR_APPLICATIONS_SP_PROPERTIES_SOLUTION] FOREIGN KEY([SOLUTION_ID])
	REFERENCES [dbo].[SP_PROPERTIES] ([PROPERTY_ID])
GO

IF OBJECT_ID('dbo.FK_PR_APPLICATIONS_SP_PROPERTIES_STATUS') IS NULL
	ALTER TABLE [dbo].[PR_APPLICATIONS]  WITH CHECK ADD  CONSTRAINT [FK_PR_APPLICATIONS_SP_PROPERTIES_STATUS] FOREIGN KEY([STATUS_ID])
	REFERENCES [dbo].[SP_PROPERTIES] ([PROPERTY_ID])
GO

IF OBJECT_ID('dbo.FK_PR_APPLICATIONS_SP_FURNITURES') IS NULL
	ALTER TABLE [dbo].[PR_APPLICATIONS]  WITH CHECK ADD  CONSTRAINT [FK_PR_APPLICATIONS_SP_FURNITURES] FOREIGN KEY([FURNITURE_ID])
	REFERENCES [dbo].[SP_FURNITURES] ([FURNITURE_ID])
GO

IF OBJECT_ID('dbo.FK_PR_APPLICATIONS_SP_PERSONS_APPLICANT') IS NULL
	ALTER TABLE [dbo].[PR_APPLICATIONS]  WITH CHECK ADD  CONSTRAINT [FK_PR_APPLICATIONS_SP_PERSONS_APPLICANT] FOREIGN KEY([APPLICANT_GUID])
	REFERENCES [dbo].[SP_PERSONS] ([PERSON_GUID])
GO

IF OBJECT_ID('dbo.FK_PR_APPLICATIONS_SP_PERSONS_MANAGER') IS NULL
	ALTER TABLE [dbo].[PR_APPLICATIONS]  WITH CHECK ADD  CONSTRAINT [FK_PR_APPLICATIONS_SP_PERSONS_MANAGER] FOREIGN KEY([MANAGER_GUID])
	REFERENCES [dbo].[SP_PERSONS] ([PERSON_GUID])
GO

