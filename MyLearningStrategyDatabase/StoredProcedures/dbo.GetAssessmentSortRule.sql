CREATE PROCEDURE [dbo].[GetAssessmentSortRule]
	    @SortRuleId INT NULL
AS
IF (@SortRuleId IS NULL)
	BEGIN
		SELECT SortRuleId,Definition,IsDisabled  
		FROM [dbo].[AssessmentSortRule]
		--WHERE IsDisabled = 0;   
	END
ELSE
	BEGIN
		SELECT SortRuleId,Definition,IsDisabled  
		FROM [dbo].[AssessmentSortRule]
		WHERE SortRuleId=@SortRuleId AND IsDisabled = 0;
	END
RETURN 0
