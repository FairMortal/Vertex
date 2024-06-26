SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.udf_GET_TYPEPROPERTY') IS NOT NULL
	DROP FUNCTION [dbo].[udf_GET_TYPEPROPERTY]
GO

CREATE FUNCTION [dbo].[udf_GET_TYPEPROPERTY]
(
	@TYPE_SNAME VARCHAR(100)
)
RETURNS INT
AS
BEGIN
	DECLARE @TYPE_ID INT

	SELECT 
		@TYPE_ID = TYPE_ID 
	FROM SP_TYPEPROPERTIES
	WHERE
		TYPE_SNAME = @TYPE_SNAME

	RETURN @TYPE_ID
END
GO

