CREATE PROCEDURE [dbo].[AddUserBokCatagory]
    @BodyOfKnowledgeId INT, 
    @CategoryId INT,
	@Originator uniqueidentifier
AS
	BEGIN
		DECLARE @UserProfileId INT
		SET @UserProfileId = [dbo].[OriginatorToUserId](@Originator)
		IF (@UserProfileId is null)
		BEGIN
			RAISERROR (13538,14,-1, 'User not found!');   
		END
		INSERT INTO [dbo].[BodyOfKnowledgeCategories]
		(BodyOfKnowledgeId,CategoryId,UserProfileId )
		VALUES (@BodyOfKnowledgeId,@CategoryId,@UserProfileId);
	END
RETURN