CREATE PROCEDURE [dbo].[GetUserLPDefinitions]
	    @BodyOfKnowledgeId INT NULL, 
		@LearningPlanDefinitionId INT NULL,
		@AppliedTaxonomyId INT NULL,
		@Originator UNIQUEIDENTIFIER
AS
IF (@BodyOfKnowledgeId IS NULL)
BEGIN
	RAISERROR (15600, 17,-1, 'GetUserLPDefinitions.@BodyOfKnowledgeId');   
END
IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
BEGIN
	RAISERROR (13538,14,-1, 'User is not the owner!');   
END


	IF (@LearningPlanDefinitionId IS NOT NULL)
		BEGIN
			SELECT	LearningPlanDefinitionId, 
			BodyOfKnowledgeId, Description, 
			SortRuleId, TableOfContentsRandom, 
			TableOfContentsMax, TableOfContentsMin,
			ContentsRandom, ContentsMax, ContentsMin,
			AppliedTaxonomyId, Taxonomy,
			LastModifiedOffset,CloudRowId
			FROM [dbo].[LearningPlanDefinitions]
			WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId
			AND LearningPlanDefinitionId = @LearningPlanDefinitionId
		END
	ELSE IF(@AppliedTaxonomyId IS NOT NULL)
		BEGIN
			SELECT LearningPlanDefinitionId, 
			BodyOfKnowledgeId, Description, 
			SortRuleId, TableOfContentsRandom, 
			TableOfContentsMax, TableOfContentsMin,
			ContentsRandom, ContentsMax, ContentsMin,
			AppliedTaxonomyId, Taxonomy,
			LastModifiedOffset,CloudRowId
			FROM [dbo].[LearningPlanDefinitions]
			WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId
			AND AppliedTaxonomyId =@AppliedTaxonomyId
		END
	ELSE
		BEGIN
			SELECT LearningPlanDefinitionId, 
			BodyOfKnowledgeId, Description, 
			SortRuleId, TableOfContentsRandom, 
			TableOfContentsMax, TableOfContentsMin,
			ContentsRandom, ContentsMax, ContentsMin,
			AppliedTaxonomyId, Taxonomy,
			LastModifiedOffset,CloudRowId
			FROM [dbo].[LearningPlanDefinitions]
			WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId
		END

RETURN 0
