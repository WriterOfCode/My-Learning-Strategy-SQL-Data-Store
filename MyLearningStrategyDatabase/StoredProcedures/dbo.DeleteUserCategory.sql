CREATE PROCEDURE [dbo].[DeleteUserCategory]
	@CategoryId INT,
	@UserProfileId INT,
	@Originator UNIQUEIDENTIFIER
AS

	IF ([dbo].[IsOriginatorUsers](@UserProfileId,@Originator)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
	    
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