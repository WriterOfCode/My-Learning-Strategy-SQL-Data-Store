CREATE PROCEDURE [dbo].[AddUserContentSelections]
	@LearningPlanDefinitionId INT,
	@TableOfContentId INT NULL,
	@LearningContentId INT NULL,
	@Originator UNIQUEIDENTIFIER
AS
	DECLARE @LearningPlanContentSelectionsId AS INT
	IF (@Originator IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[AddUserContentSelections].@Originator');   
	END
	IF (@LearningPlanDefinitionId IS NULL AND @TableOfContentId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, 'Both [AddUserContentSelections].@LearningPlanDefinitionId and @TableOfContentId can not be null');   
	END
	IF (@TableOfContentId IS NOT NULL)
		BEGIN
  			IF ([dbo].[IsTOCOriginator](@Originator,@TableOfContentId)=0)
			BEGIN
				RAISERROR (13538,14,-1, 'User is not the owner!');   
			END
		END
	ELSE
		IF (@LearningPlanDefinitionId IS NOT NULL)
		BEGIN
  			IF ([dbo].[IsLPDUsers](@Originator,@LearningPlanDefinitionId)=0)
			BEGIN
				RAISERROR (13538,14,-1, 'User is not the owner!');   
			END 
		END

	BEGIN
	INSERT INTO [dbo].[LearningPlanContentSelections]
			   (LearningPlanDefinitionId
			   ,TableOfContentId
			   ,LearningContentId)
		 VALUES
			   (@LearningPlanDefinitionId
			   ,@TableOfContentId
			   ,@LearningContentId);

			   SELECT CAST(SCOPE_IDENTITY() AS INT) AS LearningPlanContentSelectionsId;
	END
RETURN @LearningPlanContentSelectionsId