CREATE TABLE [dbo].[LearningPlanSortRule]
(
	[SortRuleId] INT IDENTITY (1, 1) NOT NULL , 
    [Definition] NVARCHAR(50) NULL, 
    [IsDisabled] BIT NOT NULL DEFAULT 0, 
    CONSTRAINT [PK_LearningSortRule] PRIMARY KEY ([SortRuleId]) 
)
