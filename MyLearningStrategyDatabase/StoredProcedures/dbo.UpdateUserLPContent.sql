 CREATE PROCEDURE [dbo].[UpdateUserLPContent]
	@LearningContentId INT,
    @TableOfContentId INT, 
	@OrderBy INT, 
    @Heading NVARCHAR(50) NULL, 
    @LearningContent NVARCHAR(MAX) NULL, 
    @ImageUrl VARCHAR(2083) NULL, 
    @Hyperlink_1 VARCHAR(2083) NULL, 
    @Hyperlink_2 VARCHAR(2083) NULL, 
    @Hyperlink_3 VARCHAR(2083) NULL,
	@Originator UNIQUEIDENTIFIER
AS
	DECLARE @rowsaffected INT 

	IF (@TableOfContentId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[UpdateUserLPContent].@TableOfContentId');   
	END
	IF (@Originator IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[UpdateUserLPContent].@Originator');   
	END
	IF ([dbo].[IsTOCOriginator](@Originator,@TableOfContentId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END

	BEGIN
		
		UPDATE [dbo].[LearningPlanContent]
		SET TableOfContentId=@TableOfContentId, 
			OrderBy=@OrderBy,
			Heading=@Heading, 
			LearningContent=@LearningContent,
			ImageUrl=@ImageUrl,
			Hyperlink_1=@Hyperlink_1,
			Hyperlink_2=@Hyperlink_2,
			Hyperlink_3=@Hyperlink_3
		WHERE LearningContentId=@LearningContentId;
		
		SET @rowsaffected = @@ROWCOUNT
	END

RETURN @rowsaffected
 
