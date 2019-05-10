CREATE PROCEDURE [dbo].[AddUserBodyOfKnowledge]
	@Name NVARCHAR (50),
	@Acronym NVARCHAR (20) NULL,
	@Keywords NVARCHAR(MAX) NULL,
	@IsShared BIT NULL,
	@HasBeenShared BIT NULL,
	@Originator UNIQUEIDENTIFIER
AS
	DECLARE @UserProfileId INT
	DECLARE @BodyOfKnowledgeId AS INT


	IF (@Originator IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[UpdateUserAssessmentDefinitions].@Originator');   
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
			   ,HasBeenShared)
		 VALUES
			   (@UserProfileId
			   ,@Name
			   ,@Acronym
			   ,@Keywords
			   ,@IsShared
			   ,@HasBeenShared);

	SELECT CAST(SCOPE_IDENTITY() AS INT) AS BodyOfKnowledgeId;

	END
RETURN @BodyOfKnowledgeId