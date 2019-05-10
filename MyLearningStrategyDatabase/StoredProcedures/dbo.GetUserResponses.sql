CREATE PROCEDURE [dbo].[GetUserResponses]
	@ResponseId INT NULL,
    @QuestionId INT,
	@Originator UNIQUEIDENTIFIER
AS
	IF (@QuestionId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, 'GetUserResponses.@QuestionId can not be null');   
	END
	IF ([dbo].[IsQuestionOriginator](@Originator,@QuestionId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
IF (@ResponseId IS NOT NULL AND @QuestionId IS NOT NULL)
	BEGIN
	SELECT [ResponseId]
		  ,[QuestionId]
		  ,[OrderBy]
		  ,[Response]
		  ,[IsCorrect]
		  ,[ImageUrl]
		  ,[Hyperlink_1]
		  ,[Hyperlink_2]
		  ,[Hyperlink_3]
	  FROM [dbo].[Responses]
	  WHERE ResponseId= @ResponseId
	  AND QuestionId= @QuestionId
	END 
ELSE IF (@QuestionId IS NOT NULL)
BEGIN
  SELECT [ResponseId]
      ,[QuestionId]
      ,[OrderBy]
      ,[Response]
      ,[IsCorrect]
      ,[ImageUrl]
      ,[Hyperlink_1]
      ,[Hyperlink_2]
      ,[Hyperlink_3]
  FROM [dbo].[Responses]
  WHERE QuestionId= @QuestionId
END
RETURN 0
