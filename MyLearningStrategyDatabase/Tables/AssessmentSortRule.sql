CREATE TABLE [dbo].[AssessmentSortRule]
(
	[SortRuleId] INT IDENTITY (1, 1) NOT NULL , 
    [Definition] NVARCHAR(50) NOT NULL, 
    [IsDisabled] BIT NULL DEFAULT 0, 
    CONSTRAINT [PK_AssessmentSortRule] PRIMARY KEY ([SortRuleId]) 
)
