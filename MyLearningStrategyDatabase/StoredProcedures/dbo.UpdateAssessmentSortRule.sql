CREATE PROCEDURE [dbo].[UpdateAssessmentSortRule]
	    @SortRuleId INT NULL,
		@Definition NVARCHAR(50),
		@IsDisabled BIT
AS
	DECLARE @rowsaffected INT 

	IF (@SortRuleId IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[UpdateAssessmentSortRule].@SortRuleId');   
	END

	BEGIN
		UPDATE [dbo].[AssessmentSortRule]
		SET Definition=@Definition,
		IsDisabled=@IsDisabled
		WHERE SortRuleId = @SortRuleId;  
		
		SET @rowsaffected = @@ROWCOUNT
	END
 
RETURN @rowsaffected
