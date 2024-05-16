SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.usp_SP_PERSONS_UPDATE') IS NOT NULL
	DROP PROCEDURE [dbo].[usp_SP_PERSONS_UPDATE]
GO

CREATE PROCEDURE [dbo].[usp_SP_PERSONS_UPDATE] 
	@JSON NVARCHAR(MAX)
AS
BEGIN
	BEGIN TRY

		UPDATE p
		SET
			p.PERSON_NAME1 = j.PERSON_NAME1
			, p.PERSON_NAME2 = j.PERSON_NAME2
			, p.PERSON_NAME3 = j.PERSON_NAME3
		FROM OPENJSON(@JSON) WITH (
			PERSON_GUID VARCHAR(36)
			, PERSON_NAME1 VARCHAR(255)
			, PERSON_NAME2 VARCHAR(255)
			, PERSON_NAME3 VARCHAR(255)
		) j
		JOIN SP_PERSONS p ON p.PERSON_GUID = j.PERSON_GUID
		
		RETURN 0;
	END TRY
	BEGIN CATCH
		DECLARE @ErrMessage VARCHAR(MAX) = '������ ��� ���������� (SP_PERSONS):' + CHAR(13) + CHAR(10);
		SET @ErrMessage = @ErrMessage + '(' + CAST(ERROR_NUMBER() AS VARCHAR(MAX)) + ') ' +  ERROR_MESSAGE();
		RAISERROR(@ErrMessage, 16, 1);
		RETURN 1;
	END CATCH
END
GO