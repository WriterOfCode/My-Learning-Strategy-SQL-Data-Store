CREATE PROCEDURE [dbo].[UpdateUserQuestions]
	@QuestionId INT,
    @BodyOfKnowledgeId INT, 
    @AppliedTaxonomyId INT NULL, 
	@OrderBy INT NULL, 
    @Question NVARCHAR(4000) NULL, 
	@Image_1_Device NVARCHAR(256) NULL, 
	@Image_1_Cloud NVARCHAR(2083) NULL, 
	@Image_1_Hash INT NULL, 
	@Image_2_Device NVARCHAR(256) NULL, 
	@Image_2_Cloud NVARCHAR(2083) NULL, 
	@Image_2_Hash INT NULL, 
	@Image_3_Device NVARCHAR(256) NULL, 
	@Image_3_Cloud NVARCHAR(2083) NULL, 
	@Image_3_Hash INT NULL, 
	@Hyperlink_1 VARCHAR(2083) NULL, 
    @Hyperlink_2 VARCHAR(2083) NULL, 
    @Hyperlink_3 VARCHAR(2083) NULL,
	@Mnemonic VARCHAR(300) NULL,
	@LastModifiedOffset DATETIMEOFFSET NULL,
	@CloudRowId  UNIQUEIDENTIFIER,
	@Originator UNIQUEIDENTIFIER

AS
	DECLARE @rowsaffected INT 
	
	IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
	BEGIN
	UPDATE Questions 
	SET OrderBy=@OrderBy, 
		Question=@Question, 
		Image_1_Device=@Image_1_Device, 
		Image_1_Cloud=@Image_1_Cloud, 
		Image_1_Hash=@Image_1_Hash,  
		Image_2_Device=@Image_2_Device, 
		Image_2_Cloud=@Image_2_Cloud,
		Image_2_Hash=@Image_1_Hash,  
		Image_3_Device=@Image_3_Device, 
		Image_3_Cloud=@Image_3_Cloud,
		Image_3_Hash=@Image_1_Hash,  
		Hyperlink_1=@Hyperlink_1, 
		Hyperlink_2=@Hyperlink_2, 
		Hyperlink_3=@Hyperlink_3,
		Mnemonic=@Mnemonic,
		LastModifiedOffset=SYSDATETIMEOFFSET()
	WHERE QuestionId=@QuestionId
		AND CloudRowId=@CloudRowId
		AND BodyOfKnowledgeId=@BodyOfKnowledgeId;
		
		SET @rowsaffected = @@ROWCOUNT
	END

RETURN @rowsaffected
