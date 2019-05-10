CREATE PROCEDURE [dbo].[GetUserLPContent]
	@LearningContentId INT NULL,
	@TableOfContentId INT NULL,
	@Originator UNIQUEIDENTIFIER
AS
	IF (@TableOfContentId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[GetUserLPContent].@TableOfContentId');   
	END
	IF (@Originator IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[GetUserLPContent].@Originator');   
	END
	IF ([dbo].[IsTOCOriginator](@Originator,@TableOfContentId)=0)
	BEGIN
		RAISERROR (13538,14,-1, 'User is not the owner!');   
	END

	IF (@LearningContentId IS NOT NULL)
		BEGIN
			SELECT
			[LearningContentId], 
			[TableOfContentId], 
			[OrderBy], 
			[Heading], 
			[LearningContent], 
			[ImageUrl], 
			[Hyperlink_1], 
			[Hyperlink_2], 
			[Hyperlink_3] 
			FROM [dbo].[LearningPlanContent]
			WHERE LearningContentId = @LearningContentId
			AND TableOfContentId = @TableOfContentId
		END
	ELSE
		BEGIN
			SELECT
			[LearningContentId], 
			[TableOfContentId], 
			[OrderBy], 
			[Heading], 
			[LearningContent], 
			[ImageUrl], 
			[Hyperlink_1], 
			[Hyperlink_2], 
			[Hyperlink_3] 
			FROM [dbo].[LearningPlanContent]
			WHERE TableOfContentId = @TableOfContentId
		END

RETURN 0
