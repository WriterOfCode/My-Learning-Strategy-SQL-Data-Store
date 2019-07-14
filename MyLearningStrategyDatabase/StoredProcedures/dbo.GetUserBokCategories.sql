CREATE PROCEDURE [dbo].[GetUserBokCategories]
    @BodyOfKnowledgeId INT,
	@CategoryId INT NULL,
	@Originator UNIQUEIDENTIFIER
AS
	IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId )=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
	    
	IF (@CategoryId IS NULL)
		BEGIN
			SELECT BodyOfKnowledgeId, CategoryId, UserProfileId, LastModifiedOffset, CloudRowId
			FROM [dbo].[BodyOfKnowledgeCategories]
			WHERE BodyOfKnowledgeId=@BodyOfKnowledgeId
		END
	ELSE
		BEGIN
			SELECT BodyOfKnowledgeId, CategoryId, UserProfileId, LastModifiedOffset, CloudRowId
			FROM [dbo].[BodyOfKnowledgeCategories]
			WHERE   BodyOfKnowledgeId=@BodyOfKnowledgeId AND CategoryId=@CategoryId 
		END
	
RETURN 0