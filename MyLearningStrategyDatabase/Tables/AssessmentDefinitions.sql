CREATE TABLE [dbo].[AssessmentDefinitions]
(
	[AssessmentDefinitionId] INT IDENTITY (1, 1) NOT NULL , 
    [BodyOfKnowledgeId] INT NOT NULL, 
    [Description] NVARCHAR(256) NOT NULL, 
    [SortRuleId] INT NOT NULL DEFAULT 0, 
    [QuestionRandom] BIT NOT NULL DEFAULT 0, 
    [QuestionMax] INT NOT NULL DEFAULT 0, 
    [QuestionMin] INT NOT NULL DEFAULT 0, 
    [ResponseRandom] BIT NOT NULL DEFAULT 0, 
    [ResponseMax] INT NOT NULL DEFAULT 0 , 
    [ResponseMin] INT NOT NULL DEFAULT 0, 
    [ResponseMinCorrect] INT NOT NULL DEFAULT 0, 
    [ResponseMaxCorrect] INT NOT NULL DEFAULT 0, 
    [AppliedTaxonomyId] INT NULL DEFAULT 0, 
    [Taxonomy] BIT NOT NULL DEFAULT 0, 
    [LastModifiedOffset] DATETIMEOFFSET NULL, 
    [CloudRowId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    CONSTRAINT [FK_Assessments_BodyOfKnowledge] FOREIGN KEY ([BodyOfKnowledgeId]) REFERENCES [BodyOfKnowledge]([BodyOfKnowledgeId]), 
    CONSTRAINT [FK_Assessments_SortRule] FOREIGN KEY ([SortRuleId]) REFERENCES [AssessmentSortRule]([SortRuleId]), 
	CONSTRAINT [FK_Assessments_TaxonomyApplied] FOREIGN KEY ([AppliedTaxonomyId]) REFERENCES [Taxonomy]([TaxonomyId]),
	CONSTRAINT [PK_Assessments] PRIMARY KEY ([AssessmentDefinitionId], [BodyOfKnowledgeId])
)

GO

CREATE UNIQUE INDEX [IX_AssessmentDefinitions_BOK] ON [dbo].[AssessmentDefinitions] ([AssessmentDefinitionId], [BodyOfKnowledgeId])
