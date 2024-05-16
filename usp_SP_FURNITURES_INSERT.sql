SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.usp_SP_FURNITURES_INSERT') IS NOT NULL
	DROP PROCEDURE [dbo].[usp_SP_FURNITURES_INSERT]
GO

CREATE PROCEDURE [dbo].[usp_SP_FURNITURES_INSERT] 
	@JSON NVARCHAR(MAX)
AS
BEGIN
	BEGIN TRY

		INSERT INTO SP_FURNITURES
			(FURNITURE_NAME)
		SELECT 
			j.FURNITURE_NAME
		FROM OPENJSON(@JSON) WITH (
			FURNITURE_NAME VARCHAR(255)
		) j
		
		RETURN 0;
	END TRY
	BEGIN CATCH
		DECLARE @ErrMessage VARCHAR(MAX) = '������ ��� �������� (SP_FURNITURES):' + CHAR(13) + CHAR(10);
		SET @ErrMessage = @ErrMessage + '(' + CAST(ERROR_NUMBER() AS VARCHAR(MAX)) + ') ' +  ERROR_MESSAGE();
		RAISERROR(@ErrMessage, 16, 1);
		RETURN 1;
	END CATCH
END
GO