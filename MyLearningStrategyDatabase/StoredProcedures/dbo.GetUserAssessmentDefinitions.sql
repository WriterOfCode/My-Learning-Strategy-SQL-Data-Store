CREATE PROCEDURE [dbo].[GetUserAssessmentDefinitions]
    @BodyOfKnowledgeId INT NULL,
	@AssessmentDefinitionId INT NULL,
	@Originator UNIQUEIDENTIFIER
AS
IF (@BodyOfKnowledgeId IS NULL)
BEGIN
	RAISERROR (15600, 17,-1, 'GetUserAssessments.@BodyOfKnowledgeId');   
END

	IF (@BodyOfKnowledgeId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[UpdateUserQuestions].@BodyOfKnowledgeId');   
	END
	IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END

	IF (@AssessmentDefinitionId IS NULL)
	BEGIN
		SELECT [AssessmentDefinitionId] , 
		[BodyOfKnowledgeId], 
		[Description], 
		[SortRuleId], 
		[QuestionRandom], 
		[QuestionMax], 
		[QuestionMin], 
		[ResponseRandom], 
		[ResponseMax], 
		[ResponseMin], 
		[ResponseMinCorrect], 
		[ResponseMaxCorrect], 
		[AppliedTaxonomyId],
		[Taxonomy]
		FROM [dbo].[AssessmentDefinitions]
		WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId
	END 
	ELSE
	BEGIN
		SELECT [AssessmentDefinitionId] , 
		[BodyOfKnowledgeId], 
		[Description], 
		[SortRuleId], 
		[QuestionRandom], 
		[QuestionMax], 
		[QuestionMin], 
		[ResponseRandom], 
		[ResponseMax], 
		[ResponseMin], 
		[ResponseMinCorrect], 
		[ResponseMaxCorrect], 
		[AppliedTaxonomyId],
		[Taxonomy]
		FROM [dbo].[AssessmentDefinitions]
		WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId
		AND AssessmentDefinitionId = @AssessmentDefinitionId
	END

RETURN 0
