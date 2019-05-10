CREATE PROCEDURE [dbo].[UpdateUserLPTableOfContent]
	@BodyOfKnowledgeId INT,
	@TableOfContentId INT,
	@AppliedTaxonomyId INT,
	@OrderBy INT, 
    @Heading NVARCHAR(50),
	@Originator UNIQUEIDENTIFIER
	
AS
	DECLARE @rowsaffected INT 
	
	IF (@BodyOfKnowledgeId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[UpdateUserLPTableOfContent].@BodyOfKnowledgeId');   
	END
	IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
	BEGIN 
		UPDATE [dbo].[LearningPlanTableOfContents] 
		SET BodyOfKnowledgeId=@BodyOfKnowledgeId,
		AppliedTaxonomyId=@AppliedTaxonomyId, 
		OrderBy=@OrderBy, 
		Heading=@Heading
		WHERE TableOfContentId=@TableOfContentId
		AND BodyOfKnowledgeId = @BodyOfKnowledgeId;

		SET @rowsaffected = @@ROWCOUNT
	END
RETURN @rowsaffected
