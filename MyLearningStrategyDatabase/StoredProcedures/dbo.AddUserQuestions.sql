CREATE PROCEDURE [dbo].[AddUserQuestions]
    @BodyOfKnowledgeId INT, 
    @AppliedTaxonomyId INT NULL, 
	@OrderBy INT NULL, 
    @Question NVARCHAR(4000) NULL, 
	@Image_1_Device NVARCHAR(256) NULL, 
	@Image_1_Cloud NVARCHAR(2083) NULL, 
	@Image_2_Device NVARCHAR(256) NULL, 
	@Image_2_Cloud NVARCHAR(2083) NULL, 
	@Image_3_Device NVARCHAR(256) NULL, 
	@Image_3_Cloud NVARCHAR(2083) NULL, 
	@Hyperlink_1 VARCHAR(2083) NULL, 
    @Hyperlink_2 VARCHAR(2083) NULL, 
    @Hyperlink_3 VARCHAR(2083) NULL,
	@Mnemonic VARCHAR(300) NULL,
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
							Image_1_Device, 
							Image_1_Cloud, 
							Image_2_Device, 
							Image_2_Cloud, 
							Image_3_Device, 
							Image_3_Cloud, 
							Hyperlink_1, 
							Hyperlink_2, 
							Hyperlink_3,
							Mnemonic,
							LastModifiedOffset)
	VALUES (
			@BodyOfKnowledgeId, 
			@AppliedTaxonomyId, 
			@OrderBy, 
			@Question, 
			@Image_1_Device, 
			@Image_1_Cloud, 
			@Image_2_Device, 
			@Image_2_Cloud, 
			@Image_3_Device, 
			@Image_3_Cloud, 
			@Hyperlink_1, 
			@Hyperlink_2, 
			@Hyperlink_3,
			@Mnemonic, 
			@LastModifiedOffset);
 
	SELECT CAST(SCOPE_IDENTITY() AS INT) AS QuestionId;
	END

RETURN @QuestionId
