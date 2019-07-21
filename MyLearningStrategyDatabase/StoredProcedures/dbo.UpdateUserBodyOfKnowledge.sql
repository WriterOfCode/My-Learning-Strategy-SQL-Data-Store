CREATE PROCEDURE [dbo].[UpdateUserBodyOfKnowledge]
	@BodyOfKnowledgeId INT,
	@Name NVARCHAR (50),
	@Acronym NVARCHAR (20) NULL,
	@Keywords NVARCHAR(100) NULL,
	@ImageDevice NVARCHAR(256) NULL, 
	@ImageCloud NVARCHAR(2083) NULL,
	@ImageHash INT NULL, 
	@IsShared BIT NULL,
	@HasBeenShared BIT NULL,
	@Originator UNIQUEIDENTIFIER
AS
	DECLARE @rowsaffected INT 
	DECLARE @UserProfileId INT

	SET @UserProfileId = [dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)
	IF (@UserProfileId=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END

	BEGIN
		UPDATE [dbo].[BodyOfKnowledge]
		SET Name=@Name,
			Acronym=@Acronym,
			Keywords=@Keywords,
			ImageDevice=@ImageDevice,
			ImageCloud=@ImageCloud,
			ImageHash=@ImageHash,
			IsShared=@IsShared,
			HasBeenShared=@HasBeenShared,
			LastModifiedOffset=SYSDATETIMEOFFSET()
		WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId
		AND UserProfileId=@UserProfileId
		SET @rowsaffected = @@ROWCOUNT
	END
RETURN @rowsaffected