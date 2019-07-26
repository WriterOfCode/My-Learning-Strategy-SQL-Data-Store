CREATE PROCEDURE [dbo].[DeleteUserCategory]
	@CategoryId INT,
	@Originator UNIQUEIDENTIFIER
AS

	DECLARE @UserProfileId INT
	SET @UserProfileId = [dbo].[OriginatorToUserId](@Originator)

	BEGIN
			BEGIN TRANSACTION RESPONSE;
			BEGIN TRY
				DELETE FROM  [dbo].[BodyOfKnowledgeCategories]
				WHERE  UserProfileId=@UserProfileId AND CategoryId= @CategoryId 

				DELETE FROM  [dbo].[QuestionCategories]
				WHERE  UserProfileId=@UserProfileId AND CategoryId= @CategoryId 

				DELETE FROM [dbo].[Categories]
				WHERE  UserProfileId=@UserProfileId AND CategoryId= @CategoryId
			END TRY
			BEGIN CATCH

			IF @@TRANCOUNT>0
				ROLLBACK TRANSACTION RESPONSE;
			END CATCH;
			IF @@TRANCOUNT>0
				COMMIT TRANSACTION RESPONSE;
	END

RETURN 0