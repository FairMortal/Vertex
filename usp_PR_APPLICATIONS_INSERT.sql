SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.usp_PR_APPLICATIONS_INSERT') IS NOT NULL
	DROP PROCEDURE [dbo].[usp_PR_APPLICATIONS_INSERT]
GO

/*
{"furnitureOrderId": 1,
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

CREATE PROCEDURE [dbo].[usp_PR_APPLICATIONS_INSERT] 
	@JSON NVARCHAR(MAX)
AS
BEGIN
	BEGIN TRY

		INSERT INTO PR_APPLICATIONS
			([FURNITURE_ID]
			, [APPLICANT_GUID]
			, [REASON_ID]
			, [MANAGER_GUID]
			, [RESULUTION_ID]
			, [resolutionPeriod]
			, [SOLUTION_ID]
			, [STATUS_ID])
		SELECT 
			j.furnitureOrderId
			, j.applicant_id
			, p1.PROPERTY_ID AS [REASON_ID]
			, j.coordinatingManager
			, p3.PROPERTY_ID AS [RESULUTION_ID]
			, j.resolutionPeriod
			, p2.PROPERTY_ID AS [SOLUTION_ID]
			, p4.PROPERTY_ID AS [STATUS_ID]
		FROM OPENJSON(@JSON) WITH (
			furnitureOrderId INT
			, applicant_id VARCHAR(36) '$.applicant.id'
			, applicationReason VARCHAR(100)
			, coordinatingManager VARCHAR(36) '$.coordinatingManager.id'
			, resolution VARCHAR(100)
			, resolutionPeriod SMALLINT
			, resolutionSolution VARCHAR(100)
			, status VARCHAR(100)
		) j
		LEFT JOIN SP_PROPERTIES p1 WITH(NOLOCK) ON p1.PROPERTY_SNAME = j.applicationReason	AND p1.TYPE_ID = [dbo].[udf_GET_TYPEPROPERTY]('������.�������')
		LEFT JOIN SP_PROPERTIES p2 WITH(NOLOCK) ON p2.PROPERTY_SNAME = j.resolution			AND p2.TYPE_ID = [dbo].[udf_GET_TYPEPROPERTY]('������.��������������')
		LEFT JOIN SP_PROPERTIES p3 WITH(NOLOCK) ON p3.PROPERTY_SNAME = j.resolutionSolution AND p3.TYPE_ID = [dbo].[udf_GET_TYPEPROPERTY]('������.�����������')
		LEFT JOIN SP_PROPERTIES p4 WITH(NOLOCK) ON p4.PROPERTY_SNAME = j.status				AND p4.TYPE_ID = [dbo].[udf_GET_TYPEPROPERTY]('������.�������')
		
		RETURN 0;
	END TRY
	BEGIN CATCH
		DECLARE @ErrMessage VARCHAR(MAX) = '������ ��� �������� (PR_APPLICATIONS):' + CHAR(13) + CHAR(10);
		SET @ErrMessage = @ErrMessage + '(' + CAST(ERROR_NUMBER() AS VARCHAR(MAX)) + ') ' +  ERROR_MESSAGE();
		RAISERROR(@ErrMessage, 16, 1);
		RETURN 1;
	END CATCH
END
GO