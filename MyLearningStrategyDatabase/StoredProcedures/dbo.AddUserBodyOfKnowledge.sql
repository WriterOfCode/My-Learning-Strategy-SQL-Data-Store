CREATE PROCEDURE [dbo].[AddUserBodyOfKnowledge]
	@Name NVARCHAR (150),
	@Acronym NVARCHAR (50) NULL,
	@Keywords NVARCHAR(100) NULL,
	@IsShared BIT NULL,
	@HasBeenShared BIT NULL,
	@LastModifiedOffset DATETIMEOFFSET NULL,
	@Originator UNIQUEIDENTIFIER

AS
	DECLARE @UserProfileId INT
	DECLARE @BodyOfKnowledgeId AS INT


	IF (@Originator IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[AddUserBodyOfKnowledge].@Originator');   
	END
	SET @UserProfileId = [dbo].[OriginatorToUserId](@Originator)
	IF (@UserProfileId=0)
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
			   ,HasBeenShared
			   ,LastModifiedOffset)
		 VALUES
			   (@UserProfileId
			   ,@Name
			   ,@Acronym
			   ,@Keywords
			   ,@IsShared
			   ,@HasBeenShared
			   ,@LastModifiedOffset);

	SELECT CAST(SCOPE_IDENTITY() AS INT) AS BodyOfKnowledgeId;

	END
RETURN @BodyOfKnowledgeId