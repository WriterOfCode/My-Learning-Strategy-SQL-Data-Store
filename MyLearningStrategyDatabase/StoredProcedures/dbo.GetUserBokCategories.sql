CREATE PROCEDURE [dbo].[GetUserBokCategories]
    @BodyOfKnowledgeId INT,
	@CategoryId INT NULL,
	@UserProfileId INT
AS
	--IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId )=0)
	--BEGIN
	--	RAISERROR (13538,14,-1, 'User is not the owner!');   
	--END
	 IF (@CategoryId IS NULL)
		BEGIN
			SELECT bokc.BodyOfKnowledgeId, 
			bokc.CategoryId, bokc.UserProfileId, 
			bokc.LastModifiedOffset, bokc.CloudRowId,
			c.CategoryName,c.ImageDevice, c.ImageCloud,c.ImageHash
			FROM [dbo].[BodyOfKnowledgeCategories] bokc
			JOIN [dbo].[Categories] c on c.CategoryId = bokc.CategoryId AND c.UserProfileId = bokc.UserProfileId
			JOIN [dbo].[UserProfiles] u on u.UserProfileId = bokc.UserProfileId
			WHERE   bokc.BodyOfKnowledgeId=@BodyOfKnowledgeId
			AND u.UserProfileId = @UserProfileId
		END
	ELSE
		BEGIN
			SELECT bokc.BodyOfKnowledgeId, 
			bokc.CategoryId, bokc.UserProfileId, 
			bokc.LastModifiedOffset, bokc.CloudRowId,
			c.CategoryName,c.ImageDevice, c.ImageCloud,c.ImageHash
			FROM [dbo].[BodyOfKnowledgeCategories] bokc
			JOIN [dbo].[Categories] c on c.CategoryId = bokc.CategoryId AND c.UserProfileId = bokc.UserProfileId
			JOIN [dbo].[UserProfiles] u on u.UserProfileId = bokc.UserProfileId
			WHERE   bokc.BodyOfKnowledgeId=@BodyOfKnowledgeId 
			AND u.UserProfileId = @UserProfileId
			AND c.CategoryId=@CategoryId
		END
	
RETURN 0