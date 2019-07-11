CREATE PROCEDURE [dbo].[UpdateUserBodyOfKnowledge]
	@BodyOfKnowledgeId INT,
	@Name NVARCHAR (50),
	@Acronym NVARCHAR (20) NULL,
	@Keywords NVARCHAR(MAX) NULL,
	@IsShared BIT NULL,
	@HasBeenShared BIT NULL,
	@LastModifiedOffset DATETIMEOFFSET NULL,
	@CloudRowId UNIQUEIDENTIFIER,
	@Originator UNIQUEIDENTIFIER
AS
	DECLARE @rowsaffected INT 
	DECLARE @UserProfileId INT

	IF (@BodyOfKnowledgeId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[UpdateUserBodyOfKnowledge].@BodyOfKnowledgeId')  
	END
	IF (@Originator IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[UpdateUserBodyOfKnowledge].@Originator')  
	END

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
			LastModifiedOffset=@LastModifiedOffset
		WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId
		AND UserProfileId=@UserProfileId
		AND CloudRowId=@CloudRowId;
		SET @rowsaffected = @@ROWCOUNT
	END
RETURN @rowsaffected