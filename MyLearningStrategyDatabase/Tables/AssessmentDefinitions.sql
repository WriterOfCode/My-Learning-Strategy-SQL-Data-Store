CREATE TABLE [dbo].[AssessmentDefinitions]
(
	[AssessmentDefinitionId] INT IDENTITY (1, 1) NOT NULL , 
    [BodyOfKnowledgeId] INT NOT NULL, 
    [Description] NVARCHAR(256) NOT NULL, 
    [SortRuleId] INT NOT NULL DEFAULT 0, 
    [QuestionRandom] BIT NOT NULL DEFAULT 0, 
    [QuestionMax] INT NULL, 
    [QuestionMin] INT NULL, 
    [ResponseRandom] BIT NULL DEFAULT 0, 
    [ResponseMax] INT NULL , 
    [ResponseMin] INT NULL, 
    [ResponseMinCorrect] INT NULL, 
    [ResponseMaxCorrect] INT NULL, 
    [AppliedTaxonomyId] INT NULL, 
    [Taxonomy] BIT NULL, 
    CONSTRAINT [FK_Assessments_BodyOfKnowledge] FOREIGN KEY ([BodyOfKnowledgeId]) REFERENCES [BodyOfKnowledge]([BodyOfKnowledgeId]), 
    CONSTRAINT [FK_Assessments_SortRule] FOREIGN KEY ([SortRuleId]) REFERENCES [AssessmentSortRule]([SortRuleId]), 
	CONSTRAINT [FK_Assessments_TaxonomyApplied] FOREIGN KEY ([AppliedTaxonomyId]) REFERENCES [Taxonomy]([TaxonomyId]),
	CONSTRAINT [PK_Assessments] PRIMARY KEY ([AssessmentDefinitionId], [BodyOfKnowledgeId])
)

GO

CREATE UNIQUE INDEX [IX_AssessmentDefinitions_BOK] ON [dbo].[AssessmentDefinitions] ([AssessmentDefinitionId], [BodyOfKnowledgeId])
