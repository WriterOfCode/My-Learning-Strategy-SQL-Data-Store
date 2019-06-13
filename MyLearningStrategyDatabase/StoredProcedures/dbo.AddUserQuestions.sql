CREATE PROCEDURE [dbo].[AddUserQuestions]
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
	DECLARE @QuestionId AS INT
	IF (@BodyOfKnowledgeId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[AddUserQuestions].@BodyOfKnowledgeId');   
	END
	IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
	BEGIN
	INSERT INTO Questions (	BodyOfKnowledgeId, 
							AppliedTaxonomyId, 
							OrderBy, 
							Question, 
							ImageUrl, 
							Hyperlink_1, 
							Hyperlink_2, 
							Hyperlink_3,
							LastModifiedOffset)
	VALUES (
			@BodyOfKnowledgeId, 
			@AppliedTaxonomyId, 
			@OrderBy, 
			@Question, 
			@ImageUrl, 
			@Hyperlink_1, 
			@Hyperlink_2, 
			@Hyperlink_3,
			@LastModifiedOffset);
 
	SELECT CAST(SCOPE_IDENTITY() AS INT) AS QuestionId;
	END

RETURN @QuestionId
