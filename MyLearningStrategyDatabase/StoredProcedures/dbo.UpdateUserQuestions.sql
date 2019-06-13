CREATE PROCEDURE [dbo].[UpdateUserQuestions]
	@QuestionId INT,
    @BodyOfKnowledgeId INT, 
    @AppliedTaxonomyId INT NULL, 
	@OrderBy INT NULL, 
    @Question NVARCHAR(MAX) NULL, 
    @ImageUrl NVARCHAR(2083) NULL, 
	@Hyperlink_1 VARCHAR(2083) NULL, 
    @Hyperlink_2 VARCHAR(2083) NULL, 
    @Hyperlink_3 VARCHAR(2083) NULL,
	@LastModifiedOffset DATETIMEOFFSET NULL,
	@Originator UNIQUEIDENTIFIER

AS
	DECLARE @rowsaffected INT 

	IF (@BodyOfKnowledgeId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[UpdateUserQuestions].@BodyOfKnowledgeId');   
	END
	IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
	BEGIN
	UPDATE Questions 
	SET AppliedTaxonomyId=@AppliedTaxonomyId, 
		OrderBy=@OrderBy, 
		Question=@Question, 
		ImageUrl=@ImageUrl, 
		Hyperlink_1=@Hyperlink_1, 
		Hyperlink_2=@Hyperlink_2, 
		Hyperlink_3=@Hyperlink_3,
		LastModifiedOffset=@LastModifiedOffset
	WHERE QuestionId=@QuestionId
		AND BodyOfKnowledgeId=@BodyOfKnowledgeId;
		
		SET @rowsaffected = @@ROWCOUNT
	END

RETURN @rowsaffected
