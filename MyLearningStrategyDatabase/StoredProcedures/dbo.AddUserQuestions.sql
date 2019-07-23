CREATE PROCEDURE [dbo].[AddUserQuestions]
    @BodyOfKnowledgeId INT, 
	@OrderBy INT NULL, 
    @Question NVARCHAR(4000) NULL, 
	@Image_1_Device NVARCHAR(256) NULL, 
	@Image_1_Cloud NVARCHAR(2083) NULL,
	@Image_1_Hash INT,
	@Image_2_Device NVARCHAR(256) NULL, 
	@Image_2_Cloud NVARCHAR(2083) NULL, 
	@Image_2_Hash INT,
	@Image_3_Device NVARCHAR(256) NULL, 
	@Image_3_Cloud NVARCHAR(2083) NULL, 
	@Image_3_Hash INT,
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
							OrderBy, 
							Question, 
							Image_1_Device, 
							Image_1_Cloud, 
							Image_1_Hash,
							Image_2_Device, 
							Image_2_Cloud, 
							Image_2_Hash,
							Image_3_Device, 
							Image_3_Cloud, 
							Image_3_Hash,
							Hyperlink_1, 
							Hyperlink_2, 
							Hyperlink_3,
							Mnemonic,
							LastModifiedOffset)
	VALUES (
			@BodyOfKnowledgeId, 
			@OrderBy, 
			@Question, 
			@Image_1_Device, 
			@Image_1_Cloud, 
			@Image_1_Hash,
			@Image_2_Device, 
			@Image_2_Cloud, 
			@Image_2_Hash,
			@Image_3_Device, 
			@Image_3_Cloud, 
			@Image_3_Hash,
			@Hyperlink_1, 
			@Hyperlink_2, 
			@Hyperlink_3,
			@Mnemonic, 
			SYSDATETIMEOFFSET());
 
		SELECT CAST(SCOPE_IDENTITY() AS INT) AS IdentiyValue;
	END

RETURN
