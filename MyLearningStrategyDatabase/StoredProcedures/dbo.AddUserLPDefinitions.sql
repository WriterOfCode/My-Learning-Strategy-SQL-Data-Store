CREATE PROCEDURE [dbo].[AddUserLPDefinitions]
	@BodyOfKnowledgeId INT, 
    @Description NVARCHAR(256), 
    @SortRuleId INT, 
    @TableOfContentsRandom BIT NULL, 
    @TableOfContentsMax INT NULL,
	@TableOfContentsMin INT NULL,
	@ContentsRandom INT NULL, 
	@ContentsMax INT NULL, 
	@ContentsMin INT NULL,
	@AppliedTaxonomyId INT NULL,
	@Taxonomy BIT,
	@Originator UNIQUEIDENTIFIER
AS
	DECLARE @LearningPlanDefinitionId INT 
	
	IF (@BodyOfKnowledgeId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[AddUserLPDefinitions].@BodyOfKnowledgeId');   
	END
	IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
	BEGIN 
		INSERT INTO [dbo].[LearningPlanDefinitions] (BodyOfKnowledgeId, Description, 
		SortRuleId, TableOfContentsRandom,TableOfContentsMax, TableOfContentsMin,
		ContentsRandom,ContentsMax,ContentsMin,AppliedTaxonomyId,Taxonomy)
		VALUES (@BodyOfKnowledgeId,  @Description, @SortRuleId, @TableOfContentsRandom, @TableOfContentsMax, @TableOfContentsMin
			,@ContentsRandom, @ContentsMax, @ContentsMin, @AppliedTaxonomyId, @Taxonomy);

		SELECT CAST(SCOPE_IDENTITY() AS INT) AS LearningPlanDefinitionId;
	END
RETURN @LearningPlanDefinitionId