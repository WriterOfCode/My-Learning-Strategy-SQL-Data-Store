CREATE PROCEDURE [dbo].[GetUserQuestions]
    @BodyOfKnowledgeId INT,
	@QuestionId INT NULL,
	@AppliedTaxonomyId INT NULL,
	@Originator UNIQUEIDENTIFIER
AS
	IF (@BodyOfKnowledgeId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, 'GetUserQuestions.@BodyOfKnowledgeId');   
	END
	IF (@Originator IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, 'GetUserLPTableOfContent.@Originator');   
	END
	IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
--BodyOfKnowledgeId @QuestionId
IF (@QuestionId IS NOT NULL)
BEGIN
	SELECT QuestionId,BodyOfKnowledgeId
		  ,AppliedTaxonomyId,OrderBy
		  ,Question,ImageUrl
		  ,Hyperlink_1,Hyperlink_2
		  ,Hyperlink_3,LastModifiedOffset,CloudRowId
	FROM [Questions]
	WHERE QuestionId = @QuestionId
	AND BodyOfKnowledgeId = @BodyOfKnowledgeId;
END
--BodyOfKnowledgeId
IF (@QuestionId IS NULL AND @AppliedTaxonomyId IS NULL)
	BEGIN 
	SELECT QuestionId,BodyOfKnowledgeId
		  ,AppliedTaxonomyId,OrderBy
		  ,Question,ImageUrl
		  ,Hyperlink_1,Hyperlink_2
		  ,Hyperlink_3,LastModifiedOffset,CloudRowId
	  FROM [Questions]
	  WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId;
	END
--BodyOfKnowledgeId and @QuestionId
ELSE IF (@QuestionId IS NULL AND @AppliedTaxonomyId IS NOT NULL)
BEGIN
SELECT QuestionId,BodyOfKnowledgeId
		  ,AppliedTaxonomyId,OrderBy
		  ,Question,ImageUrl
		  ,Hyperlink_1,Hyperlink_2
		  ,Hyperlink_3,LastModifiedOffset,CloudRowId
  FROM [Questions]
  WHERE AppliedTaxonomyId = @AppliedTaxonomyId
  AND BodyOfKnowledgeId = @BodyOfKnowledgeId;
END

RETURN 0
