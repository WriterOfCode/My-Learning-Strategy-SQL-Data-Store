CREATE PROCEDURE [dbo].[AddUserResponses]
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
	DECLARE @ResponseId INT 

	IF (@QuestionId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[dbo.AddUserResponses].@QuestionId');   
	END
	IF (@Originator IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[dbo.AddUserResponses].@Originator');   
	END

	IF ([dbo].[IsQuestionOriginator](@Originator,@QuestionId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END
	BEGIN 
		INSERT INTO [dbo].[Responses] (QuestionId, OrderBy, Response, IsCorrect, ImageUrl, Hyperlink_1, Hyperlink_2, Hyperlink_3)
		VALUES (@QuestionId, @OrderBy, @Response, @IsCorrect, @ImageUrl, @Hyperlink_1, @Hyperlink_2, @Hyperlink_3 );

		SELECT CAST(SCOPE_IDENTITY() AS INT) AS ResponseId;
	END
RETURN @ResponseId
