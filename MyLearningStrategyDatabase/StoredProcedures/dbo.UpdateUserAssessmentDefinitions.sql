CREATE PROCEDURE [dbo].[UpdateUserAssessmentDefinitions]
	@BodyOfKnowledgeId INT, 
	@AssessmentDefinitionId INT,
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
	@Originator UNIQUEIDENTIFIER
AS
	DECLARE @rowsaffected INT 
	
	IF (@AssessmentDefinitionId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[UpdateUserAssessmentDefinitions].@AssessmentDefinitionId');   
	END
	IF (@BodyOfKnowledgeId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[UpdateUserAssessmentDefinitions].@BodyOfKnowledgeId');   
	END
	IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END

	BEGIN
		UPDATE [dbo].[AssessmentDefinitions]
			SET Description=@Description, 
			SortRuleId=@SortRuleId, 
			QuestionRandom=@QuestionRandom, 
			QuestionMax=@QuestionMax, 
			QuestionMin=@QuestionMin, 
			ResponseRandom=@ResponseRandom, 
			ResponseMax=@ResponseMax, 
			ResponseMin=@ResponseMin, 
			ResponseMinCorrect=@ResponseMinCorrect, 
			ResponseMaxCorrect=@ResponseMaxCorrect, 
			AppliedTaxonomyId=@AppliedTaxonomyId,
			@Taxonomy= @Taxonomy
		WHERE AssessmentDefinitionId=@AssessmentDefinitionId
				AND BodyOfKnowledgeId = @BodyOfKnowledgeId

		SET @rowsaffected = @@ROWCOUNT
	END
RETURN @rowsaffected
