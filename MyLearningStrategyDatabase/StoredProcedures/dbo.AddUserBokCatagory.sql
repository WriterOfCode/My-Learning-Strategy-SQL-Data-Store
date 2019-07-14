CREATE PROCEDURE [dbo].[AddUserBokCatagory]
    @BodyOfKnowledgeId INT, 
    @CategoryId INT,
	@UserProfileId INT,
	@Originator UNIQUEIDENTIFIER
AS
	IF ([dbo].[IsOriginatorUsers](@UserProfileId,@Originator)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END

	BEGIN
		INSERT INTO [dbo].[BodyOfKnowledgeCategories]
		(BodyOfKnowledgeId,CategoryId,UserProfileId )
		VALUES (@BodyOfKnowledgeId,@CategoryId,@UserProfileId);
	END
RETURN