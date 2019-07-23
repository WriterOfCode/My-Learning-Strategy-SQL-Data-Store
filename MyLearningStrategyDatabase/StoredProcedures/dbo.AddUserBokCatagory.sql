CREATE PROCEDURE [dbo].[AddUserBokCatagory]
    @BodyOfKnowledgeId INT, 
    @CategoryId INT,
	@UserProfileId INT
AS
	BEGIN
		INSERT INTO [dbo].[BodyOfKnowledgeCategories]
		(BodyOfKnowledgeId,CategoryId,UserProfileId )
		VALUES (@BodyOfKnowledgeId,@CategoryId,@UserProfileId);
	END
RETURN