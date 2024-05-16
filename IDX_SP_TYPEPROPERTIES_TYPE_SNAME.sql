SET ANSI_PADDING ON
GO

IF INDEXPROPERTY(OBJECT_ID('dbo.SP_TYPEPROPERTIES'), 'IDX_SP_TYPEPROPERTIES_TYPE_SNAME', 'IndexID') IS NULL
	CREATE NONCLUSTERED INDEX [IDX_SP_TYPEPROPERTIES_TYPE_SNAME] ON [dbo].[SP_TYPEPROPERTIES]
	(
		[TYPE_SNAME] ASC
	) ON [PRIMARY]
GO


