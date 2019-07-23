CREATE PROCEDURE [dbo].[DeleteUserBokCategories]
    @BodyOfKnowledgeId INT, 
    @CategoryId INT NULL,
	@UserProfileId INT
AS

	    
	IF (@CategoryId IS NULL)
		BEGIN
			DELETE FROM [dbo].[BodyOfKnowledgeCategories]
			WHERE BodyOfKnowledgeId=@BodyOfKnowledgeId 
			AND UserProfileId=@UserProfileId
		END
	ELSE
		BEGIN
			DELETE FROM [dbo].[BodyOfKnowledgeCategories]
			WHERE BodyOfKnowledgeId=@BodyOfKnowledgeId 
			AND CategoryId=@CategoryId
			AND UserProfileId=@UserProfileId
		END

RETURN 0