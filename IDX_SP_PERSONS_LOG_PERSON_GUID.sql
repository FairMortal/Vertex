SET ANSI_PADDING ON
GO

IF INDEXPROPERTY(OBJECT_ID('dbo.SP_PERSONS_LOG'), 'IDX_SP_PERSONS_LOG_PERSON_GUID', 'IndexID') IS NULL
	CREATE NONCLUSTERED INDEX [IDX_SP_PERSONS_LOG_PERSON_GUID] ON [dbo].[SP_PERSONS_LOG]
	(
		[PERSON_GUID] ASC
	) ON [PRIMARY]
GO


