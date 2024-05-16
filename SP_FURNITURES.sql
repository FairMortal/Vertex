SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.SP_FURNITURES') IS NULL
	CREATE TABLE [dbo].[SP_FURNITURES](
		[FURNITURE_ID] [INT] IDENTITY(1,1) NOT NULL,
		[FURNITURE_NAME] [VARCHAR](255) NOT NULL,
		CONSTRAINT [PK_SP_FURNITURES] PRIMARY KEY CLUSTERED 
		(
			[FURNITURE_ID] ASC
		) ON [PRIMARY]
	) ON [PRIMARY]
GO