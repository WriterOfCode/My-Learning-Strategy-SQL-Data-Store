CREATE TABLE [dbo].[LearningPlanContentSelections]
(
	[LearningPlanContentSelectionsId] [int] IDENTITY(1,1) NOT NULL,
	[LearningPlanDefinitionId] [int] NULL,
	[TableOfContentId] [int] NULL,
	[LearningContentId] [int] NULL, 
	[LastModifiedOffset] DATETIMEOFFSET NULL, 
    [CloudRowId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    CONSTRAINT [PK_LearningPlanContentSelections] PRIMARY KEY NONCLUSTERED ([LearningPlanContentSelectionsId]), 
    CONSTRAINT [FK_LearningPlanContentSelections_LearningPlanDefinitions] FOREIGN KEY ([LearningPlanDefinitionId]) REFERENCES [LearningPlanDefinitions]([LearningPlanDefinitionId]), 
    CONSTRAINT [FK_LearningPlanContentSelections_LPTableOfContents] FOREIGN KEY ([TableOfContentId]) REFERENCES [LearningPlanTableOfContents]([TableOfContentId]), 
    CONSTRAINT [FK_LearningPlanContentSelections_LearningPlanContent] FOREIGN KEY ([LearningContentId]) REFERENCES [LearningPlanContent]([LearningContentId]),
)

GO

CREATE UNIQUE CLUSTERED INDEX [IX_LearningPlanContentSelections_TriColumn] ON [dbo].[LearningPlanContentSelections] ([LearningPlanDefinitionId],[TableOfContentId],[LearningContentId])
