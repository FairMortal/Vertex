SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.usp_SP_TYPEPROPERTIES_UPDATE') IS NOT NULL
	DROP PROCEDURE [dbo].[usp_SP_TYPEPROPERTIES_UPDATE]
GO

CREATE PROCEDURE [dbo].[usp_SP_TYPEPROPERTIES_UPDATE] 
	@JSON NVARCHAR(MAX)
AS
BEGIN
	BEGIN TRY

		UPDATE p
		SET
			p.TYPE_NAME = j.TYPE_NAME
			, p.TYPE_SNAME = j.TYPE_SNAME
		FROM OPENJSON(@JSON) WITH (
			TYPE_ID SMALLINT
			, TYPE_NAME VARCHAR(255)
			, TYPE_SNAME VARCHAR(100)
		) j
		JOIN SP_TYPEPROPERTIES p ON p.TYPE_ID = j.TYPE_ID
		
		RETURN 0;
	END TRY
	BEGIN CATCH
		DECLARE @ErrMessage VARCHAR(MAX) = '������ ��� ���������� (SP_TYPEPROPERTIES):' + CHAR(13) + CHAR(10);
		SET @ErrMessage = @ErrMessage + '(' + CAST(ERROR_NUMBER() AS VARCHAR(MAX)) + ') ' +  ERROR_MESSAGE();
		RAISERROR(@ErrMessage, 16, 1);
		RETURN 1;
	END CATCH
END
GO