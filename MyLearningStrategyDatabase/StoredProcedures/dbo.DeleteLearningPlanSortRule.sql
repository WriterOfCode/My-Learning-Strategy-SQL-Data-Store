CREATE PROCEDURE [dbo].[DeleteLearningPlanSortRule]
	    @SortRuleId INT NULL
AS
	DECLARE @rowsaffected INT 

	IF (@SortRuleId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[DeleteLearningPlanSortRule].@SortRuleId');   
	END

	BEGIN
		DELETE [dbo].[LearningPlanSortRule]
		WHERE SortRuleId = @SortRuleId;
		
		SET @rowsaffected = @@ROWCOUNT
	END
 
RETURN @rowsaffected