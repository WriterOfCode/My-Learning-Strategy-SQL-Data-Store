CREATE PROCEDURE [dbo].[AddUserBodyOfKnowledge]
	@Name NVARCHAR (150),
	@Acronym NVARCHAR (50) NULL,
	@Keywords NVARCHAR(100) NULL,
	@ImageDevice NVARCHAR(256) NULL, 
	@ImageCloud NVARCHAR(2083) NULL,
	@ImageHash INT NULL, 
	@IsShared BIT NULL,
	@HasBeenShared BIT NULL,
	@Originator UNIQUEIDENTIFIER
AS
	DECLARE @IdentityValue INT
	DECLARE @UserProfileId INT
	SET @UserProfileId = [dbo].[OriginatorToUserId](@Originator)
	BEGIN
	INSERT INTO [dbo].[BodyOfKnowledge]
			   (UserProfileId
			   ,Name
			   ,Acronym
			   ,Keywords
			   ,ImageDevice
			   ,ImageCloud
			   ,ImageHash
			   ,IsShared
			   ,HasBeenShared)
		 VALUES
			   (@UserProfileId
			   ,@Name
			   ,@Acronym
			   ,@Keywords
			   ,@ImageDevice
			   ,@ImageCloud
			   ,@ImageHash
			   ,@IsShared
			   ,@HasBeenShared);

	SET @IdentityValue = CAST(SCOPE_IDENTITY() AS INT);

	INSERT INTO [dbo].[LearningStrategies](BodyOfKnowledgeId, Name)
	VALUES (@IdentityValue, @Name)

	SELECT @IdentityValue AS BodyOfKnowledgeId

	END
RETURN