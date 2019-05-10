CREATE PROCEDURE [dbo].[AddAssessmentSortRule]
		@Definition NVARCHAR(50),
		@IsDisabled BIT
AS
	DECLARE @SortRuleId INT
	
	IF (@Definition IS NULL)
	BEGIN
		RAISERROR (15600, 17,-1, '[AddAssessmentSortRule].@Deffinition');   
	END

	BEGIN 
		INSERT INTO [dbo].[AssessmentSortRule] (Definition, IsDisabled)
		VALUES (@Definition,  @IsDisabled);

		SELECT CAST(SCOPE_IDENTITY() AS INT) AS SortRuleId;
	END
 
RETURN @SortRuleId
