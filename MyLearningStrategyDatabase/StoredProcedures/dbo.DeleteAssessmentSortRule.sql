CREATE PROCEDURE [dbo].[DeleteAssessmentSortRule]
	    @SortRuleId INT NULL
AS
	DECLARE @rowsaffected INT 

	IF (@SortRuleId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[UpdateAssessmentSortRule].@SortRuleId');   
	END

	BEGIN
		DELETE [dbo].[AssessmentSortRule]
		WHERE SortRuleId = @SortRuleId
		AND IsDisabled=1;  
		
		SET @rowsaffected = @@ROWCOUNT
	END
 
RETURN @rowsaffected
