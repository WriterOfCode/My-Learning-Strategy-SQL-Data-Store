CREATE TABLE [dbo].[LearningPlanDefinitions]
(
	[LearningPlanDefinitionId] INT IDENTITY (1, 1) NOT NULL , 
    [BodyOfKnowledgeId] INT NOT NULL, 
    [Description] NVARCHAR(256) NOT NULL, 
    [SortRuleId] INT NOT NULL DEFAULT 0, 
    [TableOfContentsRandom] BIT NOT NULL DEFAULT 0, 
    [TableOfContentsMax] INT NULL, 
    [TableOfContentsMin] INT NULL, 
    [ContentsRandom] BIT NULL, 
    [ContentsMax] INT NULL, 
    [ContentsMin] INT NULL, 
    [AppliedTaxonomyId] INT NULL, 
    [Taxonomy] BIT NULL, 
    CONSTRAINT [PK_LearningPlans] PRIMARY KEY ([LearningPlanDefinitionId]), 
    CONSTRAINT [FK_LearningPlan_BodyOfKnowledge] FOREIGN KEY ([BodyOfKnowledgeId]) REFERENCES [BodyOfKnowledge]([BodyOfKnowledgeId]), 
    CONSTRAINT [FK_LearningPlan_SortOrderRule] FOREIGN KEY ([SortRuleId]) REFERENCES [LearningPlanSortRule]([SortRuleId]),
	CONSTRAINT [FK_LearningPlan_Taxonomy] FOREIGN KEY ([AppliedTaxonomyId]) REFERENCES [Taxonomy]([TaxonomyId]) 
)

GO

CREATE INDEX [IX_LearningPlanDefinitions_BOKId] ON [dbo].[LearningPlanDefinitions] ([LearningPlanDefinitionId],[BodyOfKnowledgeId])
