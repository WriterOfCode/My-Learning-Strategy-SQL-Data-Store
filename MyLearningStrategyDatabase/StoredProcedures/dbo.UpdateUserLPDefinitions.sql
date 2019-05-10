CREATE PROCEDURE [dbo].[UpdateUserLPDefinitions]
    @BodyOfKnowledgeId INT, 
	@LearningPlanDefinitionId INT,
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
	DECLARE @rowsaffected INT 
	
	IF (@BodyOfKnowledgeId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[UpdateUserLPDeffinitions].@BodyOfKnowledgeId');   
	END
	IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
	BEGIN 
		UPDATE [dbo].[LearningPlanDefinitions] 
		SET BodyOfKnowledgeId=@BodyOfKnowledgeId,
		Description=@Description, 
		SortRuleId=@SortRuleId, 
		TableOfContentsRandom=@TableOfContentsRandom,
		TableOfContentsMax=@TableOfContentsMax,
		TableOfContentsMin =@TableOfContentsMin,
		ContentsRandom=@ContentsRandom, 
		ContentsMax=@ContentsMax, 
		ContentsMin=@ContentsMin,
		AppliedTaxonomyId=@AppliedTaxonomyId,
		Taxonomy=@Taxonomy
		WHERE LearningPlanDefinitionId=@LearningPlanDefinitionId
		AND BodyOfKnowledgeId=@BodyOfKnowledgeId;
		
		SET @rowsaffected = @@ROWCOUNT
	END
RETURN @rowsaffected