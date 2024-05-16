SET ANSI_PADDING ON
GO

IF INDEXPROPERTY(OBJECT_ID('dbo.SP_PROPERTIES_LOG'), 'IDX_SP_PROPERTIES_LOG_PROPERTY_ID', 'IndexID') IS NULL
	CREATE NONCLUSTERED INDEX [IDX_SP_PROPERTIES_LOG_PROPERTY_ID] ON [dbo].[SP_PROPERTIES_LOG]
	(
		[PROPERTY_ID] ASC
	) ON [PRIMARY]
GO


