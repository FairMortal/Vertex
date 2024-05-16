SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.usp_PR_APPLICATIONS_UPDATE') IS NOT NULL
	DROP PROCEDURE [dbo].[usp_PR_APPLICATIONS_UPDATE]
GO

/*
{"APPLICATION_ID":1,
"furnitureOrderId": 1,
"applicant": {
"id": "GUID_Петров",
"name": "Василий",
"surname": "Петров",
"department": "Департамент ИТ"
},
"applicationReason": "поломка",
"coordinatingManager": {
"id": "GUID_Александров",
"name": "Владимир",
"surname": "Александров",
"department": "Департамент хозяйственной деятельности",
"division": "отдел эксплуатации здания",
"position": "заведующий хозяйством"
},
"resolution": "одобрено",
"resolutionPeriod": 1,
"resolutionSolution": "замена",
"status": "в работе"}
*/

CREATE PROCEDURE [dbo].[usp_PR_APPLICATIONS_UPDATE] 
	@JSON NVARCHAR(MAX)
AS
BEGIN
	BEGIN TRY

		UPDATE a
		SET
			a.[FURNITURE_ID] = j.furnitureOrderId
			, a.[APPLICANT_GUID] = j.applicant_id
			, a.[REASON_ID] = p1.PROPERTY_ID
			, a.[MANAGER_GUID] = j.coordinatingManager
			, a.[RESULUTION_ID] = p3.PROPERTY_ID
			, a.[resolutionPeriod] = j.resolutionPeriod
			, a.[SOLUTION_ID] = p2.PROPERTY_ID
			, a.[STATUS_ID] = p4.PROPERTY_ID
		FROM OPENJSON(@JSON) WITH (
			APPLICATION_ID INT
			,furnitureOrderId INT
			, applicant_id VARCHAR(36) '$.applicant.id'
			, applicationReason VARCHAR(100)
			, coordinatingManager VARCHAR(36) '$.coordinatingManager.id'
			, resolution VARCHAR(100)
			, resolutionPeriod SMALLINT
			, resolutionSolution VARCHAR(100)
			, status VARCHAR(100)
		) j
		JOIN PR_APPLICATIONS a ON j.APPLICATION_ID = a.APPLICATION_ID
		LEFT JOIN SP_PROPERTIES p1 WITH(NOLOCK) ON p1.PROPERTY_SNAME = j.applicationReason	AND p1.TYPE_ID = [dbo].[udf_GET_TYPEPROPERTY]('Заявки.Причины')
		LEFT JOIN SP_PROPERTIES p2 WITH(NOLOCK) ON p2.PROPERTY_SNAME = j.resolution			AND p2.TYPE_ID = [dbo].[udf_GET_TYPEPROPERTY]('Заявки.СтатусыРешений')
		LEFT JOIN SP_PROPERTIES p3 WITH(NOLOCK) ON p3.PROPERTY_SNAME = j.resolutionSolution AND p3.TYPE_ID = [dbo].[udf_GET_TYPEPROPERTY]('Заявки.ТипыРешений')
		LEFT JOIN SP_PROPERTIES p4 WITH(NOLOCK) ON p4.PROPERTY_SNAME = j.status				AND p4.TYPE_ID = [dbo].[udf_GET_TYPEPROPERTY]('Заявки.Статусы')
		
		RETURN 0;
	END TRY
	BEGIN CATCH
		DECLARE @ErrMessage VARCHAR(MAX) = 'Ошибка обновления (PR_APPLICATIONS):' + CHAR(13) + CHAR(10);
		SET @ErrMessage = @ErrMessage + '(' + CAST(ERROR_NUMBER() AS VARCHAR(MAX)) + ') ' +  ERROR_MESSAGE();
		RAISERROR(@ErrMessage, 16, 1);
		RETURN 1;
	END CATCH
END
GO
