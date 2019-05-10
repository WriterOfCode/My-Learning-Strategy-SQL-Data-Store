CREATE PROCEDURE [dbo].[GetLearningPlanSortRule]
	    @SortRuleId INT NULL
AS
IF (@SortRuleId IS NULL)
	BEGIN
		SELECT SortRuleId,Definition,IsDisabled  
		FROM [dbo].[LearningPlanSortRule]
		--WHERE IsDisabled = 0;   
	END
ELSE
	BEGIN
		SELECT SortRuleId,Definition,IsDisabled  
		FROM [dbo].[LearningPlanSortRule]
		WHERE SortRuleId=@SortRuleId;
	END
RETURN 0
