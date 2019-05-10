CREATE PROCEDURE [dbo].[AddUserAssessmentDefinitions]
    @BodyOfKnowledgeId INT, 
    @Description NVARCHAR(256), 
    @SortRuleId INT, 
    @QuestionRandom BIT, 
    @QuestionMax INT NULL, 
    @QuestionMin INT NULL, 
    @ResponseRandom BIT NULL, 
    @ResponseMax INT NULL, 
    @ResponseMin INT NULL, 
    @ResponseMinCorrect INT NULL, 
    @ResponseMaxCorrect INT NULL, 
    @AppliedTaxonomyId INT NULL,
	@Taxonomy BIT,
	@Originator uniqueidentifier
AS
	DECLARE	@AssessmentDefinitionId INT; 

	IF (@BodyOfKnowledgeId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[AddUserAssessmentDefinitions].@BodyOfKnowledgeId');   
	END
	IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
	
	BEGIN
		INSERT INTO [dbo].[AssessmentDefinitions]
			(BodyOfKnowledgeId, 
			Description, 
			SortRuleId, 
			QuestionRandom, 
			QuestionMax, 
			QuestionMin, 
			ResponseRandom, 
			ResponseMax, 
			ResponseMin, 
			ResponseMinCorrect, 
			ResponseMaxCorrect, 
			AppliedTaxonomyId,
			Taxonomy)
		VALUES (@BodyOfKnowledgeId, 
				@Description, 
				@SortRuleId, 
				@QuestionRandom, 
				@QuestionMax, 
				@QuestionMin, 
				@ResponseRandom, 
				@ResponseMax, 
				@ResponseMin, 
				@ResponseMinCorrect, 
				@ResponseMaxCorrect, 
				@AppliedTaxonomyId,
				@Taxonomy);

		SELECT CAST(SCOPE_IDENTITY() AS INT) AS AssessmentDefinitionId;
	END

RETURN
