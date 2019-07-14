CREATE PROCEDURE [dbo].[GetUserResponses]
	@ResponseId INT NULL,
    @QuestionId INT NULL,
	@Originator UNIQUEIDENTIFIER
AS
IF ([dbo].[IsQuestionOriginator](@Originator,@QuestionId)=0)
BEGIN
	RAISERROR (13538,14,-1, 'User is not the owner!');   
END
IF (@ResponseId IS NOT NULL AND @QuestionId IS NOT NULL)
	BEGIN
	SELECT ResponseId,
		QuestionId,
		OrderBy,
		Response,
		IsCorrect,
		Image_1_Device, 
		Image_1_Cloud, 
		Image_2_Device, 
		Image_2_Cloud, 
		Image_3_Device, 
		Image_3_Cloud, 
		Hyperlink_1,
		Hyperlink_2,
		Hyperlink_3,
		LastModifiedOffset,
		CloudRowId
	  FROM [dbo].[Responses]
	  WHERE ResponseId= @ResponseId
	  AND QuestionId= @QuestionId
	END 
ELSE IF (@QuestionId IS NOT NULL)
BEGIN
  SELECT ResponseId,
		QuestionId,
		OrderBy,
		Response,
		IsCorrect,
		Image_1_Device, 
		Image_1_Cloud, 
		Image_2_Device, 
		Image_2_Cloud, 
		Image_3_Device, 
		Image_3_Cloud, 
		Hyperlink_1,
		Hyperlink_2,
		Hyperlink_3,
		LastModifiedOffset,
		CloudRowId
  FROM [dbo].[Responses]
  WHERE QuestionId= @QuestionId
END
RETURN 0
