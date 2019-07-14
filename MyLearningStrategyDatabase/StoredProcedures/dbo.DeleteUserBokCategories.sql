CREATE PROCEDURE [dbo].[DeleteUserBokCategories]
    @BodyOfKnowledgeId INT,
	@CategoryId INT NULL,
	@Originator UNIQUEIDENTIFIER
AS
	IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
	    
	IF (@CategoryId IS NULL)
		BEGIN
			DELETE FROM [dbo].[BodyOfKnowledgeCategories]
			WHERE BodyOfKnowledgeId=@BodyOfKnowledgeId
		END
	ELSE
		BEGIN
			DELETE FROM [dbo].[BodyOfKnowledgeCategories]
			WHERE BodyOfKnowledgeId=@BodyOfKnowledgeId AND CategoryId=@CategoryId
		END

RETURN 0