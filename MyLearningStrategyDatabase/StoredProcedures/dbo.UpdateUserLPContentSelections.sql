CREATE PROCEDURE [dbo].[UpdateUserContentSelections]
	@LearningPlanContentSelectionsId INT,
	@LearningPlanDefinitionId INT,
	@TableOfContentId INT NULL,
	@LearningContentId INT NULL
AS
	DECLARE @rowsaffected INT 

	IF (@LearningPlanContentSelectionsId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[UpdateUserContentSelections].@LearningPlanContentSelectionsId');   
	END

	BEGIN
		UPDATE [dbo].[LearningPlanContentSelections]
		SET LearningPlanDefinitionId=@LearningPlanDefinitionId,
			TableOfContentId=@TableOfContentId,
			LearningContentId=@LearningContentId
		WHERE LearningPlanContentSelectionsId =@LearningPlanContentSelectionsId;
		
		SET @rowsaffected = @@ROWCOUNT
	END
RETURN @rowsaffected