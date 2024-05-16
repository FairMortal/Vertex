SET ANSI_PADDING ON
GO

IF INDEXPROPERTY(OBJECT_ID('dbo.SP_PROPERTIES'), 'IDX_SP_PROPERTIES_TYPE_ID', 'IndexID') IS NULL
	CREATE NONCLUSTERED INDEX [IDX_SP_PROPERTIES_TYPE_ID] ON [dbo].[SP_PROPERTIES]
	(
		[TYPE_ID] ASC
	) ON [PRIMARY]
GO

