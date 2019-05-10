CREATE PROCEDURE [dbo].[DeteUserResponses]
    @QuestionId INT NULL,
	@ResponseId INT NULL,
	@Originator UNIQUEIDENTIFIER
AS
	IF (@QuestionId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[DeteUserResponses].@QuestionId can not be null');   
	END
	IF (@Originator IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[DeteUserResponses].@Originator can not be null');   
	END
	IF ([dbo].[IsQuestionOriginator](@Originator,@QuestionId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
	IF (@ResponseId IS NULL)
		BEGIN
			BEGIN TRANSACTION RESPONSE;
			BEGIN TRY
				DELETE FROM [dbo].[Responses]
				WHERE QuestionId= @QuestionId
			END TRY
			BEGIN CATCH

			IF @@TRANCOUNT>0
				ROLLBACK TRANSACTION RESPONSE;
			END CATCH;
			IF @@TRANCOUNT>0
				COMMIT TRANSACTION RESPONSE;
		END
	ELSE
	BEGIN
			BEGIN TRANSACTION RESPONSE;
			BEGIN TRY
				DELETE FROM [dbo].[Responses]
				WHERE ResponseId= @ResponseId 
				AND QuestionId= @QuestionId
			END TRY
			BEGIN CATCH

			IF @@TRANCOUNT>0
				ROLLBACK TRANSACTION RESPONSE;
			END CATCH;
			IF @@TRANCOUNT>0
				COMMIT TRANSACTION RESPONSE;
	END
RETURN 0