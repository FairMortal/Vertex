SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.usp_PR_APPLICATIONS_DELETE') IS NOT NULL
	DROP PROCEDURE [dbo].[usp_PR_APPLICATIONS_DELETE]
GO

/*
{"APPLICATION_ID":1,
"furnitureOrderId": 1,
"applicant": {
"id": "GUID_������",
"name": "�������",
"surname": "������",
"department": "����������� ��"
},
"applicationReason": "�������",
"coordinatingManager": {
"id": "GUID_�����������",
"name": "��������",
"surname": "�����������",
"department": "����������� ������������� ������������",
"division": "����� ������������ ������",
"position": "���������� ����������"
},
"resolution": "��������",
"resolutionPeriod": 1,
"resolutionSolution": "������",
"status": "� ������"}
*/

CREATE PROCEDURE [dbo].[usp_PR_APPLICATIONS_DELETE] 
	@JSON NVARCHAR(MAX)
AS
BEGIN
	BEGIN TRY
		DECLARE @APPLICATION_ID INT;
		
		SELECT
			@APPLICATION_ID = APPLICATION_ID
		FROM OPENJSON(@JSON) WITH (
			APPLICATION_ID INT
		)

		DELETE PR_APPLICATIONS WHERE APPLICATION_ID = @APPLICATION_ID
		
		RETURN 0;
	END TRY
	BEGIN CATCH
		DECLARE @ErrMessage VARCHAR(MAX) = '������ �������� (PR_APPLICATIONS):' + CHAR(13) + CHAR(10);
		SET @ErrMessage = @ErrMessage + '(' + CAST(ERROR_NUMBER() AS VARCHAR(MAX)) + ') ' +  ERROR_MESSAGE();
		RAISERROR(@ErrMessage, 16, 1);
		RETURN 1;
	END CATCH
END
GO
