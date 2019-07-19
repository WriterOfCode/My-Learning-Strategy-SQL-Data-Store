CREATE PROCEDURE [dbo].[UpdateUserBodyOfKnowledge]
	@BodyOfKnowledgeId INT,
	@Name NVARCHAR (50),
	@Acronym NVARCHAR (20) NULL,
	@Keywords NVARCHAR(100) NULL,
	@IsShared BIT NULL,
	@HasBeenShared BIT NULL,
	@LastModifiedOffset DATETIMEOFFSET NULL,
	@CloudRowId UNIQUEIDENTIFIER,
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
			IsShared=@IsShared,
			HasBeenShared=@HasBeenShared,
			LastModifiedOffset=SYSDATETIMEOFFSET()
		WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId
		AND UserProfileId=@UserProfileId
		AND CloudRowId=@CloudRowId;
		SET @rowsaffected = @@ROWCOUNT
	END
RETURN @rowsaffected