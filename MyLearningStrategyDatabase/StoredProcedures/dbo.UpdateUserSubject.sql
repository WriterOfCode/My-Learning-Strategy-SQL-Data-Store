CREATE PROCEDURE [dbo].[UpdateUserSubject]
	@BodyOfKnowledgeId INT,
	@UserProfileId INT,
	@Name NVARCHAR (50),
	@Description NVARCHAR (300) NULL,
	@Keywords NVARCHAR(100) NULL,
	@ImageDevice NVARCHAR(256) NULL, 
	@ImageCloud NVARCHAR(2083) NULL,
	@ImageHash INT NULL, 
	@IsShared BIT NULL,
	@HasBeenShared BIT NULL,
	@Originator UNIQUEIDENTIFIER
AS
	DECLARE @rowsaffected INT 
	IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END

	BEGIN
		UPDATE [dbo].[BodyOfKnowledge]
		SET Name=@Name,
			Description=@Description,
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