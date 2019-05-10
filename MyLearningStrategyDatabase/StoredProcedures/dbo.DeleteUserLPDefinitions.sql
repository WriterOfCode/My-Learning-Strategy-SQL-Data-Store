CREATE PROCEDURE [dbo].[DeleteUserLPDefinitions]
	    @BodyOfKnowledgeId INT NULL, 
		@Originator UNIQUEIDENTIFIER,
		@LearningPlanDefinitionId INT NULL,
		@AppliedTaxonomyId INT NULL
AS
	IF (@BodyOfKnowledgeId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, 'DeleteUserLPDefinitions.@BodyOfKnowledgeId');   
	END
	IF (@Originator IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, 'DeleteUserLPDefinitions.@Originator');   
	END
	IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
	IF (@LearningPlanDefinitionId IS NOT NULL)
		BEGIN
			DELETE
			FROM [dbo].[LearningPlanDefinitions]
			WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId
			AND LearningPlanDefinitionId = @LearningPlanDefinitionId
		END
	ELSE IF (@AppliedTaxonomyId IS NOT NULL)
		BEGIN
			DELETE
			FROM [dbo].[LearningPlanDefinitions]
			WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId
			AND AppliedTaxonomyId = @AppliedTaxonomyId
		END
	ELSE
		BEGIN
			DELETE
			FROM [dbo].[LearningPlanDefinitions]
			WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId
		END

RETURN 0
