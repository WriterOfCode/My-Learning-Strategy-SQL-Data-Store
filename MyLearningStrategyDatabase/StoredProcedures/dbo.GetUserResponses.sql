CREATE PROCEDURE [dbo].[GetUserResponses]
    @QuestionId INT NULL,
	@Originator UNIQUEIDENTIFIER
AS
IF ([dbo].[IsQuestionOriginator](@Originator,@QuestionId)=0)
BEGIN
	RAISERROR (13538,14,-1, 'User is not the owner!');   
END

BEGIN
  SELECT ResponseId,
		QuestionId,
		OrderBy,
		Response,
		IsCorrect,
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
		CloudRowId
  FROM [dbo].[Responses]
  WHERE QuestionId= @QuestionId
END
RETURN 0
