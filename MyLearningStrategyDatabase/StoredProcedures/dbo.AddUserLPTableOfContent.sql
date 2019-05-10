CREATE PROCEDURE [dbo].[AddUserLPTableOfContent]
	@BodyOfKnowledgeId INT,
	@AppliedTaxonomyId INT,
	@OrderBy INT, 
    @Heading NVARCHAR(50),
	@Originator UNIQUEIDENTIFIER

AS
	DECLARE @TableOfContentId INT 
	IF (@BodyOfKnowledgeId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[AddUserLPTableOfContent].@BodyOfKnowledgeId');   
	END
	IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
	BEGIN 
		INSERT INTO [dbo].[LearningPlanTableOfContents] (BodyOfKnowledgeId, AppliedTaxonomyId, OrderBy, Heading)
		VALUES (@BodyOfKnowledgeId, @AppliedTaxonomyId, @OrderBy, @Heading );

		SELECT CAST(SCOPE_IDENTITY() AS INT) AS TableOfContentId;
	END
RETURN @TableOfContentId
