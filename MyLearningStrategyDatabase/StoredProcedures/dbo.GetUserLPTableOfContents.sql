CREATE PROCEDURE [dbo].[GetUserLPTableOfContents]
	@BodyOfKnowledgeId INT NULL,
	@TableOfContentId INT NULL,
	@AppliedTaxonomyId INT NULL,
	@Originator UNIQUEIDENTIFIER
AS
	IF (@BodyOfKnowledgeId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, 'GetUserLPTableOfContent.@BodyOfKnowledgeId');   
	END
	IF (@Originator IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, 'GetUserLPTableOfContent.@Originator');   
	END
	IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
	IF (@TableOfContentId IS NULL AND @AppliedTaxonomyId IS NULL)
		BEGIN
			SELECT 
			TableOfContentId,
			BodyOfKnowledgeId,
			AppliedTaxonomyId,
			OrderBy,Heading,
			LastModifiedOffset,CloudRowId
			FROM [dbo].[LearningPlanTableOfContents]
			WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId;
		END
	ELSE IF (@TableOfContentId IS NOT NULL)
		BEGIN 
			SELECT 
			TableOfContentId,
			BodyOfKnowledgeId,
			AppliedTaxonomyId,
			OrderBy,Heading,
			LastModifiedOffset,CloudRowId
			FROM [dbo].[LearningPlanTableOfContents]
			WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId
			AND TableOfContentId =	@TableOfContentId;
		END
	ELSE
		BEGIN 
			SELECT 
			[TableOfContentId],
			[BodyOfKnowledgeId],
			[AppliedTaxonomyId],
			[OrderBy], 
			[Heading]
			FROM [dbo].[LearningPlanTableOfContents]
			WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId
			AND AppliedTaxonomyId = @AppliedTaxonomyId;
		END

RETURN 0;