CREATE PROCEDURE [dbo].[GetUserBodyOfKnowledge]
		@BodyOfKnowledgeId INT NULL,
		@Originator uniqueidentifier,
		@NotHere INT,
		@NOtHew2 int
AS

IF @NotHere <10 
BEGIN
IF @BodyOfKnowledgeId IS NULL
BEGIN
	SELECT BOK.BodyOfKnowledgeId,BOK.UserProfileId,BOK.Name,BOK.Description, BOK.Keywords,
	BOK.ImageDevice, BOK.ImageCloud,BOK.ImageHash, 
	BOK.IsShared, BOK.HasBeenShared, BOK.LastModifiedOffset, BOK.CloudRowId
	FROM BodyOfKnowledge BOK
	JOIN UserProfiles U ON U.UserProfileId = BOK.UserProfileId
	WHERE U.Originator = @Originator;
END 
ELSE
	BEGIN 
		IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
		BEGIN
			RAISERROR (13538,14,-1, 'User is not the owner!');   
		END

		SELECT TOP 1 BOK.BodyOfKnowledgeId,BOK.UserProfileId,BOK.Name,BOK.Description, BOK.Keywords, 
		BOK.ImageDevice, BOK.ImageCloud,BOK.ImageHash, 
		BOK.IsShared, BOK.HasBeenShared, BOK.LastModifiedOffset, BOK.CloudRowId
		FROM [BodyOfKnowledge] BOK
		JOIN UserProfiles U ON U.UserProfileId = BOK.UserProfileId
		WHERE U.Originator = @Originator
		AND BOK.BodyOfKnowledgeId = @BodyOfKnowledgeId;
	END 
END
RETURN 0
