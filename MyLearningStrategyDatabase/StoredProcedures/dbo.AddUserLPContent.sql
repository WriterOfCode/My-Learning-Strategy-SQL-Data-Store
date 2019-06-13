 CREATE PROCEDURE [dbo].[AddUserLPContent]
    @TableOfContentId INT, 
	@OrderBy INT, 
    @Heading NVARCHAR(50) NULL, 
    @LearningContent NVARCHAR(MAX) NULL, 
    @ImageUrl VARCHAR(2083) NULL, 
    @Hyperlink_1 VARCHAR(2083) NULL, 
    @Hyperlink_2 VARCHAR(2083) NULL, 
    @Hyperlink_3 VARCHAR(2083) NULL,
	@LastModifiedOffset DATETIMEOFFSET NULL,
	@Originator UNIQUEIDENTIFIER
AS
	IF (@TableOfContentId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[AddUserLPContent].@TableOfContentId');   
	END
	IF (@Originator IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[AddUserLPContent].@Originator');   
	END
	IF ([dbo].[IsTOCOriginator](@Originator,@TableOfContentId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END

	DECLARE	@LearningContentId INT; 

	BEGIN
		INSERT INTO [dbo].[LearningPlanContent]
				(TableOfContentId, 
				OrderBy,
				Heading, 
				LearningContent,
				ImageUrl,
				Hyperlink_1,
				Hyperlink_2,
				Hyperlink_3, 
				LastModifiedOffset )
		VALUES (@TableOfContentId, 
				@OrderBy,
				@Heading, 
				@LearningContent,
				@ImageUrl,
				@Hyperlink_1,
				@Hyperlink_2,
				@Hyperlink_3,
				@LastModifiedOffset );

		SELECT CAST(SCOPE_IDENTITY() AS INT) AS LearningContentId;
	END

RETURN @LearningContentId
 
