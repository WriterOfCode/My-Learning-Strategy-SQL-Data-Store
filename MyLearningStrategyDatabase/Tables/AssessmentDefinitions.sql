CREATE TABLE [dbo].[AssessmentDefinitions]
(
	[AssessmentDefinitionId] INT IDENTITY (1, 1) NOT NULL , 
    [BodyOfKnowledgeId] INT NOT NULL, 
    [Description] NVARCHAR(256) NOT NULL, 
    [SortRuleId] INT NULL DEFAULT 0, 
    [QuestionRandom] BIT NULL DEFAULT 0, 
    [QuestionMax] INT NULL DEFAULT 0, 
    [QuestionMin] INT NULL DEFAULT 0, 
    [ResponseRandom] BIT NULL DEFAULT 0, 
    [ResponseMax] INT NULL DEFAULT 0 , 
    [ResponseMin] INT NULL DEFAULT 0, 
    [ResponseMinCorrect] INT NULL DEFAULT 0, 
    [ResponseMaxCorrect] INT NULL DEFAULT 0, 
    [AppliedTaxonomyId] INT NULL DEFAULT 0, 
    [Taxonomy] BIT NULL DEFAULT 0, 
    [LastModifiedOffset] DATETIMEOFFSET NULL, 
    [CloudRowId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    CONSTRAINT [FK_Assessments_BodyOfKnowledge] FOREIGN KEY ([BodyOfKnowledgeId]) REFERENCES [BodyOfKnowledge]([BodyOfKnowledgeId]), 
    CONSTRAINT [FK_Assessments_SortRule] FOREIGN KEY ([SortRuleId]) REFERENCES [AssessmentSortRule]([SortRuleId]), 
	CONSTRAINT [FK_Assessments_TaxonomyApplied] FOREIGN KEY ([AppliedTaxonomyId]) REFERENCES [Taxonomy]([TaxonomyId]),
	CONSTRAINT [PK_Assessments] PRIMARY KEY ([AssessmentDefinitionId], [BodyOfKnowledgeId])
)

GO

CREATE UNIQUE INDEX [IX_AssessmentDefinitions_BOK] ON [dbo].[AssessmentDefinitions] ([AssessmentDefinitionId], [BodyOfKnowledgeId])
