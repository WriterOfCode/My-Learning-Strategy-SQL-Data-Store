CREATE PROCEDURE [dbo].[GetUserQuestions]
    @BodyOfKnowledgeId INT,
	@QuestionId INT NULL,
	@Originator UNIQUEIDENTIFIER
AS
	IF ([dbo].[IsBokOriginator](@Originator,@BodyOfKnowledgeId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
--BodyOfKnowledgeId @QuestionId
IF (@QuestionId IS NOT NULL)
	BEGIN
		SELECT QuestionId,
			BodyOfKnowledgeId,
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
			LastModifiedOffset,
			CloudRowId,
			Mnemonic
		FROM [Questions]
		WHERE QuestionId = @QuestionId
		AND BodyOfKnowledgeId = @BodyOfKnowledgeId;
	END
ELSE
--BodyOfKnowledgeId
	BEGIN 
		SELECT QuestionId,
				BodyOfKnowledgeId,
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
				LastModifiedOffset,
				CloudRowId,
				Mnemonic
		  FROM [Questions]
		  WHERE BodyOfKnowledgeId = @BodyOfKnowledgeId;
	END
RETURN 0