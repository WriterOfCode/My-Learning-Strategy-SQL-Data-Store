CREATE PROCEDURE [dbo].[AddUserBodyOfKnowledge]
	@UserProfileId INT,
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

	DECLARE @BodyOfKnowledgeId AS INT

	IF ([dbo].[IsOriginatorUsers](@UserProfileId,@Originator)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END

	BEGIN
	INSERT INTO [dbo].[BodyOfKnowledge]
			   (UserProfileId
			   ,Name
			   ,Acronym
			   ,Keywords
			   ,IsShared
			   ,ImageDevice
			   ,ImageCloud
			   ,ImageHash
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

	SELECT CAST(SCOPE_IDENTITY() AS INT) AS BodyOfKnowledgeId;

	END
RETURN @BodyOfKnowledgeId