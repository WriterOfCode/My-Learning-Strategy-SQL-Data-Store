CREATE PROCEDURE [dbo].[UpdateUserResponses]
	@ResponseId INT NULL,
	@QuestionId INT NULL, 
	@OrderBy INT NULL, 
	@Response NVARCHAR(MAX) NULL, 
	@IsCorrect BIT NULL, 
	@ImageUrl NVARCHAR(2083) NULL, 
	@Hyperlink_1 VARCHAR(2083) NULL, 
	@Hyperlink_2 VARCHAR(2083) NULL, 
	@Hyperlink_3 VARCHAR(2083) NULL,
	@Originator UNIQUEIDENTIFIER
AS
	DECLARE @rowsaffected INT 

	IF (@QuestionId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[dbo.UpdateUserResponses].@QuestionId');   
	END
	IF ([dbo].[IsQuestionOriginator](@Originator,@QuestionId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
	BEGIN 
		UPDATE [dbo].[Responses] 
		SET OrderBy=@OrderBy,
		Response=@Response, 
		IsCorrect=@IsCorrect, 
		ImageUrl=@ImageUrl, 
		Hyperlink_1=@Hyperlink_1, 
		Hyperlink_2=@Hyperlink_2, 
		Hyperlink_3=@Hyperlink_3
		WHERE ResponseId=@ResponseId
		AND QuestionId=@QuestionId;
		
		SET @rowsaffected = @@ROWCOUNT
	END
RETURN @rowsaffected
