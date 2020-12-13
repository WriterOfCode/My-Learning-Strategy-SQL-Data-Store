CREATE PROCEDURE [dbo].[AddUserSubject]
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
	DECLARE @BodyOfKnowledgeId INT

	IF NOT EXISTS (SELECT UserProfileId FROM UserProfiles WHERE Originator = @Originator)
	BEGIN
		RAISERROR (13538,14,-1, 'User not found!');   
	END
	BEGIN
	INSERT INTO [dbo].[BodyOfKnowledge]
			   (UserProfileId
			   ,Name
			   ,Description
			   ,Keywords
			   ,ImageDevice
			   ,ImageCloud
			   ,ImageHash
			   ,IsShared
			   ,HasBeenShared)
		 VALUES
			   (@UserProfileId
			   ,@Name
			   ,@Description
			   ,@Keywords
			   ,@ImageDevice
			   ,@ImageCloud
			   ,@ImageHash
			   ,@IsShared
			   ,@HasBeenShared);

	SET @BodyOfKnowledgeId = CAST(SCOPE_IDENTITY() AS INT);

	SELECT @BodyOfKnowledgeId AS BodyOfKnowledgeId

	END
RETURN @BodyOfKnowledgeId